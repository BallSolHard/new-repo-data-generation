import type { ExamGuide, ExamDomain } from '@/lib/types/exam-guide';
import type { VersionDiff, DomainChange, TaskChange, ChangeType, RegenerationScope } from '@/lib/types/versioning';

/**
 * Compare two versions of an exam guide and produce a structured diff.
 *
 * Identifies domain additions/removals/modifications, weight changes,
 * task changes, and service changes. Outputs a regeneration scope
 * indicating which domains need new questions.
 */
export function diffExamGuides(oldGuide: ExamGuide, newGuide: ExamGuide): VersionDiff {
  const domainChanges: DomainChange[] = [];
  const addedServices: string[] = [];
  const removedServices: string[] = [];

  const oldDomainMap = new Map(oldGuide.domains.map(d => [normalizeName(d.name), d]));
  const newDomainMap = new Map(newGuide.domains.map(d => [normalizeName(d.name), d]));

  // Check for modified and removed domains
  for (const [key, oldDomain] of oldDomainMap) {
    const newDomain = findMatchingDomain(oldDomain, newGuide.domains);

    if (!newDomain) {
      domainChanges.push({
        domainId: oldDomain.id,
        domainName: oldDomain.name,
        changeType: 'removed',
        oldWeight: oldDomain.weightPercent,
      });
    } else {
      const change = compareDomains(oldDomain, newDomain);
      domainChanges.push(change);

      // Track service changes
      const oldServiceNames = new Set(oldDomain.inScopeServices.map(s => s.name));
      const newServiceNames = new Set(newDomain.inScopeServices.map(s => s.name));

      for (const name of newServiceNames) {
        if (!oldServiceNames.has(name)) addedServices.push(name);
      }
      for (const name of oldServiceNames) {
        if (!newServiceNames.has(name)) removedServices.push(name);
      }
    }
  }

  // Check for added domains
  for (const [key, newDomain] of newDomainMap) {
    const oldDomain = findMatchingDomain(newDomain, oldGuide.domains);
    if (!oldDomain) {
      domainChanges.push({
        domainId: newDomain.id,
        domainName: newDomain.name,
        changeType: 'added',
        newWeight: newDomain.weightPercent,
      });

      // All services in added domain are new
      for (const s of newDomain.inScopeServices) {
        if (!addedServices.includes(s.name)) addedServices.push(s.name);
      }
    }
  }

  const regenerationScope = determineRegenerationScope(domainChanges);
  const summary = buildSummary(oldGuide, newGuide, domainChanges, addedServices, removedServices);

  return {
    fromVersion: oldGuide.version,
    toVersion: newGuide.version,
    certificationName: newGuide.certificationName,
    diffDate: new Date().toISOString(),
    domainChanges,
    addedServices: [...new Set(addedServices)],
    removedServices: [...new Set(removedServices)],
    summary,
    regenerationScope,
  };
}

function compareDomains(oldDomain: ExamDomain, newDomain: ExamDomain): DomainChange {
  const taskChanges: TaskChange[] = [];
  let changeType: ChangeType = 'unchanged';

  // Check weight changes
  if (oldDomain.weightPercent !== newDomain.weightPercent) {
    changeType = 'weight_changed';
  }

  // Compare tasks
  const oldTaskMap = new Map(oldDomain.tasks.map(t => [normalizeName(t.text), t]));
  const newTaskMap = new Map(newDomain.tasks.map(t => [normalizeName(t.text), t]));

  for (const [key, oldTask] of oldTaskMap) {
    const newTask = [...newTaskMap.values()].find(
      t => normalizeName(t.text) === key || textSimilarity(oldTask.text, t.text) > 0.7
    );

    if (!newTask) {
      taskChanges.push({ taskId: oldTask.id, taskText: oldTask.text, changeType: 'removed' });
      changeType = 'modified';
    } else {
      // Compare knowledge statements
      const oldKs = new Set(oldTask.knowledgeStatements.map(k => normalizeName(k.text)));
      const newKs = new Set(newTask.knowledgeStatements.map(k => normalizeName(k.text)));
      const added = [...newKs].filter(k => !oldKs.has(k));
      const removed = [...oldKs].filter(k => !newKs.has(k));

      if (added.length > 0 || removed.length > 0) {
        taskChanges.push({
          taskId: newTask.id,
          taskText: newTask.text,
          changeType: 'modified',
          details: `+${added.length} knowledge statements, -${removed.length} knowledge statements`,
        });
        changeType = 'modified';
      }
    }
  }

  for (const [key, newTask] of newTaskMap) {
    const oldTask = [...oldTaskMap.values()].find(
      t => normalizeName(t.text) === key || textSimilarity(t.text, newTask.text) > 0.7
    );

    if (!oldTask) {
      taskChanges.push({ taskId: newTask.id, taskText: newTask.text, changeType: 'added' });
      changeType = 'modified';
    }
  }

  return {
    domainId: newDomain.id,
    domainName: newDomain.name,
    changeType,
    oldWeight: oldDomain.weightPercent,
    newWeight: newDomain.weightPercent,
    taskChanges: taskChanges.length > 0 ? taskChanges : undefined,
  };
}

function determineRegenerationScope(changes: DomainChange[]): RegenerationScope {
  const fullRegenDomains: string[] = [];
  const partialRegenDomains: string[] = [];
  const unchangedDomains: string[] = [];

  for (const change of changes) {
    switch (change.changeType) {
      case 'added':
        fullRegenDomains.push(change.domainId);
        break;
      case 'removed':
        // Removed domains don't need regen, but questions should be cleaned up
        break;
      case 'modified':
        fullRegenDomains.push(change.domainId);
        break;
      case 'weight_changed':
        // Weight change means proportional question counts change
        partialRegenDomains.push(change.domainId);
        break;
      case 'unchanged':
        unchangedDomains.push(change.domainId);
        break;
    }
  }

  return { fullRegenDomains, partialRegenDomains, unchangedDomains };
}

function buildSummary(
  oldGuide: ExamGuide,
  newGuide: ExamGuide,
  changes: DomainChange[],
  added: string[],
  removed: string[]
): string {
  const parts: string[] = [
    `Version change: ${oldGuide.version} → ${newGuide.version}`,
  ];

  const addedDomains = changes.filter(c => c.changeType === 'added');
  const removedDomains = changes.filter(c => c.changeType === 'removed');
  const modifiedDomains = changes.filter(c => c.changeType === 'modified');
  const weightChanges = changes.filter(c => c.changeType === 'weight_changed');
  const unchanged = changes.filter(c => c.changeType === 'unchanged');

  if (addedDomains.length) parts.push(`${addedDomains.length} domain(s) added`);
  if (removedDomains.length) parts.push(`${removedDomains.length} domain(s) removed`);
  if (modifiedDomains.length) parts.push(`${modifiedDomains.length} domain(s) modified`);
  if (weightChanges.length) parts.push(`${weightChanges.length} domain(s) with weight changes`);
  if (unchanged.length) parts.push(`${unchanged.length} domain(s) unchanged`);
  if (added.length) parts.push(`${added.length} new service(s) in scope`);
  if (removed.length) parts.push(`${removed.length} service(s) removed from scope`);

  return parts.join('. ') + '.';
}

function findMatchingDomain(target: ExamDomain, candidates: ExamDomain[]): ExamDomain | undefined {
  // Exact name match
  const exact = candidates.find(c => normalizeName(c.name) === normalizeName(target.name));
  if (exact) return exact;

  // Fuzzy match — domains might be renamed slightly
  return candidates.find(c => textSimilarity(c.name, target.name) > 0.6);
}

function normalizeName(name: string): string {
  return name.toLowerCase().replace(/[^a-z0-9\s]/g, '').trim();
}

function textSimilarity(a: string, b: string): number {
  const wordsA = normalizeName(a).split(/\s+/).filter(w => w.length > 3);
  const wordsB = normalizeName(b).split(/\s+/).filter(w => w.length > 3);
  if (wordsA.length === 0 || wordsB.length === 0) return 0;

  const overlap = wordsA.filter(w => wordsB.includes(w));
  return overlap.length / Math.max(wordsA.length, wordsB.length);
}

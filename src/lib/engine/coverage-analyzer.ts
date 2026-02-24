// Coverage Analyzer — cross-references question bank against exam guide structure

import { getQuestions } from './question-bank';
import { getCurrentGuide, resolveGuideFromCertName } from '@/data/exam-guides';
import type { ExamGuide, ExamDomain } from '@/lib/types/exam-guide';
import type { BankQuestion } from '@/lib/types/question-bank';
import type { Difficulty } from '@/lib/types/reference-question';
import type {
  CertificationCoverageReport,
  DomainCoverageReport,
  KnowledgeStatementCoverage,
  ServiceCoverage,
  CoverageGap,
} from '@/lib/types/coverage';

const WELL_COVERED_THRESHOLD = 3; // Minimum questions per KS to be "well covered"

/**
 * Full certification coverage report.
 * Analyzes every domain, knowledge statement, and service.
 */
export async function analyzeCoverage(certCode: string): Promise<CertificationCoverageReport> {
  const guide = getCurrentGuide(certCode) || resolveGuideFromCertName(certCode);
  if (!guide) {
    throw new Error(`No exam guide found for: ${certCode}`);
  }

  // Fetch all questions for this cert (active + validated)
  const questions = await getQuestions({
    certificationCode: guide.certificationCode,
    status: undefined, // All statuses — we'll filter per report
  });

  const activeQuestions = questions.filter(q => q.status === 'active' || q.status === 'validated');
  const staleQuestions = questions.filter(q => q.status === 'stale');
  const retiredQuestions = questions.filter(q => q.status === 'retired');

  // Build domain reports
  const domainReports = guide.domains.map(domain =>
    buildDomainReport(domain, activeQuestions)
  );

  // Find gaps
  const gaps = findGaps(guide, activeQuestions);

  // Aggregate metrics
  const totalKS = guide.domains.reduce(
    (sum, d) => sum + d.tasks.reduce((s, t) => s + t.knowledgeStatements.length, 0),
    0
  );
  const coveredKS = domainReports.reduce((sum, d) => sum + d.coveredKnowledgeStatements, 0);

  const allServices = new Set<string>();
  guide.domains.forEach(d => d.inScopeServices.forEach(s => allServices.add(s.name)));
  const coveredServices = new Set<string>();
  activeQuestions.forEach(q => q.coverage.servicesTested.forEach(s => {
    if (allServices.has(s)) coveredServices.add(s);
  }));

  const overallScore = domainReports.length > 0
    ? Math.round(domainReports.reduce((sum, d) => sum + d.coverageScore, 0) / domainReports.length)
    : 0;

  return {
    certificationCode: guide.certificationCode,
    examGuideVersion: guide.version,
    generatedAt: new Date().toISOString(),
    totalQuestions: questions.length,
    activeQuestions: activeQuestions.length,
    staleQuestions: staleQuestions.length,
    retiredQuestions: retiredQuestions.length,
    domainReports,
    overallCoverageScore: overallScore,
    totalKnowledgeStatements: totalKS,
    coveredKnowledgeStatements: coveredKS,
    totalServices: allServices.size,
    coveredServices: coveredServices.size,
    gaps,
  };
}

/**
 * Analyze coverage for a single domain.
 */
function buildDomainReport(domain: ExamDomain, allQuestions: BankQuestion[]): DomainCoverageReport {
  const domainQuestions = allQuestions.filter(q => q.coverage.domainId === domain.id);
  const activeQuestions = domainQuestions.filter(q => q.status === 'active' || q.status === 'validated');
  const staleQuestions = domainQuestions.filter(q => q.status === 'stale');

  // KS coverage
  const allKS: string[] = [];
  const coveredKSIds = new Set<string>();
  const wellCoveredKSIds = new Set<string>();

  for (const task of domain.tasks) {
    for (const ks of task.knowledgeStatements) {
      allKS.push(ks.id);
      const matchingQuestions = activeQuestions.filter(
        q => q.coverage.knowledgeStatementIds.includes(ks.id)
      );
      if (matchingQuestions.length > 0) coveredKSIds.add(ks.id);
      if (matchingQuestions.length >= WELL_COVERED_THRESHOLD) wellCoveredKSIds.add(ks.id);
    }
  }

  const uncoveredKS = allKS.filter(id => !coveredKSIds.has(id));

  // Service coverage
  const domainServices = domain.inScopeServices.map(s => s.name);
  const coveredServices = new Set<string>();
  activeQuestions.forEach(q => q.coverage.servicesTested.forEach(s => {
    if (domainServices.includes(s)) coveredServices.add(s);
  }));
  const uncoveredServices = domainServices.filter(s => !coveredServices.has(s));

  // Difficulty distribution
  const difficultyDist: Record<Difficulty, number> = { basic: 0, intermediate: 0, advanced: 0 };
  for (const q of activeQuestions) {
    difficultyDist[q.difficulty] = (difficultyDist[q.difficulty] || 0) + 1;
  }

  // Coverage score: weighted combination of KS coverage (60%), service coverage (30%), question volume (10%)
  const ksCoverage = allKS.length > 0 ? coveredKSIds.size / allKS.length : 0;
  const serviceCoverage = domainServices.length > 0 ? coveredServices.size / domainServices.length : 0;
  const volumeScore = Math.min(1, activeQuestions.length / 20); // 20 questions = full volume score
  const coverageScore = Math.round((ksCoverage * 60 + serviceCoverage * 30 + volumeScore * 10));

  return {
    domainId: domain.id,
    domainName: domain.name,
    weightPercent: domain.weightPercent,
    totalQuestions: domainQuestions.length,
    activeQuestions: activeQuestions.length,
    staleQuestions: staleQuestions.length,
    totalKnowledgeStatements: allKS.length,
    coveredKnowledgeStatements: coveredKSIds.size,
    wellCoveredKnowledgeStatements: wellCoveredKSIds.size,
    uncoveredKnowledgeStatements: uncoveredKS,
    totalServices: domainServices.length,
    coveredServices: coveredServices.size,
    uncoveredServices,
    difficultyDistribution: difficultyDist,
    coverageScore,
  };
}

/**
 * Find actionable gaps in coverage.
 */
function findGaps(guide: ExamGuide, activeQuestions: BankQuestion[]): CoverageGap[] {
  const gaps: CoverageGap[] = [];

  for (const domain of guide.domains) {
    const domainQuestions = activeQuestions.filter(q => q.coverage.domainId === domain.id);

    // Check each knowledge statement
    for (const task of domain.tasks) {
      for (const ks of task.knowledgeStatements) {
        const count = domainQuestions.filter(
          q => q.coverage.knowledgeStatementIds.includes(ks.id)
        ).length;

        if (count === 0) {
          gaps.push({
            type: 'knowledge_statement',
            domainId: domain.id,
            identifier: ks.id,
            description: `No questions cover: "${ks.text}"`,
            severity: 'critical',
            suggestedQuestionCount: 3,
          });
        } else if (count < WELL_COVERED_THRESHOLD) {
          gaps.push({
            type: 'knowledge_statement',
            domainId: domain.id,
            identifier: ks.id,
            description: `Only ${count} question(s) cover: "${ks.text}"`,
            severity: 'moderate',
            suggestedQuestionCount: WELL_COVERED_THRESHOLD - count,
          });
        }
      }
    }

    // Check service coverage
    for (const service of domain.inScopeServices) {
      const count = domainQuestions.filter(
        q => q.coverage.servicesTested.includes(service.name)
      ).length;

      if (count === 0) {
        gaps.push({
          type: 'service',
          domainId: domain.id,
          identifier: service.name,
          description: `No questions test ${service.name}`,
          severity: 'moderate',
          suggestedQuestionCount: 2,
        });
      }
    }

    // Check difficulty distribution
    const diffCounts: Record<string, number> = { basic: 0, intermediate: 0, advanced: 0 };
    for (const q of domainQuestions) {
      diffCounts[q.difficulty] = (diffCounts[q.difficulty] || 0) + 1;
    }

    if (domainQuestions.length >= 5) {
      for (const level of ['basic', 'intermediate', 'advanced'] as const) {
        const pct = (diffCounts[level] / domainQuestions.length) * 100;
        if (level === 'basic' && pct < 10) {
          gaps.push({
            type: 'difficulty',
            domainId: domain.id,
            identifier: level,
            description: `Only ${pct.toFixed(0)}% basic questions (target: 20%)`,
            severity: 'low',
            suggestedQuestionCount: Math.ceil(domainQuestions.length * 0.2) - diffCounts[level],
          });
        }
        if (level === 'advanced' && pct < 15) {
          gaps.push({
            type: 'difficulty',
            domainId: domain.id,
            identifier: level,
            description: `Only ${pct.toFixed(0)}% advanced questions (target: 30%)`,
            severity: 'low',
            suggestedQuestionCount: Math.ceil(domainQuestions.length * 0.3) - diffCounts[level],
          });
        }
      }
    }
  }

  // Sort: critical first, then moderate, then low
  const severityOrder = { critical: 0, moderate: 1, low: 2 };
  gaps.sort((a, b) => severityOrder[a.severity] - severityOrder[b.severity]);

  return gaps;
}

/**
 * Get knowledge statement coverage details.
 */
export async function getKnowledgeStatementCoverage(
  certCode: string
): Promise<KnowledgeStatementCoverage[]> {
  const guide = getCurrentGuide(certCode) || resolveGuideFromCertName(certCode);
  if (!guide) throw new Error(`No exam guide found for: ${certCode}`);

  const questions = await getQuestions({
    certificationCode: guide.certificationCode,
  });
  const active = questions.filter(q => q.status === 'active' || q.status === 'validated');

  const results: KnowledgeStatementCoverage[] = [];

  for (const domain of guide.domains) {
    for (const task of domain.tasks) {
      for (const ks of task.knowledgeStatements) {
        const matching = active.filter(q =>
          q.coverage.knowledgeStatementIds.includes(ks.id)
        );

        const diffBreakdown: Record<Difficulty, number> = { basic: 0, intermediate: 0, advanced: 0 };
        matching.forEach(q => {
          diffBreakdown[q.difficulty] = (diffBreakdown[q.difficulty] || 0) + 1;
        });

        results.push({
          ksId: ks.id,
          ksText: ks.text,
          taskId: task.id,
          domainId: domain.id,
          questionCount: matching.length,
          questionIds: matching.map(q => q.id),
          difficultyBreakdown: diffBreakdown,
          isCovered: matching.length > 0,
          isWellCovered: matching.length >= WELL_COVERED_THRESHOLD,
        });
      }
    }
  }

  return results;
}

/**
 * Get service coverage details.
 */
export async function getServiceCoverage(certCode: string): Promise<ServiceCoverage[]> {
  const guide = getCurrentGuide(certCode) || resolveGuideFromCertName(certCode);
  if (!guide) throw new Error(`No exam guide found for: ${certCode}`);

  const questions = await getQuestions({
    certificationCode: guide.certificationCode,
  });
  const active = questions.filter(q => q.status === 'active' || q.status === 'validated');

  // Build service → domains mapping
  const serviceMap = new Map<string, { category?: string; domainIds: Set<string> }>();
  for (const domain of guide.domains) {
    for (const service of domain.inScopeServices) {
      if (!serviceMap.has(service.name)) {
        serviceMap.set(service.name, { category: service.category, domainIds: new Set() });
      }
      serviceMap.get(service.name)!.domainIds.add(domain.id);
    }
  }

  const results: ServiceCoverage[] = [];
  for (const [serviceName, info] of serviceMap) {
    const matching = active.filter(q =>
      q.coverage.servicesTested.includes(serviceName)
    );

    results.push({
      serviceName,
      category: info.category,
      domainIds: Array.from(info.domainIds),
      questionCount: matching.length,
      questionIds: matching.map(q => q.id),
      isCovered: matching.length > 0,
    });
  }

  return results;
}

// Versioning types — track cert changes and determine regeneration scope

export type ChangeType = 'added' | 'removed' | 'modified' | 'weight_changed' | 'unchanged';

export interface TaskChange {
  taskId: string;
  taskText: string;
  changeType: ChangeType;
  details?: string;
}

export interface DomainChange {
  domainId: string;
  domainName: string;
  changeType: ChangeType;
  oldWeight?: number;
  newWeight?: number;
  taskChanges?: TaskChange[];
  addedServices?: string[];
  removedServices?: string[];
}

export interface RegenerationScope {
  fullRegenDomains: string[];      // Domain IDs needing full regeneration
  partialRegenDomains: string[];   // Domain IDs needing partial regeneration
  unchangedDomains: string[];      // Domain IDs safe to keep
}

export interface VersionDiff {
  fromVersion: string;
  toVersion: string;
  certificationName: string;
  diffDate: string;                // ISO date when diff was computed
  domainChanges: DomainChange[];
  addedServices: string[];
  removedServices: string[];
  summary: string;                 // Human-readable summary
  regenerationScope: RegenerationScope;
}

export interface ExamGuideVersionRecord {
  certificationCode: string;
  version: string;
  status: 'current' | 'retiring' | 'retired';
  effectiveDate: string;
  importedAt: string;
}

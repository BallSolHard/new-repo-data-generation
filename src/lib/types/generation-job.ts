// Generation job types — batch generation with progress tracking

import type { QuestionType } from './exam-guide';
import type { Difficulty } from './reference-question';

export type JobStatus =
  | 'pending'        // Created, waiting to start
  | 'running'        // Currently generating questions
  | 'completed'      // All targets met
  | 'failed'         // Unrecoverable error
  | 'partial';       // Some domains completed, others failed

export type JobType =
  | 'single_domain'       // Generate for one domain
  | 'full_certification'  // All domains of a cert
  | 'regeneration'        // Triggered by exam guide version change
  | 'gap_fill';           // Fill coverage gaps

export interface DifficultyDistribution {
  basic: number;          // Percentage, e.g. 20
  intermediate: number;   // e.g. 50
  advanced: number;       // e.g. 30
  // Must sum to 100
}

export const DEFAULT_DIFFICULTY_DISTRIBUTION: DifficultyDistribution = {
  basic: 20,
  intermediate: 50,
  advanced: 30,
};

export interface DomainTarget {
  domainId: string;
  domainName: string;
  targetQuestionCount: number;
  difficultyDistribution: DifficultyDistribution;
  questionTypes: QuestionType[];
  // Progress
  generatedCount: number;
  validatedCount: number;
  rejectedCount: number;
  status: 'pending' | 'running' | 'completed' | 'failed';
  error?: string;
}

export interface GenerationJob {
  id: string;                           // e.g. "job_SAA-C03_1706140800_abc123"
  type: JobType;
  status: JobStatus;

  // Scope
  certificationCode: string;
  examGuideVersion: string;
  domainTargets: DomainTarget[];

  // Configuration
  totalTargetQuestions: number;
  difficultyDistribution: DifficultyDistribution;
  questionTypes: QuestionType[];
  enableValidation: boolean;

  // Aggregate progress
  questionsGenerated: number;
  questionsValidated: number;
  questionsRejected: number;
  domainsCompleted: number;
  domainsTotal: number;

  // Timing
  createdAt: string;
  startedAt?: string;
  completedAt?: string;

  // Provenance
  triggeredBy: 'manual' | 'version_change' | 'gap_fill';
  versionDiffId?: string;              // If triggered by exam guide version change

  // Errors
  errors: JobError[];
}

export interface JobError {
  domainId: string;
  timestamp: string;
  message: string;
  retryable: boolean;
}

export interface JobProgress {
  jobId: string;
  status: JobStatus;
  percentComplete: number;
  currentDomain?: string;
  questionsGenerated: number;
  questionsValidated: number;
  questionsRejected: number;
}

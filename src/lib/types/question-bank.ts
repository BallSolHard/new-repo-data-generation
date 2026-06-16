// Question bank types — persistent question storage with lifecycle, coverage, and quality tracking

import type { QuestionType } from './exam-guide';
import type { Difficulty, MatchingPairs, MatchingAnswers } from './reference-question';
import type { CertTier, GenMode } from './tier';

// Question lifecycle: generated → validated → active → stale → retired
export type QuestionStatus =
  | 'generated'      // Produced by pipeline, not yet validated
  | 'validated'      // Passed AI validation
  | 'active'         // Live in question bank, available for quizzes/mocks
  | 'stale'          // Exam guide changed — may need regeneration
  | 'retired'        // No longer valid for current exam version
  | 'rejected';      // Failed validation — kept for dedup reference

export interface QuestionCoverage {
  domainId: string;
  taskIds: string[];                    // Which tasks this question tests
  knowledgeStatementIds: string[];      // Which KS this question covers
  servicesTested: string[];             // AWS services referenced in question/answer
}

export interface QuestionQuality {
  validationScore: number;              // 0–1, from AI validation confidence
  validationConfidence: 'high' | 'medium' | 'low';
  validationNotes?: string;
  factualErrors?: string[];
}

export interface BankQuestion {
  // Identity
  id: string;                           // e.g. "bq_SAA-C03_d1_001"
  certificationCode: string;
  examGuideVersion: string;

  // Content
  text: string;
  type: QuestionType;
  options: string[] | Record<string, string>;
  correctAnswer: string | number[] | null;
  explanation: string;
  difficulty: Difficulty;
  pairs?: MatchingPairs;
  matches?: MatchingAnswers;

  // Coverage & traceability
  coverage: QuestionCoverage;

  // Quality & lifecycle
  status: QuestionStatus;
  quality: QuestionQuality;

  // V2 tier/mode
  certTier?: CertTier;
  genMode?: GenMode;

  // Dedup
  contentHash: string;                  // SHA-256 of normalized question text

  // Metadata
  generationJobId?: string;
  generatedAt: string;                  // ISO date
  validatedAt?: string;
  activatedAt?: string;
  retiredAt?: string;
}

// Lightweight summary for listing/filtering
export interface BankQuestionSummary {
  id: string;
  certificationCode: string;
  domainId: string;
  difficulty: Difficulty;
  type: QuestionType;
  status: QuestionStatus;
  validationScore: number;
  servicesTested: string[];
  generatedAt: string;
}

// Filters for querying the question bank
export interface QuestionBankFilters {
  certificationCode?: string;
  domainId?: string;
  taskIds?: string[];
  knowledgeStatementIds?: string[];
  services?: string[];
  difficulty?: Difficulty;
  type?: QuestionType;
  status?: QuestionStatus;
  minValidationScore?: number;
  examGuideVersion?: string;
  certTier?: CertTier;
  genMode?: GenMode;
  limit?: number;
  offset?: number;
}

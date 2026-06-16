// Reference questions — curated few-shot examples for LLM prompt injection

import type { QuestionType } from './exam-guide';
import type { CertTier, GenMode } from './tier';

export type Difficulty = 'basic' | 'intermediate' | 'advanced';
export type QuestionSource = 'official-practice' | 'community' | 'generated-validated' | 'custom';

export interface MatchingPairs {
  left: string[];
  right: string[];
}

export interface MatchingAnswers {
  left: number[];
  right: number[];
}

export interface ReferenceQuestion {
  id: string;                      // Unique ID, e.g. "ref-saa-c03-d1-001"
  certificationCode: string;       // e.g. "SAA-C03"
  domainId: string;                // Maps to ExamDomain.id
  text: string;
  type: QuestionType;
  difficulty: Difficulty;
  tags?: string[];                 // e.g. ["s3", "encryption", "sse-kms"]
  source?: QuestionSource;
  pairs?: MatchingPairs;
  matches?: MatchingAnswers;
  // V2 tier/mode
  certTier?: CertTier;
  genMode?: GenMode;
}

export interface ReferenceQuestionSet {
  certificationCode: string;
  questions: ReferenceQuestion[];
}

// Generation pipeline types — question generation, validation, and pipeline results

import type { ExamGuide, ExamDomain, QuestionType } from './exam-guide';
import type { Difficulty, MatchingPairs, MatchingAnswers, ReferenceQuestion } from './reference-question';
import type { CertTier, GenMode } from './tier';

export interface GeneratedQuestion {
  text: string;
  options: string[] | Record<string, string>;
  correct_answer: string | number[] | null;
  explanation: string;
  type?: QuestionType;
  module_id?: string;
  topic_id?: string;
  question_number?: number;
  // Validation fields
  confidence_score?: 0 | 1;
  validation_status?: 'correct' | 'incorrect' | 'validation_failed';
  validation_notes?: string;
  new_correct_answer?: string;
  new_explanation?: string;
  // Matching-specific
  pairs?: MatchingPairs;
  matches?: MatchingAnswers;
  // Exam guide traceability
  examGuideVersion?: string;
  domainId?: string;
  taskIds?: string[];
  // V2 tier/mode metadata
  certTier?: CertTier;
  genMode?: GenMode;
}

export interface QuestionGenerationParams {
  modules: ModuleInput[];
  topicName: string;
  topicDescription?: string;
  certificationName: string;
  questionsPerModule: number;
  questionTypes: QuestionType[];
  questionType?: QuestionType;
  complexityLevel?: Difficulty;
  isProfessionalOrSpecialty?: boolean;
  // Exam guide context
  examGuide?: ExamGuide;
  domainContext?: ExamDomain;
  fewShotExamples?: ReferenceQuestion[];
  examGuideVersion?: string;
  // V2 tier/mode
  certTier?: CertTier;
  genMode?: GenMode;
}

export interface ModuleInput {
  module_id: string;
  module_name: string;
  module_description?: string;
  module_content?: string;
}

export interface ValidationResponse {
  is_correct: boolean;
  correct_answer_index: string | number[] | { left: number[]; right: number[] };
  confidence: 'high' | 'medium' | 'low';
  validation_notes: string;
}

export interface PipelineResult {
  success: boolean;
  sqlScript: string;
  questionCount: number;
  validatedCount: number;
  rejectedCount: number;
  examGuideVersion: string;
  generationTimestamp: string;
  questions: GeneratedQuestion[];
  // Returned for downstream use (e.g., question bank storage)
  domainContext?: ExamDomain;
}

export interface PipelineParams {
  certificationCode: string;
  certificationName: string;
  certificationId: number;
  topicId: string;
  topicName: string;
  topicDescription?: string;
  quizId: string;
  modules: ModuleInput[];
  questionType?: QuestionType;
  questionTypes?: QuestionType[];
  complexityLevel?: Difficulty;
  questionsPerModule?: number;
  enableValidation?: boolean;
  // V2 tier/mode
  certTier?: CertTier;
  genMode?: GenMode;
}

export interface MockPipelineParams {
  certificationCode: string;
  certificationName: string;
  certificationId: number;
  title: string;
  duration: number;
  totalQuestions: number;
  passingScore: number;
  questionType?: QuestionType;
  questionTypes?: QuestionType[];
  complexityLevel?: Difficulty;
  enableValidation?: boolean;
  modules: ModuleInput[];
  topicModuleMap: Record<string, { topicName: string; topicDescription?: string; modules: ModuleInput[] }>;
  // V2 tier/mode
  certTier?: CertTier;
  genMode?: GenMode;
}

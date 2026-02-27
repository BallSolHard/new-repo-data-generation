// Interface for matching question pairs
export interface MatchingPairs {
  left: string[];
  right: string[];
}

// Interface for matching question answers
export interface MatchingAnswers {
  left: number[];
  right: number[];
}

// Interface for generated question
export interface GeneratedQuestion {
  text: string;
  options: string[] | { [key: string]: string }; // string[] for mcq/multiple/ordering, object for matching
  correct_answer: string | number[] | null; // string for mcq, number[] for multiple/ordering, null for matching
  explanation: string;
  type?: 'mcq' | 'multiple' | 'ordering' | 'matching'; // Add matching type
  module_id?: string;
  topic_id?: string;
  question_number?: number;
  confidence_score?: 0 | 1; // Simple binary score
  validation_status?: 'correct' | 'incorrect' | 'validation_failed';
  validation_notes?: string;
  new_correct_answer?: string; // Suggested correct answer (if incorrect)
  new_explanation?: string; // Suggested explanation (if incorrect)
  pairs?: MatchingPairs; // For matching questions only
  matches?: MatchingAnswers; // For matching questions only
}

// Interface for validation response
export interface ValidationResponse {
  is_correct: boolean;
  correct_answer_index: string | number[] | MatchingAnswers; // string for mcq, number[] for multiple/ordering, MatchingAnswers for matching
  confidence: 'high' | 'medium' | 'low';
  validation_notes: string;
}

// Interface for question generation parameters
export interface QuestionGenerationParams {
  modules: any[];
  topicName: string;
  topicDescription?: string; // Optional topic description for better context
  certificationName: string;
  questionsPerModule: number;
  questionTypes: string[];
  questionType?: string; // Optional: "mcq", "multiple", or "ordering"
  complexityLevel?: string; // Optional: "basic", "intermediate", "advanced"
  isProfessionalOrSpecialty?: boolean; // Optional: true for Professional/Specialty certifications
}

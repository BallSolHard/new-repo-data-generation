// Interface for generated question
export interface GeneratedQuestion {
  text: string;
  options: string[];
  correct_answer: string;
  explanation: string;
  module_id?: string;
  question_number?: number;
  confidence_score?: 0 | 1; // Simple binary score
  validation_status?: 'correct' | 'incorrect' | 'validation_failed';
  validation_notes?: string;
  new_correct_answer?: string; // Suggested correct answer (if incorrect)
  new_explanation?: string; // Suggested explanation (if incorrect)
}

// Interface for validation response
export interface ValidationResponse {
  is_correct: boolean;
  correct_answer_index: string;
  confidence: 'high' | 'medium' | 'low';
  validation_notes: string;
}

// Interface for question generation parameters
export interface QuestionGenerationParams {
  modules: any[];
  topicName: string;
  certificationName: string;
  questionsPerModule: number;
  certificationContext: {
    services: string[];
    focus: string;
  };
  questionTypes: string[];
}

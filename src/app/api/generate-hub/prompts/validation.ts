// Interface for generated question
interface GeneratedQuestion {
  text: string;
  options: string[];
  correct_answer: string;
  explanation: string;
  module_id?: string;
  question_number?: number;
  confidence_score?: 0 | 1;
  validation_status?: 'correct' | 'incorrect' | 'validation_failed';
  validation_notes?: string;
  new_correct_answer?: string;
  new_explanation?: string;
}

/**
 * Creates a validation prompt for verifying the correctness of a multiple-choice question
 * @param question - The generated question to validate
 * @param certificationName - The name of the certification (e.g., "AWS Solutions Architect")
 * @returns A formatted prompt string for LLM validation
 */
export function createValidationPrompt(question: GeneratedQuestion, certificationName: string): string {
  return `You are an expert ${certificationName} certification validator. Analyze this multiple-choice question and determine if the indicated correct answer is actually correct.
QUESTION TO VALIDATE:
${question.text}

OPTIONS:
A) ${question.options[0]}
B) ${question.options[1]}
C) ${question.options[2]}
D) ${question.options[3]}

CLAIMED CORRECT ANSWER: ${question.correct_answer}
EXPLANATION PROVIDED: ${question.explanation}

TASK: Verify if the claimed correct answer is indeed correct for ${certificationName} certification standards.

RESPOND WITH JSON ONLY:
{
  "is_correct": true/false,
  "correct_answer_index": "0-3 (actual correct answer index)",
  "confidence": "high/medium/low",
  "validation_notes": "Brief explanation of your assessment"
}`;
}

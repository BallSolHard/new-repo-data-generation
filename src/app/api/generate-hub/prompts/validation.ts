// Interface for generated question - matches the types.ts interface
interface GeneratedQuestion {
  text: string;
  options: string[];
  correct_answer: string | number[]; // Updated to support ordering and multiple select
  explanation: string;
  type?: 'mcq' | 'multiple' | 'ordering'; // Add type field
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
  let claimedAnswers = "";
  let validationInstructions = "";
  let claimedIndices: number[] = [];
  
  // Handle different answer formats based on type and format
  if (question.type === 'ordering') {
    // Ordering questions
    if (Array.isArray(question.correct_answer)) {
      claimedIndices = question.correct_answer;
    } else if (typeof question.correct_answer === 'string') {
      try {
        claimedIndices = JSON.parse(question.correct_answer);
      } catch {
        claimedIndices = [0, 1, 2, 3]; // Default ordering
      }
    }
    
    claimedAnswers = claimedIndices.map((index, position) => 
      `${position + 1}. ${question.options[index]}`
    ).join('\n');
    
    validationInstructions = `
IMPORTANT: This is an ORDERING question. Options must be arranged in the correct sequence.

The question claims this sequence is correct:
${claimedAnswers}

VALIDATION CHECKLIST:
✓ Is this sequence logically correct?
✓ Are there any steps that should come earlier or later?
✓ Are all necessary steps included in the right order?`;
    
  } else if (question.type === 'multiple' || (typeof question.correct_answer === 'string' && question.correct_answer.startsWith('[') && question.correct_answer.endsWith(']'))) {
    // Multiple select questions
    if (Array.isArray(question.correct_answer)) {
      claimedIndices = question.correct_answer;
    } else if (typeof question.correct_answer === 'string') {
      try {
        claimedIndices = JSON.parse(question.correct_answer);
      } catch {
        claimedIndices = [0]; // Fallback
      }
    }
    
    const answerOptions = claimedIndices.map((index: number) => `${String.fromCharCode(65 + index)}) ${question.options[index]}`).join(" AND ");
    claimedAnswers = `Options ${claimedIndices.map(i => String.fromCharCode(65 + i)).join(", ")} - ${answerOptions}`;
    
    validationInstructions = `
IMPORTANT: This is a MULTIPLE SELECT question. The user can select 2-3 options that are ALL correct.

VALIDATION CHECKLIST:
✓ Are ALL claimed options (${claimedIndices.map(i => String.fromCharCode(65 + i)).join(", ")}) correct?
✓ Are there any OTHER correct options that should also be selected?
✓ Are any of the claimed options actually incorrect?

You must provide the COMPLETE list of ALL correct answer indices (typically 2-3 options).`;
    
  } else {
    // Single answer questions (mcq)
    if (typeof question.correct_answer === 'string') {
      const answerMatch = question.correct_answer.match(/\{(\d+)\}/);
      if (answerMatch) {
        const index = parseInt(answerMatch[1]);
        claimedAnswers = `Option ${String.fromCharCode(65 + index)} - ${question.options[index]}`;
        validationInstructions = `
IMPORTANT: This is a SINGLE CHOICE question. Only ONE option should be correct.

VALIDATION CHECKLIST:
✓ Is the claimed option (${String.fromCharCode(65 + index)}) the BEST answer?
✓ Are the other options clearly inferior or incorrect?`;
      } else {
        claimedAnswers = question.correct_answer;
        validationInstructions = "Please validate if this answer is correct.";
      }
    } else if (Array.isArray(question.correct_answer)) {
      // Handle array format for single answer
      const index = question.correct_answer[0] || 0;
      claimedAnswers = `Option ${String.fromCharCode(65 + index)} - ${question.options[index]}`;
      validationInstructions = `
IMPORTANT: This is a SINGLE CHOICE question. Only ONE option should be correct.

VALIDATION CHECKLIST:
✓ Is the claimed option (${String.fromCharCode(65 + index)}) the BEST answer?
✓ Are the other options clearly inferior or incorrect?`;
    }
  }

  // Determine question type for response format
  const responseType = question.type === 'ordering' ? 'ordering' :
                      question.type === 'multiple' ? 'multiple' : 
                      'single';

  return `You are an expert ${certificationName} certification validator. 

QUESTION TO VALIDATE:
${question.text}

ALL OPTIONS:
A) ${question.options[0]}
B) ${question.options[1]}
C) ${question.options[2]}
D) ${question.options[3]}

CLAIMED CORRECT: ${claimedAnswers}
QUESTION TYPE: ${responseType.toUpperCase()}
GIVEN EXPLANATION: ${question.explanation}

${validationInstructions}

CRITICAL: You MUST respond with ONLY valid JSON in this exact format:

${responseType === 'ordering' ? `{
  "is_correct": false,
  "correct_answer_index": [0, 1, 2, 3],
  "confidence": "high",
  "validation_notes": "Brief explanation of the correct sequence"
}` : responseType === 'multiple' ? `{
  "is_correct": false,
  "correct_answer_index": [0, 1],
  "confidence": "high",
  "validation_notes": "Brief explanation of why these specific options are correct"
}` : `{
  "is_correct": true,
  "correct_answer_index": 2,
  "confidence": "high",
  "validation_notes": "Brief explanation of why this option is correct"
}`}

RULES:
- ONLY return the JSON object above
- NO additional text, explanations, or markdown
- For ordering: correct_answer_index must be an array showing correct sequence [0,1,2,3]
- For multiple select: correct_answer_index must be an array of numbers [0,1,2]
- For single choice: correct_answer_index must be a single number 0-3
- confidence must be "high", "medium", or "low"
- Keep validation_notes under 100 words`;
}

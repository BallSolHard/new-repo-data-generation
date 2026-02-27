// Interface for matching question pairs
interface MatchingPairs {
  left: string[];
  right: string[];
}

// Interface for matching question answers
interface MatchingAnswers {
  left: number[];
  right: number[];
}

// Interface for generated question - matches the types.ts interface
interface GeneratedQuestion {
  text: string;
  options: string[] | { [key: string]: string }; // Updated to support matching questions object format
  correct_answer: string | number[] | null; // Updated to support matching (null), ordering and multiple select
  explanation: string;
  type?: 'mcq' | 'multiple' | 'ordering' | 'matching'; // Add matching type
  module_id?: string;
  question_number?: number;
  confidence_score?: 0 | 1;
  validation_status?: 'correct' | 'incorrect' | 'validation_failed';
  validation_notes?: string;
  new_correct_answer?: string;
  new_explanation?: string;
  pairs?: MatchingPairs; // For matching questions only
  matches?: MatchingAnswers; // For matching questions only
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
  if (question.type === 'matching') {
    // Matching questions - validate the matches
    if (question.pairs && question.matches) {
      claimedAnswers = question.pairs.left.map((leftItem, index) => {
        const rightIndex = question.matches!.right[index];
        const rightItem = question.pairs!.right[rightIndex];
        return `${leftItem} → ${rightItem}`;
      }).join('\n');
    } else {
      claimedAnswers = "Matching pairs not properly defined";
    }
    
    validationInstructions = `
IMPORTANT: This is a MATCHING question. Verify that each term is correctly matched with its description.

The question claims these matches are correct:
${claimedAnswers}

VALIDATION CHECKLIST:
✓ Does each left item match correctly with its paired right item?
✓ Are all the relationships factually accurate?
✓ Are any matches incorrect or could be improved?
✓ TEXT LENGTH CHECK: Are left items concise (1-3 words max)?
✓ TEXT LENGTH CHECK: Are right items brief (6-10 words max, fit in 2 lines)?
✓ REJECT if any text is too long - matching pairs must be concise for good UI display`;
    
  } else if (question.type === 'ordering') {
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
    
    // Type guard to ensure options is an array for ordering questions
    if (Array.isArray(question.options)) {
      const optionsArray = question.options as string[];
      claimedAnswers = claimedIndices.map((index, position) => 
        `${position + 1}. ${optionsArray[index]}`
      ).join('\n');
    } else {
      claimedAnswers = "Options format error for ordering question";
    }
    
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
    
    // Type guard to ensure options is an array for multiple select questions
    if (Array.isArray(question.options)) {
      const optionsArray = question.options as string[];
      const answerOptions = claimedIndices.map((index: number) => `${String.fromCharCode(65 + index)}) ${optionsArray[index]}`).join(" AND ");
      claimedAnswers = `Options ${claimedIndices.map(i => String.fromCharCode(65 + i)).join(", ")} - ${answerOptions}`;
    } else {
      claimedAnswers = "Options format error for multiple select question";
    }
    
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
      if (answerMatch && Array.isArray(question.options)) {
        const index = parseInt(answerMatch[1]);
        const optionsArray = question.options as string[];
        claimedAnswers = `Option ${String.fromCharCode(65 + index)} - ${optionsArray[index]}`;
        validationInstructions = `
IMPORTANT: This is a SINGLE CHOICE question. Only ONE option should be correct.

VALIDATION CHECKLIST:
✓ Is the claimed option (${String.fromCharCode(65 + index)}) the BEST answer?
✓ Are the other options clearly inferior or incorrect?`;
      } else {
        claimedAnswers = question.correct_answer;
        validationInstructions = "Please validate if this answer is correct.";
      }
    } else if (Array.isArray(question.correct_answer) && Array.isArray(question.options)) {
      // Handle array format for single answer
      const index = question.correct_answer[0] || 0;
      const optionsArray = question.options as string[];
      claimedAnswers = `Option ${String.fromCharCode(65 + index)} - ${optionsArray[index]}`;
      validationInstructions = `
IMPORTANT: This is a SINGLE CHOICE question. Only ONE option should be correct.

VALIDATION CHECKLIST:
✓ Is the claimed option (${String.fromCharCode(65 + index)}) the BEST answer?
✓ Are the other options clearly inferior or incorrect?`;
    }
  }

  // Determine question type for response format
  const responseType = question.type === 'matching' ? 'matching' :
                      question.type === 'ordering' ? 'ordering' :
                      question.type === 'multiple' ? 'multiple' : 
                      'single';

  // Format options display based on question type
  let optionsDisplay = '';
  if (question.type === 'matching') {
    if (question.pairs) {
      optionsDisplay = `LEFT ITEMS:\n${question.pairs.left.map((item, i) => `${i + 1}. ${item}`).join('\n')}\n\nRIGHT ITEMS:\n${question.pairs.right.map((item, i) => `${String.fromCharCode(65 + i)}. ${item}`).join('\n')}`;
    } else {
      optionsDisplay = 'Matching pairs not properly defined';
    }
  } else if (Array.isArray(question.options)) {
    const optionsArray = question.options as string[];
    optionsDisplay = `A) ${optionsArray[0]}\nB) ${optionsArray[1]}\nC) ${optionsArray[2]}\nD) ${optionsArray[3]}`;
  } else {
    optionsDisplay = 'Options format not supported for validation';
  }

  return `You are an expert ${certificationName} certification validator. 

QUESTION TO VALIDATE:
${question.text}

ALL OPTIONS:
${optionsDisplay}

CLAIMED CORRECT: ${claimedAnswers}
QUESTION TYPE: ${responseType.toUpperCase()}
GIVEN EXPLANATION: ${question.explanation}

${validationInstructions}

CRITICAL: You MUST respond with ONLY valid JSON in this exact format:

${responseType === 'matching' ? `{
  "is_correct": false,
  "correct_answer_index": {"left": [0, 1, 2], "right": [1, 0, 2]},
  "confidence": "high",
  "validation_notes": "Brief explanation of the correct matches"
}` : responseType === 'ordering' ? `{
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
- For matching: correct_answer_index must be an object with left and right arrays showing correct matches
- For ordering: correct_answer_index must be an array showing correct sequence [0,1,2,3]
- For multiple select: correct_answer_index must be an array of numbers [0,1,2]
- For single choice: correct_answer_index must be a single number 0-3
- confidence must be "high", "medium", or "low"
- Keep validation_notes under 100 words`;
}

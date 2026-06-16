import type { GeneratedQuestion } from '@/lib/types/generation';
import type { ExamDomain } from '@/lib/types/exam-guide';

/**
 * Build a validation prompt for a single generated question.
 * The validation model checks factual accuracy, answer correctness,
 * distractor plausibility, and explanation quality.
 */
export function createValidationPrompt(
  question: GeneratedQuestion,
  certificationName: string,
  domainContext?: ExamDomain
): string {
  const servicesContext = domainContext
    ? `\nIN-SCOPE SERVICES: ${domainContext.inScopeServices.map(s => s.name).join(', ')}`
    : '';

  const basePrompt = `You are a senior ${certificationName} subject matter expert performing quality assurance on an exam question. Your job is to verify FACTUAL ACCURACY.

CERTIFICATION: ${certificationName}${servicesContext}

QUESTION TO VALIDATE:
Text: ${question.text}
Type: ${question.type || 'mcq'}
Options: ${JSON.stringify(question.options, null, 2)}
Claimed Correct Answer: ${JSON.stringify(question.correct_answer)}
Explanation: ${question.explanation}`;

  const typeSpecificInstructions = getTypeSpecificValidation(question);

  return `${basePrompt}

${typeSpecificInstructions}

VALIDATION CHECKLIST — evaluate each item:
1. FACTUAL ACCURACY: Is every fact stated in the question, options, and explanation technically correct according to current AWS documentation?
2. CORRECT ANSWER: Is the claimed correct answer actually the BEST answer? Could any other option be argued as equally or more correct?
3. DISTRACTOR QUALITY: Are all wrong answers plausible but clearly incorrect? Is any wrong answer actually correct?
4. EXPLANATION ACCURACY: Does the explanation correctly describe why the answer is right and why wrong answers are wrong?
5. SERVICE NAMES: Are all AWS service names exact and current? (e.g., "Amazon S3" not "AWS S3")
6. SERVICE BEHAVIOR: Are all described service behaviors, limits, and characteristics accurate?

RESPOND WITH ONLY THIS JSON (no markdown, no other text):
${getValidationResponseFormat(question)}`;
}

function getTypeSpecificValidation(question: GeneratedQuestion): string {
  switch (question.type) {
    case 'multiple':
      return `This is a MULTIPLE SELECT question. Verify:
- ALL claimed correct options are genuinely correct
- ALL unclaimed options are genuinely incorrect
- The number of correct answers matches what the question states (e.g., "Select TWO")`;

    case 'ordering':
      return `This is an ORDERING question. Verify:
- The claimed sequence is the CORRECT logical order
- No reasonable alternative ordering exists that would be equally valid
- Each step logically follows from the previous one`;

    case 'matching':
      return `This is a MATCHING question. Verify:
- Every pairing in the matches is factually correct
- No alternative pairing would be more accurate
- Left and right items are clearly and unambiguously matched`;

    default:
      return `This is a SINGLE ANSWER (MCQ) question. Verify:
- The claimed correct answer is the BEST and ONLY defensible answer
- No other option could reasonably be argued as correct
- The question has exactly one unambiguous correct answer`;
  }
}

function getValidationResponseFormat(question: GeneratedQuestion): string {
  switch (question.type) {
    case 'multiple':
      return `{
  "is_correct": true/false,
  "correct_answer_index": [0, 2],
  "confidence": "high" | "medium" | "low",
  "validation_notes": "Brief explanation of your assessment. If incorrect, explain what the real answer should be and why.",
  "factual_errors": ["List any factual errors found, or empty array if none"],
  "suggested_explanation": "Only include this if the original explanation has errors — provide corrected explanation"
}`;

    case 'ordering':
      return `{
  "is_correct": true/false,
  "correct_answer_index": [0, 1, 2, 3],
  "confidence": "high" | "medium" | "low",
  "validation_notes": "Brief explanation of your assessment. If incorrect, provide the correct sequence.",
  "factual_errors": [],
  "suggested_explanation": ""
}`;

    case 'matching':
      return `{
  "is_correct": true/false,
  "correct_answer_index": {"left": [0, 1, 2], "right": [0, 1, 2]},
  "confidence": "high" | "medium" | "low",
  "validation_notes": "Brief explanation of your assessment. If incorrect, provide correct pairings.",
  "factual_errors": [],
  "suggested_explanation": ""
}`;

    default:
      return `{
  "is_correct": true/false,
  "correct_answer_index": 1,
  "confidence": "high" | "medium" | "low",
  "validation_notes": "Brief explanation of your assessment. If incorrect, state which option is actually correct and why.",
  "factual_errors": ["List any factual errors found, or empty array if none"],
  "suggested_explanation": "Only include this if the original explanation has errors — provide corrected explanation"
}`;
  }
}

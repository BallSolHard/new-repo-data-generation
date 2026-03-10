// Validation prompt builder — "Red Team" adversarial validator with tier compliance

import type { GeneratedQuestion } from '@/lib/types/generation';
import type { ExamDomain, ExamTask } from '@/lib/types/exam-guide';
import type { CertTier } from '@/lib/types/tier';
import { getTierProfile } from './tier-profiles';

export interface ValidationPromptParams {
  question: GeneratedQuestion;
  certificationName: string;
  certTier: CertTier;
  domainContext?: ExamDomain;
  targetTask?: ExamTask;
}

/**
 * Validation response for questions.
 * Focuses on: 1) Factual correctness 2) Explanation quality
 */
export interface ValidationResponse {
  is_correct: boolean;
  correct_answer_index: string | number[] | { left: number[]; right: number[] };
  confidence: 'high' | 'medium' | 'low';
  validation_notes: string;
  factual_errors?: string[];
  suggested_explanation?: string;
}

export function createValidationPrompt(params: ValidationPromptParams): string {
  const { question, certificationName, certTier } = params;
  const typeSpecific = getTypeSpecificValidation(question);

  return `You are a validator reviewing a ${certificationName} exam question. Focus ONLY on these two critical aspects:

QUESTION TO VALIDATE:
Text: ${question.text}
Type: ${question.type || 'mcq'}
Options: ${JSON.stringify(question.options, null, 2)}
Claimed Correct Answer: ${JSON.stringify(question.correct_answer)}
Explanation: ${question.explanation}

${typeSpecific}

VALIDATION CHECKLIST — check ONLY these two things:

1. FACTUAL CORRECTNESS:
   - Is the question stem factually correct according to AWS documentation?
   - Is the claimed correct answer actually correct?
   - Are all options real and plausible?
   - Flag any technical inaccuracies, wrong service capabilities, or incorrect behaviors.

2. EXPLANATION QUALITY:
   - Does the explanation clearly state WHY the correct option is right?
   - Does the explanation explain WHY each incorrect option is wrong?
   - Is the explanation clear, complete, and accurate?
   - No ambiguity or missing reasoning.

RESPOND WITH ONLY THIS JSON (no markdown, no other text):
{
  "is_correct": true/false,
  "correct_answer_index": ${getAnswerFormat(question)},
  "confidence": "high" | "medium" | "low",
  "validation_notes": "Brief assessment. If incorrect, explain what is wrong.",
  "factual_errors": ["List any factual errors, or empty array if none"],
  "suggested_explanation": "Only if explanation needs improvement — provide corrected version"
}`;
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

function getAnswerFormat(question: GeneratedQuestion): string {
  switch (question.type) {
    case 'multiple':
      return '[0, 2]';
    case 'ordering':
      return '[0, 1, 2, 3]';
    case 'matching':
      return '{"left": [0, 1, 2], "right": [0, 1, 2]}';
    default:
      return '1';
  }
}

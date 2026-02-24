// V2 validation prompt builder — "Red Team" adversarial validator with tier compliance

import type { GeneratedQuestion } from '@/lib/types/generation';
import type { ExamDomain, ExamTask } from '@/lib/types/exam-guide';
import type { CertTier } from '@/lib/types/tier';
import { getTierProfile } from './tier-profiles';

export interface V2ValidationPromptParams {
  question: GeneratedQuestion;
  certificationName: string;
  certTier: CertTier;
  domainContext?: ExamDomain;
  targetTask?: ExamTask;
}

/**
 * V2 validation response extends the standard response with tier compliance metadata.
 * IMPORTANT: tier_compliance is used internally by validate.ts for pass/fail decisions
 * and MUST be stripped before passing questions downstream.
 */
export interface V2ValidationResponse {
  is_correct: boolean;
  correct_answer_index: string | number[] | { left: number[]; right: number[] };
  confidence: 'high' | 'medium' | 'low';
  validation_notes: string;
  factual_errors?: string[];
  suggested_explanation?: string;
  tier_compliance: {
    stem_length_ok: boolean;
    cognitive_level_ok: boolean;
    notes: string;
  };
}

export function createV2ValidationPrompt(params: V2ValidationPromptParams): string {
  const { question, certificationName, certTier, domainContext, targetTask } = params;
  const tierProfile = getTierProfile(certTier);

  const servicesContext = domainContext
    ? `\nIN-SCOPE SERVICES: ${domainContext.inScopeServices.map(s => s.name).join(', ')}`
    : '';

  // Collect anti-patterns from domain or targeted task
  const antiPatterns = targetTask?.antiPatterns
    || domainContext?.tasks.flatMap(t => t.antiPatterns || [])
    || [];

  const antiPatternSection = antiPatterns.length > 0
    ? `\nKNOWN ANTI-PATTERNS FOR THIS DOMAIN:\n${antiPatterns.map(ap => `- [${ap.id}] ${ap.misconception}: ${ap.whyWrong}`).join('\n')}`
    : '';

  const typeSpecific = getTypeSpecificValidation(question);

  return `You are a HOSTILE adversarial reviewer performing red-team quality assurance on a ${certificationName} exam question. Assume the question is WRONG until you prove otherwise. Your job is to find every possible flaw.

CERTIFICATION: ${certificationName}
TIER: ${certTier.toUpperCase()}${servicesContext}
${antiPatternSection}

TIER COMPLIANCE REQUIREMENTS:
- Stem length must be ${tierProfile.stemLength} (${tierProfile.stemWordRange[0]}-${tierProfile.stemWordRange[1]} words)
- Cognitive level must be: ${tierProfile.cognitiveLevel}
- Service interaction: ${tierProfile.serviceInteraction}
- Distractor strategy: ${tierProfile.distractorStrategy}

QUESTION TO VALIDATE:
Text: ${question.text}
Type: ${question.type || 'mcq'}
Options: ${JSON.stringify(question.options, null, 2)}
Claimed Correct Answer: ${JSON.stringify(question.correct_answer)}
Explanation: ${question.explanation}

${typeSpecific}

RED-TEAM VALIDATION CHECKLIST — be aggressive on every item:

1. FACTUAL ACCURACY: Is EVERY fact stated in the question, options, and explanation technically correct according to CURRENT AWS documentation? Flag ANY claim you cannot verify with certainty.

2. CORRECT ANSWER: Is the claimed correct answer actually the BEST answer? Actively try to argue for each wrong answer — if you can construct a reasonable argument for any distractor, the question is ambiguous.

3. DISTRACTOR QUALITY: Are all wrong answers plausible but clearly incorrect? Do any distractors embody the known anti-patterns listed above? If distractors are too easy to eliminate, flag this.

4. ANTI-PATTERN ALIGNMENT: Do the distractors represent realistic misconceptions? A good question should have at least one distractor that matches a known anti-pattern for this domain.

5. EXPLANATION ACCURACY: Does the explanation correctly describe why the answer is right AND why each wrong answer is wrong? Is anything misleading or incomplete?

6. SERVICE NAMES: Are all AWS service names exact and current? (e.g., "Amazon S3" not "AWS S3")

7. SERVICE BEHAVIOR: Are all described service behaviors, limits, and characteristics accurate as of the current AWS documentation?

8. TIER COMPLIANCE: Does the stem length fall within ${tierProfile.stemWordRange[0]}-${tierProfile.stemWordRange[1]} words? Is the cognitive level appropriate for ${certTier} (${tierProfile.cognitiveLevel})? Does the scenario complexity match the tier?

RESPOND WITH ONLY THIS JSON (no markdown, no other text):
{
  "is_correct": true/false,
  "correct_answer_index": ${getAnswerFormat(question)},
  "confidence": "high" | "medium" | "low",
  "validation_notes": "Detailed explanation of your assessment. If incorrect, explain what the real answer should be and why.",
  "factual_errors": ["List any factual errors found, or empty array if none"],
  "suggested_explanation": "Only include if the original explanation has errors — provide corrected explanation",
  "tier_compliance": {
    "stem_length_ok": true/false,
    "cognitive_level_ok": true/false,
    "notes": "Brief assessment of tier compliance — does this question match the ${certTier} tier profile?"
  }
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

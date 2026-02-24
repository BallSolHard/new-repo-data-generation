import type { GeneratedQuestion, ValidationResponse } from '@/lib/types/generation';
import type { ExamDomain } from '@/lib/types/exam-guide';
import type { CertTier } from '@/lib/types/tier';
import { getValidationModel, parseGeminiJson } from '@/lib/gemini/client';
import { createValidationPrompt } from '@/lib/prompts/validation';
import { createV2ValidationPrompt, type V2ValidationResponse } from '@/lib/prompts/v2-validation';

interface ValidateOptions {
  certificationName: string;
  domainContext?: ExamDomain;
  rejectLowConfidence?: boolean; // default: true
  certTier?: CertTier;
}

interface ValidationResult {
  validated: GeneratedQuestion[];
  rejected: GeneratedQuestion[];
}

/**
 * Validate step: run each generated question through the validation model.
 *
 * Uses a separate Gemini instance with conservative temperature (0.3) to verify
 * factual accuracy, answer correctness, and explanation quality.
 */
export async function validate(
  questions: GeneratedQuestion[],
  options: ValidateOptions
): Promise<ValidationResult> {
  const { certificationName, domainContext, rejectLowConfidence = true, certTier } = options;
  const isV2 = !!certTier;
  const model = getValidationModel(isV2);

  const validated: GeneratedQuestion[] = [];
  const rejected: GeneratedQuestion[] = [];

  console.log(`[validate] Validating ${questions.length} questions...`);

  // Process questions in parallel batches of 5 to stay within rate limits
  const batchSize = 5;
  for (let i = 0; i < questions.length; i += batchSize) {
    const batch = questions.slice(i, i + batchSize);
    const results = await Promise.allSettled(
      batch.map(q => isV2 && certTier
        ? validateSingleQuestionV2(model, q, certificationName, certTier, domainContext)
        : validateSingleQuestion(model, q, certificationName, domainContext)
      )
    );

    for (let j = 0; j < results.length; j++) {
      const question = batch[j];
      const result = results[j];

      if (result.status === 'rejected') {
        console.warn(`[validate] Validation call failed for question: ${result.reason}`);
        question.validation_status = 'validation_failed';
        question.confidence_score = 0;
        rejected.push(question);
        continue;
      }

      const validation = result.value;
      question.validation_status = validation.is_correct ? 'correct' : 'incorrect';
      question.confidence_score = validation.is_correct ? 1 : 0;
      question.validation_notes = validation.validation_notes;

      // If validation says the answer is wrong, apply correction
      if (!validation.is_correct && validation.correct_answer_index !== undefined) {
        question.new_correct_answer = typeof validation.correct_answer_index === 'object'
          ? JSON.stringify(validation.correct_answer_index)
          : `{${validation.correct_answer_index}}`;
      }

      // Reject low-confidence or incorrect questions
      if (rejectLowConfidence && (validation.confidence === 'low' || !validation.is_correct)) {
        rejected.push(question);
      } else {
        validated.push(question);
      }
    }
  }

  console.log(`[validate] Results: ${validated.length} passed, ${rejected.length} rejected`);
  return { validated, rejected };
}

async function validateSingleQuestion(
  model: ReturnType<typeof getValidationModel>,
  question: GeneratedQuestion,
  certificationName: string,
  domainContext?: ExamDomain
): Promise<ValidationResponse> {
  const prompt = createValidationPrompt(question, certificationName, domainContext);
  const result = await model.generateContent(prompt);
  const responseText = result.response.text();

  const validation = parseGeminiJson<ValidationResponse & { factual_errors?: string[]; suggested_explanation?: string }>(responseText);

  // If there are factual errors, flag the question
  if (validation.factual_errors && validation.factual_errors.length > 0) {
    validation.validation_notes = `FACTUAL ERRORS: ${validation.factual_errors.join('; ')}. ${validation.validation_notes || ''}`;
    validation.is_correct = false;
    validation.confidence = 'low';
  }

  return validation;
}

/**
 * V2 validation: red-team adversarial check with tier compliance.
 * Uses Gemini Pro for higher reasoning. Strips tier_compliance before returning
 * a standard ValidationResponse (Constraint 1: schema isolation).
 */
async function validateSingleQuestionV2(
  model: ReturnType<typeof getValidationModel>,
  question: GeneratedQuestion,
  certificationName: string,
  certTier: CertTier,
  domainContext?: ExamDomain
): Promise<ValidationResponse> {
  const prompt = createV2ValidationPrompt({
    question,
    certificationName,
    certTier,
    domainContext,
  });

  const result = await model.generateContent(prompt);
  const responseText = result.response.text();

  const v2Validation = parseGeminiJson<V2ValidationResponse>(responseText);

  // Use tier compliance to influence pass/fail decision
  if (v2Validation.tier_compliance) {
    const { stem_length_ok, cognitive_level_ok, notes } = v2Validation.tier_compliance;
    if (!stem_length_ok || !cognitive_level_ok) {
      const tierNote = `TIER COMPLIANCE FAILURE: ${notes}`;
      v2Validation.validation_notes = `${tierNote}. ${v2Validation.validation_notes || ''}`;
      // Downgrade confidence if tier compliance fails
      if (v2Validation.confidence === 'high') {
        v2Validation.confidence = 'medium';
      }
    }
  }

  // If there are factual errors, flag the question
  if (v2Validation.factual_errors && v2Validation.factual_errors.length > 0) {
    v2Validation.validation_notes = `FACTUAL ERRORS: ${v2Validation.factual_errors.join('; ')}. ${v2Validation.validation_notes || ''}`;
    v2Validation.is_correct = false;
    v2Validation.confidence = 'low';
  }

  // Strip tier_compliance — return clean ValidationResponse (Constraint 1)
  return {
    is_correct: v2Validation.is_correct,
    correct_answer_index: v2Validation.correct_answer_index,
    confidence: v2Validation.confidence,
    validation_notes: v2Validation.validation_notes,
  };
}

import type { GeneratedQuestion, ValidationResponse } from '@/lib/types/generation';
import type { ExamDomain } from '@/lib/types/exam-guide';
import type { CertTier } from '@/lib/types/tier';
import { getValidationModel, parseGeminiJson } from '@/lib/gemini/client';
import { createValidationPrompt, type ValidationResponse as ValidationResponseType } from '@/lib/prompts/validation-new';

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
  const model = getValidationModel();

  const validated: GeneratedQuestion[] = [];
  const rejected: GeneratedQuestion[] = [];
  let validationFailedCount = 0;

  console.log(`[validate] Validating ${questions.length} questions...`);

  // Process questions in parallel batches of 5 to stay within rate limits
  const batchSize = 5;
  for (let i = 0; i < questions.length; i += batchSize) {
    const batch = questions.slice(i, i + batchSize);
    const results = await Promise.allSettled(
      batch.map(q => validateSingleQuestion(model, q, certificationName, certTier || 'associate', domainContext))
    );

    for (let j = 0; j < results.length; j++) {
      const question = batch[j];
      const result = results[j];

      if (result.status === 'rejected') {
        console.warn(`[validate] Validation call failed for question: ${result.reason}`);
        validationFailedCount++;
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

  console.log(`[validate] Results: ${validated.length} passed, ${rejected.length} rejected (${validationFailedCount} failed to parse)`);
  return { validated, rejected };
}

async function validateSingleQuestion(
  model: ReturnType<typeof getValidationModel>,
  question: GeneratedQuestion,
  certificationName: string,
  certTier: CertTier,
  domainContext?: ExamDomain
): Promise<ValidationResponse> {
  // Use validation with tier-aware red-team check
  const prompt = createValidationPrompt({
    question,
    certificationName,
    certTier,
    domainContext,
  });

  const result = await model.generateContent(prompt);
  const responseText = result.response.text();

  let validation: ValidationResponseType;
  try {
    validation = parseGeminiJson<ValidationResponseType>(responseText);
  } catch (parseError) {
    console.error('[validate] Failed to parse validation response:', parseError);
    console.error('[validate] Raw response (first 500 chars):', responseText.slice(0, 500));
    // If parsing fails, treat as validation failure but allow question through with low confidence
    // This prevents the entire batch from failing due to JSON parsing issues
    const fallbackAnswer = Array.isArray(question.correct_answer)
      ? question.correct_answer
      : typeof question.correct_answer === 'string'
        ? question.correct_answer
        : '0';
    return {
      is_correct: true, // Default to passing if we can't parse validation
      correct_answer_index: fallbackAnswer,
      confidence: 'low',
      validation_notes: `Validation parsing failed: ${parseError instanceof Error ? parseError.message : String(parseError)}. Question allowed through with low confidence.`,
    };
  }

  // Use tier compliance to influence pass/fail decision
  if (validation.tier_compliance) {
    const { stem_length_ok, cognitive_level_ok, notes } = validation.tier_compliance;
    if (!stem_length_ok || !cognitive_level_ok) {
      const tierNote = `TIER COMPLIANCE FAILURE: ${notes}`;
      validation.validation_notes = `${tierNote}. ${validation.validation_notes || ''}`;
      // Downgrade confidence if tier compliance fails
      if (validation.confidence === 'high') {
        validation.confidence = 'medium';
      }
    }
  }

  // If there are factual errors, flag the question
  if (validation.factual_errors && validation.factual_errors.length > 0) {
    validation.validation_notes = `FACTUAL ERRORS: ${validation.factual_errors.join('; ')}. ${validation.validation_notes || ''}`;
    validation.is_correct = false;
    validation.confidence = 'low';
  }

  // Return clean ValidationResponse
  return {
    is_correct: validation.is_correct,
    correct_answer_index: validation.correct_answer_index,
    confidence: validation.confidence,
    validation_notes: validation.validation_notes,
  };
}

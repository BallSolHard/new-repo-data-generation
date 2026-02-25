import type { GeneratedQuestion, QuestionGenerationParams } from '@/lib/types/generation';
import { getGenerationModel, parseGeminiJson } from '@/lib/gemini/client';
import { createGenerationPrompt } from '@/lib/prompts/generation';
import { createV2GenerationPrompt } from '@/lib/prompts/v2-generation';

/**
 * Generate step: call Gemini to produce exam questions.
 *
 * Builds a fully-contextualized prompt from the exam guide, modules,
 * and few-shot examples, then parses the LLM's JSON response.
 */
export async function generate(params: QuestionGenerationParams): Promise<GeneratedQuestion[]> {
  const isV2 = !!params.certTier;
  let prompt: string;

  if (isV2 && params.examGuide && params.domainContext && params.certTier) {
    // V2 path: tier-aware, mode-specific prompt
    prompt = createV2GenerationPrompt({
      examGuide: params.examGuide,
      domainContext: params.domainContext,
      certTier: params.certTier,
      genMode: params.genMode || 'simulation',
      modules: params.modules,
      totalQuestions: params.modules.length * params.questionsPerModule,
      questionTypes: params.questionTypes,
      fewShotExamples: params.fewShotExamples,
    });
  } else {
    // V1 path: existing behavior unchanged
    prompt = createGenerationPrompt({
      modules: params.modules,
      topicName: params.topicName,
      topicDescription: params.topicDescription,
      certificationName: params.certificationName,
      questionsPerModule: params.questionsPerModule,
      questionTypes: params.questionTypes,
      complexityLevel: params.complexityLevel || 'intermediate',
      isProfessionalOrSpecialty: params.isProfessionalOrSpecialty,
      examGuide: params.examGuide,
      domainContext: params.domainContext,
      fewShotExamples: params.fewShotExamples,
    });
  }

  console.log(`[generate] Calling Gemini (${isV2 ? 'v2' : 'v1'}) for ${params.modules.length} modules × ${params.questionsPerModule} questions`);

  const model = getGenerationModel(isV2);
  const result = await model.generateContent(prompt);
  const responseText = result.response.text();

  console.log(`[generate] Received response (${responseText.length} chars, first 3000 chars): ${responseText.slice(0, 3000)}`);

  let questions: GeneratedQuestion[];
  try {
    questions = parseGeminiJson<GeneratedQuestion[]>(responseText);
  } catch (error) {
    console.error('[generate] Failed to parse Gemini response:', error);
    console.error('[generate] Raw response (first 1000 chars):', responseText.slice(0, 1000));
    console.error('[generate] Raw response (last 500 chars):', responseText.slice(-500));
    
    // Provide more specific error information
    if (responseText.length < 50) {
      throw new Error(`Question generation failed: AI returned very short response (${responseText.length} chars). Response: "${responseText}"`);
    }
    
    throw new Error(`Question generation failed: could not parse LLM response as JSON. Error: ${error instanceof Error ? error.message : String(error)}`);
  }

  if (!Array.isArray(questions)) {
    console.error('[generate] Response was not an array:', typeof questions);
    throw new Error(`Question generation failed: expected JSON array, got ${typeof questions}`);
  }

  if (questions.length === 0) {
    console.warn('[generate] Warning: AI returned empty question array');
  }

  // Tag each question with exam guide metadata
  const version = params.examGuideVersion || params.examGuide?.version;
  const domainId = params.domainContext?.id;

  questions = questions.map(q => ({
    ...q,
    examGuideVersion: version,
    domainId: domainId,
    ...(params.certTier && { certTier: params.certTier }),
    ...(params.genMode && { genMode: params.genMode }),
  }));

  // Validate basic structure
  questions = questions.filter(q => {
    if (!q.text || !q.options || q.correct_answer === undefined) {
      console.warn('[generate] Skipping malformed question:', JSON.stringify(q).slice(0, 200));
      return false;
    }
    return true;
  });

  console.log(`[generate] Successfully generated ${questions.length} questions`);
  return questions;
}

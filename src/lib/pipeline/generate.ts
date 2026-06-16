import type { GeneratedQuestion, QuestionGenerationParams } from '@/lib/types/generation';
import type { ExamGuide } from '@/lib/types/exam-guide';
import { getGenerationModel as getGeminiGenerationModel, parseGeminiJson } from '@/lib/gemini/client';
import { getGenerationModel as getKimiGenerationModel, generateContent as kimiGenerateContent, parseKimiJson } from '@/lib/kimi/client';
import { createGenerationPrompt } from '@/lib/prompts/generation-new';
import type { GenerationContext } from '@/lib/prompts/generation-new';

export type AIModel = 'gemini' | 'kimi';

export interface GenerateOptions {
  aiModel?: AIModel;
  kimiWebSearchEnabled?: boolean;
}

/**
 * Generate step: call LLM (Gemini or Kimi) to produce exam questions.
 *
 * Builds a fully-contextualized prompt from the exam guide, modules,
 * and few-shot examples, then parses the LLM's JSON response.
 */
export async function generate(
  params: QuestionGenerationParams,
  generationContext: GenerationContext = 'hub',
  options?: GenerateOptions
): Promise<GeneratedQuestion[]> {
  const aiModel = options?.aiModel || 'gemini';
  const kimiWebSearchEnabled = options?.kimiWebSearchEnabled !== false;

  // Create fallback exam guide if one is not available
  let examGuide = params.examGuide;
  if (!examGuide) {
    console.warn(`[generate] ⚠️ WARNING: No exam guide found for certification "${params.certificationName}". Using fallback exam guide.`);
    // Create a minimal fallback exam guide
    examGuide = {
      certificationName: params.certificationName,
      certificationCode: 'unknown',
      provider: 'aws',
      version: '1.0',
      status: 'current' as const,
      effectiveDate: new Date().toISOString(),
      examFormat: {
        totalQuestions: 65,
        scoredQuestions: 50,
        unscoredQuestions: 15,
        passingScore: 720,
        duration: 130,
        questionTypes: params.questionTypes || ['mcq'],
      },
      domains: [],
    };
  }

  // Warn if domain context is missing
  if (!params.domainContext) {
    console.warn(`[generate] ⚠️ WARNING: Domain context not found. Proceeding with generic generation.`);
  }

  // Generate prompt using tier-aware, mode-specific approach
  const prompt = await createGenerationPrompt({
    examGuide,
    domainContext: params.domainContext,
    certTier: params.certTier || 'associate',
    genMode: params.genMode || 'drill',
    modules: params.modules,
    totalQuestions: params.modules.length * params.questionsPerModule,
    questionTypes: params.questionTypes,
    fewShotExamples: params.fewShotExamples,
    serperContext: params.serperContext,
    generationContext,
    complexityLevelDistribution: params.complexityLevelDistribution,
    currentDifficulty: params.complexityLevel,
  });
  console.log(`[generate] Calling ${aiModel} for ${params.modules.length} modules × ${params.questionsPerModule} questions`);

  let responseText: string;
  let parseFunction: typeof parseGeminiJson;

  if (aiModel === 'kimi') {
    const model = getKimiGenerationModel(kimiWebSearchEnabled);
    responseText = await kimiGenerateContent(prompt, model);
    parseFunction = parseKimiJson;
  } else {
    const model = getGeminiGenerationModel();
    const result = await model.generateContent(prompt);
    responseText = result.response.text();
    parseFunction = parseGeminiJson;
  }

  console.log(`[generate] Received response (${responseText.length} chars, first 3000 chars): ${responseText.slice(0, 3000)}`);

  let questions: GeneratedQuestion[];
  try {
    questions = parseFunction<GeneratedQuestion[]>(responseText);
  } catch (error) {
    console.error(`[generate] Failed to parse ${aiModel} response:`, error);
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

  // Distribute questions across modules and enrich with module_id if missing
  questions = questions.map((q, index) => {
    // If module_id is not set, assign one based on round-robin distribution across modules
    let assignedModuleId = q.module_id;
    if (!assignedModuleId && params.modules.length > 0) {
      const moduleIndex = index % params.modules.length;
      assignedModuleId = params.modules[moduleIndex].module_id;
    }

    return {
      ...q,
      module_id: assignedModuleId,
      examGuideVersion: version,
      domainId: domainId,
      ...(params.certTier && { certTier: params.certTier }),
      ...(params.genMode && { genMode: params.genMode }),
    };
  });

  // Validate basic structure
  questions = questions.filter(q => {
    // Matching questions use 'pairs' instead of 'options'
    const hasOptions = q.type === 'matching' ? q.pairs : q.options;
    
    if (!q.text || !hasOptions || q.correct_answer === undefined) {
      console.warn('[generate] Skipping malformed question:', JSON.stringify(q).slice(0, 200));
      return false;
    }
    return true;
  });

  console.log(`[generate] Successfully generated ${questions.length} questions`);
  return questions;
}

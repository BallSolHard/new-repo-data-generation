import type { PipelineParams, PipelineResult, QuestionGenerationParams } from '@/lib/types/generation';
import { ingest } from './ingest';
import { generate } from './generate';
import { validate } from './validate';
import { buildSqlOutput } from './output';
import { promises as fs } from 'fs';
import path from 'path';
import { computeContentHash } from '@/lib/engine/question-bank';

/**
 * Main pipeline orchestrator.
 *
 * Runs the full generation workflow:
 *   1. Ingest  — resolve exam guide, domain context, few-shot examples
 *   2. Generate — call Gemini to produce questions
 *   3. Validate — verify accuracy with conservative model (optional)
 *   4. Output  — build SQL script for Supabase insertion
 */
export async function runGenerationPipeline(params: PipelineParams): Promise<PipelineResult> {
  const generationTimestamp = new Date().toISOString();

  console.log(`[pipeline] Starting generation for ${params.certificationName}, topic: ${params.topicName}`);

  // ─── Step 1: Ingest ───
  const { examGuide, domainContext, fewShotExamples, examGuideVersion, certTier, genMode } = await ingest({
    certificationName: params.certificationName,
    certificationCode: params.certificationCode,
    topicName: params.topicName,
    modules: params.modules,
    questionType: params.questionType,
    complexityLevel: params.complexityLevel,
    certTier: params.certTier,
    genMode: params.genMode,
  });

  console.log(`[pipeline] Exam guide: ${examGuideVersion}, domain: ${domainContext?.name || 'none'}, examples: ${fewShotExamples.length}`);

  // ─── Step 2: Generate ───
  const questionTypes = params.questionTypes || (params.questionType ? [params.questionType] : ['mcq']);
  const questionsPerModule = params.questionsPerModule || 2;

  const generationParams: QuestionGenerationParams = {
    modules: params.modules,
    topicName: params.topicName,
    topicDescription: params.topicDescription,
    certificationName: params.certificationName,
    questionsPerModule,
    questionTypes,
    questionType: params.questionType,
    complexityLevel: params.complexityLevel || 'intermediate',
    examGuide,
    domainContext,
    fewShotExamples,
    examGuideVersion,
    certTier,
    genMode,
  };

  const rawQuestions = await generate(generationParams);

  // ─── deduplicate against previously generated questions (hash file) ───
  const hashFile = path.join(process.cwd(), 'generated_hashes.txt');
  let seenHashes = new Set<string>();
  try {
    const contents = await fs.readFile(hashFile, 'utf-8');
    contents.split('\n').forEach(h => { if (h.trim()) seenHashes.add(h.trim()); });
  } catch (err) {
    // file may not exist yet, that's fine
  }

  const unique: typeof rawQuestions = [];
  for (const q of rawQuestions) {
    const h = computeContentHash(q.text, q.options);
    if (!seenHashes.has(h)) {
      seenHashes.add(h);
      unique.push(q);
    } else {
      console.log('[pipeline] dropping duplicate question hash', h);
    }
  }

  // append new hashes to file (async, don't block generation output)
  fs.appendFile(hashFile, Array.from(seenHashes).join('\n') + '\n').catch(() => {});

  const dedupedQuestions = unique;

  // ─── Step 3: Validate (optional) ───
  let finalQuestions = dedupedQuestions;
  let rejectedCount = 0;

  if (params.enableValidation !== false) {
    const { validated, rejected } = await validate(dedupedQuestions, {
      certificationName: params.certificationName,
      domainContext,
      rejectLowConfidence: true,
      certTier,
    });
    finalQuestions = validated;
    rejectedCount = rejected.length;
  }

  // ─── Step 4: Output ───
  const sqlScript = buildSqlOutput(finalQuestions, {
    topicId: params.topicId,
    quizId: params.quizId,
    examGuideVersion,
    generationTimestamp,
    validatedCount: finalQuestions.length,
    rejectedCount,
  });

  console.log(`[pipeline] Complete. ${finalQuestions.length} questions generated, ${rejectedCount} rejected.`);

  return {
    success: true,
    sqlScript,
    questionCount: finalQuestions.length,
    validatedCount: finalQuestions.length,
    rejectedCount,
    examGuideVersion,
    generationTimestamp,
    questions: finalQuestions,
    domainContext,
  };
}

export { ingest } from './ingest';
export { generate } from './generate';
export { validate } from './validate';
export { buildSqlOutput } from './output';

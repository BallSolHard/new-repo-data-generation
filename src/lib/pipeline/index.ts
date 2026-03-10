import type { PipelineParams, PipelineResult, QuestionGenerationParams, GeneratedQuestion } from '@/lib/types/generation';
import type { Difficulty } from '@/lib/types/reference-question';
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
  const { examGuide, domainContext, fewShotExamples, examGuideVersion, certTier, genMode, serperContext } = await ingest({
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
  
  console.log('[pipeline] Question types resolution:', {
    params_questionTypes: params.questionTypes,
    params_questionType: params.questionType,
    resolved_questionTypes: questionTypes
  });
  let questionsPerModule = params.questionsPerModule || 2;
  // ensure at least 1 per module
  const minPerModule = 1;
  questionsPerModule = Math.max(questionsPerModule, minPerModule);

  // Determine if a difficulty distribution was requested.
  const distribution = params.complexityLevelDistribution;
  let rawQuestions: GeneratedQuestion[] = [];
  let targetCount = 0;

  if (distribution && Object.keys(distribution).length > 0) {
    // iterate through each difficulty level and generate the requested number
    for (const level of ['easy', 'intermediate', 'hard'] as Difficulty[]) {
      const count = distribution[level as Difficulty] || 0;
      if (count <= 0) continue;
      console.log(`[pipeline] Generating for difficulty="${level}": ${params.modules.length} modules × ${count} questions = ${params.modules.length * count} total`);
      const subParams: QuestionGenerationParams = {
        modules: params.modules,
        topicName: params.topicName,
        topicDescription: params.topicDescription,
        certificationName: params.certificationName,
        questionsPerModule: Math.max(count, minPerModule),
        questionTypes,
        questionType: params.questionType,
        complexityLevel: level,
        complexityLevelDistribution: distribution,
        serperContext,
        examGuide,
        domainContext,
        fewShotExamples,
        examGuideVersion,
        certTier,
        genMode,
      };
      const batch = await generate(subParams, params.generationContext ?? 'hub');
      // tag each question with the difficulty that was requested so the UI
      // can display it later
      rawQuestions = rawQuestions.concat(batch.map(q => ({ ...q, difficulty: level })));
      targetCount += params.modules.length * count;
    }
  } else {
    const generationParams: QuestionGenerationParams = {
      modules: params.modules,
      topicName: params.topicName,
      topicDescription: params.topicDescription,
      certificationName: params.certificationName,
      questionsPerModule,
      questionTypes,
      questionType: params.questionType,
      complexityLevel: params.complexityLevel || 'intermediate',
      serperContext,
      examGuide,
      domainContext,
      fewShotExamples,
      examGuideVersion,
      certTier,
      genMode,
    };
    rawQuestions = (await generate(generationParams, params.generationContext ?? 'hub')).map(q => ({
      ...q,
      difficulty: generationParams.complexityLevel,
    }));
    targetCount = params.modules.length * questionsPerModule;
  }

  // ─── deduplicate against previously generated questions (hash file) ───
  const hashFile = path.join(process.cwd(), 'generated_hashes.txt');
  let seenHashes = new Set<string>();
  try {
    const contents = await fs.readFile(hashFile, 'utf-8');
    contents.split('\n').forEach(h => { if (h.trim()) seenHashes.add(h.trim()); });
  } catch (err) {
    // file may not exist yet, that's fine
  }

  // helper to filter new questions
  const filterNew = (batch: GeneratedQuestion[]) => {
    const unique: typeof batch = [];
    for (const q of batch) {
      const h = computeContentHash(q.text, q.options);
      if (!seenHashes.has(h)) {
        seenHashes.add(h);
        unique.push(q);
      }
    }
    return unique;
  };

  let accumulated: typeof rawQuestions = filterNew(rawQuestions);
  let remaining = targetCount - accumulated.length;
  let attempts = 0;
  const maxAttempts = 5;

  if (remaining > 0) {
    console.log(`[pipeline] After deduplication: ${accumulated.length}/${targetCount} questions remain (${targetCount - accumulated.length} duplicates removed)`);
  }

  // if we didn't get enough, run additional rounds (single pass, not per-difficulty)
  while (remaining > 0 && attempts < maxAttempts) {
    attempts++;
    console.log(`[pipeline] only generated ${accumulated.length}/${targetCount}, regenerating ${remaining} more`);
    // simply use the original parameters; if distribution was used, there is not
    // a clean way to recalc per-difficulty remaining so we just request a
    // roughly equivalent number of questions.
    const extraParams: QuestionGenerationParams = {
      modules: params.modules,
      topicName: params.topicName,
      topicDescription: params.topicDescription,
      certificationName: params.certificationName,
      questionsPerModule: Math.ceil(remaining / params.modules.length),
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
    const extra = await generate(extraParams, params.generationContext ?? 'hub');
    const deduped = filterNew(extra);
    accumulated = accumulated.concat(deduped);
    remaining = targetCount - accumulated.length;
  }

  if (remaining > 0) {
    console.warn(`[pipeline] final question count ${accumulated.length} less than requested ${targetCount}`);
  }

  // append new hashes to file (async, don't block generation output)
  fs.appendFile(hashFile, Array.from(seenHashes).join('\n') + '\n').catch(() => {});

  const dedupedQuestions = accumulated;

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
    startIndexByModule: params.startIndexByModule,
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

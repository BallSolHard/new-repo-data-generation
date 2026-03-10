import { NextRequest, NextResponse } from 'next/server';
import { runGenerationPipeline } from '@/lib/pipeline';
import { toBankQuestions, storeQuestions } from '@/lib/engine/question-bank';
import type { PipelineParams } from '@/lib/types/generation';
import type { QuestionType } from '@/lib/types/exam-guide';
import type { Difficulty } from '@/lib/types/reference-question';
import type { CertTier, GenMode } from '@/lib/types/tier';
import { getSupabaseClient } from '../config';

// ─── Types ────────────────────────────────────────────────────────────────────

interface RequestBody {
  certification_id: string;
  certification_code?: string;
  certification_name: string;
  topic_id: string;
  topic_name?: string;
  topic_description?: string;
  quiz_id: string;
  modules: Array<{ module_id: string; module_name: string; module_description?: string; module_content?: string }>;
  questionType?: QuestionType;
  questionTypes?: QuestionType[];
  complexityLevel?: Difficulty;
  questionsPerModule?: number;
  enableValidation?: boolean;
  storeInBank?: boolean;
  certTier?: CertTier;
  genMode?: GenMode;
  complexityLevelDistribution?: Record<string, number>;
}

// ─── Validation ───────────────────────────────────────────────────────────────

function validateRequest(body: RequestBody): string | null {
  if (!body.certification_id || !body.topic_id || !body.quiz_id) {
    return 'Missing required parameters: certification_id, topic_id, quiz_id';
  }
  if (!body.certification_name) {
    return 'Missing required parameter: certification_name';
  }
  if (!body.modules || body.modules.length === 0) {
    return 'No modules provided';
  }
  return null;
}

// ─── Questions Per Module Resolution ──────────────────────────────────────────

function resolveQuestionsPerModule(
  questionsPerModule: number,
  distribution?: Record<string, number>
): { qpm: number; error?: string } {
  let qpm = Math.max(questionsPerModule, 1);

  if (distribution && Object.keys(distribution).length > 0) {
    for (const [level, count] of Object.entries(distribution)) {
      if (typeof count !== 'number' || count < 1) {
        return { qpm, error: `Invalid count for difficulty ${level}` };
      }
    }
    const total = Object.values(distribution).reduce((sum, v) => sum + v, 0);
    qpm = Math.max(total, 1);
  }

  return { qpm };
}

// ─── Start Index Lookup ───────────────────────────────────────────────────────

async function getStartIndexByModule(
  topicId: string,
  moduleIds: string[]
): Promise<Record<string, number>> {
  const startIndexByModule: Record<string, number> = {};
  try {
    const supabase = await getSupabaseClient();
    for (const moduleId of moduleIds) {
      const prefix = `q_${topicId}_${moduleId}_`;
      const { count } = await supabase
        .from('question')
        .select('id', { count: 'exact' })
        .like('id', `${prefix}%`);

      if (count !== null && count > 0) {
        startIndexByModule[moduleId] = count;
      }
    }
  } catch (err) {
    console.warn('[generate-hub] Could not fetch question count, starting from 0:', err);
  }
  return startIndexByModule;
}

// ─── Route Handler ────────────────────────────────────────────────────────────

export async function POST(request: NextRequest) {
  try {
    const body: RequestBody = await request.json();

    // Apply defaults
    body.questionType ??= 'mcq';
    body.complexityLevel ??= 'intermediate';
    body.questionsPerModule ??= 10;
    body.enableValidation ??= true;
    body.storeInBank ??= false;
    body.genMode ??= 'drill';
    body.modules ??= [];

    // Validate
    const validationError = validateRequest(body);
    if (validationError) {
      return NextResponse.json({ error: validationError }, { status: 400 });
    }

    // Resolve questions per module (with optional difficulty distribution)
    const { qpm, error: distributionError } = resolveQuestionsPerModule(
      body.questionsPerModule,
      body.complexityLevelDistribution
    );
    if (distributionError) {
      return NextResponse.json({ error: distributionError }, { status: 400 });
    }

    // Fetch start index per module for sequential question IDs
    const moduleIds = body.modules.map(m => String(m.module_id));
    const startIndexByModule = await getStartIndexByModule(String(body.topic_id), moduleIds);

    // Build pipeline params
    const pipelineParams: PipelineParams = {
      certificationCode: body.certification_code || '',
      certificationName: body.certification_name,
      certificationId: Number(body.certification_id),
      topicId: String(body.topic_id),
      topicName: body.topic_name || '',
      topicDescription: body.topic_description,
      quizId: body.quiz_id,
      modules: body.modules.map(m => ({
        module_id: m.module_id,
        module_name: m.module_name,
        module_description: m.module_description,
        module_content: m.module_content,
      })),
      questionType: body.questionType,
      questionTypes: body.questionTypes || [body.questionType],
      complexityLevel: body.complexityLevel,
      questionsPerModule: qpm,
      complexityLevelDistribution: body.complexityLevelDistribution,
      enableValidation: body.enableValidation,
      certTier: body.certTier,
      genMode: body.genMode,
      startIndexByModule,
    };

    const result = await runGenerationPipeline(pipelineParams);

    // Optionally store generated questions in the question bank
    let bankResult: { stored: number; duplicates: number } | undefined;
    if (body.storeInBank && result.questions.length > 0) {
      const bankQuestions = toBankQuestions(result.questions, {
        certificationCode: body.certification_code || body.certification_name,
        examGuideVersion: result.examGuideVersion,
        domainId: result.domainContext?.id || String(body.topic_id),
        domainContext: result.domainContext,
        defaultDifficulty: body.complexityLevel,
        certTier: body.certTier,
        genMode: body.genMode,
      });
      bankResult = await storeQuestions(bankQuestions);
    }

    return NextResponse.json({
      success: result.success,
      sqlScript: result.sqlScript,
      questions: result.questions,
      questionCount: result.questionCount,
      moduleCount: body.modules.length,
      examGuideVersion: result.examGuideVersion,
      validatedCount: result.validatedCount,
      rejectedCount: result.rejectedCount,
      generationTimestamp: result.generationTimestamp,
      ...(bankResult && { questionBank: bankResult }),
    });
  } catch (error) {
    console.error('[generate-hub] Unexpected error:', error);
    const message = error instanceof Error ? error.message : 'Failed to generate hub questions';
    return NextResponse.json({ error: message }, { status: 500 });
  }
}

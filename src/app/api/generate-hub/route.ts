import { NextRequest, NextResponse } from 'next/server';
import { runGenerationPipeline } from '@/lib/pipeline';
import { toBankQuestions, storeQuestions } from '@/lib/engine/question-bank';
import type { PipelineParams } from '@/lib/types/generation';
import type { QuestionType } from '@/lib/types/exam-guide';
import type { Difficulty } from '@/lib/types/reference-question';
import type { CertTier, GenMode } from '@/lib/types/tier';
import { getSupabaseClient } from '../config';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const {
      certification_id,
      certification_code,
      certification_name,
      topic_id,
      topic_name,
      topic_description,
      quiz_id,
      modules = [],
      questionType = 'mcq',
      questionTypes,
      complexityLevel = 'intermediate',
      questionsPerModule = 10,
      enableValidation = true,
      storeInBank = false,
      certTier,
      genMode = 'drill',
      complexityLevelDistribution,
    } = body;

    // Validate required parameters
    if (!certification_id || !topic_id || !quiz_id) {
      return NextResponse.json(
        { error: 'Missing required parameters: certification_id, topic_id, quiz_id' },
        { status: 400 }
      );
    }

    if (!modules || modules.length === 0) {
      return NextResponse.json(
        { error: 'No modules provided' },
        { status: 400 }
      );
    }

    if (!certification_name) {
      return NextResponse.json(
        { error: 'Missing required parameter: certification_name' },
        { status: 400 }
      );
    }

    // enforce minimum questions per module
    const minPerModule = 1;
    let qpm = Math.max(questionsPerModule, minPerModule);

    // if a distribution is provided, ensure each entry is at least 1 and compute the
    // sum for logging/validation. We still send `questionsPerModule` as the total
    // so the pipeline can fall back if distribution is ignored.
    const distribution = complexityLevelDistribution as Record<string, number> | undefined;
    if (distribution && Object.keys(distribution).length > 0) {
      for (const [level, count] of Object.entries(distribution)) {
        if (typeof count !== 'number' || count < 1) {
          return NextResponse.json({ error: `Invalid count for difficulty ${level}` }, { status: 400 });
        }
      }
      const total = Object.values(distribution).reduce((s, v) => s + v, 0);
      qpm = Math.max(total, minPerModule);
    }

    // ── Fetch last question index per module so new IDs continue correctly ──
    const moduleIds: string[] = modules.map((m: any) => String(m.module_id));
    const startIndexByModule: Record<string, number> = {};
    try {
      const supabase = await getSupabaseClient();
      const topicIdStr = String(topic_id);
      for (const moduleId of moduleIds) {
        // IDs are in the format q_<topicId>_m_<moduleId>_<n>
        const prefix = `q_${topicIdStr}_m_${moduleId}_`;
        const { data } = await supabase
          .from('question')
          .select('id')
          .like('id', `${prefix}%`)
          .order('id', { ascending: false })
          .limit(1);
        if (data && data.length > 0) {
          const lastId: string = data[0].id as string;
          const parts = lastId.split('_');
          const lastIndex = parseInt(parts[parts.length - 1], 10);
          if (!isNaN(lastIndex)) {
            startIndexByModule[moduleId] = lastIndex;
          }
        }
      }
    } catch (err) {
      console.warn('[generate-hub] Could not fetch last question index, starting from 1:', err);
    }

    const pipelineParams: PipelineParams = {
      certificationCode: certification_code || '',
      certificationName: certification_name,
      certificationId: certification_id,
      topicId: String(topic_id),
      topicName: topic_name || '',
      topicDescription: topic_description,
      quizId: quiz_id,
      modules: modules.map((m: any) => ({
        module_id: m.module_id,
        module_name: m.module_name,
        module_description: m.module_description,
        module_content: m.module_content,
      })),
      questionType: questionType as QuestionType,
      questionTypes: questionTypes || [questionType],
      complexityLevel: complexityLevel as Difficulty,
      questionsPerModule: qpm,
      complexityLevelDistribution: distribution,
      enableValidation,
      certTier: certTier as CertTier | undefined,
      genMode: genMode as GenMode | undefined,
      startIndexByModule,
    };

    const result = await runGenerationPipeline(pipelineParams);

    // Optionally store in question bank
    let bankResult: { stored: number; duplicates: number } | undefined;
    if (storeInBank && result.questions.length > 0) {
      const bankQuestions = toBankQuestions(result.questions, {
        certificationCode: certification_code || certification_name,
        examGuideVersion: result.examGuideVersion,
        domainId: result.domainContext?.id || String(topic_id),
        domainContext: result.domainContext,
        defaultDifficulty: complexityLevel as Difficulty,
        certTier: certTier as CertTier | undefined,
        genMode: genMode as GenMode | undefined,
      });
      bankResult = await storeQuestions(bankQuestions);
    }

    return NextResponse.json({
      success: result.success,
      sqlScript: result.sqlScript,
      questions: result.questions,
      questionCount: result.questionCount,
      moduleCount: modules.length,
      examGuideVersion: result.examGuideVersion,
      validatedCount: result.validatedCount,
      rejectedCount: result.rejectedCount,
      generationTimestamp: result.generationTimestamp,
      ...(bankResult && { questionBank: bankResult }),
    });
  } catch (error) {
    console.error('Error generating hub questions:', error);
    const message = error instanceof Error ? error.message : 'Failed to generate hub questions';
    return NextResponse.json(
      { error: message },
      { status: 500 }
    );
  }
}

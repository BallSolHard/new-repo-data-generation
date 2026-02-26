import { NextRequest, NextResponse } from 'next/server';
import { runGenerationPipeline } from '@/lib/pipeline';
import { toBankQuestions, storeQuestions } from '@/lib/engine/question-bank';
import type { PipelineParams } from '@/lib/types/generation';
import type { QuestionType } from '@/lib/types/exam-guide';
import type { Difficulty } from '@/lib/types/reference-question';
import type { CertTier, GenMode } from '@/lib/types/tier';

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
      questionsPerModule = 2,
      enableValidation = true,
      storeInBank = false,
      certTier,
      genMode = 'drill',
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
    const minPerModule = 2;
    let qpm = Math.max(questionsPerModule, minPerModule);

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
      enableValidation,
      certTier: certTier as CertTier | undefined,
      genMode: genMode as GenMode | undefined,
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

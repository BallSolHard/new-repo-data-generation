import { NextRequest, NextResponse } from 'next/server';
import { runGenerationPipeline } from '@/lib/pipeline';
import { toBankQuestions, storeQuestions } from '@/lib/engine/question-bank';
import type { PipelineParams } from '@/lib/types/generation';
import type { QuestionType } from '@/lib/types/exam-guide';
import type { Difficulty } from '@/lib/types/reference-question';
import type { CertTier, GenMode } from '@/lib/types/tier';
import type { GeneratedQuestion } from '@/lib/types/generation';
import { getSupabaseClient } from '../config';

// ─── Types ────────────────────────────────────────────────────────────────────

interface RequestBody {
  certification_id: string;
  certification_code?: string;
  certification_name: string;
  topic_id: string;
  topic_name?: string;
  topic_description?: string;
  mock_test_id: string;
  modules: Array<{ module_id: string; module_name: string; module_description?: string; module_content?: string }>;
  questionType?: QuestionType;
  questionTypes?: QuestionType[];
  complexityLevel?: Difficulty;
  questionsPerModule?: number;
  enableValidation?: boolean;
  storeInBank?: boolean;
  certTier?: CertTier;
  mock_test_action?: 'existing' | 'new';
  existing_mock_test?: any;
  complexityLevelDistribution?: Record<string, number>;
}

// ─── SQL Output for Mock Tests ─────────────────────────────────────────────────

function escapeSql(str: string): string {
  if (!str) return '';
  return str.replace(/'/g, "''");
}

function buildMockTestSqlOutput(
  questions: GeneratedQuestion[],
  quizId: string,
  topicId: string
): string {
  let sql = `-- ═══════════════════════════════════════════════════════\n`;
  sql += `-- Generated Mock Test Questions — AI Pipeline Output\n`;
  sql += `-- ═══════════════════════════════════════════════════════\n`;
  sql += `-- Mock Test ID: ${quizId}\n`;
  sql += `-- Topic ID: ${topicId}\n`;
  sql += `-- Questions: ${questions.length}\n`;
  sql += `-- Generated: ${new Date().toISOString()}\n`;
  sql += `-- ═══════════════════════════════════════════════════════\n\n`;
  sql += `BEGIN;\n\n`;

  // Group questions by module for organized output
  const byModule = new Map<string, GeneratedQuestion[]>();
  for (const q of questions) {
    const key = q.module_id || 'unknown';
    if (!byModule.has(key)) byModule.set(key, []);
    byModule.get(key)!.push(q);
  }

  let questionOrder = 1;

  for (const [moduleId, moduleQuestions] of byModule) {
    sql += `-- ─────────────────────────────────────────\n`;
    sql += `-- Module: ${moduleId}\n`;
    sql += `-- ─────────────────────────────────────────\n\n`;

    sql += `INSERT INTO public.mock_test_questions (mock_test_id, question_text, options, question_type, correct_answer, explanation, topic_id, module_id, question_order, pairs, matches)\n`;
    sql += `VALUES\n`;

    const questionRecords: string[] = [];

    for (const q of moduleQuestions) {
      const questionText = escapeSql(q.text);
      const explanationText = escapeSql(q.explanation || '');
      
      // Handle different question types
      let optionsValue: string;
      let correctAnswerValue: string;
      let pairsValue: string;
      let matchesValue: string;

      if (q.type === 'matching') {
        // Matching questions: store pairs and matches, correct_answer is NULL
        optionsValue = 'NULL';
        correctAnswerValue = 'NULL';
        const pairsJson = escapeSql(JSON.stringify(q.pairs || { left: [], right: [] }));
        pairsValue = `'${pairsJson}'::jsonb`;
        const matchesJson = escapeSql(JSON.stringify(q.matches || { left: [], right: [] }));
        matchesValue = `'${matchesJson}'::jsonb`;
      } else {
        // Non-matching questions: store options and correct_answer
        const optionsJson = escapeSql(JSON.stringify(q.options || []));
        optionsValue = `'${optionsJson}'::jsonb`;
        pairsValue = 'NULL';
        matchesValue = 'NULL';

        // Format correct_answer based on type
        let correctAnswerJson: string;
        if (q.type === 'mcq') {
          // MCQ: single index as integer array [0]
          correctAnswerJson = escapeSql(JSON.stringify([Number(q.correct_answer)]));
        } else if (q.type === 'multiple' || q.type === 'ordering') {
          // Multiple Select / Ordering: already an array
          correctAnswerJson = escapeSql(JSON.stringify(Array.isArray(q.correct_answer) ? q.correct_answer : [q.correct_answer]));
        } else {
          correctAnswerJson = escapeSql(JSON.stringify([Number(q.correct_answer)]));
        }
        correctAnswerValue = `'${correctAnswerJson}'::integer[]`;
      }

      const questionRecord = `  ('${escapeSql(quizId)}', '${questionText}', ${optionsValue}, '${q.type}', ${correctAnswerValue}, '${explanationText}', ${topicId}, '${escapeSql(String(q.module_id))}', ${questionOrder}, ${pairsValue}, ${matchesValue})`;
      questionRecords.push(questionRecord);
      questionOrder++;
    }

    sql += questionRecords.join(',\n');
    sql += `;\n\n`;
  }

  // Update mock_tests table with question count
  sql += `-- Update mock test with question count\n`;
  sql += `UPDATE public.mock_tests\n`;
  sql += `SET total_questions = total_questions + ${questions.length}\n`;
  sql += `WHERE id = '${escapeSql(quizId)}';\n\n`;

  sql += `COMMIT;\n`;

  return sql;
}

// ─── Validation ───────────────────────────────────────────────────────────────

function validateRequest(body: RequestBody): string | null {
  if (!body.certification_id || !body.topic_id || !body.mock_test_id) {
    return 'Missing required parameters: certification_id, topic_id, mock_test_id';
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
    console.warn('[generate-mock-with-data] Could not fetch question count, starting from 0:', err);
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
    body.modules ??= [];

    // For mock tests, we want TOTAL questions = questionsPerModule (not per module)
    // So we need to calculate questions per module = total / number of modules
    const totalQuestionsNeeded = body.questionsPerModule;
    const questionsPerModuleActual = Math.max(1, Math.ceil(totalQuestionsNeeded / body.modules.length));

    console.log('[generate-mock-with-data] Question calculation:', {
      totalQuestionsNeeded,
      modulesCount: body.modules.length,
      questionsPerModuleActual,
    });

    // Validate
    const validationError = validateRequest(body);
    if (validationError) {
      return NextResponse.json({ error: validationError }, { status: 400 });
    }

    // Resolve questions per module (with optional difficulty distribution)
    const { qpm, error: distributionError } = resolveQuestionsPerModule(
      questionsPerModuleActual,
      body.complexityLevelDistribution
    );
    if (distributionError) {
      return NextResponse.json({ error: distributionError }, { status: 400 });
    }

    // Fetch start index per module for sequential question IDs
    const moduleIds = body.modules.map(m => String(m.module_id));
    const startIndexByModule = await getStartIndexByModule(String(body.topic_id), moduleIds);

    // Build pipeline params with genMode set to 'simulation' for mock tests
    const pipelineParams: PipelineParams = {
      certificationCode: body.certification_code || '',
      certificationName: body.certification_name,
      certificationId: Number(body.certification_id),
      topicId: String(body.topic_id),
      topicName: body.topic_name || '',
      topicDescription: body.topic_description,
      quizId: body.mock_test_id, // Use mock_test_id as quizId for pipeline
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
      genMode: 'simulation' as GenMode, // Mock tests use simulation mode instead of drill
      generationContext: 'mock', // Use mock prompt with strict quality standards
      startIndexByModule,
    };

    const result = await runGenerationPipeline(pipelineParams);

    // Generate mock-specific SQL script that inserts into mock_test_questions table
    const mockSqlScript = buildMockTestSqlOutput(result.questions, body.mock_test_id, String(body.topic_id));

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
        genMode: 'simulation',
      });
      bankResult = await storeQuestions(bankQuestions);
    }

    return NextResponse.json({
      success: result.success,
      sqlScript: mockSqlScript, // Use mock-specific SQL script
      questions: result.questions,
      questionCount: result.questionCount,
      moduleCount: body.modules.length,
      examGuideVersion: result.examGuideVersion,
      validatedCount: result.validatedCount,
      rejectedCount: result.rejectedCount,
      generationTimestamp: result.generationTimestamp,
      mockTestAction: body.mock_test_action,
      mock_test_id: body.mock_test_id,
      ...(bankResult && { questionBank: bankResult }),
    });
  } catch (error) {
    console.error('[generate-mock-with-data] Unexpected error:', error);
    const message = error instanceof Error ? error.message : 'Failed to generate mock questions';
    return NextResponse.json({ error: message }, { status: 500 });
  }
}

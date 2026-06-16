import { NextRequest, NextResponse } from 'next/server';
import {
  getQuestions,
  getQuestionBankStats,
  storeQuestions,
  updateQuestionStatus,
} from '@/lib/engine/question-bank';
import type { QuestionBankFilters, QuestionStatus } from '@/lib/types/question-bank';

/**
 * GET /api/question-bank
 *
 * Query the question bank with filters.
 * Query params: certificationCode, domainId, difficulty, type, status,
 *               examGuideVersion, minValidationScore, limit, offset
 *
 * GET /api/question-bank?action=stats — returns aggregate stats
 */
export async function GET(request: NextRequest) {
  try {
    const params = request.nextUrl.searchParams;

    // Stats endpoint
    if (params.get('action') === 'stats') {
      const stats = await getQuestionBankStats(params.get('certificationCode') || undefined);
      return NextResponse.json(stats);
    }

    // Build filters from query params
    const filters: QuestionBankFilters = {};

    if (params.get('certificationCode')) filters.certificationCode = params.get('certificationCode')!;
    if (params.get('domainId')) filters.domainId = params.get('domainId')!;
    if (params.get('difficulty')) filters.difficulty = params.get('difficulty') as QuestionBankFilters['difficulty'];
    if (params.get('type')) filters.type = params.get('type') as QuestionBankFilters['type'];
    if (params.get('status')) filters.status = params.get('status') as QuestionBankFilters['status'];
    if (params.get('examGuideVersion')) filters.examGuideVersion = params.get('examGuideVersion')!;
    if (params.get('minValidationScore')) filters.minValidationScore = Number(params.get('minValidationScore'));
    if (params.get('certTier')) filters.certTier = params.get('certTier') as QuestionBankFilters['certTier'];
    if (params.get('genMode')) filters.genMode = params.get('genMode') as QuestionBankFilters['genMode'];
    if (params.get('limit')) filters.limit = Number(params.get('limit'));
    if (params.get('offset')) filters.offset = Number(params.get('offset'));

    const questions = await getQuestions(filters);

    return NextResponse.json({
      questions,
      count: questions.length,
      filters,
    });
  } catch (error) {
    console.error('[question-bank] GET error:', error);
    return NextResponse.json(
      { error: error instanceof Error ? error.message : 'Internal server error' },
      { status: 500 }
    );
  }
}

/**
 * POST /api/question-bank
 *
 * Store questions or update status.
 *
 * Body for storing:
 * { action: "store", questions: BankQuestion[] }
 *
 * Body for status update:
 * { action: "updateStatus", questionIds: string[], status: QuestionStatus }
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();

    if (!body.action) {
      return NextResponse.json({ error: 'Missing action field' }, { status: 400 });
    }

    if (body.action === 'store') {
      if (!body.questions || !Array.isArray(body.questions) || body.questions.length === 0) {
        return NextResponse.json({ error: 'Missing or empty questions array' }, { status: 400 });
      }

      const result = await storeQuestions(body.questions);
      return NextResponse.json({
        success: true,
        ...result,
      });
    }

    if (body.action === 'updateStatus') {
      if (!body.questionIds || !Array.isArray(body.questionIds) || body.questionIds.length === 0) {
        return NextResponse.json({ error: 'Missing or empty questionIds array' }, { status: 400 });
      }
      if (!body.status) {
        return NextResponse.json({ error: 'Missing status field' }, { status: 400 });
      }

      const updated = await updateQuestionStatus(body.questionIds, body.status as QuestionStatus);
      return NextResponse.json({
        success: true,
        updated,
      });
    }

    return NextResponse.json({ error: `Unknown action: ${body.action}` }, { status: 400 });
  } catch (error) {
    console.error('[question-bank] POST error:', error);
    return NextResponse.json(
      { error: error instanceof Error ? error.message : 'Internal server error' },
      { status: 500 }
    );
  }
}

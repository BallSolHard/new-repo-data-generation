// Hybrid DB/code few-shot selection for v2 — Supabase first, fallback to in-code

import type { ReferenceQuestion } from '@/lib/types/reference-question';
import type { QuestionType } from '@/lib/types/exam-guide';
import type { CertTier, GenMode } from '@/lib/types/tier';
import { selectFewShotExamples, getReferencesForDomain } from '@/data/reference-questions';

/**
 * V2 few-shot selection: query DB first, fall back to in-code references.
 *
 * Constraint 2 (Few-Shot Mode Safety): If v2 params are provided, the fallback
 * MUST also match the requested genMode. If no matches exist, return zero
 * examples (zero-shot) rather than injecting conflicting mode examples.
 */
export async function selectFewShotExamplesV2(
  certCode: string,
  domainId: string,
  params: {
    certTier?: CertTier;
    genMode?: GenMode;
    questionType?: QuestionType;
    count?: number;
  }
): Promise<ReferenceQuestion[]> {
  const count = params.count ?? 3;

  // Step 1: Try DB-backed selection
  try {
    const dbResults = await queryReferenceQuestionsFromDB(
      certCode,
      domainId,
      params.certTier,
      params.genMode,
      count
    );

    if (dbResults.length >= count) {
      return dbResults.slice(0, count);
    }

    // Partial DB results — try to fill from in-code
    if (dbResults.length > 0) {
      const inCodeFill = selectModeMatchingInCode(
        certCode,
        domainId,
        params.genMode,
        params.questionType,
        count - dbResults.length,
        dbResults.map(q => q.id)
      );
      return [...dbResults, ...inCodeFill].slice(0, count);
    }
  } catch (error) {
    // DB unavailable — fall through to in-code
    console.warn('[selectFewShotExamplesV2] DB query failed, falling back to in-code:', error);
  }

  // Step 2: Fall back to in-code with mode safety
  return selectModeMatchingInCode(
    certCode,
    domainId,
    params.genMode,
    params.questionType,
    count,
    []
  );
}

/**
 * Select in-code references that match the requested genMode.
 * Returns empty array if no mode-matching references exist (Constraint 2).
 */
function selectModeMatchingInCode(
  certCode: string,
  domainId: string,
  genMode?: GenMode,
  questionType?: QuestionType,
  count: number = 3,
  excludeIds: string[] = []
): ReferenceQuestion[] {
  let candidates = getReferencesForDomain(certCode, domainId, questionType);

  // Exclude already-selected IDs
  if (excludeIds.length > 0) {
    candidates = candidates.filter(q => !excludeIds.includes(q.id));
  }

  // If genMode is specified, filter by matching mode (Constraint 2: mode safety)
  if (genMode) {
    const modeMatched = candidates.filter(q => q.genMode === genMode);
    if (modeMatched.length > 0) {
      return modeMatched.slice(0, count);
    }
    // No mode-matching in-code refs — return zero-shot rather than conflicting examples
    return [];
  }

  // No mode specified — use standard v1 selection
  return selectFewShotExamples(certCode, domainId, questionType, undefined, count);
}

/**
 * Query the reference_question table in Supabase.
 * Gracefully returns empty array if table doesn't exist or query fails.
 */
async function queryReferenceQuestionsFromDB(
  certCode: string,
  domainId: string,
  certTier?: CertTier,
  genMode?: GenMode,
  limit: number = 3
): Promise<ReferenceQuestion[]> {
  // Dynamic import to avoid hard dependency on Supabase at module load
  const { getSupabaseClient } = await import('@/app/api/config');
  const supabase = await getSupabaseClient();

  let query = supabase
    .from('reference_question')
    .select('*')
    .eq('certification_code', certCode)
    .eq('domain_id', domainId);

  if (certTier) {
    query = query.eq('cert_tier', certTier);
  }
  if (genMode) {
    query = query.eq('gen_mode', genMode);
  }

  query = query.limit(limit);

  const { data, error } = await query;

  if (error) {
    console.warn('[queryReferenceQuestionsFromDB] Query error:', error.message);
    return [];
  }

  return (data || []).map(mapRowToReferenceQuestion);
}

function mapRowToReferenceQuestion(row: Record<string, unknown>): ReferenceQuestion {
  return {
    id: row.id as string,
    certificationCode: row.certification_code as string,
    domainId: row.domain_id as string,
    text: row.text as string,
    type: (row.type as ReferenceQuestion['type']) || 'mcq',
    options: row.options as string[],
    correctAnswer: parseAnswer(row.correct_answer as string),
    explanation: row.explanation as string,
    difficulty: (row.difficulty as ReferenceQuestion['difficulty']) || 'intermediate',
    tags: (row.tags as string[]) || [],
    source: (row.source as ReferenceQuestion['source']) || 'custom',
    certTier: row.cert_tier as CertTier | undefined,
    genMode: row.gen_mode as GenMode | undefined,
  };
}

function parseAnswer(answer: string): string | number[] | null {
  if (!answer) return null;
  try {
    const parsed = JSON.parse(answer);
    if (Array.isArray(parsed)) return parsed;
  } catch {
    // Not JSON
  }
  return answer;
}

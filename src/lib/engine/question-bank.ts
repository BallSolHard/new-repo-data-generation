// Question Bank Engine — core data layer for storing, querying, and managing questions

import { getSupabaseClient } from '@/app/api/config';
import type {
  BankQuestion,
  BankQuestionSummary,
  QuestionBankFilters,
  QuestionStatus,
  QuestionCoverage,
  QuestionQuality,
} from '@/lib/types/question-bank';
import type { GeneratedQuestion } from '@/lib/types/generation';
import type { ExamDomain, QuestionType } from '@/lib/types/exam-guide';
import type { Difficulty } from '@/lib/types/reference-question';
import type { CertTier, GenMode } from '@/lib/types/tier';

// ─── Content Hashing (dedup) ───

/**
 * Compute a content hash for deduplication.
 * Normalizes: lowercase, strip punctuation, sort options, concatenate.
 */
export function computeContentHash(text: string, options: string[] | Record<string, string>): string {
  const normalizedText = text.toLowerCase().replace(/[^a-z0-9\s]/g, '').trim();

  let normalizedOptions: string;
  if (Array.isArray(options)) {
    normalizedOptions = options
      .map(o => o.toLowerCase().replace(/[^a-z0-9\s]/g, '').trim())
      .sort()
      .join('|');
  } else {
    normalizedOptions = Object.values(options)
      .map(o => o.toLowerCase().replace(/[^a-z0-9\s]/g, '').trim())
      .sort()
      .join('|');
  }

  const combined = `${normalizedText}::${normalizedOptions}`;

  // Simple hash using Web Crypto-style approach (sync, good enough for dedup)
  let hash = 0;
  for (let i = 0; i < combined.length; i++) {
    const char = combined.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash |= 0; // Convert to 32-bit integer
  }
  return Math.abs(hash).toString(36);
}

// ─── Convert GeneratedQuestion → BankQuestion ───

export interface ToBankQuestionParams {
  certificationCode: string;
  examGuideVersion: string;
  domainId: string;
  domainContext?: ExamDomain;
  jobId?: string;
  defaultDifficulty?: Difficulty;
  certTier?: CertTier;
  genMode?: GenMode;
}

/**
 * Convert pipeline-generated questions into BankQuestion objects.
 * Infers coverage from domain context when available.
 */
export function toBankQuestions(
  questions: GeneratedQuestion[],
  params: ToBankQuestionParams
): BankQuestion[] {
  const now = new Date().toISOString();

  return questions.map((q, idx) => {
    const contentHash = computeContentHash(q.text, q.options);
    const coverage = inferCoverage(q, params);
    const quality = inferQuality(q);

    const status: QuestionStatus = q.validation_status === 'correct'
      ? 'validated'
      : q.validation_status === 'incorrect'
        ? 'rejected'
        : 'generated';

    return {
      id: `bq_${params.certificationCode}_${params.domainId}_${Date.now()}_${idx}`,
      certificationCode: params.certificationCode,
      examGuideVersion: params.examGuideVersion,
      text: q.text,
      type: q.type || 'mcq',
      options: q.options,
      correctAnswer: q.new_correct_answer
        ? q.new_correct_answer
        : q.correct_answer,
      explanation: q.new_explanation || q.explanation,
      difficulty: params.defaultDifficulty || 'intermediate',
      pairs: q.pairs,
      matches: q.matches,
      coverage,
      certTier: q.certTier || params.certTier,
      genMode: q.genMode || params.genMode,
      status,
      quality,
      contentHash,
      generationJobId: params.jobId,
      generatedAt: now,
      validatedAt: status === 'validated' ? now : undefined,
    };
  });
}

function inferCoverage(q: GeneratedQuestion, params: ToBankQuestionParams): QuestionCoverage {
  const coverage: QuestionCoverage = {
    domainId: params.domainId,
    taskIds: q.taskIds || [],
    knowledgeStatementIds: [],
    servicesTested: [],
  };

  // Infer services from question text + options + explanation
  if (params.domainContext?.inScopeServices) {
    const searchText = [
      q.text,
      q.explanation,
      ...(Array.isArray(q.options) ? q.options : Object.values(q.options)),
    ].join(' ').toLowerCase();

    coverage.servicesTested = params.domainContext.inScopeServices
      .filter(s => searchText.includes(s.name.toLowerCase()))
      .map(s => s.name);
  }

  // Infer knowledge statements from question text matching
  if (params.domainContext?.tasks) {
    const searchText = [q.text, q.explanation].join(' ').toLowerCase();

    for (const task of params.domainContext.tasks) {
      for (const ks of task.knowledgeStatements) {
        // Extract key phrases from KS text (words > 4 chars)
        const ksWords = ks.text.toLowerCase()
          .split(/\s+/)
          .filter(w => w.length > 4);

        // If 40%+ of KS key words appear in question, it's a match
        const matchCount = ksWords.filter(w => searchText.includes(w)).length;
        if (ksWords.length > 0 && matchCount / ksWords.length >= 0.4) {
          coverage.knowledgeStatementIds.push(ks.id);
          if (!coverage.taskIds.includes(task.id)) {
            coverage.taskIds.push(task.id);
          }
        }
      }
    }
  }

  return coverage;
}

function inferQuality(q: GeneratedQuestion): QuestionQuality {
  return {
    validationScore: q.confidence_score ?? 0,
    validationConfidence: q.validation_status === 'correct' ? 'high' : 'low',
    validationNotes: q.validation_notes,
    factualErrors: undefined,
  };
}

// ─── Question Bank CRUD Operations ───

/**
 * Store questions in the question bank table.
 * Uses upsert (ON CONFLICT DO NOTHING) to handle duplicates.
 */
export async function storeQuestions(questions: BankQuestion[]): Promise<{ stored: number; duplicates: number }> {
  if (questions.length === 0) return { stored: 0, duplicates: 0 };

  const supabase = await getSupabaseClient();

  const rows = questions.map(q => ({
    id: q.id,
    certification_code: q.certificationCode,
    exam_guide_version: q.examGuideVersion,
    domain_id: q.coverage.domainId,
    text: q.text,
    type: q.type,
    options: q.options,
    correct_answer: formatAnswer(q.correctAnswer),
    explanation: q.explanation,
    difficulty: q.difficulty,
    pairs: q.pairs || null,
    matches: q.matches || null,
    task_ids: q.coverage.taskIds,
    knowledge_statement_ids: q.coverage.knowledgeStatementIds,
    services_tested: q.coverage.servicesTested,
    status: q.status,
    validation_score: q.quality.validationScore,
    validation_confidence: q.quality.validationConfidence,
    validation_notes: q.quality.validationNotes || null,
    content_hash: q.contentHash,
    cert_tier: q.certTier || null,
    gen_mode: q.genMode || null,
    generation_job_id: q.generationJobId || null,
    generated_at: q.generatedAt,
    validated_at: q.validatedAt || null,
    activated_at: q.activatedAt || null,
    retired_at: q.retiredAt || null,
  }));

  const { data, error } = await supabase
    .from('question_bank')
    .upsert(rows, { onConflict: 'id', ignoreDuplicates: true })
    .select('id');

  if (error) throw new Error(`Failed to store questions: ${error.message}`);

  const stored = data?.length ?? 0;
  return { stored, duplicates: questions.length - stored };
}

/**
 * Query question bank with flexible filters.
 */
export async function getQuestions(filters: QuestionBankFilters = {}): Promise<BankQuestion[]> {
  const supabase = await getSupabaseClient();

  let query = supabase.from('question_bank').select('*');

  if (filters.certificationCode) {
    query = query.eq('certification_code', filters.certificationCode);
  }
  if (filters.domainId) {
    query = query.eq('domain_id', filters.domainId);
  }
  if (filters.difficulty) {
    query = query.eq('difficulty', filters.difficulty);
  }
  if (filters.type) {
    query = query.eq('type', filters.type);
  }
  if (filters.status) {
    query = query.eq('status', filters.status);
  }
  if (filters.examGuideVersion) {
    query = query.eq('exam_guide_version', filters.examGuideVersion);
  }
  if (filters.minValidationScore !== undefined) {
    query = query.gte('validation_score', filters.minValidationScore);
  }
  if (filters.services && filters.services.length > 0) {
    query = query.overlaps('services_tested', filters.services);
  }
  if (filters.knowledgeStatementIds && filters.knowledgeStatementIds.length > 0) {
    query = query.overlaps('knowledge_statement_ids', filters.knowledgeStatementIds);
  }
  if (filters.certTier) {
    query = query.eq('cert_tier', filters.certTier);
  }
  if (filters.genMode) {
    query = query.eq('gen_mode', filters.genMode);
  }

  query = query.order('generated_at', { ascending: false });

  if (filters.limit) {
    query = query.limit(filters.limit);
  }
  if (filters.offset) {
    query = query.range(filters.offset, filters.offset + (filters.limit || 50) - 1);
  }

  const { data, error } = await query;

  if (error) throw new Error(`Failed to query question bank: ${error.message}`);

  return (data || []).map(mapRowToBankQuestion);
}

/**
 * Get question bank summary (counts by status, domain, etc.)
 */
export async function getQuestionBankStats(certificationCode?: string): Promise<{
  total: number;
  byStatus: Record<QuestionStatus, number>;
  byCert: Record<string, number>;
}> {
  const supabase = await getSupabaseClient();

  let query = supabase.from('question_bank').select('certification_code, status');
  if (certificationCode) {
    query = query.eq('certification_code', certificationCode);
  }

  const { data, error } = await query;
  if (error) throw new Error(`Failed to get stats: ${error.message}`);

  const rows = data || [];
  const byStatus: Record<string, number> = {};
  const byCert: Record<string, number> = {};

  for (const row of rows) {
    byStatus[row.status] = (byStatus[row.status] || 0) + 1;
    byCert[row.certification_code] = (byCert[row.certification_code] || 0) + 1;
  }

  return {
    total: rows.length,
    byStatus: byStatus as Record<QuestionStatus, number>,
    byCert,
  };
}

/**
 * Update status of questions (lifecycle transitions).
 */
export async function updateQuestionStatus(
  questionIds: string[],
  newStatus: QuestionStatus
): Promise<number> {
  if (questionIds.length === 0) return 0;

  const supabase = await getSupabaseClient();
  const now = new Date().toISOString();

  const updates: Record<string, unknown> = {
    status: newStatus,
    modified_at: now,
  };

  // Set lifecycle timestamps
  if (newStatus === 'validated') updates.validated_at = now;
  if (newStatus === 'active') updates.activated_at = now;
  if (newStatus === 'retired') updates.retired_at = now;

  const { data, error } = await supabase
    .from('question_bank')
    .update(updates)
    .in('id', questionIds)
    .select('id');

  if (error) throw new Error(`Failed to update status: ${error.message}`);
  return data?.length ?? 0;
}

/**
 * Mark questions as stale for a certification's affected domains.
 * Used when an exam guide version changes.
 */
export async function markQuestionsStale(
  certificationCode: string,
  domainIds: string[]
): Promise<number> {
  if (domainIds.length === 0) return 0;

  const supabase = await getSupabaseClient();
  const now = new Date().toISOString();

  const { data, error } = await supabase
    .from('question_bank')
    .update({ status: 'stale', modified_at: now })
    .eq('certification_code', certificationCode)
    .in('domain_id', domainIds)
    .in('status', ['active', 'validated'])
    .select('id');

  if (error) throw new Error(`Failed to mark stale: ${error.message}`);
  return data?.length ?? 0;
}

/**
 * Check for duplicate questions by content hash.
 */
export async function checkDuplicates(
  contentHashes: string[],
  certificationCode: string
): Promise<Set<string>> {
  if (contentHashes.length === 0) return new Set();

  const supabase = await getSupabaseClient();

  const { data, error } = await supabase
    .from('question_bank')
    .select('content_hash')
    .eq('certification_code', certificationCode)
    .in('content_hash', contentHashes);

  if (error) throw new Error(`Failed to check duplicates: ${error.message}`);
  return new Set((data || []).map(r => r.content_hash));
}

// ─── Helpers ───

function formatAnswer(answer: string | number[] | null): string {
  if (answer === null) return '';
  if (Array.isArray(answer)) return JSON.stringify(answer);
  return String(answer);
}

function mapRowToBankQuestion(row: Record<string, unknown>): BankQuestion {
  return {
    id: row.id as string,
    certificationCode: row.certification_code as string,
    examGuideVersion: row.exam_guide_version as string,
    text: row.text as string,
    type: (row.type as QuestionType) || 'mcq',
    options: row.options as string[] | Record<string, string>,
    correctAnswer: parseAnswer(row.correct_answer as string),
    explanation: row.explanation as string,
    difficulty: (row.difficulty as Difficulty) || 'intermediate',
    pairs: row.pairs as BankQuestion['pairs'],
    matches: row.matches as BankQuestion['matches'],
    coverage: {
      domainId: row.domain_id as string,
      taskIds: (row.task_ids as string[]) || [],
      knowledgeStatementIds: (row.knowledge_statement_ids as string[]) || [],
      servicesTested: (row.services_tested as string[]) || [],
    },
    status: row.status as QuestionStatus,
    quality: {
      validationScore: Number(row.validation_score) || 0,
      validationConfidence: (row.validation_confidence as 'high' | 'medium' | 'low') || 'low',
      validationNotes: row.validation_notes as string | undefined,
    },
    certTier: row.cert_tier as CertTier | undefined,
    genMode: row.gen_mode as GenMode | undefined,
    contentHash: row.content_hash as string,
    generationJobId: row.generation_job_id as string | undefined,
    generatedAt: row.generated_at as string,
    validatedAt: row.validated_at as string | undefined,
    activatedAt: row.activated_at as string | undefined,
    retiredAt: row.retired_at as string | undefined,
  };
}

function parseAnswer(answer: string): string | number[] | null {
  if (!answer) return null;
  try {
    const parsed = JSON.parse(answer);
    if (Array.isArray(parsed)) return parsed;
  } catch {
    // Not JSON, return as string
  }
  return answer;
}

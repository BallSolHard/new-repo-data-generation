import type { ExamGuide, ExamDomain } from '@/lib/types/exam-guide';
import type { ReferenceQuestion } from '@/lib/types/reference-question';
import type { ModuleInput } from '@/lib/types/generation';
import type { CertTier, GenMode } from '@/lib/types/tier';
import { getCurrentGuide, resolveGuideFromCertName } from '@/data/exam-guides';
import { selectFewShotExamples } from '@/data/reference-questions';
import { selectFewShotExamplesV2 } from '@/data/reference-questions/db-backed';
import type { QuestionType } from '@/lib/types/exam-guide';
import type { Difficulty } from '@/lib/types/reference-question';

export interface IngestResult {
  examGuide: ExamGuide | undefined;
  domainContext: ExamDomain | undefined;
  fewShotExamples: ReferenceQuestion[];
  examGuideVersion: string;
  certTier?: CertTier;
  genMode?: GenMode;
}

/**
 * Ingest step: resolve the exam guide and reference questions for a generation run.
 *
 * Maps the certification name and topic to the correct exam guide domain,
 * then selects appropriate few-shot examples for prompt injection.
 */
export async function ingest(params: {
  certificationName: string;
  certificationCode?: string;
  topicName: string;
  modules: ModuleInput[];
  questionType?: QuestionType;
  complexityLevel?: Difficulty;
  certTier?: CertTier;
  genMode?: GenMode;
}): Promise<IngestResult> {
  const { certificationName, certificationCode, topicName, questionType, complexityLevel, certTier, genMode } = params;

  // Resolve exam guide — try code first, then name matching
  let examGuide: ExamGuide | undefined;
  if (certificationCode) {
    examGuide = getCurrentGuide(certificationCode);
  }
  if (!examGuide) {
    examGuide = resolveGuideFromCertName(certificationName);
  }

  if (!examGuide) {
    console.warn(`[ingest] No exam guide found for: ${certificationName} (${certificationCode})`);
    return {
      examGuide: undefined,
      domainContext: undefined,
      fewShotExamples: [],
      examGuideVersion: 'unknown',
    };
  }

  // Match topic to domain — fuzzy matching on name
  const domainContext = matchDomain(examGuide, topicName);

  if (!domainContext) {
    console.warn(`[ingest] Could not match topic "${topicName}" to any domain in ${examGuide.certificationCode}`);
  }

  // Select few-shot examples — v2 uses DB-backed selection with mode safety
  const domainId = domainContext?.id || 'domain-1';
  let fewShotExamples: ReferenceQuestion[];

  if (certTier || genMode) {
    fewShotExamples = await selectFewShotExamplesV2(
      examGuide.certificationCode,
      domainId,
      { certTier, genMode, questionType, count: 3 }
    );
  } else {
    fewShotExamples = selectFewShotExamples(
      examGuide.certificationCode,
      domainId,
      questionType,
      complexityLevel,
      3
    );
  }

  return {
    examGuide,
    domainContext,
    fewShotExamples,
    examGuideVersion: examGuide.version,
    certTier,
    genMode,
  };
}

/**
 * Match a topic name (from Supabase) to an exam guide domain.
 * Uses normalized substring matching to handle variations like
 * "Design Secure Architectures" vs "Secure Architecture Design".
 */
function matchDomain(guide: ExamGuide, topicName: string): ExamDomain | undefined {
  const normalized = topicName.toLowerCase().replace(/[^a-z0-9\s]/g, '');

  // Try exact match first
  const exact = guide.domains.find(
    d => d.name.toLowerCase() === topicName.toLowerCase()
  );
  if (exact) return exact;

  // Try substring match — check if key words overlap
  const topicWords = normalized.split(/\s+/).filter(w => w.length > 3);
  let bestMatch: ExamDomain | undefined;
  let bestScore = 0;

  for (const domain of guide.domains) {
    const domainWords = domain.name.toLowerCase().replace(/[^a-z0-9\s]/g, '').split(/\s+/).filter(w => w.length > 3);
    const overlap = topicWords.filter(w => domainWords.some(dw => dw.includes(w) || w.includes(dw)));
    const score = overlap.length / Math.max(topicWords.length, domainWords.length);

    if (score > bestScore) {
      bestScore = score;
      bestMatch = domain;
    }
  }

  // Require at least 40% word overlap to consider a match
  return bestScore >= 0.4 ? bestMatch : undefined;
}

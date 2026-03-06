import type { ReferenceQuestion, Difficulty } from '@/lib/types/reference-question';
import type { QuestionType } from '@/lib/types/exam-guide';
import { saaC03Samples } from './aws/solutions-architect-associate/saa-c03-samples';
import { clfC02Samples } from './aws/cloud-practitioner/clf-c02-samples';

// ─── Reference Question Registry ───
// Maps certification codes to their curated few-shot example sets.

const referenceRegistry: Record<string, ReferenceQuestion[]> = {
  'SAA-C03': saaC03Samples.questions,
  'CLF-C02': clfC02Samples.questions,
};

/** Get all reference questions for a certification */
export function getReferencesForCert(certCode: string): ReferenceQuestion[] {
  return referenceRegistry[certCode.toUpperCase()] || [];
}

/** Get reference questions for a specific domain within a certification */
export function getReferencesForDomain(
  certCode: string,
  domainId: string,
  questionType?: QuestionType,
  difficulty?: Difficulty
): ReferenceQuestion[] {
  // If domainId is empty, return all questions for the cert (fallback for missing domain)
  let questions = getReferencesForCert(certCode);
  if (domainId) {
    questions = questions.filter(q => q.domainId === domainId);
  }

  if (questionType) {
    questions = questions.filter(q => q.type === questionType);
  }
  if (difficulty) {
    questions = questions.filter(q => q.difficulty === difficulty);
  }

  return questions;
}

/**
 * Select few-shot examples for prompt injection.
 * Picks up to `count` reference questions, prioritizing matches on
 * questionType and difficulty, then filling with any domain questions.
 */
export function selectFewShotExamples(
  certCode: string,
  domainId: string,
  questionType?: QuestionType,
  difficulty?: Difficulty,
  count: number = 3
): ReferenceQuestion[] {
  // Try exact match first
  const exact = getReferencesForDomain(certCode, domainId, questionType, difficulty);
  if (exact.length >= count) return exact.slice(0, count);

  // Relax difficulty constraint
  const typeOnly = getReferencesForDomain(certCode, domainId, questionType);
  const combined = [...exact];
  for (const q of typeOnly) {
    if (!combined.find(c => c.id === q.id)) combined.push(q);
    if (combined.length >= count) break;
  }
  if (combined.length >= count) return combined.slice(0, count);

  // Fill with any domain questions
  const allDomain = getReferencesForDomain(certCode, domainId);
  for (const q of allDomain) {
    if (!combined.find(c => c.id === q.id)) combined.push(q);
    if (combined.length >= count) break;
  }

  return combined.slice(0, count);
}

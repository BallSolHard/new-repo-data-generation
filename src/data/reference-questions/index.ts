import type { ReferenceQuestion, Difficulty } from '@/lib/types/reference-question';
import type { QuestionType } from '@/lib/types/exam-guide';

// ─── Reference Question Registry ───
// Maps certification codes to their reference question sets.
// All reference questions are loaded from index.txt files in:
// ./aws/[cert-name]/index.txt

let referenceRegistry: Record<string, ReferenceQuestion[]> = {
  // Loaded lazily from index.txt files
};

const loadedCerts = new Set<string>();

/** Initialize reference questions from index.txt file (lazy load) */
async function initializeCertReferences(certCode: string): Promise<void> {
  if (loadedCerts.has(certCode)) return;
  
  try {
    const { getCachedReferences } = await import('@/lib/utils/load-reference-questions');
    const questions = await getCachedReferences(certCode, 400);
    referenceRegistry[certCode] = questions;
    loadedCerts.add(certCode);
    console.log(`[index.ts] Loaded ${questions.length} reference questions for ${certCode} from index.txt`);
  } catch (error) {
    console.warn(`[index.ts] Failed to load ${certCode} from index.txt:`, error);
    // Fallback: use empty array if loading fails
    referenceRegistry[certCode] = [];
  }
}

/** Get all reference questions for a certification */
export async function getReferencesForCert(certCode: string): Promise<ReferenceQuestion[]> {
  // Ensure certification is loaded if requested
  await initializeCertReferences(certCode.toUpperCase());
  return referenceRegistry[certCode.toUpperCase()] || [];
}

/** Get reference questions for a specific domain within a certification */
export async function getReferencesForDomain(
  certCode: string,
  domainId: string,
  questionType?: QuestionType,
  difficulty?: Difficulty
): Promise<ReferenceQuestion[]> {
  // If domainId is empty, return all questions for the cert (fallback for missing domain)
  let questions = await getReferencesForCert(certCode);
  if (domainId) {
    questions = questions.filter((q: ReferenceQuestion) => q.domainId === domainId);
  }

  if (questionType) {
    questions = questions.filter((q: ReferenceQuestion) => q.type === questionType);
  }
  if (difficulty) {
    questions = questions.filter((q: ReferenceQuestion) => q.difficulty === difficulty);
  }

  return questions;
}

/**
 * Select few-shot examples for prompt injection.
 * Picks up to `count` reference questions, prioritizing matches on
 * questionType and difficulty, then filling with any domain questions.
 */
export async function selectFewShotExamples(
  certCode: string,
  domainId: string,
  questionType?: QuestionType,
  difficulty?: Difficulty,
  count: number = 3
): Promise<ReferenceQuestion[]> {
  // Try exact match first
  const exact = await getReferencesForDomain(certCode, domainId, questionType, difficulty);
  if (exact.length >= count) return exact.slice(0, count);

  // Relax difficulty constraint
  const typeOnly = await getReferencesForDomain(certCode, domainId, questionType);
  const combined = [...exact];
  for (const q of typeOnly) {
    if (!combined.find(c => c.id === q.id)) combined.push(q);
    if (combined.length >= count) break;
  }
  if (combined.length >= count) return combined.slice(0, count);

  // Fill with any domain questions
  const allDomain = await getReferencesForDomain(certCode, domainId);
  for (const q of allDomain) {
    if (!combined.find(c => c.id === q.id)) combined.push(q);
    if (combined.length >= count) break;
  }

  return combined.slice(0, count);
}

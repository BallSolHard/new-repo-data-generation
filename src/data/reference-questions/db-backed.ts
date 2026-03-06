// V2 few-shot selection — uses in-code references only

import type { ReferenceQuestion } from '@/lib/types/reference-question';
import type { QuestionType } from '@/lib/types/exam-guide';
import type { CertTier, GenMode } from '@/lib/types/tier';
import { selectFewShotExamples, getReferencesForDomain } from '@/data/reference-questions';

/**
 * V2 few-shot selection: select from in-code references with mode matching.
 *
 * If genMode is specified, tries to match references by genMode.
 * Falls back to standard selection if no mode-matching references exist.
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
 * Falls back to standard v1 selection if no mode-matching references exist.
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

  // If genMode is specified, try to filter by matching mode
  if (genMode) {
    const modeMatched = candidates.filter(q => q.genMode === genMode);
    if (modeMatched.length > 0) {
      return modeMatched.slice(0, count);
    }
    // No mode-matching in-code refs — fall back to standard v1 selection (don't return empty)
    console.warn(
      `[selectModeMatchingInCode] No mode-matching refs for genMode='${genMode}', falling back to standard selection`
    );
    return selectFewShotExamples(certCode, domainId, questionType, undefined, count);
  }

  // No mode specified — use standard v1 selection
  return selectFewShotExamples(certCode, domainId, questionType, undefined, count);
}

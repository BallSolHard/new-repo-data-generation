/**
 * Version tracker — utilities for mapping questions to exam guide versions.
 *
 * Question IDs follow the convention:
 *   q_{topicId}_m_{moduleId}_{versionCode}_{index}
 *
 * This allows identifying which exam guide version generated each question.
 */

/** Extract the exam guide version from a question ID */
export function extractVersionFromQuestionId(questionId: string): string | null {
  // Pattern: q_{topicId}_m_{moduleId}_{version}_{index}
  const parts = questionId.split('_');
  if (parts.length < 6) return null;

  // Version is the second-to-last segment (before the numeric index)
  const index = parts[parts.length - 1];
  if (!/^\d+$/.test(index)) return null;

  // Version could be multi-part like "SAA-C03", so join everything between moduleId marker and index
  const mIndex = parts.indexOf('m');
  if (mIndex === -1 || mIndex + 2 >= parts.length) return null;

  // Skip topicId (after q_), m marker, moduleId — rest before last is version
  const versionParts = parts.slice(mIndex + 2, parts.length - 1);
  return versionParts.join('-').toUpperCase() || null;
}

/** Build a question ID with version encoding */
export function buildVersionedQuestionId(
  topicId: string,
  moduleId: string,
  version: string,
  index: number
): string {
  const safeVersion = version.toLowerCase().replace(/[^a-z0-9]/g, '');
  return `q_${topicId}_m_${moduleId}_${safeVersion}_${index}`;
}

/** Check if a question was generated from a specific version */
export function isFromVersion(questionId: string, version: string): boolean {
  const extracted = extractVersionFromQuestionId(questionId);
  if (!extracted) return false;
  return extracted.replace(/[^A-Z0-9]/g, '') === version.toUpperCase().replace(/[^A-Z0-9]/g, '');
}

/** Filter a list of question IDs to those from a specific version */
export function filterByVersion(questionIds: string[], version: string): string[] {
  return questionIds.filter(id => isFromVersion(id, version));
}

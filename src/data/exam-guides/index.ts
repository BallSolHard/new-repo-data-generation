import type { ExamGuide } from '@/lib/types/exam-guide';
import { saaC03 } from './aws/solutions-architect-associate/saa-c03';
import { clfC02 } from './aws/cloud-practitioner/clf-c02';

// ─── Exam Guide Registry ───
// Maps certification slugs to all versions of their exam guides.
// When a cert updates (e.g., SAA-C03 → SAA-C04), add the new guide file
// and register it here. Set old guide status to 'retired'.

const examGuideRegistry: Record<string, ExamGuide[]> = {
  'aws-solutions-architect-associate': [saaC03],
  'aws-cloud-practitioner': [clfC02],
};

// Slug aliases — map common names/codes to registry keys
const slugAliases: Record<string, string> = {
  'saa-c03': 'aws-solutions-architect-associate',
  'saa': 'aws-solutions-architect-associate',
  'aws-saa': 'aws-solutions-architect-associate',
  'aws solutions architect': 'aws-solutions-architect-associate',
  'clf-c02': 'aws-cloud-practitioner',
  'clf': 'aws-cloud-practitioner',
  'aws-clf': 'aws-cloud-practitioner',
  'cloud practitioner': 'aws-cloud-practitioner',
};

function resolveSlug(input: string): string {
  const normalized = input.toLowerCase().trim();
  return slugAliases[normalized] || normalized;
}

/** Get the current (non-retired) exam guide for a certification */
export function getCurrentGuide(slug: string): ExamGuide | undefined {
  const key = resolveSlug(slug);
  const guides = examGuideRegistry[key];
  if (!guides) return undefined;
  return guides.find(g => g.status === 'current') || guides[guides.length - 1];
}

/** Get a specific version of an exam guide */
export function getGuideByVersion(slug: string, version: string): ExamGuide | undefined {
  const key = resolveSlug(slug);
  const guides = examGuideRegistry[key];
  return guides?.find(g => g.version === version);
}

/** Get all versions for a certification */
export function getGuideVersions(slug: string): ExamGuide[] {
  const key = resolveSlug(slug);
  return examGuideRegistry[key] || [];
}

/** List all registered certifications with their current guide */
export function getAllGuides(): { slug: string; current: ExamGuide; versions: ExamGuide[] }[] {
  return Object.entries(examGuideRegistry).map(([slug, versions]) => ({
    slug,
    current: versions.find(g => g.status === 'current') || versions[versions.length - 1],
    versions,
  }));
}

/** Resolve a certification name (from Supabase) to its exam guide */
export function resolveGuideFromCertName(certName: string): ExamGuide | undefined {
  const lower = certName.toLowerCase();

  // Try direct alias lookup
  for (const [alias, key] of Object.entries(slugAliases)) {
    if (lower.includes(alias)) {
      return getCurrentGuide(key);
    }
  }

  // Try matching against registry keys
  for (const key of Object.keys(examGuideRegistry)) {
    const parts = key.split('-');
    const matches = parts.every(part => lower.includes(part));
    if (matches) return getCurrentGuide(key);
  }

  return undefined;
}

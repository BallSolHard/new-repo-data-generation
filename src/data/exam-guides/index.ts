import type { ExamGuide } from '@/lib/types/exam-guide';

// ─── AWS Imports ───
import { saaC03 } from './aws/solutions-architect-associate/saa-c03';
import { clfC02 } from './aws/cloud-practitioner/clf-c02';
import { aifC01 } from './aws/ai-practitioner/aif-c01';
import { mlaC01 } from './aws/ml-engineer-associate/mla-c01';
import { soaC03 } from './aws/sysops-administrator-associate/soa-c03';
import { dvaC02 } from './aws/developer-associate/dva-c02';
import { deaC01 } from './aws/data-engineer-associate/dea-c01';
import { dopC02 } from './aws/devops-engineer-professional/dop-c02';
import { sapC02 } from './aws/solutions-architect-professional/sap-c02';
import { mlsC01 } from './aws/machine-learning-specialty/mls-c01';
import { ansC01 } from './aws/advanced-networking-specialty/ans-c01';
import { scsC02 } from './aws/security-specialty/scs-c02';
import { aipC01 } from './aws/generative-ai-developer-professional/aip-c01';

// ─── HashiCorp Imports ───
import { terraformAssociate } from './hashicorp/terraform-associate/terraform-associate';
import { terraformProfessional } from './hashicorp/terraform-professional/terraform-professional';

// ─── Exam Guide Registry ───
// Maps certification slugs to all versions of their exam guides.
// When a cert updates (e.g., SAA-C03 → SAA-C04), add the new guide file
// and register it here. Set old guide status to 'retired'.

const examGuideRegistry: Record<string, ExamGuide[]> = {
  // AWS — Foundational
  'aws-cloud-practitioner': [clfC02],
  'aws-ai-practitioner': [aifC01],

  // AWS — Associate
  'aws-solutions-architect-associate': [saaC03],
  'aws-sysops-administrator-associate': [soaC03],
  'aws-developer-associate': [dvaC02],
  'aws-ml-engineer-associate': [mlaC01],
  'aws-data-engineer-associate': [deaC01],

  // AWS — Professional
  'aws-solutions-architect-professional': [sapC02],
  'aws-devops-engineer-professional': [dopC02],
  'aws-generative-ai-developer-professional': [aipC01],

  // AWS — Specialty
  'aws-machine-learning-specialty': [mlsC01],
  'aws-advanced-networking-specialty': [ansC01],
  'aws-security-specialty': [scsC02],

  // HashiCorp
  'hashicorp-terraform-associate': [terraformAssociate],
  'hashicorp-terraform-professional': [terraformProfessional],
};

// Slug aliases — map common names/codes to registry keys
const slugAliases: Record<string, string> = {
  // AWS Solutions Architect Associate
  'saa-c03': 'aws-solutions-architect-associate',
  'saa': 'aws-solutions-architect-associate',
  'aws-saa': 'aws-solutions-architect-associate',
  'aws solutions architect': 'aws-solutions-architect-associate',

  // AWS Cloud Practitioner
  'clf-c02': 'aws-cloud-practitioner',
  'clf': 'aws-cloud-practitioner',
  'aws-clf': 'aws-cloud-practitioner',
  'cloud practitioner': 'aws-cloud-practitioner',

  // AWS AI Practitioner
  'AWS Certified AI Practitioner': 'aws-ai-practitioner',
  'aif': 'aws-ai-practitioner',
  'ai practitioner': 'aws-ai-practitioner',

  // AWS ML Engineer Associate
  'mla-c01': 'aws-ml-engineer-associate',
  'mla': 'aws-ml-engineer-associate',
  'ml engineer associate': 'aws-ml-engineer-associate',

  // AWS SysOps Administrator Associate
  'soa-c03': 'aws-sysops-administrator-associate',
  'soa': 'aws-sysops-administrator-associate',
  'sysops': 'aws-sysops-administrator-associate',
  'sysops administrator': 'aws-sysops-administrator-associate',

  // AWS Developer Associate
  'dva-c02': 'aws-developer-associate',
  'dva': 'aws-developer-associate',
  'aws developer': 'aws-developer-associate',

  // AWS Data Engineer Associate
  'dea-c01': 'aws-data-engineer-associate',
  'dea': 'aws-data-engineer-associate',
  'data engineer': 'aws-data-engineer-associate',

  // AWS DevOps Engineer Professional
  'dop-c02': 'aws-devops-engineer-professional',
  'dop': 'aws-devops-engineer-professional',
  'devops engineer': 'aws-devops-engineer-professional',
  'devops professional': 'aws-devops-engineer-professional',

  // AWS Solutions Architect Professional
  'sap-c02': 'aws-solutions-architect-professional',
  'sap': 'aws-solutions-architect-professional',
  'solutions architect professional': 'aws-solutions-architect-professional',

  // AWS Generative AI Developer Professional
  'aip-c01': 'aws-generative-ai-developer-professional',
  'aip': 'aws-generative-ai-developer-professional',
  'generative ai developer': 'aws-generative-ai-developer-professional',

  // AWS Machine Learning Specialty
  'mls-c01': 'aws-machine-learning-specialty',
  'mls': 'aws-machine-learning-specialty',
  'machine learning specialty': 'aws-machine-learning-specialty',

  // AWS Advanced Networking Specialty
  'ans-c01': 'aws-advanced-networking-specialty',
  'ans': 'aws-advanced-networking-specialty',
  'advanced networking': 'aws-advanced-networking-specialty',

  // AWS Security Specialty
  'scs-c02': 'aws-security-specialty',
  'scs': 'aws-security-specialty',
  'security specialty': 'aws-security-specialty',

  // HashiCorp Terraform Associate
  'ta-003': 'hashicorp-terraform-associate',
  'terraform associate': 'hashicorp-terraform-associate',
  'terraform-associate': 'hashicorp-terraform-associate',

  // HashiCorp Terraform Professional
  'taop-003': 'hashicorp-terraform-professional',
  'terraform professional': 'hashicorp-terraform-professional',
  'terraform authoring': 'hashicorp-terraform-professional',
  'terraform-professional': 'hashicorp-terraform-professional',
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

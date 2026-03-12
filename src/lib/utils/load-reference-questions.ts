/**
 * Loader for reference questions from index.txt files
 * This integrates parsed questions into the reference registry
 */

import { promises as fs } from 'fs';
import { join } from 'path';
import type { ReferenceQuestion } from '@/lib/types/reference-question';

interface CertificationPath {
  folderName: string;
  certCode: string;
  domainId: string;
}

const CERTIFICATIONS: CertificationPath[] = [
  {
    folderName: 'solutions-architect-associate',
    certCode: 'SAA-C03',
    domainId: 'aws-solutions-architect',
  },
  {
    folderName: 'AWS Certified Cloud Practitioner - Foundational (CLF-C02)',
    certCode: 'AWS Certified Cloud Practitioner - Foundational (CLF-C02)',
    domainId: 'aws-cloud-practitioner',
  },
  {
    folderName: 'AWS Certified AI Practitioner',
    certCode: 'AWS Certified AI Practitioner',
    domainId: 'aws-cloud-practitioner',
  },
];

const REFERENCE_DATA_PATH = join(process.cwd(), 'src', 'data', 'reference-questions', 'aws');

/**
 * Load reference questions from a specific certification's index.txt
 * Simplified approach: just extract raw text blocks without complex parsing
 */
export async function loadCertificationReferences(certPath: CertificationPath): Promise<ReferenceQuestion[]> {
  try {
    const indexPath = join(REFERENCE_DATA_PATH, certPath.folderName, 'index.txt');
    console.log(`[loadCertificationReferences] Reading from path: ${indexPath}`);
    
    const content = await fs.readFile(indexPath, 'utf-8');
    console.log(`[loadCertificationReferences] File content size: ${content.length} bytes`);
    
    // Simplified: just split by double newlines and extract first few lines of each block
    const blocks = content.split(/\n\n+/).filter(b => b.trim().length > 50);
    console.log(`[loadCertificationReferences] Found ${blocks.length} question blocks`);
    
    // Convert raw blocks to simple ReferenceQuestion objects
    const questions: ReferenceQuestion[] = blocks.slice(0, 100).map((block, idx) => {
      const lines = block.split('\n').filter(l => l.trim());
      
      return {
        id: `${certPath.certCode}-${idx}`,
        certificationCode: certPath.certCode,
        text: lines.slice(0, 3).join(' ').substring(0, 300),  // First 3 lines as question
        type: 'mcq',
        difficulty: 'intermediate',
        domainId: certPath.domainId,
        tags: [],
      };
    });
    
    console.log(`[loadCertificationReferences] Converted to ${questions.length} ReferenceQuestion objects`);
    return questions;
  } catch (error) {
    console.error(`Failed to load reference questions for ${certPath.certCode}:`, error);
    return [];
  }
}

/**
 * Get selected reference questions for generation (5 diverse questions)
 */
export async function getSelectedReferences(certCode: string, count: number = 5): Promise<ReferenceQuestion[]> {
  const cert = CERTIFICATIONS.find(c => c.certCode === certCode);
  if (!cert) {
    console.warn(`Unknown certification code: ${certCode}`);
    return [];
  }

  const allQuestions = await loadCertificationReferences(cert);
  
  if (allQuestions.length === 0) {
    console.warn(`No questions loaded for ${certCode}`);
    return [];
  }

  // Select diverse questions (prefer different types)
  return selectDiverseQuestions(allQuestions, count);
}

/**
 * Select diverse questions spanning different types and difficulties
 */
function selectDiverseQuestions(questions: ReferenceQuestion[], count: number): ReferenceQuestion[] {
  if (questions.length <= count) return questions;

  // Simple random selection - just pick N random questions
  const selected: ReferenceQuestion[] = [];
  const indices = new Set<number>();

  while (selected.length < count && indices.size < questions.length) {
    const randomIdx = Math.floor(Math.random() * questions.length);
    if (!indices.has(randomIdx)) {
      indices.add(randomIdx);
      selected.push(questions[randomIdx]);
    }
  }

  return selected;
}

/**
 * Cache for loaded references to avoid repeated file reads
 */
const referenceCache = new Map<string, ReferenceQuestion[]>();

/**
 * Get cached or fresh reference questions
 */
export async function getCachedReferences(certCode: string, count: number = 5): Promise<ReferenceQuestion[]> {
  const cacheKey = `${certCode}-${count}`;
  
  if (referenceCache.has(cacheKey)) {
    return referenceCache.get(cacheKey) || [];
  }

  const references = await getSelectedReferences(certCode, count);
  referenceCache.set(cacheKey, references);
  
  return references;
}

/**
 * Clear the reference cache (useful for dev/testing)
 */
export function clearReferenceCache(): void {
  referenceCache.clear();
}

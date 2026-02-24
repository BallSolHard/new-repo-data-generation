// Structured exam guide types — represents the official certification exam blueprint

import type { CertTier, AntiPattern } from './tier';

export type CertProvider = 'aws' | 'azure' | 'gcp';
export type GuideStatus = 'current' | 'retiring' | 'retired';
export type QuestionType = 'mcq' | 'multiple' | 'ordering' | 'matching';

export interface ExamGuideService {
  name: string;        // e.g. "Amazon S3"
  category?: string;   // e.g. "Storage"
}

export interface KnowledgeStatement {
  id: string;          // e.g. "ks-1.1.1"
  text: string;        // e.g. "Design VPC architectures with security components"
}

export interface ExamTask {
  id: string;          // e.g. "task-1.1"
  text: string;        // e.g. "Design secure access to AWS resources"
  knowledgeStatements: KnowledgeStatement[];
  antiPatterns?: AntiPattern[];
}

export interface ExamDomain {
  id: string;          // e.g. "domain-1"
  name: string;        // e.g. "Design Secure Architectures"
  weightPercent: number; // e.g. 30 — must sum to 100 across all domains
  tasks: ExamTask[];
  inScopeServices: ExamGuideService[];
}

export interface ExamFormat {
  totalQuestions: number;       // e.g. 65
  scoredQuestions: number;      // e.g. 50
  unscoredQuestions: number;    // e.g. 15 (pretest/unscored)
  duration: number;             // minutes, e.g. 130
  passingScore: number;         // e.g. 720 (out of 1000 for AWS)
  questionTypes: QuestionType[];
}

export interface ExamGuide {
  certificationCode: string;     // e.g. "SAA-C03"
  certificationName: string;     // e.g. "AWS Certified Solutions Architect - Associate"
  provider: CertProvider;
  version: string;               // e.g. "SAA-C03" — the code IS the version for AWS
  effectiveDate: string;         // ISO date, e.g. "2022-08-30"
  retirementDate?: string;       // ISO date or undefined if current
  status: GuideStatus;
  tier?: CertTier;
  examFormat: ExamFormat;
  domains: ExamDomain[];
  outOfScopeTopics?: string[];   // Explicit exclusions from the exam guide
}

// Coverage types — track what the question bank covers vs what the exam guide requires

import type { Difficulty } from './reference-question';

export interface KnowledgeStatementCoverage {
  ksId: string;
  ksText: string;
  taskId: string;
  domainId: string;
  questionCount: number;
  questionIds: string[];
  difficultyBreakdown: Record<Difficulty, number>;
  isCovered: boolean;                   // At least 1 active question
  isWellCovered: boolean;               // Meets threshold (3+ questions across difficulties)
}

export interface ServiceCoverage {
  serviceName: string;
  category?: string;
  domainIds: string[];                  // Which domains reference this service
  questionCount: number;
  questionIds: string[];
  isCovered: boolean;
}

export interface DomainCoverageReport {
  domainId: string;
  domainName: string;
  weightPercent: number;

  // Question counts
  totalQuestions: number;
  activeQuestions: number;
  staleQuestions: number;

  // Knowledge statement coverage
  totalKnowledgeStatements: number;
  coveredKnowledgeStatements: number;
  wellCoveredKnowledgeStatements: number;
  uncoveredKnowledgeStatements: string[];   // KS IDs with 0 questions

  // Service coverage
  totalServices: number;
  coveredServices: number;
  uncoveredServices: string[];

  // Difficulty distribution (actual)
  difficultyDistribution: Record<Difficulty, number>;

  // Composite score 0–100
  coverageScore: number;
}

export interface CertificationCoverageReport {
  certificationCode: string;
  examGuideVersion: string;
  generatedAt: string;

  // Aggregate counts
  totalQuestions: number;
  activeQuestions: number;
  staleQuestions: number;
  retiredQuestions: number;

  // Per-domain breakdown
  domainReports: DomainCoverageReport[];

  // Aggregate metrics
  overallCoverageScore: number;         // 0–100
  totalKnowledgeStatements: number;
  coveredKnowledgeStatements: number;
  totalServices: number;
  coveredServices: number;

  // Actionable gaps
  gaps: CoverageGap[];
}

export interface CoverageGap {
  type: 'knowledge_statement' | 'service' | 'difficulty' | 'question_type';
  domainId: string;
  identifier: string;                   // KS ID, service name, difficulty level, etc.
  description: string;
  severity: 'critical' | 'moderate' | 'low';
  suggestedQuestionCount: number;
}

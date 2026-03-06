-- ═══════════════════════════════════════════════════════
-- Migration 001: Question Bank + Generation Jobs
-- ═══════════════════════════════════════════════════════
-- Run this in Supabase SQL Editor to create the tables
-- needed for the question bank data layer.
-- ═══════════════════════════════════════════════════════

-- Question bank — persistent storage for generated questions
-- with coverage tracking, quality scoring, and lifecycle management
CREATE TABLE IF NOT EXISTS public.question_bank (
  id TEXT PRIMARY KEY,
  certification_code TEXT NOT NULL,
  exam_guide_version TEXT NOT NULL,
  domain_id TEXT NOT NULL,

  -- Question content
  text TEXT NOT NULL,
  type TEXT NOT NULL DEFAULT 'mcq',
  options JSONB NOT NULL,
  correct_answer TEXT,
  explanation TEXT NOT NULL,
  difficulty TEXT NOT NULL DEFAULT 'intermediate',
  pairs JSONB,
  matches JSONB,

  -- Coverage tracking (which parts of the exam guide this question tests)
  task_ids TEXT[] DEFAULT '{}',
  knowledge_statement_ids TEXT[] DEFAULT '{}',
  services_tested TEXT[] DEFAULT '{}',

  -- Quality & lifecycle
  status TEXT NOT NULL DEFAULT 'generated',
  validation_score NUMERIC(3,2) DEFAULT 0,
  validation_confidence TEXT,
  validation_notes TEXT,

  -- Deduplication
  content_hash TEXT NOT NULL,

  -- Provenance
  generation_job_id TEXT,

  -- Timestamps
  generated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  validated_at TIMESTAMPTZ,
  activated_at TIMESTAMPTZ,
  retired_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  modified_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for common query patterns
CREATE INDEX IF NOT EXISTS idx_qb_cert ON public.question_bank(certification_code);
CREATE INDEX IF NOT EXISTS idx_qb_cert_domain ON public.question_bank(certification_code, domain_id);
CREATE INDEX IF NOT EXISTS idx_qb_status ON public.question_bank(status);
CREATE INDEX IF NOT EXISTS idx_qb_difficulty ON public.question_bank(difficulty);
CREATE INDEX IF NOT EXISTS idx_qb_content_hash ON public.question_bank(content_hash);
CREATE INDEX IF NOT EXISTS idx_qb_generated_at ON public.question_bank(generated_at DESC);
CREATE INDEX IF NOT EXISTS idx_qb_job ON public.question_bank(generation_job_id);

-- GIN indexes for array containment queries (coverage lookups)
CREATE INDEX IF NOT EXISTS idx_qb_ks ON public.question_bank USING GIN(knowledge_statement_ids);
CREATE INDEX IF NOT EXISTS idx_qb_services ON public.question_bank USING GIN(services_tested);
CREATE INDEX IF NOT EXISTS idx_qb_tasks ON public.question_bank USING GIN(task_ids);

-- Generation jobs — track batch generation progress
CREATE TABLE IF NOT EXISTS public.generation_job (
  id TEXT PRIMARY KEY,
  type TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending',

  -- Scope
  certification_code TEXT NOT NULL,
  exam_guide_version TEXT NOT NULL,
  domain_targets JSONB NOT NULL,

  -- Configuration
  total_target_questions INTEGER NOT NULL,
  difficulty_distribution JSONB NOT NULL DEFAULT '{"basic":20,"intermediate":50,"advanced":30}',
  question_types TEXT[] NOT NULL DEFAULT '{mcq}',
  enable_validation BOOLEAN DEFAULT true,

  -- Progress
  questions_generated INTEGER DEFAULT 0,
  questions_validated INTEGER DEFAULT 0,
  questions_rejected INTEGER DEFAULT 0,
  domains_completed INTEGER DEFAULT 0,
  domains_total INTEGER NOT NULL,

  -- Provenance
  triggered_by TEXT NOT NULL DEFAULT 'manual',
  version_diff_id TEXT,
  errors JSONB DEFAULT '[]',

  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_job_status ON public.generation_job(status);
CREATE INDEX IF NOT EXISTS idx_job_cert ON public.generation_job(certification_code);

-- Exam guide version history — track when guides were imported
CREATE TABLE IF NOT EXISTS public.exam_guide_version (
  id TEXT PRIMARY KEY,
  certification_code TEXT NOT NULL,
  version TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'current',
  effective_date DATE NOT NULL,
  retirement_date DATE,
  domain_count INTEGER,
  total_knowledge_statements INTEGER,
  total_services INTEGER,
  imported_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(certification_code, version)
);

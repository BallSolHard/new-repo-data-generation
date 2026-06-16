-- V2: Add cert_tier and gen_mode support to question bank + reference questions table
-- Run after 001_question_bank.sql

-- Add tier/mode columns to question_bank
ALTER TABLE question_bank ADD COLUMN IF NOT EXISTS cert_tier TEXT;
ALTER TABLE question_bank ADD COLUMN IF NOT EXISTS gen_mode TEXT;
CREATE INDEX IF NOT EXISTS idx_qb_cert_tier ON question_bank(cert_tier);
CREATE INDEX IF NOT EXISTS idx_qb_gen_mode ON question_bank(gen_mode);

-- Reference questions table (DB-backed for v2 few-shot selection)
CREATE TABLE IF NOT EXISTS reference_question (
  id TEXT PRIMARY KEY,
  certification_code TEXT NOT NULL,
  domain_id TEXT NOT NULL,
  cert_tier TEXT,
  gen_mode TEXT,
  text TEXT NOT NULL,
  type TEXT NOT NULL DEFAULT 'mcq',
  options JSONB NOT NULL,
  correct_answer TEXT,
  explanation TEXT NOT NULL,
  difficulty TEXT NOT NULL DEFAULT 'intermediate',
  tags TEXT[] DEFAULT '{}',
  source TEXT DEFAULT 'custom',
  created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_ref_tier_mode ON reference_question(cert_tier, gen_mode);
CREATE INDEX IF NOT EXISTS idx_ref_cert_domain ON reference_question(certification_code, domain_id);

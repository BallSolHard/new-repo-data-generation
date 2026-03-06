-- ═══════════════════════════════════════════════════════
-- Parameterized Export Questions Script
-- ═══════════════════════════════════════════════════════
-- Purpose: Export questions by certification ID with INSERT statements
-- Compatible with: PostgreSQL, Supabase
-- 
-- Usage:
--   1. Set certification_id variable at the top
--   2. Run entire script in your SQL editor or via CLI:
--      psql -d your_database -v cert_id=13 -f export_questions_parameterized.sql
--   3. Or in Supabase SQL Editor, set the variable and run
-- ═══════════════════════════════════════════════════════

-- ╔═══════════════════════════════════════════════════════╗
-- ║ CONFIGURATION — MODIFY THESE VALUES                  ║
-- ╚═══════════════════════════════════════════════════════╝

\set cert_id 13
\set env_name 'development'
\set dry_run false

-- ═══════════════════════════════════════════════════════
-- Step 0: Configuration Summary
-- ═══════════════════════════════════════════════════════

\echo '═══════════════════════════════════════════════════════'
\echo 'EXPORT QUESTIONS SCRIPT'
\echo '═══════════════════════════════════════════════════════'
\echo 'Environment: ' :env_name
\echo 'Certification ID: ' :cert_id
\echo 'Timestamp: ' now
\echo '═══════════════════════════════════════════════════════'

-- ═══════════════════════════════════════════════════════
-- Step 1: Preview — Show all questions that will be exported
-- ═══════════════════════════════════════════════════════

\echo ''
\echo 'STEP 1: PREVIEW — Questions to be exported'
\echo '───────────────────────────────────────────────────────'

SELECT 
  COUNT(*) as total_questions
FROM public.question_bank qb
WHERE qb.certification_code IN (
  SELECT DISTINCT c.code 
  FROM certifications c 
  WHERE c.id = :cert_id
);

-- Show sample of questions
SELECT 
  qb.id,
  qb.certification_code,
  qb.text,
  qb.type,
  qb.difficulty,
  qb.status,
  qb.generated_at
FROM public.question_bank qb
WHERE qb.certification_code IN (
  SELECT DISTINCT c.code 
  FROM certifications c 
  WHERE c.id = :cert_id
)
ORDER BY generated_at DESC
LIMIT 5;

-- ═══════════════════════════════════════════════════════
-- Step 2: Generate INSERT statements with ON CONFLICT
-- ═══════════════════════════════════════════════════════

\echo ''
\echo 'STEP 2: INSERTING questions with ON CONFLICT handling'
\echo '───────────────────────────────────────────────────────'

BEGIN;

-- Export all questions and generate INSERT statements
-- Each question gets an INSERT with ON CONFLICT (id) DO NOTHING
WITH questions_to_export AS (
  SELECT 
    qb.id,
    qb.certification_code,
    qb.exam_guide_version,
    qb.domain_id,
    qb.text,
    qb.type,
    qb.options,
    qb.correct_answer,
    qb.explanation,
    qb.difficulty,
    qb.pairs,
    qb.matches,
    qb.task_ids,
    qb.knowledge_statement_ids,
    qb.services_tested,
    qb.status,
    qb.validation_score,
    qb.validation_confidence,
    qb.validation_notes,
    qb.content_hash,
    qb.generation_job_id,
    qb.generated_at,
    qb.validated_at,
    qb.activated_at,
    qb.retired_at
  FROM public.question_bank qb
  WHERE qb.certification_code IN (
    SELECT DISTINCT c.code 
    FROM certifications c 
    WHERE c.id = :cert_id
  )
)
INSERT INTO public.question_bank (
  id,
  certification_code,
  exam_guide_version,
  domain_id,
  text,
  type,
  options,
  correct_answer,
  explanation,
  difficulty,
  pairs,
  matches,
  task_ids,
  knowledge_statement_ids,
  services_tested,
  status,
  validation_score,
  validation_confidence,
  validation_notes,
  content_hash,
  generation_job_id,
  generated_at,
  validated_at,
  activated_at,
  retired_at
)
SELECT 
  id,
  certification_code,
  exam_guide_version,
  domain_id,
  text,
  type,
  options,
  correct_answer,
  explanation,
  difficulty,
  pairs,
  matches,
  task_ids,
  knowledge_statement_ids,
  services_tested,
  status,
  validation_score,
  validation_confidence,
  validation_notes,
  content_hash,
  generation_job_id,
  generated_at,
  validated_at,
  activated_at,
  retired_at
FROM questions_to_export
ON CONFLICT (id) DO NOTHING;

-- ═══════════════════════════════════════════════════════
-- Step 3: Verification Queries
-- ═══════════════════════════════════════════════════════

\echo ''
\echo 'STEP 3: VERIFICATION — Confirming successful export'
\echo '───────────────────────────────────────────────────────'

-- Check total questions for certification
SELECT 
  COUNT(*) as total_questions,
  COUNT(DISTINCT type) as question_types,
  COUNT(DISTINCT status) as statuses,
  COUNT(DISTINCT difficulty) as difficulty_levels
FROM public.question_bank qb
WHERE qb.certification_code IN (
  SELECT DISTINCT c.code 
  FROM certifications c 
  WHERE c.id = :cert_id
);

-- List questions by status
SELECT 
  status,
  difficulty,
  COUNT(*) as count
FROM public.question_bank qb
WHERE qb.certification_code IN (
  SELECT DISTINCT c.code 
  FROM certifications c 
  WHERE c.id = :cert_id
)
GROUP BY status, difficulty
ORDER BY status, difficulty;

-- List questions by type
SELECT 
  type,
  COUNT(*) as count
FROM public.question_bank qb
WHERE qb.certification_code IN (
  SELECT DISTINCT c.code 
  FROM certifications c 
  WHERE c.id = :cert_id
)
GROUP BY type
ORDER BY count DESC;

COMMIT;

\echo ''
\echo '═══════════════════════════════════════════════════════'
\echo 'EXPORT COMPLETED SUCCESSFULLY'
\echo '═══════════════════════════════════════════════════════'

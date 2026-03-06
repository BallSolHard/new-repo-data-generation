-- ═══════════════════════════════════════════════════════
-- Export Questions by Certification ID with INSERT Statements
-- ═══════════════════════════════════════════════════════
-- Purpose: Generate INSERT statements for all questions in a certification
-- Usage: Modify certification_id=13 as needed
-- ═══════════════════════════════════════════════════════

-- Step 1: Preview — Show all questions that will be exported
-- (Run this first to verify you're getting the right records)

SELECT 
  qb.id,
  qb.certification_code,
  qb.text,
  qb.type,
  qb.options,
  qb.correct_answer,
  qb.explanation,
  qb.difficulty,
  qb.status,
  qb.generated_at
FROM public.question_bank qb
WHERE qb.certification_code IN (
  SELECT DISTINCT c.code 
  FROM certifications c 
  WHERE c.id = 13
);

-- ═══════════════════════════════════════════════════════
-- Step 2: Generate INSERT statements with ON CONFLICT
-- ═══════════════════════════════════════════════════════

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
    WHERE c.id = 13
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
-- Verification Queries
-- ═══════════════════════════════════════════════════════

-- Check total questions for certification 13
SELECT 
  COUNT(*) as total_questions,
  COUNT(DISTINCT type) as question_types,
  COUNT(DISTINCT status) as statuses
FROM public.question_bank qb
WHERE qb.certification_code IN (
  SELECT DISTINCT c.code 
  FROM certifications c 
  WHERE c.id = 13
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
  WHERE c.id = 13
)
GROUP BY status, difficulty
ORDER BY status, difficulty;

-- Sample of first 10 questions
SELECT 
  id,
  text,
  type,
  difficulty,
  status,
  generated_at
FROM public.question_bank qb
WHERE qb.certification_code IN (
  SELECT DISTINCT c.code 
  FROM certifications c 
  WHERE c.id = 13
)
ORDER BY generated_at DESC
LIMIT 10;

COMMIT;

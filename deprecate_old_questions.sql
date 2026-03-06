-- ═══════════════════════════════════════════════════════
-- Deprecate Old Questions
-- ═══════════════════════════════════════════════════════
-- Purpose: Mark old questions as deprecated using is_deprecated flag
-- This allows the system to filter them out while keeping history
-- ═══════════════════════════════════════════════════════

BEGIN;

-- Insert or update deprecated questions
-- These are questions created before quality standards were implemented
-- is_deprecated = true means they should not be served to users

INSERT INTO public.question (
  id,
  text,
  options,
  correct_answer,
  explanation,
  created_at,
  quiz_id,
  modified_at,
  type,
  index,
  pairs,
  matches,
  module_id,
  difficulty,
  is_deprecated
) VALUES
  (
    'q_60_m_60_3_71',
    'Which migration strategy allows you to keep some applications on-premises?',
    '["Rehost","Refactor","Retain","Repurchase"]'::json,
    '{2}'::int[],
    'Retain keeps selected workloads on-prem.',
    '2025-08-28 01:52:30.286694'::timestamp,
    'quiz_domain60_13',
    '2025-08-28 01:52:30.286694'::timestamp,
    'mcq',
    21,
    NULL,
    NULL,
    'm_60_3',
    'medium',
    true
  ) ON CONFLICT (id) DO NOTHING,
  (
    'q_60_m_60_3_74',
    'What is a key capability of AWS Snow Family devices?',
    '["Real-time data processing","Large-scale data transfer in environments with limited connectivity","Application hosting","Database management"]'::json,
    '{1}'::int[],
    'Snow Family enables petabyte-scale transfer when networks are constrained.',
    '2025-08-28 01:52:30.286694'::timestamp,
    'quiz_domain60_13',
    '2025-08-28 01:52:30.286694'::timestamp,
    'mcq',
    24,
    NULL,
    NULL,
    'm_60_3',
    'medium',
    true
  ) ON CONFLICT (id) DO NOTHING,
  (
    'q_62_m_62_1_15',
    'A startup needs consistent deployments + on-prem AD integration. Which is best?',
    '["Manual console + VPN","CloudFormation + Directory Service","CLI only + custom auth","3rd-party tools + manual AD sync"]'::json,
    '{1}'::int[],
    'CloudFormation ensures consistent deployments; Directory Service integrates AD. Best combination for this need.',
    '2025-08-29 01:11:23.677621'::timestamp,
    'quiz_domain62_13',
    '2025-08-29 01:11:23.677621'::timestamp,
    'mcq',
    15,
    NULL,
    NULL,
    'm_62_1',
    'medium',
    true
  ) ON CONFLICT (id) DO NOTHING,
  (
    'q_62_m_62_1_16',
    'Which factors should drive choice of deployment model? (Select THREE)',
    '["Regulatory/compliance","Data sensitivity/sovereignty","Cost optimization/efficiency","Logo design","Office architecture","Marketing strategy"]'::json,
    '{0,1,2}'::int[],
    'Compliance, data sovereignty, and cost/ops needs drive model choice. Branding, building design, or marketing don''t.',
    '2025-08-29 01:11:23.677621'::timestamp,
    'quiz_domain62_13',
    '2025-08-29 01:11:23.677621'::timestamp,
    'multiple',
    16,
    NULL,
    NULL,
    'm_62_1',
    'medium',
    true
  ) ON CONFLICT (id) DO NOTHING,
  (
    'q_62_m_62_1_17',
    'When use AWS SDKs over CLI?',
    '["When integrating AWS into app code","For one-off commands","For shell scripts","For command-line only"]'::json,
    '{0}'::int[],
    'SDKs integrate directly into app code. CLI is better for one-off or scripts.',
    '2025-08-29 01:11:23.677621'::timestamp,
    'quiz_domain62_13',
    '2025-08-29 01:11:23.677621'::timestamp,
    'mcq',
    17,
    NULL,
    NULL,
    'm_62_1',
    'medium',
    true
  ) ON CONFLICT (id) DO NOTHING,
  (
    'q_60_m_60_2_12',
    'What is meant by "global reach" in AWS Cloud?',
    '["AWS has offices in every country","AWS has data centers and services available in multiple geographic regions","AWS provides customer support in all languages","AWS offers the same pricing worldwide"]'::json,
    '{1}'::int[],
    'Global reach refers to Regions/AZs and services available worldwide.',
    '2025-08-27 15:10:05.086876'::timestamp,
    'quiz_domain60_13',
    '2025-08-27 15:10:05.086876'::timestamp,
    'mcq',
    12,
    NULL,
    NULL,
    'm_60_2',
    'medium',
    true
  ) ON CONFLICT (id) DO NOTHING,
  (
    'q_60_m_60_1_16',
    'Which design principles support the Cost Optimization pillar? (Select ALL that apply)',
    '["Adopt a consumption model","Always use the largest instance sizes","Measure overall efficiency","Implement security at all layers","Stop spending money on data center operations"]'::json,
    '{0,2,4}'::int[],
    'Adopt consumption, measure efficiency, and avoid undifferentiated DC ops.',
    '2025-08-28 01:17:53.947167'::timestamp,
    'quiz_domain60_13',
    '2025-08-28 01:17:53.947167'::timestamp,
    'multiple',
    16,
    NULL,
    NULL,
    'm_60_1',
    'medium',
    true
  ) ON CONFLICT (id) DO NOTHING,
  (
    'q_60_m_60_1_17',
    'The Reliability pillar''s design principle of "scale horizontally" means:',
    '["Increasing the size of individual resources","Adding more resources of the same type","Reducing the number of resources","Using only vertical scaling"]'::json,
    '{1}'::int[],
    'Horizontal scaling uses multiple smaller units to improve reliability.',
    '2025-08-28 01:17:53.947167'::timestamp,
    'quiz_domain60_13',
    '2025-08-28 01:17:53.947167'::timestamp,
    'mcq',
    17,
    NULL,
    NULL,
    'm_60_1',
    'medium',
    true
  ) ON CONFLICT (id) DO NOTHING,
  (
    'q_60_m_60_3_54',
    'How many perspectives are there in the AWS Cloud Adoption Framework?',
    '["4","5","6","7"]'::json,
    '{2}'::int[],
    'CAF defines six perspectives.',
    '2025-08-28 01:52:30.286694'::timestamp,
    'quiz_domain60_13',
    '2025-08-28 01:52:30.286694'::timestamp,
    'mcq',
    4,
    NULL,
    NULL,
    'm_60_3',
    'medium',
    true
  ) ON CONFLICT (id) DO NOTHING,
  (
    'q_60_m_60_3_55',
    'Which are perspectives in the AWS Cloud Adoption Framework? (Select ALL that apply)',
    '["Business","People","Governance","Platform","Security","Operations"]'::json,
    '{0,1,2,3,4,5}'::int[],
    'CAF perspectives: Business, People, Governance, Platform, Security, Operations.',
    '2025-08-28 01:52:30.286694'::timestamp,
    'quiz_domain60_13',
    '2025-08-28 01:52:30.286694'::timestamp,
    'multiple',
    5,
    NULL,
    NULL,
    'm_60_3',
    'medium',
    true
  ) ON CONFLICT (id) DO NOTHING,
  (
    'q_62_m_62_1_18',
    'Which approaches support multi-region disaster recovery? (Select THREE)',
    '["CloudFormation templates","Manual console edits","Version-controlled infra definitions","Manual recovery docs","CLI automation for failover","Ad-hoc planning"]'::json,
    '{0,2,4}'::int[],
    'CloudFormation ensures consistent DR, versioned infra definitions provide blueprints, CLI automates failover. Manual/ad-hoc not reliable.',
    '2025-08-29 01:11:23.677621'::timestamp,
    'quiz_domain62_13',
    '2025-08-29 01:11:23.677621'::timestamp,
    'multiple',
    18,
    NULL,
    NULL,
    'm_62_1',
    'medium',
    true
  ) ON CONFLICT (id) DO NOTHING;

-- Update existing questions to mark as deprecated (if they exist)
UPDATE public.question
SET is_deprecated = true, modified_at = NOW()
WHERE id IN (
  'q_60_m_60_3_71',
  'q_60_m_60_3_74',
  'q_62_m_62_1_15',
  'q_62_m_62_1_16',
  'q_62_m_62_1_17',
  'q_60_m_60_2_12',
  'q_60_m_60_1_16',
  'q_60_m_60_1_17',
  'q_60_m_60_3_54',
  'q_60_m_60_3_55',
  'q_62_m_62_1_18'
);

COMMIT;

-- ═══════════════════════════════════════════════════════
-- Verification Queries
-- ═══════════════════════════════════════════════════════

-- Check how many questions are now deprecated
SELECT 
  COUNT(*) AS total_questions,
  COUNT(CASE WHEN is_deprecated = true THEN 1 END) AS deprecated_questions,
  COUNT(CASE WHEN is_deprecated = false THEN 1 END) AS active_questions
FROM public.question
WHERE id IN (
  'q_60_m_60_3_71',
  'q_60_m_60_3_74',
  'q_62_m_62_1_15',
  'q_62_m_62_1_16',
  'q_62_m_62_1_17',
  'q_60_m_60_2_12',
  'q_60_m_60_1_16',
  'q_60_m_60_1_17',
  'q_60_m_60_3_54',
  'q_60_m_60_3_55',
  'q_62_m_62_1_18'
);

-- Show all deprecated questions
SELECT 
  id,
  TEXT,
  quiz_id,
  created_at,
  is_deprecated,
  modified_at
FROM public.question
WHERE is_deprecated = true
ORDER BY created_at ASC;

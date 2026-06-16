# Mock Test SQL Generation Fixes

## Issues Identified

### 1. Missing mock_tests Table Insert
**Problem:** The generated script only inserts into `mock_test_questions` but never creates the mock test record in `mock_tests` table.

**Solution:** Add an INSERT statement for the mock_tests table before inserting questions:

```sql
INSERT INTO public.mock_tests (
  id, 
  topic_id, 
  title, 
  total_questions, 
  difficulty_distribution, 
  created_at, 
  modified_at
)
VALUES (
  'mock_5_all_1774916815746',
  5,
  'Mock Test - Topic 5 - All Modules',
  0,  -- Will be updated later
  '{"easy": 7, "medium": 6, "hard": 4}'::jsonb,
  NOW(),
  NOW()
)
ON CONFLICT (id) DO NOTHING;
```

### 2. "undefined" Module IDs
**Problem:** When module information is missing, the generator defaults to `'undefined'` instead of a proper module_id.

**Solution:** Before inserting questions, validate and map module_ids:

- If `module_id` is `'undefined'` or `NULL`, determine the correct module based on question content or topic structure
- Maintain a module mapping for each topic/certification
- For questions without a clear module, use a default module like `'m_topic_general'` or the first module of the topic

**Example Module Mapping:**
```sql
-- For Topic 5 (ML/AI related)
m_5_1 -> Basic ML Concepts
m_5_2 -> AWS AI Services
m_5_3 -> ML Development Lifecycle
m_5_4 -> Responsible AI
```

### 3. Incomplete INSERT Statements
**Problem:** Some INSERT statements have missing columns or incomplete data:

```sql
INSERT INTO public.question (...) 
VALUES (
  'q_60_m_60_2_99',
  'hard'  -- Missing all other columns!
) ON CONFLICT (id) DO NOTHING;
```

**Solution:** Complete validation before SQL generation to ensure all required fields are present:
- `text` - Question content (required)
- `type` - Question type: 'mcq', 'ordering', 'matching', 'pairing' (required)
- `options` - JSON array of options (required for mcq/ordering)
- `correct_answer` - Answer(s) (required)
- `explanation` - Question explanation (required)
- `module_id` - Must not be null/undefined (required)

## SQL Script Template for Mock Tests

```sql
-- ═══════════════════════════════════════════════════════
-- Generated Mock Test Questions — AI Pipeline Output
-- ═══════════════════════════════════════════════════════
-- Mock Test ID: {mock_test_id}
-- Topic ID: {topic_id}
-- Questions: {question_count}
-- Generated: {timestamp}
-- ═══════════════════════════════════════════════════════

BEGIN;

-- ─────────────────────────────────────────
-- Create Mock Test Record
-- ─────────────────────────────────────────

INSERT INTO public.mock_tests (
  id,
  topic_id,
  title,
  total_questions,
  difficulty_distribution,
  created_at,
  modified_at
)
VALUES (
  '{mock_test_id}',
  {topic_id},
  '{title}',
  0,  -- Will be updated at the end
  '{difficulty_distribution}'::jsonb,
  NOW(),
  NOW()
)
ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────
-- Add Questions to Mock Test
-- ─────────────────────────────────────────

INSERT INTO public.mock_test_questions (
  mock_test_id,
  question_text,
  options,
  question_type,
  correct_answer,
  explanation,
  topic_id,
  module_id,
  question_order,
  pairs,
  matches
)
VALUES
  ('{mock_test_id}', '{question_text}', '{options}'::jsonb, '{type}', '{correct_answer}'::integer[], '{explanation}', {topic_id}, '{module_id}', {order}, NULL, NULL),
  ... more rows ...
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────
-- Update Mock Test With Question Count
-- ─────────────────────────────────────────

UPDATE public.mock_tests
SET 
  total_questions = (
    SELECT COUNT(*)
    FROM public.mock_test_questions
    WHERE mock_test_id = '{mock_test_id}'
  ),
  modified_at = NOW()
WHERE id = '{mock_test_id}';

COMMIT;
```

## Implementation Checklist

- [ ] Always insert into `mock_tests` table first
- [ ] Validate all question fields before INSERT
- [ ] Replace 'undefined' module_ids with proper values
- [ ] Complete all partial INSERT statements
- [ ] Use proper data type casting (::jsonb, ::integer[])
- [ ] Include proper error handling (ON CONFLICT)
- [ ] Update question count at the end
- [ ] Verify module_id exists in the topic

## Column Requirements by Table

### mock_tests
```
id (TEXT, PRIMARY KEY) - Required
topic_id (INTEGER) - Required
title (TEXT) - Required
total_questions (INTEGER) - Optional, can be 0 initially
difficulty_distribution (JSONB) - Optional
created_at (TIMESTAMPTZ) - Default NOW()
modified_at (TIMESTAMPTZ) - Default NOW()
```

### mock_test_questions
```
mock_test_id (TEXT) - Required, FK to mock_tests.id
question_text (TEXT) - Required
options (JSONB) - Required
question_type (TEXT) - Required ('mcq', 'ordering', 'matching', 'pairing')
correct_answer (INTEGER[]) - Required
explanation (TEXT) - Required
topic_id (INTEGER) - Required
module_id (TEXT) - Required, should NOT be 'undefined'
question_order (INTEGER) - Required
pairs (JSONB) - Optional, for pairing/matching questions
matches (JSONB) - Optional, for matching questions
```

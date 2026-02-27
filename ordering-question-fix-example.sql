-- CORRECTED SQL Script for Ordering Questions
-- The issue was using JSON array format '[0,1,2,3]' instead of PostgreSQL array format '{0,1,2,3}'

-- BEFORE (INCORRECT - causes "malformed array literal" error):
INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)
VALUES ('q_64_m_64_1_19','Order the steps...','ordering','["Option 1","Option 2","Option 3","Option 4"]'::json,'[0,1,2,3]','Explanation...',NOW(),'quiz_domain64_14',NOW(),19,NULL,NULL,'m_64_1');

-- AFTER (CORRECT - PostgreSQL array format):
INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)
VALUES ('q_64_m_64_1_19','Order the steps...','ordering','["Option 1","Option 2","Option 3","Option 4"]'::json,'{0,1,2,3}','Explanation...',NOW(),'quiz_domain64_14',NOW(),19,NULL,NULL,'m_64_1');

-- CORRECTED EXAMPLE - Full RAG Implementation Ordering Question:
BEGIN;

-- =====================
-- QUESTIONS - Analyze requirements and design GenAI solutions  
-- =====================

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)
VALUES (
  'q_64_m_64_1_19',
  'Arrange the following steps in the logical sequence for implementing a Retrieval Augmented Generation (RAG) system with a vector store in a GenAI solution:',
  'ordering',
  '["Process and embed source documents into vector representations for semantic search readiness.","Store the generated vector embeddings in a purpose-built vector database for efficient indexing and retrieval.","Receive a user query, generate its embedding, and then perform a semantic similarity search against the entire vector store to retrieve the most contextually relevant document chunks from the original dataset.","Construct an augmented prompt by combining the retrieved document chunks with the original user query, and forward this to the Foundation Model for a comprehensive generative response."]'::json,
  '{0,1,2,3}',  -- ✅ CORRECT: PostgreSQL array format with curly braces
  'The typical RAG process begins with ingesting and embedding source data, storing these embeddings, retrieving relevant context based on a user query, and finally augmenting the prompt with this context before sending it to the FM.',
  NOW(),
  'quiz_domain64_14',
  NOW(),
  19,
  NULL,
  NULL,
  'm_64_1'
) ON CONFLICT (id) DO NOTHING;

-- =====================
-- Link questions to quiz
-- =====================
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
(NOW(),'quiz_domain64_14','q_64_m_64_1_19')
ON CONFLICT DO NOTHING;

-- Update question count
UPDATE public.quiz q
SET questions = sub.cnt,
    modified_at = NOW()
FROM (
  SELECT quiz_id, COUNT(*)::int AS cnt
  FROM public.quiz_question
  WHERE quiz_id = 'quiz_domain64_14'
  GROUP BY quiz_id
) sub
WHERE q.id = sub.quiz_id;

COMMIT;

/*
KEY CHANGES MADE TO FIX THE ISSUE:

1. SQL Format Fix:
   - BEFORE: '[0,1,2,3]' (JSON format with square brackets) ❌
   - AFTER:  '{0,1,2,3}' (PostgreSQL array format with curly braces) ✅

2. Code Changes in generate-hub/route.ts:
   - Updated correct_answer handling for ordering questions
   - Convert JSON arrays to PostgreSQL array format for SQL storage
   - Added proper type handling for 'ordering' questions

3. Type Updates in types.ts:
   - Updated GeneratedQuestion interface to support ordering
   - Updated ValidationResponse to handle array formats
   - Added 'ordering' to question type union

4. Prompt Updates in generation.ts:
   - Added ordering-specific instructions
   - Updated answer format guidance
   - Added ordering question validation logic

5. UI Updates in page.tsx:
   - Added "Ordering Questions" option to question type dropdown
   - Updated descriptions for different question types

RESULT:
- Ordering questions now generate proper PostgreSQL array format: '{0,1,2,3}'
- No more "malformed array literal" errors
- Questions store correctly in the database
- System supports MCQ, Multiple Select, AND Ordering questions
*/

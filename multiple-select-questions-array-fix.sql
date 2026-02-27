-- =====================================================
-- MULTIPLE SELECT QUESTIONS SQL FIX - Before and After
-- =====================================================
-- This file shows the corrected SQL format for multiple select questions

-- =====================================================
-- PROBLEM: The INCORRECT SQL that was being generated
-- =====================================================

-- This FAILED with ERROR: 22P02: malformed array literal: "[0,1]" 
-- Missing "]" after array dimensions.

-- INCORRECT SQL:
-- INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)
-- VALUES ('q_64_m_64_1_21','When designing a RAG system...','multiple','[...]'::json,'[0,1]','Explanation...',NOW(),'quiz_domain64_14',NOW(),21,NULL,NULL,'m_64_1');
--                                                                                                                    ^^^^^^^
--                                                                              Problem: '[0,1]' should be {0,1}

-- =====================================================
-- SOLUTION: The CORRECTED SQL that works properly  
-- =====================================================

BEGIN;

-- Corrected SQL for multiple select questions
INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)
VALUES (
    'q_64_m_64_1_21',
    'When designing a Retrieval Augmented Generation (RAG) system for a Generative AI solution on AWS, which of the following are essential design considerations? (Choose all that apply)',
    'multiple',
    '["Selecting an appropriate vector database or similarity search service to store document embeddings efficiently.","Implementing robust data ingestion pipelines, including strategies for document chunking and metadata extraction, to prepare data for embedding.","Manually labeling every single data point in the entire dataset for supervised fine-tuning of the foundation model, a time-consuming process that involves human annotators reviewing and categorizing vast amounts of information to ensure the highest possible accuracy and domain specificity for all model outputs.","Exclusively using serverless AWS Lambda functions for all heavy-duty embedding generation and vector similarity search operations to minimize infrastructure costs, even for extremely large-scale datasets and high-throughput requirements."]'::json,
    '{0,1}',  -- ✓ CORRECT: PostgreSQL array format {0,1} instead of JSON '[0,1]'
    'Effective RAG system design requires selecting suitable vector storage for efficient retrieval (e.g., OpenSearch Service, Aurora with pgvector) and establishing robust data processing pipelines for ingestion, chunking, and metadata extraction. Manual labeling of every data point for fine-tuning is typically for supervised learning scenarios, not a primary RAG design step. Exclusively using Lambda for all heavy-duty RAG components might not be scalable or cost-effective for large datasets and high-throughput needs, as other specialized services are often more suitable.',
    NOW(),
    'quiz_domain64_14',
    NOW(),
    21,
    NULL,
    NULL,
    'm_64_1'
) ON CONFLICT (id) DO NOTHING;

COMMIT;

-- =====================================================
-- TECHNICAL EXPLANATION OF THE FIX
-- =====================================================

-- The issue was in the question processing logic:

-- BEFORE (incorrect):
-- For multiple select questions:
-- correct_answer = JSON.stringify(questionData.correct_answer);  // Creates "[0,1]" string
-- SQL generation: `'${correctAnswerValue}'`  // Becomes '[0,1]' in SQL
-- Result: PostgreSQL tries to parse '[0,1]' as an array literal → ERROR

-- AFTER (correct):
-- For multiple select questions:
-- correct_answer = questionData.correct_answer;  // Keep as array [0,1]
-- SQL generation: `{${question.correct_answer.join(',')}}`  // Becomes {0,1}
-- const correctAnswerSQL = correctAnswerValue === 'NULL' ? 'NULL' : `'${correctAnswerValue}'`;
-- Result: PostgreSQL correctly interprets '{0,1}' as an array → SUCCESS

-- =====================================================
-- CODE CHANGES MADE
-- =====================================================

-- In src/app/api/generate-hub/route.ts:

-- CHANGE 1: Question Processing (around line 347)
-- OLD CODE:
-- } else if (questionType === "multiple") {
--   if (Array.isArray(questionData.correct_answer)) {
--     correct_answer = JSON.stringify(questionData.correct_answer);  // ❌ JSON string
--   } else {
--     correct_answer = JSON.stringify([0, 1]);
--   }

-- NEW CODE:
-- } else if (questionType === "multiple") {
--   if (Array.isArray(questionData.correct_answer)) {
--     correct_answer = questionData.correct_answer;  // ✓ Keep as array
--   } else {
--     correct_answer = [0, 1];
--   }

-- CHANGE 2: SQL Generation (around line 555)
-- Added explicit handling for multiple select JSON string format (legacy compatibility):
-- } else if (questionType === 'multiple' && typeof question.correct_answer === 'string') {
--   // Handle JSON string format for multiple select questions (legacy compatibility)
--   try {
--     const parsed = JSON.parse(question.correct_answer);
--     if (Array.isArray(parsed)) {
--       correctAnswerValue = `{${parsed.join(',')}}`;
--     } else {
--       correctAnswerValue = '{0,1}'; // Default multiple select
--     }
--   } catch {
--     correctAnswerValue = '{0,1}'; // Default multiple select
--   }

-- =====================================================
-- VERIFICATION OF ALL QUESTION TYPES
-- =====================================================

-- MCQ Question (correct_answer as string):
INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)
VALUES ('q_mcq_example', 'Which is correct?', 'mcq', '["A", "B", "C", "D"]'::json, '{1}', 'B is correct', NOW(), 'quiz_1', NOW(), 1, NULL, NULL, 'm_1');

-- Multiple Select Question (correct_answer as PostgreSQL array):
INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)
VALUES ('q_multi_example', 'Which are correct? (Select 2)', 'multiple', '["A", "B", "C", "D"]'::json, '{0,2}', 'A and C are correct', NOW(), 'quiz_1', NOW(), 2, NULL, NULL, 'm_1');

-- Ordering Question (correct_answer as PostgreSQL array):
INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)  
VALUES ('q_order_example', 'Order these steps:', 'ordering', '["Step A", "Step B", "Step C", "Step D"]'::json, '{2,0,1,3}', 'Correct order: C, A, B, D', NOW(), 'quiz_1', NOW(), 3, NULL, NULL, 'm_1');

-- Matching Question (correct_answer as NULL, uses pairs and matches):
INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)
VALUES ('q_match_example', 'Match terms to descriptions:', 'matching', '{"A": "Term1", "B": "Term2", "C": "Term3"}'::json, NULL, 'Matching explanation', NOW(), 'quiz_1', NOW(), 4, '{"left": ["Term1", "Term2", "Term3"], "right": ["Desc1", "Desc2", "Desc3"]}'::json, '{"left": [0, 1, 2], "right": [0, 1, 2]}'::json, 'm_1');

-- =====================================================
-- POSTGRESQL ARRAY FORMAT REQUIREMENTS
-- =====================================================

-- PostgreSQL expects array literals to be in curly brace format:
-- Correct:   '{0,1,2}'     → array of integers [0, 1, 2]
-- Correct:   '{a,b,c}'     → array of strings ['a', 'b', 'c']  
-- Incorrect: '[0,1,2]'     → JSON format, not PostgreSQL array
-- Incorrect: '0,1,2'       → comma-separated string, not array

-- For the correct_answer column (which is of array type in PostgreSQL):
-- - MCQ:            '{1}'           → single element array
-- - Multiple:       '{0,2}'         → multiple elements array  
-- - Ordering:       '{3,1,0,2}'     → sequence array
-- - Matching:       NULL            → no array, uses pairs/matches instead

-- =====================================================
-- SUMMARY
-- =====================================================

-- The fix ensures that:
-- 1. Multiple select questions store correct_answer as arrays (not JSON strings)
-- 2. Arrays are converted to PostgreSQL format {0,1} (not JSON format [0,1])
-- 3. Legacy JSON string format is handled with proper conversion
-- 4. Other question types continue to work as before
-- 5. PostgreSQL correctly interprets the array values

-- This resolves the "malformed array literal" error and allows
-- multiple select questions to be properly stored in the database.

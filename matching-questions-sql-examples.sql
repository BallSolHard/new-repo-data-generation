-- =====================================================
-- MATCHING QUESTIONS SQL EXAMPLE
-- =====================================================
-- This file shows how matching questions are generated and stored in the database

-- =====================================================
-- EXAMPLE 1: AI/ML Concepts Matching Question
-- =====================================================

BEGIN;

-- Insert a matching question for AI/ML domain
INSERT INTO public.question (
    id, 
    text, 
    type, 
    options, 
    correct_answer, 
    explanation, 
    created_at, 
    quiz_id, 
    modified_at, 
    index, 
    pairs, 
    matches, 
    module_id
) VALUES (
    'q_domain5_1_m_5_1_10',
    'Match each AI/ML term to its description.',
    'matching',
    '{"A": "Computer vision", "B": "NLP", "C": "Inference"}'::json,
    NULL,
    'Computer vision deals with image and video analysis, NLP (Natural Language Processing) handles human language, and inference is the process of making predictions with a trained model.',
    NOW(),
    'quiz_domain5_1',
    NOW(),
    10,
    '{"left": ["Computer vision", "NLP", "Inference"], "right": ["Making a trained model predict", "Understanding images & video", "Processing human language"]}'::json,
    '{"left": [0, 1, 2], "right": [1, 2, 0]}'::json,
    'm_5_1'
);

-- =====================================================
-- EXAMPLE 2: AWS Services Matching Question  
-- =====================================================

-- Insert a matching question for AWS services
INSERT INTO public.question (
    id, 
    text, 
    type, 
    options, 
    correct_answer, 
    explanation, 
    created_at, 
    quiz_id, 
    modified_at, 
    index, 
    pairs, 
    matches, 
    module_id
) VALUES (
    'q_domain1_2_m_1_2_15',
    'Match each AWS service to its primary use case.',
    'matching',
    '{"A": "Amazon S3", "B": "Amazon RDS", "C": "Amazon Lambda", "D": "Amazon CloudFront"}'::json,
    NULL,
    'S3 is for object storage, RDS manages relational databases, Lambda runs serverless functions, and CloudFront is a content delivery network.',
    NOW(),
    'quiz_domain1_2',
    NOW(),
    15,
    '{"left": ["Amazon S3", "Amazon RDS", "Amazon Lambda", "Amazon CloudFront"], "right": ["Content delivery and caching", "Object storage and backup", "Serverless computing", "Managed relational databases"]}'::json,
    '{"left": [0, 1, 2, 3], "right": [1, 3, 2, 0]}'::json,
    'm_1_2'
);

-- =====================================================
-- EXAMPLE 3: Architecture Patterns Matching Question
-- =====================================================

-- Insert a matching question for architecture patterns  
INSERT INTO public.question (
    id, 
    text, 
    type, 
    options, 
    correct_answer, 
    explanation, 
    created_at, 
    quiz_id, 
    modified_at, 
    index, 
    pairs, 
    matches, 
    module_id
) VALUES (
    'q_domain2_3_m_2_3_8',
    'Match each architecture pattern to its main benefit.',
    'matching',
    '{"A": "Microservices", "B": "Event-driven", "C": "Serverless"}'::json,
    NULL,
    'Microservices provide independent scaling, event-driven architecture enables loose coupling, and serverless eliminates infrastructure management.',
    NOW(),
    'quiz_domain2_3',
    NOW(),
    8,
    '{"left": ["Microservices", "Event-driven", "Serverless"], "right": ["No infrastructure management", "Independent service scaling", "Loose coupling between components"]}'::json,
    '{"left": [0, 1, 2], "right": [1, 2, 0]}'::json,
    'm_2_3'
);

-- Link questions to their respective quizzes
INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES
    (NOW(), 'quiz_domain5_1', 'q_domain5_1_m_5_1_10'),
    (NOW(), 'quiz_domain1_2', 'q_domain1_2_m_1_2_15'),
    (NOW(), 'quiz_domain2_3', 'q_domain2_3_m_2_3_8')
ON CONFLICT DO NOTHING;

COMMIT;

-- =====================================================
-- HOW TO INTERPRET THE MATCHES
-- =====================================================

-- For Example 1 (AI/ML):
-- pairs.left  = ["Computer vision", "NLP", "Inference"]           (indices: 0, 1, 2)
-- pairs.right = ["Making predictions", "Understanding images", "Processing language"] (indices: 0, 1, 2)
-- matches.left  = [0, 1, 2] (all left items)
-- matches.right = [1, 2, 0] (corresponding right indices)

-- This means:
-- Computer vision (left[0]) → Understanding images (right[1])
-- NLP (left[1]) → Processing language (right[2])
-- Inference (left[2]) → Making predictions (right[0])

-- For Example 2 (AWS Services):
-- pairs.left  = ["Amazon S3", "Amazon RDS", "Amazon Lambda", "Amazon CloudFront"]
-- pairs.right = ["Content delivery", "Object storage", "Serverless computing", "Managed databases"]
-- matches.left  = [0, 1, 2, 3]
-- matches.right = [1, 3, 2, 0]

-- This means:
-- Amazon S3 (left[0]) → Object storage (right[1])
-- Amazon RDS (left[1]) → Managed databases (right[3])
-- Amazon Lambda (left[2]) → Serverless computing (right[2])
-- Amazon CloudFront (left[3]) → Content delivery (right[0])

-- =====================================================
-- COMPARISON WITH OTHER QUESTION TYPES
-- =====================================================

-- MCQ Example:
-- INSERT INTO question VALUES (
--     'q_mcq_example', 
--     'Which AWS service is best for object storage?',
--     'mcq',
--     '["Amazon S3", "Amazon RDS", "Amazon EC2", "Amazon Lambda"]'::json,
--     '{0}',  -- Answer is index 0 (Amazon S3)
--     '...',
--     ...
-- );

-- Multiple Select Example:
-- INSERT INTO question VALUES (
--     'q_multi_example',
--     'Which AWS services can store data? (Select 2)',
--     'multiple',
--     '["Amazon S3", "Amazon RDS", "Amazon Lambda", "Amazon CloudFront"]'::json,
--     '{0,1}',  -- Answers are indices 0,1 (S3, RDS)
--     '...',
--     ...
-- );

-- Ordering Example:  
-- INSERT INTO question VALUES (
--     'q_order_example',
--     'Order these deployment steps:',
--     'ordering',
--     '["Test", "Deploy", "Build", "Plan"]'::json,
--     '{3,2,0,1}',  -- Correct order: Plan, Build, Test, Deploy
--     '...',
--     ...
-- );

-- Matching Example (Current Implementation):
-- INSERT INTO question VALUES (
--     'q_match_example',
--     'Match services to use cases:',
--     'matching', 
--     '{"A": "S3", "B": "RDS", "C": "Lambda"}'::json,
--     NULL,  -- Always NULL for matching
--     '...',
--     NOW(), 'quiz_id', NOW(), 1,
--     '{"left": ["S3", "RDS", "Lambda"], "right": ["Database", "Storage", "Compute"]}'::json,
--     '{"left": [0, 1, 2], "right": [1, 0, 2]}'::json,  -- S3→Storage, RDS→Database, Lambda→Compute
--     'module_id'
-- );

-- =====================================================
-- SYSTEM IMPLEMENTATION NOTES
-- =====================================================

-- 1. The 'options' field for matching questions contains a JSON object (not array)
--    This is for display purposes in the UI - shows the left items with labels A, B, C, etc.

-- 2. The 'pairs' field contains the actual matching data:
--    - 'left': Array of terms/concepts to be matched
--    - 'right': Array of definitions/descriptions (can be in different order)

-- 3. The 'matches' field contains the solution:
--    - 'left': [0,1,2,...] (always in sequential order for left items)
--    - 'right': [x,y,z,...] (indices pointing to correct right items)

-- 4. The 'correct_answer' field is always NULL for matching questions
--    The answer is stored in the 'matches' field instead

-- 5. AI Generation creates questions with this structure automatically
--    The system handles conversion from AI response to proper database format

-- 6. Validation system can verify matching correctness and suggest corrections
--    Validator returns matching format: {"left": [0,1,2], "right": [1,0,2]}

-- =====================================================
-- FRONTEND DISPLAY LOGIC  
-- =====================================================

-- When displaying matching questions in the UI:
-- 1. Show left items as a numbered list: 1. Term1, 2. Term2, 3. Term3
-- 2. Show right items as lettered options: A. Desc1, B. Desc2, C. Desc3  
-- 3. Allow user to drag/click to match left items with right options
-- 4. Store user answer as matching format similar to 'matches' field
-- 5. Compare user answer with 'matches' field to determine correctness

-- This implementation provides full support for matching questions
-- alongside existing MCQ, Multiple Select, and Ordering question types.

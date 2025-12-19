-- =====================================================
-- MATCHING QUESTIONS IMPLEMENTATION EXAMPLE
-- =====================================================
-- This file demonstrates how matching questions are integrated 
-- into the question generation system and SQL database

-- =====================================================
-- DATABASE STRUCTURE FOR MATCHING QUESTIONS
-- =====================================================

-- Sample matching question SQL insert:
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
    NULL,  -- For matching questions, correct_answer is always NULL
    'Computer vision deals with image and video analysis, NLP (Natural Language Processing) handles human language, and inference is the process of making predictions with a trained model.',
    NOW(),
    'quiz_domain5_1',
    NOW(),
    10,
    '{"left": ["Computer vision", "NLP", "Inference"], "right": ["Making a trained model predict", "Understanding images & video", "Processing human language"]}'::json,
    '{"left": [0, 1, 2], "right": [1, 2, 0]}'::json,  -- left[0] matches right[1], left[1] matches right[2], left[2] matches right[0]
    'm_5_1'
);

-- =====================================================
-- UNDERSTANDING THE MATCHING LOGIC
-- =====================================================

-- In the example above:
-- pairs.left  = ["Computer vision", "NLP", "Inference"]       (indices: 0, 1, 2)
-- pairs.right = ["Making predictions", "Understanding images", "Processing language"] (indices: 0, 1, 2)

-- matches.left  = [0, 1, 2]  (all left items in order)
-- matches.right = [1, 2, 0]  (corresponding right item indices)

-- This means:
-- - Computer vision (left[0]) matches with "Understanding images" (right[1])
-- - NLP (left[1]) matches with "Processing language" (right[2]) 
-- - Inference (left[2]) matches with "Making predictions" (right[0])

-- =====================================================
-- GENERATED QUESTION STRUCTURE FOR API
-- =====================================================

-- When the API generates a matching question, it creates this structure:
{
  "module_id": "m_5_1",
  "question_number": 1,
  "text": "Match each AI/ML concept to its primary application.",
  "options": {
    "A": "Deep Learning",
    "B": "Computer Vision", 
    "C": "Natural Language Processing"
  },
  "pairs": {
    "left": ["Deep Learning", "Computer Vision", "Natural Language Processing"],
    "right": ["Text analysis and chatbots", "Neural networks with multiple layers", "Image recognition and analysis"]
  },
  "matches": {
    "left": [0, 1, 2],
    "right": [1, 2, 0]
  },
  "correct_answer": null,
  "explanation": "Deep Learning uses neural networks with multiple layers, Computer Vision handles image recognition and analysis, and NLP focuses on text analysis and chatbots."
}

-- =====================================================
-- QUESTION TYPE COMPARISON
-- =====================================================

-- MCQ (Multiple Choice):
-- - options: ["Option A", "Option B", "Option C", "Option D"]
-- - correct_answer: "{1}" (string format)
-- - pairs: NULL
-- - matches: NULL

-- Multiple Select:
-- - options: ["Option A", "Option B", "Option C", "Option D"] 
-- - correct_answer: "{0,2}" (PostgreSQL array format)
-- - pairs: NULL
-- - matches: NULL

-- Ordering:
-- - options: ["Step 1", "Step 2", "Step 3", "Step 4"]
-- - correct_answer: "{0,1,2,3}" (PostgreSQL array format showing correct order)
-- - pairs: NULL
-- - matches: NULL

-- Matching:
-- - options: {"A": "Term1", "B": "Term2", "C": "Term3"}
-- - correct_answer: NULL
-- - pairs: {"left": ["Term1", "Term2", "Term3"], "right": ["Desc1", "Desc2", "Desc3"]}
-- - matches: {"left": [0,1,2], "right": [2,0,1]} (showing which left matches which right)

-- =====================================================
-- IMPLEMENTATION NOTES
-- =====================================================

-- 1. Matching questions use the 'pairs' field to store the items to be matched
-- 2. The 'matches' field stores the correct relationships between left and right items
-- 3. The 'options' field for matching questions is an object (not array) for display purposes
-- 4. correct_answer is always NULL for matching questions since matches field contains the answer
-- 5. The system automatically handles PostgreSQL JSON formatting in SQL generation
-- 6. Validation logic needs to check matches object instead of correct_answer for matching questions

-- =====================================================
-- AI PROMPT GENERATION FOR MATCHING QUESTIONS
-- =====================================================

-- The system uses specialized question types for matching:
-- - 'term-definition': Match terms with their definitions
-- - 'service-feature': Match services with their key features  
-- - 'concept-application': Match concepts with real-world applications
-- - 'tool-purpose': Match tools with their primary purposes
-- - 'architecture-component': Match architecture patterns with components
-- - 'protocol-function': Match protocols with their functions
-- - 'technology-benefit': Match technologies with their benefits
-- - 'role-responsibility': Match roles with their responsibilities
-- - 'metric-measurement': Match metrics with what they measure
-- - 'pattern-use-case': Match patterns with appropriate use cases

-- This ensures variety in matching question styles while maintaining educational value.

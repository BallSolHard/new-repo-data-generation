-- Example of how ordering questions work in the system

-- 1. For Hub Questions (table: question)
-- The ordering question format with proper JSON structure:

INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)
VALUES (
  '1.1-M09',
  'Order the basic steps of mini-batch gradient descent.',
  'ordering',
  '["Forward propagate batch","Compute batch loss","Back-propagate gradients","Update weights"]'::json,
  '[0,1,2,3]',
  'Mini-batch gradient descent follows these steps: forward propagation → loss computation → backpropagation → weight updates.',
  '2025-07-22 01:40:35.826344',
  'quiz_domain5_1',
  '2025-07-22 01:40:35.826344',
  29,
  NULL,
  NULL,
  'm_5_1'
);

-- 2. For Mock Test Questions (table: mock_test_questions) 
-- The ordering question format for mock tests:

INSERT INTO public.mock_test_questions (mock_test_id, question_text, question_type, options, correct_answer, explanation, question_order, module_id, topic_id)
VALUES (
  'aws_ml_specialty_practice_1',
  'Order the steps for deploying a machine learning model to Amazon SageMaker.',
  'ordering',
  '["Create model artifact","Create SageMaker model","Create endpoint configuration","Deploy endpoint"]'::jsonb,
  '{0,1,2,3}',
  'SageMaker deployment follows these sequential steps: prepare model artifact → register model → configure endpoint → deploy for inference.',
  1,
  'm_ml_1',
  42
);

-- 3. Example AWS GenAI Ordering Question:

INSERT INTO public.mock_test_questions (mock_test_id, question_text, question_type, options, correct_answer, explanation, question_order, module_id, topic_id)  
VALUES (
  'aws_genai_pro_test_1',
  'Order the steps to implement a RAG (Retrieval Augmented Generation) system using Amazon Bedrock.',
  'ordering', 
  '["Prepare knowledge base documents","Create vector embeddings","Store embeddings in vector database","Configure retrieval mechanism","Connect to Foundation Model"]'::jsonb,
  '{0,1,2,3,4}',
  'RAG implementation follows this sequence: prepare documents → generate embeddings → store in vector DB → set up retrieval → integrate with FM for generation.',
  1,
  'm_64_4', 
  64
);

/*
Key Points for Ordering Questions:

1. Question Structure:
   - text: Must include "Order the..." or similar phrasing
   - type: Set to 'ordering'
   - options: Array of steps/items to be ordered (JSON format)
   - correct_answer: 
     * For hub questions: JSON string like '[0,1,2,3]'  
     * For mock questions: PostgreSQL array like '{0,1,2,3}'

2. Answer Format:
   - Always starts from index 0
   - Represents the correct sequence order
   - For 4 options: [0,1,2,3] means option 1 → option 2 → option 3 → option 4
   - For 5 options: [0,1,2,3,4] means all options in given order

3. Content Guidelines:
   - Options should be clear, distinct steps or phases
   - Each option should represent one logical step
   - Options should have a clear sequential relationship
   - Avoid ambiguous or parallel steps that could have multiple valid orders

4. Examples of Good Ordering Topics:
   - Deployment workflows
   - Development lifecycle phases  
   - Troubleshooting procedures
   - Data processing pipelines
   - Security implementation steps
   - Migration processes
   - Configuration sequences
   - Algorithm steps (like ML training)

5. Question Generation:
   - System will generate options that need to be arranged in proper sequence
   - The AI will create logical, sequential steps for the given topic
   - Correct answer is always the natural order [0,1,2,3...] 
   - Questions focus on understanding proper workflows and procedures
*/

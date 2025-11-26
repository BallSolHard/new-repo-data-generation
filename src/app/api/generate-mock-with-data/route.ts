import { NextRequest, NextResponse } from 'next/server';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { createClient } from '@supabase/supabase-js';
import { createValidationPrompt, createQuestionGenerationPrompt } from '../generate-hub/prompts';
import type { GeneratedQuestion, QuestionGenerationParams } from '../generate-hub/types';

// Type definitions
interface DomainData {
  topic_id: number;
  topic_name: string;
  topic_description?: string;
}

interface ModuleData {
  module_id: string;
  module_name: string;
  module_description?: string;
}

// Helper function to parse correct_answer to integer array
function parseCorrectAnswer(correctAnswer: any): number[] {
  // Log the input for debugging
  console.log('Parsing correct_answer:', typeof correctAnswer, correctAnswer);
  
  if (Array.isArray(correctAnswer)) {
    return correctAnswer.map(n => typeof n === 'number' ? n : parseInt(n)).filter(n => !isNaN(n));
  }
  
  if (typeof correctAnswer === 'string') {
    const trimmed = correctAnswer.trim();
    
    // If it looks like JSON array, try to parse it
    if (trimmed.startsWith('[') && trimmed.endsWith(']')) {
      try {
        const parsed = JSON.parse(trimmed);
        return Array.isArray(parsed) ? parsed.map(n => parseInt(n)).filter(n => !isNaN(n)) : [parseInt(parsed)].filter(n => !isNaN(n));
      } catch (error) {
        console.log('JSON parse failed for:', trimmed, 'Error:', error);
        // If JSON parsing fails, extract numbers from the string
        const numbers = trimmed.match(/\d+/g);
        return numbers ? numbers.map(n => parseInt(n)) : [0];
      }
    }
    
    // If it looks like {number}, extract the number
    if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
      const numbers = trimmed.slice(1, -1).split(',').map(n => parseInt(n.trim())).filter(n => !isNaN(n));
      return numbers.length > 0 ? numbers : [0];
    }
    
    // Try to parse as a single number
    const num = parseInt(trimmed);
    return !isNaN(num) ? [num] : [0];
  }
  
  // If it's a number, wrap it in an array
  if (typeof correctAnswer === 'number') {
    return [correctAnswer];
  }
  
  // Default fallback
  console.log('Using fallback [0] for correct_answer:', correctAnswer);
  return [0];
}

// Initialize Gemini client
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');
const model = genAI.getGenerativeModel({ 
  model: "gemini-2.5-flash" // Using Gemini 2.5 Flash to match generate-mock
});

// Initialize Supabase clients for both environments
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL || '',
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || ''
);

const supabase_preprod = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL_PREPROD || '',
  process.env.SUPABASE_SERVICE_ROLE_KEY_PREPROD || ''
);

// Helper function to verify and create mock test in both environments
async function ensureMockTestExists(
  mockTestId: string, 
  certificationId: number, 
  certificationName: string
): Promise<{ success: boolean; wasCreated: boolean; error?: string }> {
  const defaultTitle = `${certificationName} - Data Mode Practice Test`;
  const defaultDescription = `Mock test generated from input text data for ${certificationName} certification`;
  
  const mockTestData = {
    id: mockTestId,
    certification_id: certificationId,
    title: defaultTitle,
    description: defaultDescription,
    duration: 120, // 2 hours default
    total_questions: 0, // Will be updated after inserting questions
    passing_score: 70,
    validity_months: 12,
    recommended_experience_text: "Practice test based on provided text content",
    exam_format: ["mcq", "multiple"],
    created_at: new Date().toISOString()
  };

  let wasCreated = false;
  
  // Check and create in production environment
  try {
    const { data: prodMockTest, error: prodError } = await supabase
      .from('mock_tests')
      .select('id, title, certification_id')
      .eq('id', mockTestId)
      .maybeSingle();

    if (prodError) {
      console.error('Error checking production mock test:', prodError);
      return { success: false, wasCreated: false, error: `Production error: ${prodError.message}` };
    }

    if (!prodMockTest) {
      console.log(`Creating mock test in production: ${mockTestId}`);
      const { data: newProdMockTest, error: createProdError } = await supabase
        .from('mock_tests')
        .insert(mockTestData)
        .select()
        .single();

      if (createProdError) {
        console.error('Error creating production mock test:', createProdError);
        return { success: false, wasCreated: false, error: `Failed to create in production: ${createProdError.message}` };
      }
      wasCreated = true;
    } else {
      // Verify certification ID matches
      if (prodMockTest.certification_id !== certificationId) {
        return { 
          success: false, 
          wasCreated: false, 
          error: `Mock test '${mockTestId}' belongs to certification ID ${prodMockTest.certification_id}, but you're trying to add questions for certification ID ${certificationId}.` 
        };
      }
    }
  } catch (error) {
    console.error('Error with production mock test operations:', error);
    return { success: false, wasCreated: false, error: `Production error: ${error instanceof Error ? error.message : 'Unknown error'}` };
  }

  // Check and create in preprod environment
  try {
    const { data: preprodMockTest, error: preprodError } = await supabase_preprod
      .from('mock_tests')
      .select('id, title, certification_id')
      .eq('id', mockTestId)
      .maybeSingle();

    if (preprodError) {
      console.error('Error checking preprod mock test:', preprodError);
      return { success: false, wasCreated, error: `Preprod error: ${preprodError.message}` };
    }

    if (!preprodMockTest) {
      console.log(`Creating mock test in preprod: ${mockTestId}`);
      const { data: newPreprodMockTest, error: createPreprodError } = await supabase_preprod
        .from('mock_tests')
        .insert(mockTestData)
        .select()
        .single();

      if (createPreprodError) {
        console.error('Error creating preprod mock test:', createPreprodError);
        return { success: false, wasCreated, error: `Failed to create in preprod: ${createPreprodError.message}` };
      }
      wasCreated = true;
    } else {
      // Verify certification ID matches
      if (preprodMockTest.certification_id !== certificationId) {
        return { 
          success: false, 
          wasCreated, 
          error: `Preprod mock test '${mockTestId}' belongs to certification ID ${preprodMockTest.certification_id}, but you're trying to add questions for certification ID ${certificationId}.` 
        };
      }
    }
  } catch (error) {
    console.error('Error with preprod mock test operations:', error);
    return { success: false, wasCreated, error: `Preprod error: ${error instanceof Error ? error.message : 'Unknown error'}` };
  }

  return { success: true, wasCreated };
}

export async function POST(request: NextRequest) {
  try {
    // Validate environment variables
    if (!process.env.GEMINI_API_KEY) {
      return NextResponse.json(
        { error: 'Gemini API key not configured' },
        { status: 500 }
      );
    }

    if (!process.env.NEXT_PUBLIC_SUPABASE_URL || !process.env.NEXT_PUBLIC_SUPABASE_URL_PREPROD) {
      return NextResponse.json(
        { error: 'Supabase URLs not configured for both environments' },
        { status: 500 }
      );
    }

    const {
      certification_id,
      certification_name,
      input_text,
      questionsPerModule,
      questionType,
      domains,
      modules,
      mock_test_id
    }: {
      certification_id: number;
      certification_name: string;
      input_text: string;
      questionsPerModule: number;
      questionType: string;
      domains: DomainData[];
      modules: ModuleData[];
      mock_test_id?: string;
    } = await request.json();

    console.log('Generate Mock with Data Request:', {
      certification_id,
      certification_name,
      input_text_length: input_text?.length,
      questionType,
      domains_count: domains?.length,
      modules_count: modules?.length,
      generation_mode: 'content_based'
    });

    console.log(`Preparing SQL script for mock test with data: ${certification_name}`);

    // Validate required fields
    if (!certification_id || !certification_name || !input_text || !mock_test_id) {
      return NextResponse.json(
        { error: 'Missing required fields: certification_id, certification_name, input_text, mock_test_id' },
        { status: 400 }
      );
    }

    if (input_text.trim().length < 100) {
      return NextResponse.json(
        { error: 'Input text must be at least 100 characters long' },
        { status: 400 }
      );
    }

    if (!domains || domains.length === 0) {
      return NextResponse.json(
        { error: 'No domains provided for this certification' },
        { status: 400 }
      );
    }

    if (!modules || modules.length === 0) {
      return NextResponse.json(
        { error: 'No modules found for this certification' },
        { status: 400 }
      );
    }

    // Use the selected mock test ID
    const mockTestId = mock_test_id;

    // First, verify that the mock test exists in both environments, create if it doesn't exist
    console.log(`Verifying mock test exists in both environments: ${mockTestId}`);
    
    const mockTestResult = await ensureMockTestExists(mockTestId, certification_id, certification_name);
    
    if (!mockTestResult.success) {
      return NextResponse.json(
        { 
          error: `Failed to ensure mock test exists: ${mockTestResult.error}`,
          details: 'Mock test verification/creation failed'
        },
        { status: 500 }
      );
    }
    
    const mockTestWasCreated = mockTestResult.wasCreated;
    console.log(mockTestWasCreated ? 
      `Successfully created mock test in both environments: ${mockTestId}` : 
      `Mock test already exists in both environments: ${mockTestId}`
    );

    // Get the current maximum question_order for this mock test to continue the sequence
    console.log(`Checking existing questions for mock test: ${mockTestId}`);
    let startingQuestionOrder = 1; // Default to 1 if no existing questions
    
    try {
      const { data: existingQuestions, error: queryError } = await supabase
        .from('mock_test_questions')
        .select('question_order')
        .eq('mock_test_id', mockTestId)
        .order('question_order', { ascending: false })
        .limit(1);

      if (queryError) {
        console.error('Error querying existing questions:', queryError);
        // Continue with default starting order if query fails
      } else if (existingQuestions && existingQuestions.length > 0) {
        startingQuestionOrder = existingQuestions[0].question_order + 1;
        console.log(`Found existing questions. Max question_order: ${existingQuestions[0].question_order}. Starting new questions at order: ${startingQuestionOrder}`);
      } else {
        console.log('No existing questions found. Starting at order: 1');
      }
    } catch (error) {
      console.error('Error checking existing questions:', error);
      // Continue with default starting order if there's an error
    }

    // Analyze the input text to detect questions
    console.log('Analyzing input text for question patterns...');
    const questionIndicators = [
      /^\d+[\.\)]\s/gm, // Numbered questions like "1. " or "1) "
      /^Question\s*\d+/gmi, // "Question 1", "Question 2", etc.
      /^\w[\.\)]\s/gm, // Letter-based questions like "a. " or "A) "
      /\?\s*\n/g, // Question marks followed by newlines
      /^[A-Z][\.\)]\s/gm // Options like "A. " or "A) "
    ];
    
    const questionMatches = questionIndicators.map(regex => (input_text.match(regex) || []).length);
    const estimatedQuestions = Math.max(...questionMatches, 1);
    console.log(`Estimated ${estimatedQuestions} questions in input text based on patterns`);

    // Determine certification level based on certification name
    const certificationLower = certification_name.toLowerCase();
    const isFoundational = certificationLower.includes('foundational') || certificationLower.includes('foundation') || certificationLower.includes('basics') || certificationLower.includes('fundamentals');
    const isAssociate = certificationLower.includes('associate') || certificationLower.includes('intermediate');
    const isProfessional = certificationLower.includes('professional') || certificationLower.includes('expert') || certificationLower.includes('advanced');
    const isSpecialty = certificationLower.includes('specialty') || certificationLower.includes('speciality') || certificationLower.includes('specialist');

    // Determine complexity level and question characteristics
    let complexityLevel, questionCharacteristics, difficultyGuidance;
    
    if (isProfessional || isSpecialty) {
      complexityLevel = 'advanced';
      questionCharacteristics = `
- Generate LENGTHY, DETAILED questions with multiple paragraphs when needed
- Include complex scenario-based questions with detailed context
- Create questions that require deep understanding and critical thinking
- Use technical terminology and advanced concepts extensively
- Questions should often include 3-4 sentence scenarios or case studies
- Focus on practical application, troubleshooting, and optimization
- Include questions about best practices, trade-offs, and complex decision-making`;
      difficultyGuidance = 'advanced - Focus on complex scenarios, detailed technical knowledge, and practical application';
    } else if (isAssociate) {
      complexityLevel = 'intermediate';
      questionCharacteristics = `
- Generate MODERATE-LENGTH questions with clear context
- Include scenario-based questions with practical examples
- Balance between conceptual understanding and practical application
- Use standard technical terminology with some advanced concepts
- Questions should be 1-2 sentences with additional context when needed
- Focus on implementation, configuration, and common use cases`;
      difficultyGuidance = 'intermediate - Focus on practical implementation and standard use cases';
    } else {
      complexityLevel = 'basic';
      questionCharacteristics = `
- Generate CLEAR, CONCISE questions focusing on fundamental concepts
- Include straightforward questions about basic principles and definitions
- Use simple, direct language with minimal technical jargon
- Questions should be brief and focused on core knowledge
- Focus on understanding basic concepts, terminology, and simple procedures`;
      difficultyGuidance = 'basic - Focus on fundamental concepts and basic understanding';
    }

    // Create prompt for parsing and extracting pre-formatted questions from input text
    const prompt = `
You are an expert question parser for certification exams. The input text contains pre-formatted questions with options and explanations. Your task is to carefully analyze and extract ALL questions present in the text.

INPUT TEXT WITH PRE-FORMATTED QUESTIONS:
${input_text}

CERTIFICATION CONTEXT:
- Certification: ${certification_name}
- Certification Level: ${complexityLevel.toUpperCase()}
- Mock Test ID: ${mockTestId}
- Available Domains: ${domains.map(d => `${d.topic_name} (ID: ${d.topic_id})`).join(', ')}
- Available Modules: ${modules.map(m => `${m.module_name} (ID: ${m.module_id})`).join(', ')}

QUESTION COMPLEXITY REQUIREMENTS FOR ${complexityLevel.toUpperCase()} LEVEL:${questionCharacteristics}

ANALYSIS REQUIREMENTS:
1. CAREFULLY scan the entire input text to identify ALL separate questions
2. Look for patterns like:
   - Numbered questions (1., 2., Question 1, etc.)
   - Separate question blocks with their own options
   - Multiple "?" indicating different questions
   - Clear separation between question sets
3. Count questions accurately - if there are multiple questions, extract ALL of them
4. Do NOT generate new questions - only extract what exists in the input
5. Maintain exact original wording for questions, options, and explanations

PARSING INSTRUCTIONS:
- Identify question separators (numbers, labels, blank lines)
- Extract each question's options (A, B, C, D, etc.)
- Find correct answer indicators in each question block
- Map each question to appropriate domain/module based on content
- Preserve all original text exactly as provided
- If you find multiple questions, return ALL of them in the array
- If you find only one question, return just that one

IMPORTANT FOR ${complexityLevel.toUpperCase()} LEVEL QUESTIONS:
${isProfessional || isSpecialty ? `
- Look for LENGTHY, DETAILED questions with multiple sentences or paragraphs
- Identify complex scenario-based questions with detailed context
- Preserve all technical details and lengthy explanations exactly as written
- Maintain complex question structures and comprehensive answer explanations
- Questions may span multiple lines and include detailed case studies` : isAssociate ? `
- Look for MODERATE-LENGTH questions with practical scenarios
- Identify questions with clear context and implementation details
- Preserve technical terminology and practical examples
- Maintain question structure with adequate detail for implementation guidance` : `
- Look for CLEAR, CONCISE questions about fundamental concepts
- Identify straightforward questions with basic definitions and principles
- Preserve simple, direct language and basic terminology
- Maintain clear, focused question structure for foundational understanding`}

OUTPUT FORMAT (CRITICAL - Follow exactly):
{
  "questions": [
    {
      "id": "question_1_${Date.now()}",
      "question_text": "Exact question text from input",
      "options": [
        {"option_id": "A", "option_text": "Exact option A text"},
        {"option_id": "B", "option_text": "Exact option B text"},
        {"option_id": "C", "option_text": "Exact option C text"},
        {"option_id": "D", "option_text": "Exact option D text"}
      ],
      "correct_answers": ["A"], // Array of correct option IDs based on the input
      "explanation": "Exact explanation from input",
      "difficulty": "${complexityLevel}", // ${difficultyGuidance}
      "topic_id": ${domains[0]?.topic_id || 1}, // MUST use one of: ${domains.map(d => d.topic_id).join(', ')}
      "topic_name": "${domains[0]?.topic_name || 'General'}", // MUST match the topic_id
      "module_id": "${modules[0]?.module_id || 'general'}", // MUST use one of: ${modules.map(m => m.module_id).join(', ')}
      "module_name": "${modules[0]?.module_name || 'General'}", // MUST match the module_id
      "question_type": "${questionType}",
      "confidence_score": 1,
      "validation_status": "validated",
      "validation_notes": null
    }
  ]
}

CRITICAL REQUIREMENTS:
- topic_id MUST be one of: ${domains.map(d => d.topic_id).join(', ')}
- module_id MUST be one of: ${modules.map(m => m.module_id).join(', ')}
- Map questions to the most appropriate domain/module based on content analysis
- If uncertain, use the first available domain/module from the lists above

IMPORTANT: Return ALL questions found in the input. If there are 3 questions, return 3. If there is 1 question, return 1. Count carefully and extract completely.
`;

    console.log('Sending parsing request to AI model...');
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const text = response.text();

    console.log('AI parsing response received, length:', text.length);

    // Parse the AI response
    let aiData;
    try {
      // Try to extract JSON from the response
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        aiData = JSON.parse(jsonMatch[0]);
      } else {
        throw new Error('No JSON found in response');
      }
    } catch (parseError) {
      console.error('Error parsing AI response:', parseError);
      console.log('Raw AI response:', text.substring(0, 1000));
      return NextResponse.json(
        { error: 'Failed to parse AI response. Please try again.' },
        { status: 500 }
      );
    }

    if (!aiData.questions || !Array.isArray(aiData.questions)) {
      return NextResponse.json(
        { error: 'Invalid AI response format: missing questions array' },
        { status: 500 }
      );
    }

    console.log(`Successfully parsed ${aiData.questions.length} questions from input text`);
    console.log('Question details:', aiData.questions.map((q: any) => ({
      question_preview: q.question_text?.substring(0, 50) + '...',
      options_count: q.options?.length,
      correct_answers: q.correct_answers,
      difficulty: q.difficulty,
      module_id: q.module_id,
      topic_id: q.topic_id
    })));

    // Validate that the referenced module and topic IDs exist
    const uniqueModuleIds = [...new Set(aiData.questions.map((q: any) => q.module_id).filter(Boolean))];
    const uniqueTopicIds = [...new Set(aiData.questions.map((q: any) => q.topic_id).filter(Boolean))];
    
    console.log('Validating module IDs:', uniqueModuleIds);
    console.log('Validating topic IDs:', uniqueTopicIds);

    // Check if modules exist
    if (uniqueModuleIds.length > 0) {
      try {
        const { data: existingModules, error: modulesError } = await supabase
          .from('modules')
          .select('module_id')
          .in('module_id', uniqueModuleIds);

        if (modulesError) {
          console.error('Error validating modules:', modulesError);
        } else {
          const foundModuleIds = existingModules.map(m => m.module_id);
          const missingModules = uniqueModuleIds.filter(id => !foundModuleIds.includes(id));
          
          if (missingModules.length > 0) {
            console.warn('Missing module IDs:', missingModules);
            console.log('Available modules from request:', modules.map(m => m.module_id));
            
            // Replace missing modules with available ones from the request
            aiData.questions.forEach((question: any) => {
              if (missingModules.includes(question.module_id) && modules.length > 0) {
                const fallbackModule = modules[0]; // Use first available module
                console.log(`Replacing missing module ${question.module_id} with ${fallbackModule.module_id}`);
                question.module_id = fallbackModule.module_id;
              }
            });
          }
        }
      } catch (error) {
        console.error('Error checking module existence:', error);
      }
    }

    // Check if topics exist
    if (uniqueTopicIds.length > 0) {
      try {
        const { data: existingTopics, error: topicsError } = await supabase
          .from('topics')
          .select('topic_id')
          .in('topic_id', uniqueTopicIds);

        if (topicsError) {
          console.error('Error validating topics:', topicsError);
        } else {
          const foundTopicIds = existingTopics.map(t => t.topic_id);
          const missingTopics = uniqueTopicIds.filter(id => !foundTopicIds.includes(id));
          
          if (missingTopics.length > 0) {
            console.warn('Missing topic IDs:', missingTopics);
            console.log('Available topics from request:', domains.map(d => d.topic_id));
            
            // Replace missing topics with available ones from the request
            aiData.questions.forEach((question: any) => {
              if (missingTopics.includes(question.topic_id) && domains.length > 0) {
                const fallbackTopic = domains[0]; // Use first available topic
                console.log(`Replacing missing topic ${question.topic_id} with ${fallbackTopic.topic_id}`);
                question.topic_id = fallbackTopic.topic_id;
              }
            });
          }
        }
      } catch (error) {
        console.error('Error checking topic existence:', error);
      }
    }

    // Generate SQL script for mock test questions
    let sqlScript = `-- Generated Mock Test Questions with Data for ${certification_name}\n`;
    sqlScript += `-- Mock Test ID: ${mockTestId}\n`;
    sqlScript += `-- Generated on: ${new Date().toISOString()}\n`;
    sqlScript += `-- Questions: ${aiData.questions.length}\n`;
    sqlScript += `-- Question Order: ${startingQuestionOrder} to ${startingQuestionOrder + aiData.questions.length - 1}\n`;
    sqlScript += `-- Input Text Length: ${input_text.length} characters\n`;
    sqlScript += `-- Mock test status: ${mockTestWasCreated ? 'New mock test created' : 'Existing mock test found'}\n`;
    sqlScript += `-- Note: Mock test verified/created in database\n\n`;

    // Start transaction
    sqlScript += `BEGIN;\n\n`;

    // Note: Mock test creation is handled separately in the API, SQL only contains question inserts
    sqlScript += `-- Mock test: ${mockTestId}\n`;
    sqlScript += `-- Questions will be added to the mock test\n\n`;

    // Insert questions for mock_test_questions table
    sqlScript += `-- Insert Mock Test Questions (starting from question order ${startingQuestionOrder})\n`;
    aiData.questions.forEach((question: any, index: number) => {
      const escapedText = question.question_text.replace(/'/g, "''");
      const escapedExplanation = question.explanation.replace(/'/g, "''");
      
      // Convert options to the format used in mock_test_questions table
      const optionsArray = question.options.map((opt: any) => opt.option_text);
      
      // Convert correct_answers array to the integer array format expected by mock_test_questions
      const correctAnswerIndices = question.correct_answers.map((answer: string) => {
        // Map A, B, C, D to 0, 1, 2, 3
        const optionMap: { [key: string]: number } = { 'A': 0, 'B': 1, 'C': 2, 'D': 3, 'E': 4, 'F': 5 };
        return optionMap[answer] !== undefined ? optionMap[answer] : 0;
      });
      
      // Use proper question order sequence continuing from existing questions
      const questionOrder = startingQuestionOrder + index;
      const topicIdValue = question.topic_id && !isNaN(question.topic_id) ? question.topic_id : 'NULL';
      
      sqlScript += `INSERT INTO public.mock_test_questions (mock_test_id, question_text, question_type, options, correct_answer, explanation, question_order, module_id, topic_id)\n`;
      sqlScript += `VALUES ('${mockTestId}', '${escapedText}', '${question.question_type}', '${JSON.stringify(optionsArray)}'::jsonb, '{${correctAnswerIndices.join(',')}}', '${escapedExplanation}', ${questionOrder}, '${question.module_id}', ${topicIdValue});\n\n`;
    });

    // Update the total_questions count in mock_tests based on actual inserted questions
    sqlScript += `-- Update total_questions count in mock_tests based on actual questions inserted\n`;
    sqlScript += `UPDATE public.mock_tests \n`;
    sqlScript += `SET total_questions = (\n`;
    sqlScript += `    SELECT COUNT(*) \n`;
    sqlScript += `    FROM public.mock_test_questions \n`;
    sqlScript += `    WHERE mock_test_id = '${mockTestId}'\n`;
    sqlScript += `)\n`;
    sqlScript += `WHERE id = '${mockTestId}';\n\n`;

    // End transaction
    sqlScript += `COMMIT;\n\n`;
    sqlScript += `-- Summary: ${aiData.questions.length} questions generated from input text for ${certification_name}`;

    const fullScript = sqlScript;

    // Calculate validation statistics
    const validationStats = aiData.questions.reduce((stats: Record<string, number>, question: any) => {
      const status = question.validation_status || 'validated';
      stats[status] = (stats[status] || 0) + 1;
      return stats;
    }, {});

    const validationStatus = aiData.questions.every((q: any) => q.confidence_score === 1) ? 'all_validated' : 'partial_validation';

    // Return the generated data matching generate-mock format
    return NextResponse.json({
      success: true,
      message: `Successfully parsed ${aiData.questions.length} question${aiData.questions.length !== 1 ? 's' : ''} from input text and generated SQL for mock test: ${mockTestId} (questions ${startingQuestionOrder}-${startingQuestionOrder + aiData.questions.length - 1}). ${mockTestWasCreated ? 'Created new mock test in both environments.' : 'Used existing mock test from both environments.'}`,
      mockTestId,
      startingQuestionOrder,
      script: fullScript,
      validationStatus,
      validationStats,
      summary: {
        certification_id,
        certification_name,
        mock_test_id: mockTestId,
        mock_test_created: mockTestWasCreated,
        total_questions: aiData.questions.length,
        starting_question_order: startingQuestionOrder,
        ending_question_order: startingQuestionOrder + aiData.questions.length - 1,
        generation_method: 'input_text_parsing',
        input_text_length: input_text.length,
        questions_detected: aiData.questions.length,
        domains_covered: [...new Set(aiData.questions.map((q: any) => q.topic_name))],
        modules_covered: [...new Set(aiData.questions.map((q: any) => q.module_id))].length,
        topics_covered: [...new Set(aiData.questions.map((q: any) => q.topic_id))].length,
        difficulty_distribution: {
          basic: aiData.questions.filter((q: any) => q.difficulty === 'basic').length,
          intermediate: aiData.questions.filter((q: any) => q.difficulty === 'intermediate').length,
          advanced: aiData.questions.filter((q: any) => q.difficulty === 'advanced').length
        }
      },
      questions: aiData.questions.map((question: any, index: number) => ({
        mock_test_id: mockTestId,
        question_text: question.question_text,
        options: question.options.map((opt: any) => opt.option_text),
        correct_answer: parseCorrectAnswer(question.correct_answers.map((answer: string) => {
          // Map A, B, C, D to 0, 1, 2, 3
          const optionMap: { [key: string]: number } = { 'A': 0, 'B': 1, 'C': 2, 'D': 3, 'E': 4, 'F': 5 };
          return optionMap[answer] !== undefined ? optionMap[answer] : 0;
        })),
        explanation: question.explanation,
        confidence_score: question.confidence_score || 1,
        validation_status: question.validation_status || 'validated',
        validation_notes: question.validation_notes || null,
        module_id: question.module_id,
        question_order: startingQuestionOrder + index,
        topic_id: question.topic_id ? parseInt(question.topic_id) : null
      }))
    });

  } catch (error) {
    console.error('Error generating mock test with data:', error);
    return NextResponse.json(
      { error: 'Failed to generate mock test with data' },
      { status: 500 }
    );
  }
}

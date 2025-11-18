import { NextRequest, NextResponse } from 'next/server';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { createClient } from '@supabase/supabase-js';
import { createValidationPrompt, createQuestionGenerationPrompt } from '../generate-hub/prompts';
import type { GeneratedQuestion, QuestionGenerationParams } from '../generate-hub/types';

// Initialize Gemini client
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');
const model = genAI.getGenerativeModel({ 
  model: "gemini-2.0-flash" // Using Gemini 2.5 Flash
});

// Initialize Supabase client
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL || '',
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || ''
);

// Interface for mock test generation parameters
interface MockTestParams {
  certification_id: number;
  certification_name: string;
  mock_test_id?: string;
  title: string;
  description?: string;
  duration: number; // in minutes
  total_questions: number;
  passing_score: number;
  validity_months?: number;
  recommended_experience_text?: string;
  exam_format?: string[];
  questionType?: string; // "mcq" or "multiple"
  enableValidation?: boolean;
  topic_id?: number;
  topic_name?: string;
  topic_description?: string;
  questionsPerModule?: number;
  modules?: any[];
}

// Function to get topics and modules for a certification
async function getCertificationContent(certificationId: number) {
  try {
    // Get topics for the certification
    const { data: topics, error: topicsError } = await supabase
      .from('topics')
      .select(`
        topic_id,
        topic_name,
        topic_description
      `)
      .eq('certification_id', certificationId);

    if (topicsError) {
      throw topicsError;
    }

    if (!topics || topics.length === 0) {
      throw new Error('No topics found for this certification');
    }

    // Get modules for all topics
    const allModules = [];
    for (const topic of topics) {
      const { data: modules, error: modulesError } = await supabase
        .from('modules')
        .select(`
          module_id,
          module_name,
          module_description,
          topic_id
        `)
        .eq('topic_id', topic.topic_id);

      if (modulesError) {
        console.error(`Error fetching modules for topic ${topic.topic_id}:`, modulesError);
        continue;
      }

      if (modules && modules.length > 0) {
        allModules.push(...modules.map(module => ({
          ...module,
          topic_name: topic.topic_name,
          topic_description: topic.topic_description
        })));
      }
    }

    return { topics, modules: allModules };
  } catch (error) {
    console.error('Error fetching certification content:', error);
    throw error;
  }
}

// Function to distribute questions across modules
function distributeQuestions(modules: any[], totalQuestions: number) {
  if (modules.length === 0) return [];
  
  const baseQuestionsPerModule = Math.floor(totalQuestions / modules.length);
  const remainingQuestions = totalQuestions % modules.length;
  
  return modules.map((module, index) => ({
    ...module,
    questionsCount: baseQuestionsPerModule + (index < remainingQuestions ? 1 : 0)
  }));
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

// Function to generate questions for mock test
async function generateMockTestQuestions(
  modules: any[],
  totalQuestions: number,
  certificationName: string,
  questionType: string = "mcq"
): Promise<GeneratedQuestion[]> {
  
  // Distribute questions across modules
  const modulesWithQuestions = distributeQuestions(modules, totalQuestions);
  
  // Define question types for variety
  const questionTypes = [
    'definition',           // Basic concept and terminology questions
    'best-practice',        // Industry standards and recommended approaches
    'scenario-based',       // Real-world application scenarios
    'troubleshooting',      // Problem identification and resolution
    'comparison',           // Compare different approaches or services
    'implementation',       // Step-by-step process questions
    'security-focused',     // Security considerations and compliance
    'cost-optimization',    // Budget efficiency and cost considerations
    'performance',          // Speed, scalability, and optimization
    'architecture'          // System design and component relationships
  ];
  
  const allGeneratedQuestions: GeneratedQuestion[] = [];
  
  // Generate questions for each topic group
  const topicGroups = modulesWithQuestions.reduce((groups: any, module) => {
    const topicKey = module.topic_id;
    if (!groups[topicKey]) {
      groups[topicKey] = {
        topic_name: module.topic_name,
        topic_description: module.topic_description,
        modules: []
      };
    }
    groups[topicKey].modules.push(module);
    return groups;
  }, {});
  
  // Generate questions for each topic
  for (const [topicId, topicGroup] of Object.entries(topicGroups) as [string, any][]) {
    const topicModules = topicGroup.modules;
    const topicQuestionCount = topicModules.reduce((sum: number, m: any) => sum + m.questionsCount, 0);
    
    if (topicQuestionCount === 0) continue;
    
    // Create prompt for this topic's modules
    const prompt = createQuestionGenerationPrompt({
      modules: topicModules,
      topicName: topicGroup.topic_name,
      topicDescription: topicGroup.topic_description,
      certificationName,
      questionsPerModule: 1, // Will be handled by the total count
      questionTypes,
      questionType
    });
    
    try {
      const result = await model.generateContent(prompt);
      const response = await result.response;
      const text = response.text();
      
      // Clean and parse JSON response
      let cleanedText = text.replace(/```json\n?|\n?```/g, '').trim();
      
      if (!cleanedText.startsWith('[')) {
        const startIndex = cleanedText.indexOf('[');
        if (startIndex !== -1) {
          cleanedText = cleanedText.substring(startIndex);
        }
      }
      
      if (!cleanedText.endsWith(']')) {
        const lastBracketIndex = cleanedText.lastIndexOf(']');
        if (lastBracketIndex !== -1) {
          cleanedText = cleanedText.substring(0, lastBracketIndex + 1);
        }
      }
      
      let questionsData;
      try {
        questionsData = JSON.parse(cleanedText);
      } catch (parseError) {
        console.error(`JSON parse error for topic ${topicId}:`, parseError);
        
        // Try to extract individual JSON objects
        const jsonObjects = [];
        const regex = /\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}/g;
        const matches = cleanedText.match(regex);
        
        if (matches) {
          for (const match of matches) {
            try {
              const obj = JSON.parse(match);
              if (obj.text && obj.options && obj.correct_answer && obj.explanation) {
                jsonObjects.push(obj);
              }
            } catch (objError) {
              console.log('Skipping malformed object:', match.substring(0, 100));
            }
          }
        }
        
        questionsData = jsonObjects;
      }
      
      // Process generated questions
      if (Array.isArray(questionsData)) {
        const processedQuestions = questionsData.slice(0, topicQuestionCount).map((questionData, index) => {
          // Handle correct_answer based on question type
          let correct_answer;
          if (questionType === "multiple") {
            if (Array.isArray(questionData.correct_answer)) {
              correct_answer = JSON.stringify(questionData.correct_answer);
            } else {
              correct_answer = JSON.stringify([0, 1]);
            }
          } else {
            correct_answer = questionData.correct_answer || "{1}";
          }

          // Assign to appropriate module
          const moduleIndex = Math.floor(index / Math.ceil(topicQuestionCount / topicModules.length));
          const assignedModule = topicModules[Math.min(moduleIndex, topicModules.length - 1)];

          return {
            text: questionData.text || `Generated question ${index + 1}`,
            options: Array.isArray(questionData.options) && questionData.options.length === 4 
              ? questionData.options 
              : [
                  `Basic approach without optimization`,
                  `Professional implementation following best practices`,
                  `Manual configuration only`,
                  `Legacy approach without modern tools`
                ],
            correct_answer: correct_answer,
            explanation: questionData.explanation || `Professional implementation addresses the requirements effectively.`,
            module_id: assignedModule.module_id,
            topic_id: topicId,
            question_number: index + 1
          };
        });
        
        allGeneratedQuestions.push(...processedQuestions);
      }
      
    } catch (error) {
      console.error(`Error generating questions for topic ${topicId}:`, error);
    }
  }
  
  return allGeneratedQuestions.slice(0, totalQuestions); // Ensure we don't exceed requested count
}

// Function to validate questions
async function addValidationScores(
  questions: GeneratedQuestion[],
  certificationName: string,
): Promise<void> {
  
  for (let i = 0; i < questions.length; i++) {
    const question = questions[i];
    
    const validationPrompt = createValidationPrompt(question, certificationName);

    try {
      const validationResult = await model.generateContent(validationPrompt);
      const validationText = validationResult.response.text();
    
      // Clean and parse validation response
      let cleanedValidation = validationText.replace(/```json\n?|\n?```/g, '').trim();
      
      const jsonStart = cleanedValidation.indexOf('{');
      const jsonEnd = cleanedValidation.lastIndexOf('}');
      
      if (jsonStart !== -1 && jsonEnd !== -1 && jsonEnd > jsonStart) {
        cleanedValidation = cleanedValidation.substring(jsonStart, jsonEnd + 1);
      }
      
      let validation;
      
      try {
        validation = JSON.parse(cleanedValidation);
      } catch (parseError) {
        console.error(`Failed to parse validation JSON for question ${i + 1}:`, cleanedValidation);
        question.confidence_score = 0;
        question.validation_status = 'validation_failed';
        question.validation_notes = `Failed to parse validation response`;
        continue;
      }
      
      if (typeof validation.is_correct !== 'boolean') {
        question.confidence_score = 0;
        question.validation_status = 'validation_failed';
        question.validation_notes = 'Invalid validation response structure';
        continue;
      }
      
      if (validation.is_correct === true) {
        question.confidence_score = 1;
        question.validation_status = 'correct';
        question.validation_notes = validation.validation_notes || 'Answer verified as correct';
      } else {
        question.confidence_score = 0;
        question.validation_status = 'incorrect';
        question.validation_notes = validation.validation_notes || 'Answer identified as incorrect';
      }
      
    } catch (validationError) {
      console.error(`Error validating question ${i + 1}:`, validationError);
      question.confidence_score = 0;
      question.validation_status = 'validation_failed';
      question.validation_notes = 'Validation error occurred';
    }
  }
}

export async function POST(request: NextRequest) {
  try {
    const body: MockTestParams = await request.json();
    const { 
      certification_id,
      certification_name,
      mock_test_id,
      title,
      description,
      duration,
      total_questions,
      passing_score,
      validity_months = 12,
      recommended_experience_text,
      exam_format = ['Multiple Choice'],
      questionType = "mcq",
      enableValidation = true,
      topic_id,
      topic_name,
      topic_description,
      questionsPerModule = 1,
      modules: providedModules
    } = body;

    // Validate required parameters
    if (!certification_id || !certification_name || !title || !total_questions) {
      return NextResponse.json(
        { error: 'Missing required parameters: certification_id, certification_name, title, total_questions' },
        { status: 400 }
      );
    }

    // Validate environment variables
    if (!process.env.GEMINI_API_KEY) {
      return NextResponse.json(
        { error: 'Gemini API key not configured' },
        { status: 500 }
      );
    }

    if (!process.env.NEXT_PUBLIC_SUPABASE_URL) {
      return NextResponse.json(
        { error: 'Supabase URL not configured' },
        { status: 500 }
      );
    }

    // Use provided mock_test_id from payload or generate one
    const mockTestId = mock_test_id || `mock_${certification_id}_${Date.now()}`;

    // Skip database operations - only generate SQL script
    console.log(`Preparing SQL script for mock test: ${mockTestId}`);

    // Use provided modules or get certification content (topics and modules)
    let modulesToUse;
    let topics;
    
    if (providedModules && providedModules.length > 0) {
      modulesToUse = providedModules;
      topics = [{ topic_id, topic_name, topic_description }];
    } else {
      const certContent = await getCertificationContent(certification_id);
      topics = certContent.topics;
      modulesToUse = certContent.modules;
    }

    if (!modulesToUse || modulesToUse.length === 0) {
      return NextResponse.json(
        { error: 'No modules found for this certification' },
        { status: 400 }
      );
    }

    // Generate questions
    const generatedQuestions = await generateMockTestQuestions(
      modulesToUse,
      total_questions,
      certification_name,
      questionType
    );

    if (generatedQuestions.length === 0) {
      return NextResponse.json(
        { error: 'Failed to generate questions' },
        { status: 500 }
      );
    }

    // Validate questions if enabled
    let validationStatus = 'skipped';
    if (enableValidation) {
      await addValidationScores(generatedQuestions, certification_name);
      validationStatus = 'completed';
    }

    // Skip database insertion - only generate SQL script
    console.log(`Generated ${generatedQuestions.length} questions for mock test: ${mockTestId}`);  

    // Generate SQL script
    let sqlScript = `-- Generated SQL Script for Mock Test\n`;
    sqlScript += `-- Certification ID: ${certification_id}\n`;
    sqlScript += `-- Mock Test ID: ${mockTestId}\n`;
    sqlScript += `-- Generated on: ${new Date().toISOString()}\n\n`;
    sqlScript += `BEGIN;\n\n`;

    // Insert mock test
    const escapedTitle = title.replace(/'/g, "''");
    const escapedDescription = (description || '').replace(/'/g, "''");
    const escapedExperienceText = (recommended_experience_text || '').replace(/'/g, "''");
    
    sqlScript += `-- Create Mock Test\n`;
    sqlScript += `INSERT INTO public.mock_tests (id, certification_id, title, duration, total_questions, description, validity_months, passing_score, recommended_experience_text, exam_format, created_at)\n`;
    sqlScript += `VALUES ('${mockTestId}', ${certification_id}, '${escapedTitle}', ${duration}, ${total_questions}, '${escapedDescription}', ${validity_months}, ${passing_score}, '${escapedExperienceText}', '${JSON.stringify(exam_format)}', NOW())\n`;
    sqlScript += `ON CONFLICT (id) DO NOTHING;\n\n`;

    // Insert questions for mock_test_questions table
    sqlScript += `-- Insert Mock Test Questions\n`;
    generatedQuestions.forEach((question, index) => {
      const escapedText = question.text.replace(/'/g, "''");
      const escapedExplanation = question.explanation.replace(/'/g, "''");
      
      // Parse correct_answer to integer array using helper function
      const correctAnswerArray = parseCorrectAnswer(question.correct_answer);
      
      const questionTopicId = question.topic_id ? parseInt(question.topic_id) : topic_id;
      
      sqlScript += `INSERT INTO public.mock_test_questions (mock_test_id, question_text, question_type, options, correct_answer, explanation, question_order, module_id, topic_id)\n`;
      sqlScript += `VALUES ('${mockTestId}', '${escapedText}', '${questionType}', '${JSON.stringify(question.options)}'::jsonb, '{${correctAnswerArray.join(',')}}', '${escapedExplanation}', ${index + 1}, '${question.module_id}', ${questionTopicId || 'NULL'});\n\n`;
    });

    sqlScript += `COMMIT;\n`;

    // Calculate validation statistics
    const validationStats = generatedQuestions.reduce((stats: Record<string, number>, question) => {
      const status = question.validation_status || 'unknown';
      stats[status] = (stats[status] || 0) + 1;
      return stats;
    }, {});

    return NextResponse.json({
      success: true,
      message: `Successfully created mock test with ${generatedQuestions.length} questions`,
      mockTestId,
      script: sqlScript,
      validationStatus,
      validationStats,
      summary: {
        certification_id,
        certification_name,
        title,
        total_questions: generatedQuestions.length,
        duration,
        passing_score,
        topics_covered: topics.length,
        modules_covered: modulesToUse.length
      },
      questions: generatedQuestions.map((question, index) => ({
        mock_test_id: mockTestId,
        question_text: question.text,
        options: question.options,
        correct_answer: parseCorrectAnswer(question.correct_answer),
        explanation: question.explanation,
        confidence_score: question.confidence_score,
        validation_status: question.validation_status,
        validation_notes: question.validation_notes,
        module_id: question.module_id,
        question_order: index + 1,
        topic_id: question.topic_id ? parseInt(question.topic_id) : topic_id || null
      }))
    });

  } catch (error) {
    console.error('Error generating mock test:', error);
    return NextResponse.json(
      { error: 'Failed to generate mock test' },
      { status: 500 }
    );
  }
}

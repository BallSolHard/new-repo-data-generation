import { NextRequest, NextResponse } from 'next/server';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { createClient } from '@supabase/supabase-js';
import { createValidationPrompt, createQuestionGenerationPrompt } from '../generate-hub/prompts';
import type { GeneratedQuestion, QuestionGenerationParams } from '../generate-hub/types';

// Initialize Gemini client
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');
const model = genAI.getGenerativeModel({ 
  model: "gemini-2.5-flash" // Using Gemini 2.5 Flash
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
function distributeQuestions(modules: any[], totalQuestions: number, questionsPerModule?: number) {
  if (modules.length === 0) return [];
  
  // If questionsPerModule is specified, use it; otherwise distribute totalQuestions evenly
  if (questionsPerModule && questionsPerModule > 0) {
    return modules.map((module) => ({
      ...module,
      questionsCount: questionsPerModule
    }));
  }
  
  const baseQuestionsPerModule = Math.floor(totalQuestions / modules.length);
  const remainingQuestions = totalQuestions % modules.length;
  
  return modules.map((module, index) => ({
    ...module,
    questionsCount: baseQuestionsPerModule + (index < remainingQuestions ? 1 : 0)
  }));
}

// Function to get the next question order number
async function getNextQuestionOrder(mockTestId: string): Promise<number> {
  try {
    const { data, error } = await supabase
      .from('mock_test_questions')
      .select('question_order')
      .eq('mock_test_id', mockTestId)
      .order('question_order', { ascending: false })
      .limit(1);

    if (error) {
      console.error('Error fetching max question order:', error);
      return 1; // Default to 1 if there's an error
    }

    // If no questions exist, start with 1
    if (!data || data.length === 0) {
      return 1;
    }

    // Return the highest question_order + 1
    return (data[0].question_order || 0) + 1;
  } catch (error) {
    console.error('Error in getNextQuestionOrder:', error);
    return 1; // Default fallback
  }
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
  questionType: string = "mcq",
  questionsPerModule: number = 1,
  complexityLevel: string = 'basic',
  isProfessionalOrSpecialty: boolean = false
): Promise<GeneratedQuestion[]> {
  
  // Distribute questions across modules
  const modulesWithQuestions = distributeQuestions(modules, totalQuestions, questionsPerModule);
  
  // Define question types based on complexity level
  let questionTypes;
  if (isProfessionalOrSpecialty) {
    questionTypes = [
      'complex-enterprise-scenario', // Multi-paragraph enterprise scenarios
      'architectural-decision',      // Complex architectural trade-offs
      'advanced-troubleshooting',    // Multi-layered problem diagnosis
      'strategic-optimization',      // Enterprise-level optimization decisions
      'compliance-and-security',     // Advanced security and compliance scenarios
      'scalability-challenges',      // Large-scale system design challenges
      'integration-complexity',      // Complex system integration scenarios
      'performance-analysis',        // Deep performance optimization
      'disaster-recovery',           // Business continuity planning
      'cost-architecture-balance'    // Balancing cost, performance, and architecture
    ];
  } else if (complexityLevel === 'intermediate') {
    questionTypes = [
      'scenario-based',       // Real-world application scenarios
      'best-practice',        // Industry standards and recommended approaches
      'troubleshooting',      // Problem identification and resolution
      'implementation',       // Step-by-step process questions
      'comparison',           // Compare different approaches or services
      'security-focused',     // Security considerations and compliance
      'cost-optimization',    // Budget efficiency and cost considerations
      'performance',          // Speed, scalability, and optimization
      'architecture'          // System design and component relationships
    ];
  } else {
    questionTypes = [
      'definition',           // Basic concept and terminology questions
      'best-practice',        // Industry standards and recommended approaches
      'scenario-based',       // Simple real-world scenarios
      'comparison',           // Compare different approaches or services
      'implementation',       // Basic implementation steps
      'security-focused',     // Basic security considerations
      'architecture'          // Basic system design concepts
    ];
  }
  
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
    
    console.log(`Generating ${topicQuestionCount} questions for topic ${topicId} with ${topicModules.length} modules (${questionsPerModule} questions per module)`);
    
    // Create prompt for this topic's modules
    const prompt = createQuestionGenerationPrompt({
      modules: topicModules,
      topicName: topicGroup.topic_name,
      topicDescription: topicGroup.topic_description,
      certificationName,
      questionsPerModule: questionsPerModule,
      questionTypes,
      questionType,
      complexityLevel,
      isProfessionalOrSpecialty
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

          // Use the module_id from AI response if provided, otherwise assign to appropriate module
          let assignedModuleId;
          if (questionData.module_id) {
            // Verify the module_id exists in our topicModules
            const foundModule = topicModules.find((m: any) => m.module_id === questionData.module_id);
            assignedModuleId = foundModule ? questionData.module_id : topicModules[0].module_id;
          } else {
            // Fallback: distribute questions evenly across modules
            const moduleIndex = Math.floor(index / Math.ceil(topicQuestionCount / topicModules.length));
            const assignedModule = topicModules[Math.min(moduleIndex, topicModules.length - 1)];
            assignedModuleId = assignedModule.module_id;
          }

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
            module_id: assignedModuleId,
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
  
  console.log(`Generated ${allGeneratedQuestions.length} questions total, expected ${totalQuestions}`);
  return allGeneratedQuestions; // Return all generated questions since we distribute correctly per module
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
      exam_format = ['mcq', 'multiple'],
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

    // Determine certification level based on certification name
    const certificationLower = certification_name.toLowerCase();
    const isFoundational = certificationLower.includes('foundational') || certificationLower.includes('foundation') || certificationLower.includes('basics') || certificationLower.includes('fundamentals');
    const isAssociate = certificationLower.includes('associate') || certificationLower.includes('intermediate');
    const isProfessional = certificationLower.includes('professional') || certificationLower.includes('expert') || certificationLower.includes('advanced');
    const isSpecialty = certificationLower.includes('specialty') || certificationLower.includes('speciality') || certificationLower.includes('specialist');

    // Determine complexity level and question characteristics
    let complexityLevel;
    if (isProfessional || isSpecialty) {
      complexityLevel = 'advanced';
    } else if (isAssociate) {
      complexityLevel = 'intermediate';
    } else {
      complexityLevel = 'basic';
    }

    console.log(`Detected certification level: ${complexityLevel} (Professional: ${isProfessional}, Specialty: ${isSpecialty}, Associate: ${isAssociate}, Foundational: ${isFoundational})`);
    console.log(`Question generation will use ${complexityLevel} complexity with ${isProfessional || isSpecialty ? 'lengthy, complex enterprise-level' : complexityLevel === 'intermediate' ? 'moderate practical' : 'concise fundamental'} questions`);

    // Generate questions
    const generatedQuestions = await generateMockTestQuestions(
      modulesToUse,
      total_questions,
      certification_name,
      questionType,
      questionsPerModule,
      complexityLevel,
      isProfessional || isSpecialty
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

    // Get the starting question order number
    const startingQuestionOrder = await getNextQuestionOrder(mockTestId);
    console.log(`Generated ${generatedQuestions.length} questions for mock test: ${mockTestId}, starting from question order: ${startingQuestionOrder}`);  

    // Generate SQL script
    let sqlScript = `-- Generated SQL Script for Mock Test\n`;
    sqlScript += `-- Certification ID: ${certification_id}\n`;
    sqlScript += `-- Mock Test ID: ${mockTestId}\n`;
    sqlScript += `-- Generated on: ${new Date().toISOString()}\n\n`;
    sqlScript += `BEGIN;\n\n`;

    // Insert mock test only if it doesn't exist
    const escapedTitle = title.replace(/'/g, "''");
    const escapedDescription = (description || '').replace(/'/g, "''");
    const escapedExperienceText = (recommended_experience_text || '').replace(/'/g, "''");
    
    sqlScript += `-- Create Mock Test (only if it doesn't exist)\n`;
    sqlScript += `INSERT INTO public.mock_tests (id, certification_id, title, duration, total_questions, description, validity_months, passing_score, recommended_experience_text, exam_format, created_at)\n`;
    sqlScript += `SELECT '${mockTestId}', ${certification_id}, '${escapedTitle}', ${duration}, ${total_questions}, '${escapedDescription}', ${validity_months}, ${passing_score}, '${escapedExperienceText}', ARRAY['${exam_format.join("','")}'], NOW()\n`;
    sqlScript += `WHERE NOT EXISTS (SELECT 1 FROM public.mock_tests WHERE id = '${mockTestId}');\n\n`;

    // Insert questions for mock_test_questions table
    sqlScript += `-- Insert Mock Test Questions (starting from question_order ${startingQuestionOrder})\n`;
    generatedQuestions.forEach((question, index) => {
      const escapedText = question.text.replace(/'/g, "''");
      const escapedExplanation = question.explanation.replace(/'/g, "''");
      const escapedOptions = JSON.stringify(question.options).replace(/'/g, "''");
      
      // Parse correct_answer to integer array using helper function
      const correctAnswerArray = parseCorrectAnswer(question.correct_answer);
      
      const questionTopicId = question.topic_id ? parseInt(question.topic_id) : topic_id;
      const topicIdValue = questionTopicId && !isNaN(questionTopicId) ? questionTopicId : 'NULL';
      
      // Use incremental question_order starting from the next available number
      const questionOrder = startingQuestionOrder + index;
      
      sqlScript += `INSERT INTO public.mock_test_questions (mock_test_id, question_text, question_type, options, correct_answer, explanation, question_order, module_id, topic_id)\n`;
      sqlScript += `VALUES ('${mockTestId}', '${escapedText}', '${questionType}', '${escapedOptions}'::jsonb, '{${correctAnswerArray.join(',')}}', '${escapedExplanation}', ${questionOrder}, '${question.module_id}', ${topicIdValue});\n\n`;
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

    sqlScript += `COMMIT;\n`;

    // Calculate validation statistics
    const validationStats = generatedQuestions.reduce((stats: Record<string, number>, question) => {
      const status = question.validation_status || 'unknown';
      stats[status] = (stats[status] || 0) + 1;
      return stats;
    }, {});

    return NextResponse.json({
      success: true,
      message: `Successfully created mock test with ${generatedQuestions.length} questions (starting from question ${startingQuestionOrder})`,
      mockTestId,
      startingQuestionOrder,
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

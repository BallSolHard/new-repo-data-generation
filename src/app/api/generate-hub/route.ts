import { NextRequest, NextResponse } from 'next/server';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { createClient } from '@supabase/supabase-js';
import { createValidationPrompt, createQuestionGenerationPrompt } from './prompts';
import type { GeneratedQuestion, QuestionGenerationParams } from './types';

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

// Function to get the highest question index for each module
async function getNextQuestionIndexForModules(topicId: string, modules: any[] = []): Promise<{[moduleId: string]: number}> {
  try {
    const moduleIndices: {[moduleId: string]: number} = {};
    
    for (const module of modules) {
      const pattern = `q_${topicId}_${module.module_id}_%`;
      
      const { data, error } = await supabase
        .from('question')
        .select('id')
        .like('id', pattern);
      
      if (error) {
        return Promise.reject(error);
      }

      if (data && data.length > 0) {
        // Find the highest index by comparing as we iterate
        let highestForModule = 0;
        for (const record of data) {
          const parts = record.id.split('_');
          const lastElement = parts[parts.length - 1];
          const indexNumber = parseInt(lastElement);
          if (!isNaN(indexNumber) && indexNumber > highestForModule) {
            highestForModule = indexNumber;
          }
        }
        
        moduleIndices[module.module_id] = highestForModule + 1;
      } else {
        moduleIndices[module.module_id] = 1;
      }
    }   
    return moduleIndices;    
  } catch (error) {
    console.error('Error getting next question indices for module', error);
   return Promise.reject(error);
  }
}

// Function to validate questions with another LLM instance and add confidence scores
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
    
      // Clean and parse validation response with better error handling
      let cleanedValidation = validationText.replace(/```json\n?|\n?```/g, '').trim();
      
      // Remove any text before the first { and after the last }
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
        question.validation_notes = `Failed to parse validation response: ${cleanedValidation.substring(0, 100)}...`;
        continue;
      }
      
      // Validate that we have the required fields
      if (typeof validation.is_correct !== 'boolean' || validation.correct_answer_index === undefined) {
        console.error(`Invalid validation response structure for question ${i + 1}:`, validation);
        question.confidence_score = 0;
        question.validation_status = 'validation_failed';
        question.validation_notes = 'Validation response missing required fields';
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
        
        // Handle correct answer suggestion based on type
        if (validation.correct_answer_index !== undefined && validation.correct_answer_index !== null) {
          try {
            if (Array.isArray(validation.correct_answer_index)) {
              // Multiple select format - validator provided array of correct indices
              const validIndices = validation.correct_answer_index.filter((idx: any) => 
                typeof idx === 'number' && idx >= 0 && idx < question.options.length
              );
              
              if (validIndices.length > 0) {
                question.new_correct_answer = JSON.stringify(validIndices);
                
                // Create human-readable explanation of correct answers
                const correctOptions = validIndices
                  .map((index: number) => `${String.fromCharCode(65 + index)}) ${question.options[index]}`)
                  .join(', ');
                question.new_explanation = `${validation.validation_notes || ''} Correct answers should be: ${correctOptions}`;
              } else {
                question.new_explanation = `${validation.validation_notes || ''} (Invalid suggested indices provided)`;
              }
            } else if (typeof validation.correct_answer_index === 'number') {
              // Single answer format
              const idx = validation.correct_answer_index;
              if (idx >= 0 && idx < question.options.length) {
                question.new_correct_answer = `{${idx}}`;
                const correctOption = `${String.fromCharCode(65 + idx)}) ${question.options[idx]}`;
                question.new_explanation = `${validation.validation_notes || ''} Correct answer should be: ${correctOption}`;
              } else {
                question.new_explanation = `${validation.validation_notes || ''} (Invalid suggested index: ${idx})`;
              }
            } else {
              question.new_explanation = validation.validation_notes || 'Validator suggests this answer needs review';
            }
          } catch (processingError) {
            console.error(`Error processing suggested answer for question ${i + 1}:`, processingError);
            question.new_explanation = validation.validation_notes || 'Error processing validator suggestion';
          }
        } else {
          question.new_explanation = validation.validation_notes || 'Validator suggests this answer needs review';
        }
      }
      
    } catch (validationError) {
      console.error(`Error validating question ${i + 1}:`, validationError);
      // Mark as validation failed
      question.confidence_score = 0;
      question.validation_status = 'validation_failed';
      question.validation_notes = `Validation error: ${validationError instanceof Error ? validationError.message : 'Unknown error'}`;
    }
  }
}

// Function to generate all questions for all modules in a single API call
async function generateAllQuestions(
  modules: any[],
  topicName: string,
  topicDescription: string,
  certificationName: string,
  questionsPerModule: number = 2,
  questionType: string = "mcq"
): Promise<GeneratedQuestion[]> {
  
  // Define question types for variety - different styles/formats of questions
  const questionTypes = questionType === 'ordering' ? [
    'process-flow',         // Sequential steps or procedures
    'deployment-sequence',  // Deployment and setup workflows
    'lifecycle-phases',     // Project or service lifecycle stages
    'troubleshooting-steps',// Sequential problem-solving approach
    'data-flow',           // Data processing or transformation steps
    'security-workflow',    // Security implementation sequence
    'development-stages',   // Software development lifecycle
    'migration-phases',     // System or data migration steps
    'configuration-order',  // Sequential configuration steps
    'rollback-procedure'    // Recovery and rollback sequences
  ] : [
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
  
  // Create prompt using the template function
  const prompt = createQuestionGenerationPrompt({
    modules,
    topicName,
    topicDescription,
    certificationName,
    questionsPerModule,
    questionTypes,
    questionType
  });
  
  // Alternative specialized prompts available:
  // const prompt = QuestionPromptTemplates.createBeginnerPrompt(params);
  // const prompt = QuestionPromptTemplates.createScenarioPrompt(params);  
  // const prompt = QuestionPromptTemplates.createTroubleshootingPrompt(params);
  
  try {
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const text = response.text();
    // Clean and parse JSON response with better error handling
    let cleanedText = text.replace(/```json\n?|\n?```/g, '').trim();
    
    // Try to fix common JSON issues
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
      console.error('JSON parse error:', parseError);
      console.error('Failed to parse text:', cleanedText);
      
      // Try to extract individual JSON objects if array parsing failed
      try {
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
        
        if (jsonObjects.length > 0) {
          questionsData = jsonObjects;
        } else {
          throw new Error(`Could not extract valid JSON objects: ${parseError}`);
        }
      } catch (recoveryError) {
        throw new Error(`Invalid JSON response from Gemini and recovery failed: ${parseError}`);
      }
    }
    
    // Validate and return structured response
    if (Array.isArray(questionsData)) {
      return questionsData.map((questionData, index) => {
        // Handle correct_answer based on question type
        let correct_answer;
        if (questionType === "ordering") {
          // For ordering, expect array format representing the correct sequence
          if (Array.isArray(questionData.correct_answer)) {
            correct_answer = questionData.correct_answer; // Keep as array for internal processing
          } else {
            // Fallback: assume natural order
            correct_answer = [0, 1, 2, 3];
          }
        } else if (questionType === "multiple") {
          // For multiple select, expect array format
          if (Array.isArray(questionData.correct_answer)) {
            correct_answer = JSON.stringify(questionData.correct_answer);
          } else {
            // Fallback: assume first two options are correct
            correct_answer = JSON.stringify([0, 1]);
          }
        } else {
          // For MCQ, use string format
          correct_answer = questionData.correct_answer || "{1}";
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
          type: questionType as 'mcq' | 'multiple' | 'ordering', // Add type field
          module_id: questionData.module_id || modules[Math.floor(index / questionsPerModule)]?.module_id,
          question_number: questionData.question_number || ((index % questionsPerModule) + 1)
        };
      });
    } else {
      throw new Error('Invalid response format from Gemini');
    }
    
  } catch (error) {
    console.error('Error generating questions with Gemini:', error);
    return [];
  }
}






export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { 
      certification_id, 
      certification_name,
      topic_id, 
      topic_name,
      topic_description,
      quiz_id, 
      modules = [],
      questionsPerModule = 1, // Default to 1 question per module
      questionType = "mcq", // Default to multiple choice
      enableValidation = true, // Enable validation by default
      startingIndex = null // Will be determined from Supabase if null
    } = body;

    // Validate required parameters
    if (!certification_id || !topic_id || !quiz_id) {
      return NextResponse.json(
        { error: 'Missing required parameters: certification_id, topic_id, quiz_id' },
        { status: 400 }
      );
    }

    if (!modules || modules.length === 0) {
      return NextResponse.json(
        { error: 'No modules provided' },
        { status: 400 }
      );
    }

    // Validate Gemini API key
    if (!process.env.GEMINI_API_KEY) {
      return NextResponse.json(
        { error: 'Gemini API key not configured. Please set GEMINI_API_KEY environment variable.' },
        { status: 500 }
      );
    }

    // Validate Supabase configuration
    if (!process.env.NEXT_PUBLIC_SUPABASE_URL) {
      return NextResponse.json(
        { error: 'Supabase URL not configured. Please set NEXT_PUBLIC_SUPABASE_URL environment variable.' },
        { status: 500 }
      );
    }

    // Determine starting indices from Supabase if not provided
    let moduleStartingIndices: {[moduleId: string]: number} = {};
    let actualStartingIndex = startingIndex;
    
    if (actualStartingIndex === null) {
      // Get module-specific starting indices
      moduleStartingIndices = await getNextQuestionIndexForModules(topic_id, modules);
      
      // For backward compatibility, also get global starting index
      actualStartingIndex = Math.max(...Object.values(moduleStartingIndices));
    } else {
      // If starting index is manually provided, use it for all modules
      modules.forEach((module: any) => {
        moduleStartingIndices[module.module_id] = actualStartingIndex;
      });
    }
  
    // Generate SQL script with user-specified questions per module
    let sqlScript = `-- Generated SQL Script for Hub Questions\n`;
    sqlScript += `-- Certification ID: ${certification_id}\n`;
    sqlScript += `-- Topic ID: ${topic_id}\n`;
    sqlScript += `-- Quiz ID: ${quiz_id}\n`;
    sqlScript += `-- Generated on: ${new Date().toISOString()}\n\n`;
    sqlScript += `BEGIN;\n\n`;

    // Generate all questions in a single API call
    const generatedQuestions = await generateAllQuestions(
      modules,
      body.topic_name,
      body.topic_description,
      body.certification_name,
      questionsPerModule, // Use the user-selected number of questions per module
      questionType // Pass the question type to the generation function
    );

    // // Add one intentionally incorrect test question to validate the validation system
    // if (generatedQuestions.length > 0) {
    //   generatedQuestions[0] = {
    //     ...generatedQuestions[0],
    //     correct_answer: "{0}", // Force first question to have wrong answer
    //     explanation: `Using basic configuration without optimization is the correct approach. [TEST: This is intentionally incorrect to test validation - original was ${generatedQuestions[0].correct_answer}]`
    //   };
    // }

    // Validate questions with secondary LLM instance (if enabled)
    let validationStatus = 'skipped';
    
    if (enableValidation) {
      await addValidationScores(
        generatedQuestions,
        body.certification_name,
      );
      validationStatus = 'completed';
    } else {
      console.log('Question validation skipped (disabled)');
    }

    // Track current index for each module
    const currentModuleIndices: {[moduleId: string]: number} = { ...moduleStartingIndices };
    const quizQuestionLinks = [];

    // Process each validated question
    for (const question of generatedQuestions) {
      const moduleForQuestion = modules.find((m: any) => m.module_id === question.module_id) || modules[0];
      const moduleId = moduleForQuestion.module_id;
      
      // Get the current index for this specific module
      const questionIndex = currentModuleIndices[moduleId];
      const questionId = `q_${topic_id}_${moduleId}_${questionIndex}`;
      
      // Add section header for each module (only for first question of each module)
      if (questionIndex === moduleStartingIndices[moduleId]) {
        sqlScript += `-- =====================\n`;
        sqlScript += `-- QUESTIONS - ${moduleForQuestion.module_name}\n`;
        sqlScript += `-- =====================\n\n`;
      }
      
      // Escape single quotes in text, explanation, and options for SQL
      const escapedText = question.text.replace(/'/g, "''");
      const escapedExplanation = question.explanation.replace(/'/g, "''");
      const escapedOptions = JSON.stringify(question.options).replace(/'/g, "''");
      
      // Handle correct_answer format based on question type
      let correctAnswerValue;
      if (questionType === 'ordering' && Array.isArray(question.correct_answer)) {
        // For ordering questions, store as PostgreSQL array format
        correctAnswerValue = `{${question.correct_answer.join(',')}}`;
      } else if (Array.isArray(question.correct_answer)) {
        // For multiple select, convert array to PostgreSQL array format
        correctAnswerValue = `{${question.correct_answer.join(',')}}`;
      } else if (questionType === 'ordering' && typeof question.correct_answer === 'string') {
        // Handle string format for ordering questions (parse JSON and convert to PG array)
        try {
          const parsed = JSON.parse(question.correct_answer);
          correctAnswerValue = `{${parsed.join(',')}}`;
        } catch {
          correctAnswerValue = '{0,1,2,3}'; // Default ordering
        }
      } else {
        // For single answer (mcq), use the string value
        correctAnswerValue = question.correct_answer;
      }
      
      sqlScript += `INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)\n`;
      sqlScript += `VALUES ('${questionId}','${escapedText}','${questionType}','${escapedOptions}'::json,'${correctAnswerValue}','${escapedExplanation}',NOW(),'${quiz_id}',NOW(),${questionIndex},NULL,NULL,'${moduleForQuestion.module_id}') ON CONFLICT (id) DO NOTHING;\n\n`;
      
      quizQuestionLinks.push(`(NOW(),'${quiz_id}','${questionId}')`);
      
      // Increment the index for this specific module
      currentModuleIndices[moduleId]++;
    }

    // Add quiz-question links
    sqlScript += `-- =====================\n`;
    sqlScript += `-- Link questions to quiz\n`;
    sqlScript += `-- =====================\n`;
    sqlScript += `INSERT INTO public.quiz_question (created_at, quiz_id, question_id) VALUES\n`;
    sqlScript += ` ${quizQuestionLinks.join(',\n ')}\n`;
    sqlScript += `ON CONFLICT DO NOTHING;\n\n`;

    // Update question count
    sqlScript += `-- Update question count\n`;
    sqlScript += `UPDATE public.quiz q\n`;
    sqlScript += `SET questions = sub.cnt,\n`;
    sqlScript += `    modified_at = NOW()\n`;
    sqlScript += `FROM (\n`;
    sqlScript += `  SELECT quiz_id, COUNT(*)::int AS cnt\n`;
    sqlScript += `  FROM public.quiz_question\n`;
    sqlScript += `  WHERE quiz_id = '${quiz_id}'\n`;
    sqlScript += `  GROUP BY quiz_id\n`;
    sqlScript += `) sub\n`;
    sqlScript += `WHERE q.id = sub.quiz_id;\n\n`;
    sqlScript += `COMMIT;\n`;


    // Calculate validation statistics for response
    const validationStats = generatedQuestions.reduce((stats: Record<string, number>, question) => {
      const status = question.validation_status || 'unknown';
      stats[status] = (stats[status] || 0) + 1;
      return stats;
    }, {});

    // Calculate total score
   
    return NextResponse.json({
      script: sqlScript,
      validationStatus,
      questions: generatedQuestions.map((question, index) => {
        const moduleForQuestion = modules.find((m: any) => m.module_id === question.module_id) || modules[0];
        const moduleId = moduleForQuestion.module_id;
        
        // Calculate the correct index for this question based on its position within its module
        const questionsPerModule = generatedQuestions.filter(q => 
          (modules.find((m: any) => m.module_id === q.module_id) || modules[0]).module_id === moduleId
        ).length;
        const questionIndexInModule = generatedQuestions
          .slice(0, index + 1)
          .filter(q => (modules.find((m: any) => m.module_id === q.module_id) || modules[0]).module_id === moduleId)
          .length - 1;
        
        const currentQuestionIndex = moduleStartingIndices[moduleId] + questionIndexInModule;
        
        return {
          id: `q_${topic_id}_${moduleId}_${currentQuestionIndex}`,
          text: question.text,
          options: question.options,
          correct_answer: question.correct_answer, 
          explanation: question.explanation, 
          confidence_score: question.confidence_score,
          validation_status: question.validation_status, 
          validation_notes: question.validation_notes,
          new_correct_answer: question.new_correct_answer, 
          new_explanation: question.new_explanation, 
        };
      })
    });

  } catch (error) {
    console.error('Error generating hub questions:', error);
    return NextResponse.json(
      { error: 'Failed to generate hub questions' },
      { status: 500 }
    );
  }
}

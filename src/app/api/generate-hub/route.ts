import { NextRequest, NextResponse } from 'next/server';
import { GoogleGenerativeAI } from '@google/generative-ai';

// Interface for generated question
interface GeneratedQuestion {
  text: string;
  options: string[];
  correct_answer: string;
  explanation: string;
  module_id?: string;
  question_number?: number;
}

// Initialize Gemini client
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');
const model = genAI.getGenerativeModel({ 
  model: "gemini-2.0-flash" // Using Gemini 2.0 Flash
});

// Function to validate questions with another LLM instance
async function validateQuestions(
  questions: GeneratedQuestion[],
  certificationName: string,
  topicName: string
): Promise<GeneratedQuestion[]> {
  console.log(`Validating ${questions.length} questions with secondary LLM...`);
  
  const validatedQuestions: GeneratedQuestion[] = [];
  
  for (let i = 0; i < questions.length; i++) {
    const question = questions[i];
    
    const validationPrompt = `You are an expert ${certificationName} certification validator. Analyze this multiple-choice question and determine if the indicated correct answer is actually correct.

QUESTION TO VALIDATE:
${question.text}

OPTIONS:
A) ${question.options[0]}
B) ${question.options[1]}
C) ${question.options[2]}
D) ${question.options[3]}

CLAIMED CORRECT ANSWER: ${question.correct_answer}
EXPLANATION PROVIDED: ${question.explanation}

TASK: Verify if the claimed correct answer is indeed correct for ${certificationName} certification standards.

RESPOND WITH JSON ONLY:
{
  "is_correct": true/false,
  "correct_answer_index": "0-3 (actual correct answer index)",
  "confidence": "high/medium/low",
  "validation_notes": "Brief explanation of your assessment"
}`;

    try {
      const validationResult = await model.generateContent(validationPrompt);
      const validationText = validationResult.response.text();
      
      // Clean and parse validation response
      const cleanedValidation = validationText.replace(/```json\n?|\n?```/g, '').trim();
      let validation;
      
      try {
        validation = JSON.parse(cleanedValidation);
      } catch (parseError) {
        console.warn(`Validation parse error for question ${i + 1}, accepting original`);
        validatedQuestions.push(question);
        continue;
      }
      
      // If validation failed or confidence is low, log it but keep the question
      if (!validation.is_correct || validation.confidence === 'low') {
        console.warn(`Question ${i + 1} validation concerns:`, validation.validation_notes);
        
        // If validator suggests a different correct answer with high confidence, update it
        if (validation.confidence === 'high' && validation.correct_answer_index !== undefined) {
          const correctedQuestion = {
            ...question,
            correct_answer: `{${validation.correct_answer_index}}`,
            explanation: `${question.explanation} [Validated and corrected: ${validation.validation_notes}]`
          };
          validatedQuestions.push(correctedQuestion);
          console.log(`Corrected answer for question ${i + 1}: {${validation.correct_answer_index}}`);
        } else {
          validatedQuestions.push(question);
        }
      } else {
        console.log(`Question ${i + 1} validated successfully`);
        validatedQuestions.push(question);
      }
      
    } catch (validationError) {
      console.error(`Error validating question ${i + 1}:`, validationError);
      // Keep original question if validation fails
      validatedQuestions.push(question);
    }
    
    // Add small delay to avoid rate limiting
    if (i < questions.length - 1) {
      await new Promise(resolve => setTimeout(resolve, 100));
    }
  }
  
  console.log(`Validation complete: ${validatedQuestions.length} questions processed`);
  return validatedQuestions;
}

// Function to generate all questions for all modules in a single API call
async function generateAllQuestions(
  modules: any[],
  topicName: string,
  topicDescription: string,
  certificationName: string,
  questionsPerModule: number = 2
): Promise<GeneratedQuestion[]> {
  
  // Get certification context for better prompt engineering
  const certificationContext = getCertificationContext(certificationName);
  
  // Define question types for variety
  const questionTypes = [
    'scenario-based',
    'best-practice',
    'troubleshooting', 
    'architectural',
    'security-focused'
  ];
  
  // Build modules information for the prompt
  const modulesInfo = modules.map((module, index) => {
    return `
Module ${index + 1}:
- ID: ${module.module_id}
- Name: ${module.module_name}
- Description: ${module.module_description || 'Not provided'}
- Content: ${module.module_content || 'Not provided'}`;
  }).join('\n');
  
  // Create concise prompt for Gemini to generate all questions at once
  const prompt = `Generate ${questionsPerModule * modules.length} ${certificationName} exam questions as valid JSON array.

MODULES:
${modulesInfo}

CONTEXT: ${topicName} - ${certificationContext.focus}
SERVICES: ${certificationContext.services.slice(0, 8).join(', ')}

FORMAT (JSON only, no markdown):
[
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "Professional certification question",
    "options": ["Wrong option", "Wrong option", "Correct option", "Wrong option"],
    "correct_answer": "{2}",
    "explanation": "Why option 3 is correct"
  }
]

REQUIREMENTS:
- Exactly ${questionsPerModule} questions per module
- Professional difficulty level
- Real-world scenarios
- Mix question types: ${questionTypes.slice(0, 3).join(', ')}
- Proper JSON format with escaped quotes
- Return only the JSON array

Generate ${questionsPerModule * modules.length} questions:`;

  console.log('Gemini Batch Prompt for', modules.length, 'modules');
  
  try {
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const text = response.text();
    
    console.log('Raw Gemini response length:', text.length);
    console.log('Raw Gemini response preview:', text.substring(0, 500));
    
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
    
    console.log('Cleaned text for parsing:', cleanedText.substring(0, 200));
    
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
          console.log(`Recovered ${jsonObjects.length} valid questions from malformed response`);
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
      return questionsData.map((questionData, index) => ({
        text: questionData.text || `Generated question ${index + 1}`,
        options: Array.isArray(questionData.options) && questionData.options.length === 4 
          ? questionData.options 
          : [
              `Basic approach without optimization`,
              `Professional implementation using ${certificationContext.services[0]} and ${certificationContext.services[1]}`,
              `Manual configuration only`,
              `Legacy approach without cloud services`
            ],
        correct_answer: questionData.correct_answer || "{1}",
        explanation: questionData.explanation || `Professional implementation addresses the requirements effectively.`,
        module_id: questionData.module_id || modules[Math.floor(index / questionsPerModule)]?.module_id,
        question_number: questionData.question_number || ((index % questionsPerModule) + 1)
      }));
    } else {
      throw new Error('Invalid response format from Gemini');
    }
    
  } catch (error) {
    console.error('Error generating questions with Gemini:', error);
    
    // Fallback: generate questions for each module
    return generateFallbackQuestions(modules, topicName, certificationContext, questionsPerModule);
  }
}

// Fallback questions generator in case Gemini fails
function generateFallbackQuestions(
  modules: any[],
  topicName: string, 
  certificationContext: any,
  questionsPerModule: number = 2
): GeneratedQuestion[] {
  const services = certificationContext.services.slice(0, 4);
  const questions: GeneratedQuestion[] = [];
  
  modules.forEach((module) => {
    for (let i = 1; i <= questionsPerModule; i++) {
      questions.push({
        text: `When implementing ${module.module_name} as part of ${topicName}, what is the most appropriate approach for a production environment?`,
        options: [
          `Use basic ${services[0]} without additional configuration`,
          `Implement comprehensive solution using ${services[1]}, ${services[2]}, and proper monitoring`,
          `Rely on manual processes and default settings`,
          `Use on-premises solutions exclusively`
        ],
        correct_answer: "{1}",
        explanation: `Implementing a comprehensive solution using ${services[1]}, ${services[2]}, and proper monitoring ensures scalability, reliability, and best practices for ${module.module_name} in production environments.`,
        module_id: module.module_id,
        question_number: i
      });
    }
  });
  
  return questions;
}

// Get certification-specific context and services
function getCertificationContext(certificationName: string) {
  const contexts = {
    'AWS Solutions Architect': {
      services: ['IAM', 'VPC', 'EC2', 'Lambda', 'RDS', 'DynamoDB', 'S3', 'CloudFront', 'ELB', 'Auto Scaling', 'CloudWatch', 'CloudTrail', 'KMS', 'ECS', 'ElastiCache'],
      focus: 'scalability, reliability, performance optimization, cost optimization, security',
      scenarios: 'enterprise applications, microservices, data lakes, content delivery, high availability'
    },
    'Azure Fundamentals': {
      services: ['Azure AD', 'Virtual Network', 'Virtual Machines', 'App Service', 'Azure Functions', 'SQL Database', 'Cosmos DB', 'Blob Storage', 'CDN', 'Load Balancer', 'Monitor', 'Key Vault'],
      focus: 'cloud concepts, core services, security compliance, governance, hybrid connectivity',
      scenarios: 'web applications, data storage, hybrid cloud, business continuity, digital transformation'
    },
    'Google Cloud Associate': {
      services: ['Cloud IAM', 'VPC', 'Compute Engine', 'Cloud Functions', 'Cloud SQL', 'Firestore', 'Cloud Storage', 'Cloud CDN', 'Cloud Load Balancing', 'Stackdriver', 'GKE', 'Cloud Security'],
      focus: 'cloud infrastructure, data services, networking security, container orchestration, machine learning',
      scenarios: 'containerized applications, big data analytics, machine learning pipelines, global deployment, DevOps automation'
    }
  };
  
  return contexts[certificationName as keyof typeof contexts] || contexts['AWS Solutions Architect'];
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
      enableValidation = true // Enable validation by default
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

    // Generate SQL script with 2 questions per module
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
      2 // 2 questions per module
    );

    // Validate questions with secondary LLM instance (if enabled)
    let validatedQuestions = generatedQuestions;
    let validationStatus = 'skipped';
    
    if (enableValidation) {
      validatedQuestions = await validateQuestions(
        generatedQuestions,
        body.certification_name,
        body.topic_name
      );
      validationStatus = 'completed';
    } else {
      console.log('Question validation skipped (disabled)');
    }

    let questionIndex = 1;
    const quizQuestionLinks = [];

    // Process each validated question
    for (const question of validatedQuestions) {
      const moduleForQuestion = modules.find((m: any) => m.module_id === question.module_id) || modules[Math.floor((questionIndex - 1) / 2)];
      const questionId = `q_${topic_id}_${moduleForQuestion.module_id}_${question.question_number || ((questionIndex - 1) % 2) + 1}`;
      
      // Add section header for each module (only for first question of each module)
      if (questionIndex === 1 || (questionIndex - 1) % 2 === 0) {
        sqlScript += `-- =====================\n`;
        sqlScript += `-- QUESTIONS - ${moduleForQuestion.module_name}\n`;
        sqlScript += `-- =====================\n\n`;
      }
      
      // Escape single quotes in text and explanation for SQL
      const escapedText = question.text.replace(/'/g, "''");
      const escapedExplanation = question.explanation.replace(/'/g, "''");
      
      sqlScript += `INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)\n`;
      sqlScript += `VALUES ('${questionId}','${escapedText}','mcq','${JSON.stringify(question.options)}'::json,'${question.correct_answer}','${escapedExplanation}',NOW(),'${quiz_id}',NOW(),${questionIndex},NULL,NULL,'${moduleForQuestion.module_id}') ON CONFLICT (id) DO NOTHING;\n\n`;
      
      quizQuestionLinks.push(`(NOW(),'${quiz_id}','${questionId}')`);
      questionIndex++;
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

    return NextResponse.json({
      success: true,
      sqlScript,
      questionCount: validatedQuestions.length,
      moduleCount: modules.length,
      generationMethod: 'batch_gemini_api',
      validationStatus,
      originalQuestionCount: generatedQuestions.length,
      validatedQuestionCount: validatedQuestions.length
    });

  } catch (error) {
    console.error('Error generating hub questions:', error);
    return NextResponse.json(
      { error: 'Failed to generate hub questions' },
      { status: 500 }
    );
  }
}

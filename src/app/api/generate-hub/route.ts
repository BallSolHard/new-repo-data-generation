import { NextRequest, NextResponse } from 'next/server';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { createClient } from '@supabase/supabase-js';
import { createValidationPrompt, createQuestionGenerationPrompt } from './prompts';
import type { GeneratedQuestion, QuestionGenerationParams } from './types';

// Initialize Gemini client
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');

// Primary model for question generation (maximum creativity and diversity)
const model = genAI.getGenerativeModel({ 
  model: "gemini-2.5-flash", // Using Gemini 2.5 Flash
  generationConfig: {
    temperature: 1.0,        // Maximum temperature for creativity and diversity
    topP: 0.95,             // Very broad nucleus sampling for maximum variety  
    topK: 60,               // Consider more tokens for variety
    maxOutputTokens: 8192,  // Allow longer responses
    candidateCount: 1,      // Single candidate for consistency
  }
});

// Validation model (more conservative for accurate validation)
const validationModel = genAI.getGenerativeModel({ 
  model: "gemini-2.5-flash",
  generationConfig: {
    temperature: 0.3,        // Lower temperature for more focused validation
    topP: 0.6,              // More focused sampling for validation
    topK: 20,               // Narrower token consideration for consistency
    maxOutputTokens: 2048,  // Shorter responses for validation
  }
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
      const validationResult = await validationModel.generateContent(validationPrompt);
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
            if (typeof validation.correct_answer_index === 'object' && validation.correct_answer_index !== null && 'left' in validation.correct_answer_index && 'right' in validation.correct_answer_index) {
              // Matching question format - validator provided object with left and right arrays
              const matchingResponse = validation.correct_answer_index as {left: number[], right: number[]};
              if (Array.isArray(matchingResponse.left) && Array.isArray(matchingResponse.right)) {
                question.new_correct_answer = JSON.stringify(matchingResponse);
                
                // Create human-readable explanation of correct matches
                if (question.pairs) {
                  const correctMatches = matchingResponse.left
                    .map((leftIdx: number, position: number) => {
                      const rightIdx = matchingResponse.right[position];
                      return `${question.pairs!.left[leftIdx]} → ${question.pairs!.right[rightIdx]}`;
                    })
                    .join(', ');
                  question.new_explanation = `${validation.validation_notes || ''} Correct matches should be: ${correctMatches}`;
                } else {
                  question.new_explanation = `${validation.validation_notes || ''} Corrected matching provided`;
                }
              } else {
                question.new_explanation = `${validation.validation_notes || ''} (Invalid matching format provided)`;
              }
            } else if (Array.isArray(validation.correct_answer_index)) {
              // Multiple select format - validator provided array of correct indices
              const validIndices = validation.correct_answer_index.filter((idx: any) => 
                typeof idx === 'number' && idx >= 0 && Array.isArray(question.options) && idx < question.options.length
              );
              
              if (validIndices.length > 0) {
                question.new_correct_answer = JSON.stringify(validIndices);
                
                // Create human-readable explanation of correct answers
                if (Array.isArray(question.options)) {
                  const correctOptions = validIndices
                    .map((index: number) => `${String.fromCharCode(65 + index)}) ${(question.options as string[])[index]}`)
                    .join(', ');
                  question.new_explanation = `${validation.validation_notes || ''} Correct answers should be: ${correctOptions}`;
                } else {
                  question.new_explanation = `${validation.validation_notes || ''} Corrected answers provided`;
                }
              } else {
                question.new_explanation = `${validation.validation_notes || ''} (Invalid suggested indices provided)`;
              }
            } else if (typeof validation.correct_answer_index === 'number') {
              // Single answer format
              const idx = validation.correct_answer_index;
              if (Array.isArray(question.options) && idx >= 0 && idx < question.options.length) {
                question.new_correct_answer = `{${idx}}`;
                const correctOption = `${String.fromCharCode(65 + idx)}) ${(question.options as string[])[idx]}`;
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
  questionType: string = "mcq",
  patternKey?: string
): Promise<GeneratedQuestion[]> {
  
  // Define question types for variety - different styles/formats of questions
  const questionTypes = questionType === 'matching' ? [
    'term-definition',      // Match terms with their definitions
    'service-feature',      // Match services with their key features
    'concept-application',  // Match concepts with real-world applications
    'tool-purpose',         // Match tools with their primary purposes
    'architecture-component', // Match architecture patterns with components
    'protocol-function',    // Match protocols with their functions
    'technology-benefit',   // Match technologies with their benefits
    'role-responsibility',  // Match roles with their responsibilities
    'metric-measurement',   // Match metrics with what they measure
    'pattern-use-case'      // Match patterns with appropriate use cases
  ] : questionType === 'ordering' ? [
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
  let prompt = createQuestionGenerationPrompt({
    modules,
    topicName,
    topicDescription,
    certificationName,
    questionsPerModule,
    questionTypes,
    questionType
  });
  
  // Add dynamic variety and randomization instructions
  prompt += generateVarietyInstructions(questionType, modules);
  
  // Add pattern avoidance instructions if pattern key is provided
  if (patternKey) {
    prompt += getAvoidanceInstructions(patternKey);
  }
  
  // Add specific constraints for matching questions to ensure concise text
  if (questionType === 'matching') {
    prompt += `\n\nCRITICAL MATCHING QUESTION CONSTRAINTS:
- LEFT items: Maximum 3 words (e.g., "API Gateway", "Lambda Function", "DynamoDB")  
- RIGHT items: Maximum 8 words, must fit on 2 lines when displayed (e.g., "Serverless compute service", "HTTP request routing", "NoSQL database service")
- NO long explanations in pairs - keep descriptions brief and clear
- Examples of GOOD right items: "Manages user authentication", "Stores application data", "Routes HTTP requests"
- Examples of BAD right items: "A comprehensive service that provides robust authentication and authorization capabilities for applications", "Database service that offers high performance and scalability for modern applications"
- Each right item should be a concise phrase that clearly identifies the left item`;
  }
  
  // Add JSON format enforcement
  prompt += `\n\nCRITICAL JSON FORMAT REQUIREMENTS:
🚨 MANDATORY: Return ONLY a valid JSON array - no markdown, no explanations, no comments
🚨 ENSURE: Every question object is complete with ALL required fields
🚨 VALIDATE: Each question must have proper closing brackets and commas
🚨 DOUBLE-CHECK: The entire response must be valid JSON that can be parsed

REQUIRED JSON STRUCTURE - Every question MUST have:
- "module_id": string
- "question_number": number  
- "text": string
- "options": array or object
- "correct_answer": appropriate type for question type
- "explanation": string
${questionType === 'matching' ? '- "pairs": object with left/right arrays\n- "matches": object with left/right arrays' : ''}

⚠️ CRITICAL: If you cannot complete a question properly, do not include it in the response.
✅ VALIDATION: Before sending, verify the JSON is complete and parseable.`;
  
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
      console.error('Failed to parse text (first 500 chars):', cleanedText.substring(0, 500));
      
      // Enhanced recovery: Try to fix common JSON issues
      try {
        let fixedText = cleanedText;
        
        // Step 1: Ensure it's a proper array
        if (!fixedText.startsWith('[')) {
          fixedText = '[' + fixedText;
        }
        
        // Step 2: Handle incomplete JSON objects - find the last complete object
        const objectMatches = fixedText.match(/\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}/g);
        
        if (objectMatches && objectMatches.length > 0) {
          // Reconstruct array with complete objects only
          const completeObjects = [];
          
          for (const match of objectMatches) {
            try {
              const obj = JSON.parse(match);
              // Validate required fields based on question type
              if (obj.text && obj.options && (obj.correct_answer !== undefined || obj.pairs)) {
                completeObjects.push(obj);
              }
            } catch (objError) {
              console.log('Skipping malformed object:', match.substring(0, 100) + '...');
            }
          }
          
          if (completeObjects.length > 0) {
            questionsData = completeObjects;
            console.log(`Recovered ${completeObjects.length} valid questions from malformed JSON`);
          } else {
            throw new Error('No valid question objects found in response');
          }
        } else {
          // Step 3: Try to fix the JSON by adding missing closing brackets/commas
          const bracketCount = (fixedText.match(/\{/g) || []).length - (fixedText.match(/\}/g) || []).length;
          const squareBracketCount = (fixedText.match(/\[/g) || []).length - (fixedText.match(/\]/g) || []).length;
          
          // Add missing closing brackets
          for (let i = 0; i < bracketCount; i++) {
            fixedText += '}';
          }
          for (let i = 0; i < squareBracketCount; i++) {
            fixedText += ']';
          }
          
          // Try to fix incomplete last property (common issue)
          if (fixedText.includes('"correct_answer": [') && !fixedText.includes('"correct_answer": []')) {
            // Look for incomplete array in correct_answer
            const lastCorrectAnswer = fixedText.lastIndexOf('"correct_answer": [');
            if (lastCorrectAnswer !== -1) {
              const afterCorrectAnswer = fixedText.substring(lastCorrectAnswer);
              if (!afterCorrectAnswer.includes(']')) {
                // Find the partial array and close it
                const arrayStart = afterCorrectAnswer.indexOf('[') + 1;
                const partialContent = afterCorrectAnswer.substring(arrayStart);
                const numbers = partialContent.match(/\d+/g);
                
                if (numbers && numbers.length > 0) {
                  const beforeArray = fixedText.substring(0, lastCorrectAnswer);
                  const validNumbers = numbers.slice(0, 4); // Take first 4 numbers max
                  fixedText = beforeArray + `"correct_answer": [${validNumbers.join(', ')}]` + 
                             (fixedText.includes('"explanation"') ? '' : ', "explanation": "Generated explanation"') + '}]';
                }
              }
            }
          }
          
          console.log('Attempting to parse fixed JSON (first 200 chars):', fixedText.substring(0, 200));
          questionsData = JSON.parse(fixedText);
        }
        
      } catch (recoveryError) {
        console.error('Recovery attempt failed:', recoveryError);
        console.error('Original error:', parseError);
        
        // Final fallback: Generate minimal valid structure with available data
        console.log('Attempting emergency fallback question generation...');
        
        try {
          const fallbackQuestions = [];
          const moduleCount = modules.length;
          const totalNeeded = moduleCount * questionsPerModule;
          
          for (let i = 0; i < totalNeeded; i++) {
            const moduleIndex = Math.floor(i / questionsPerModule);
            const currentModule = modules[moduleIndex] || modules[0];
            
            const fallbackQuestion = {
              module_id: currentModule.module_id,
              question_number: (i % questionsPerModule) + 1,
              text: `[FALLBACK] Complex ${questionType} question for ${currentModule.module_name}. This question needs manual review due to AI generation issues.`,
              options: questionType === 'matching' 
                ? { "A": "Concept 1", "B": "Concept 2", "C": "Concept 3" }
                : ["Option A (needs review)", "Option B (needs review)", "Option C (needs review)", "Option D (needs review)"],
              correct_answer: questionType === 'matching' 
                ? null 
                : questionType === 'multiple' 
                  ? [0, 1] 
                  : questionType === 'ordering'
                    ? [0, 1, 2, 3]
                    : "{0}",
              explanation: `[FALLBACK] This question was generated as a fallback due to JSON parsing issues. Please review and replace with appropriate content.`,
              ...(questionType === 'matching' ? {
                pairs: { left: ["Term 1", "Term 2", "Term 3"], right: ["Definition 1", "Definition 2", "Definition 3"] },
                matches: { left: [0, 1, 2], right: [0, 1, 2] }
              } : {})
            };
            
            fallbackQuestions.push(fallbackQuestion);
          }
          
          console.log(`Generated ${fallbackQuestions.length} fallback questions`);
          questionsData = fallbackQuestions;
          
        } catch (fallbackError) {
          throw new Error(`Complete generation failure. Original: ${parseError instanceof Error ? parseError.message : String(parseError)}. Recovery: ${recoveryError instanceof Error ? recoveryError.message : String(recoveryError)}. Fallback: ${fallbackError instanceof Error ? fallbackError.message : String(fallbackError)}`);
        }
      }
    }
    
    // Validate and return structured response
    if (Array.isArray(questionsData)) {
      return questionsData.map((questionData, index) => {
        // Handle correct_answer based on question type
        let correct_answer;
        let pairs = undefined;
        let matches = undefined;
        let options;
        
        if (questionType === "matching") {
          // For matching questions, correct_answer should be null
          correct_answer = null;
          pairs = questionData.pairs || {
            left: ["Term 1", "Term 2", "Term 3"],
            right: ["Definition 1", "Definition 2", "Definition 3"]
          };
          matches = questionData.matches || {
            left: [0, 1, 2],
            right: [0, 1, 2]
          };
          options = questionData.options || {
            "A": pairs.left[0],
            "B": pairs.left[1], 
            "C": pairs.left[2]
          };
        } else if (questionType === "ordering") {
          // For ordering, expect array format representing the correct sequence
          if (Array.isArray(questionData.correct_answer)) {
            correct_answer = questionData.correct_answer; // Keep as array for internal processing
          } else {
            // ERROR: Invalid correct_answer for ordering - log and mark for review
            console.error(`Invalid correct_answer for ordering question ${index + 1}:`, questionData.correct_answer);
            correct_answer = null; // Mark as invalid - will be caught in validation
          }
          options = questionData.options;
        } else if (questionType === "multiple") {
          // For multiple select, expect array format - keep as array for SQL conversion
          if (Array.isArray(questionData.correct_answer)) {
            correct_answer = questionData.correct_answer; // Keep as array for PostgreSQL format conversion
          } else {
            // ERROR: Invalid correct_answer for multiple select - log and mark for review
            console.error(`Invalid correct_answer for multiple select question ${index + 1}:`, questionData.correct_answer);
            correct_answer = null; // Mark as invalid - will be caught in validation
          }
          options = questionData.options;
        } else {
          // For MCQ, use string format
          if (questionData.correct_answer) {
            correct_answer = questionData.correct_answer;
          } else {
            // ERROR: Missing correct_answer for MCQ - log and mark for review
            console.error(`Missing correct_answer for MCQ question ${index + 1}:`, questionData);
            correct_answer = null; // Mark as invalid - will be caught in validation
          }
          options = questionData.options;
        }

        const baseQuestion = {
          text: questionData.text || `Generated question ${index + 1}`,
          correct_answer: correct_answer,
          explanation: questionData.explanation || `Professional implementation addresses the requirements effectively.`,
          type: questionType as 'mcq' | 'multiple' | 'ordering' | 'matching',
          module_id: questionData.module_id || modules[Math.floor(index / questionsPerModule)]?.module_id,
          question_number: questionData.question_number || ((index % questionsPerModule) + 1)
        };

        if (questionType === "matching") {
          return {
            ...baseQuestion,
            options: options,
            pairs: pairs,
            matches: matches
          };
        } else {
          // Validate options for non-matching questions
          let validOptions;
          if (Array.isArray(options) && options.length >= 2) {
            validOptions = options;
          } else {
            // ERROR: Invalid or insufficient options - log and create placeholder
            console.error(`Invalid options for question ${index + 1}:`, options);
            validOptions = [
              `[INVALID] Generated option A - requires manual review`,
              `[INVALID] Generated option B - requires manual review`,
              `[INVALID] Generated option C - requires manual review`,
              `[INVALID] Generated option D - requires manual review`
            ];
          }
          
          return {
            ...baseQuestion,
            options: validOptions
          };
        }
      });
    } else {
      throw new Error('Invalid response format from Gemini');
    }
    
  } catch (error) {
    console.error('Error generating questions with Gemini:', error);
    return [];
  }
}

// Function to generate dynamic variety instructions for question uniqueness
function generateVarietyInstructions(questionType: string, modules: any[]): string {
  const timestamp = Date.now();
  const randomSeed = Math.floor(Math.random() * 1000000);
  
  // Dynamic variety approaches for each question type (COMPLEX scenarios only)
  const varietyApproaches = {
    matching: [
      "Match complex business scenarios to optimal architectural solutions with trade-off analysis",
      "Connect multi-constraint problems to specific implementation strategies requiring expertise", 
      "Pair disaster recovery scenarios with appropriate resilience patterns considering RTO/RPO",
      "Match compliance requirements with technical implementation approaches and their limitations",
      "Link performance bottleneck symptoms to root cause analysis and resolution strategies",
      "Associate cost optimization scenarios with specific techniques considering business impact",
      "Match security incident types to appropriate response strategies and preventive measures",
      "Connect scalability challenges to architectural patterns considering team size and expertise"
    ],
    ordering: [
      "Sequence complex disaster recovery procedures with multiple failure scenarios and dependencies",
      "Order multi-team coordination steps for critical system migrations with rollback considerations", 
      "Arrange incident response procedures for cascading failures across multiple services",
      "Sequence performance optimization phases considering business continuity and user impact",
      "Order security breach containment steps with evidence preservation and communication protocols",
      "Arrange complex deployment sequences with feature flags, canary releases, and rollback triggers",
      "Sequence cost optimization initiatives balancing immediate savings with long-term architectural debt",
      "Order compliance audit remediation steps considering regulatory deadlines and business operations"
    ],
    multiple: [
      "Identify all factors that must be considered when migrating legacy systems with zero downtime",
      "Select all architectural decisions required for handling unpredictable traffic spikes during critical events",
      "Choose all security measures necessary for multi-tenant SaaS applications with enterprise clients", 
      "Identify all optimization strategies that balance cost, performance, and reliability for startups scaling rapidly",
      "Select all monitoring approaches required for detecting and preventing cascading failures in microservices",
      "Choose all deployment strategies that minimize risk while maintaining continuous delivery for regulated industries",
      "Identify all compliance requirements that affect technical architecture for global healthcare applications",
      "Select all disaster recovery components necessary for achieving 99.99% uptime with geographic redundancy"
    ],
    mcq: [
      "Analyze complex trade-offs between competing architectural decisions under strict constraints",
      "Evaluate optimal approaches for handling edge cases that challenge conventional best practices",
      "Determine most appropriate solutions when standard recommendations conflict with business requirements", 
      "Assess critical decisions for systems experiencing unexpected scaling challenges beyond typical patterns",
      "Choose optimal strategies for legacy system modernization while maintaining business continuity",
      "Identify best approaches for cost optimization that don't compromise security or performance requirements",
      "Evaluate most effective incident response strategies for complex distributed system failures",
      "Determine optimal architectural patterns for handling compliance requirements in global multi-region deployments"
    ]
  };

  // Select random approach based on timestamp
  const approaches = varietyApproaches[questionType as keyof typeof varietyApproaches] || varietyApproaches.mcq;
  const selectedApproach = approaches[Math.floor((timestamp + randomSeed) % approaches.length)];
  
  // Generate unique perspective instructions
  const perspectiveInstructions = [
    "Think from a solutions architect perspective",
    "Consider a DevOps engineer's viewpoint", 
    "Focus on a security specialist's concerns",
    "Approach from a performance optimization angle",
    "Consider cost management priorities",
    "Think about compliance and governance",
    "Focus on scalability and reliability",
    "Consider developer experience aspects"
  ];
  
  const selectedPerspective = perspectiveInstructions[Math.floor((randomSeed) % perspectiveInstructions.length)];
  
  // Module-specific variety prompts
  const moduleTopics = modules.map(m => m.module_name).join(", ");
  
  return `\n\n🚨 EXTREME UNIQUENESS & COMPLEXITY REQUIREMENTS (Seed: ${randomSeed}):
🚫 ABSOLUTELY FORBIDDEN: Simple, straightforward, or obvious questions
🚫 NEVER REPEAT: Similar scenarios, patterns, or question structures from any previous generation

🎯 MANDATORY APPROACH FOR THIS GENERATION: ${selectedApproach}
🧠 REQUIRED PERSPECTIVE: ${selectedPerspective}
📋 MODULE CONTEXT: Focus on different aspects of: ${moduleTopics}

🔥 COMPLEXITY REQUIREMENTS:
- Questions must require MULTI-STEP reasoning and deep understanding
- NO straightforward "What is X?" or "Which service does Y?" questions
- Create SCENARIO-BASED questions with real-world constraints and trade-offs
- Include multiple variables that affect the decision-making process
- Force candidates to analyze, compare, and synthesize information

${questionType === 'matching' ? `
🔗 MATCHING COMPLEXITY REQUIREMENTS:
- NO simple term-to-definition matches
- Create COMPLEX scenario-based matching requiring deep understanding
- Match CONSTRAINTS to SOLUTIONS, not basic concepts to descriptions
- Include business context: "Given scenario X with constraints Y, match the optimal approach"
- Example: Match "High-traffic e-commerce during Black Friday with 99.99% uptime requirement" → "Multi-AZ Auto Scaling with Reserved Capacity"
- Use UNEXPECTED relationships that require professional judgment
- Avoid obvious service-to-feature mappings
- Create matches that involve TRADE-OFFS and decision-making
` : questionType === 'ordering' ? `
📋 ORDERING COMPLEXITY REQUIREMENTS:
- NO simple linear procedures or obvious sequences
- Create CONDITIONAL sequences where order depends on specific constraints
- Include BRANCHING scenarios: "If condition X, then steps A,B,C; if condition Y, then steps D,E,F"
- Focus on TROUBLESHOOTING sequences with multiple possible failure points
- Example: "Order these disaster recovery steps when primary region fails AND data consistency is critical"
- Include PARALLEL processes that must be coordinated
- Create sequences involving ROLLBACK considerations and risk assessment
- Avoid straightforward deployment or configuration steps
` : questionType === 'multiple' ? `
✅ MULTIPLE SELECT COMPLEXITY REQUIREMENTS:
- NO simple "select all features" questions
- Create scenarios requiring ANALYSIS of multiple constraints simultaneously
- Include questions with INTERDEPENDENT factors: "Given constraints A, B, C, which approaches satisfy ALL requirements?"
- Focus on TRADE-OFF analysis: "Which options provide the OPTIMAL balance between cost, performance, and security?"
- Example: "For a startup with limited budget, strict compliance needs, and rapid scaling requirements, select ALL viable approaches"
- Include CONDITIONAL selections: "Which options are valid ONLY if certain prerequisites are met?"
- Avoid obvious feature lists or benefit compilations
` : `
🎯 MCQ COMPLEXITY REQUIREMENTS:
- NO straightforward knowledge recall questions
- Create ANALYTICAL scenarios requiring synthesis of multiple concepts
- Include CONSTRAINT-BASED decision making with competing priorities
- Focus on EDGE CASES and nuanced situations where best practices conflict
- Example: "Given a legacy system with security vulnerabilities, budget constraints, and zero-downtime requirements, what is the MOST appropriate migration strategy?"
- Include COMPARATIVE analysis between seemingly similar solutions
- Create scenarios with HIDDEN complexity or non-obvious considerations
- Avoid simple "which service" or "what feature" questions
`}

🚨 CRITICAL UNIQUENESS & COMPLEXITY RULES:
❌ ABSOLUTELY FORBIDDEN:
  - Simple definition or explanation questions
  - Straightforward "which service" or "what feature" questions  
  - Basic concept matching without complex scenarios
  - Linear procedures without conditional logic
  - Obvious multiple choice answers
  - Questions answerable without deep expertise

❌ NEVER REPEAT:
  - Similar business scenarios or industry contexts
  - Identical technical service combinations
  - Same phrasing patterns or question structures  
  - Similar constraint or requirement combinations
  - Comparable complexity levels or analytical approaches

✅ MANDATORY REQUIREMENTS:
  - Every question must require MULTI-STEP analytical thinking
  - Include CONFLICTING requirements that need balancing
  - Create scenarios with HIDDEN complexity or non-obvious considerations
  - Force candidates to SYNTHESIZE knowledge from multiple domains
  - Include REAL-WORLD constraints (budget, time, compliance, legacy systems)
  - Require understanding of TRADE-OFFS and business impact
  - Test PROFESSIONAL JUDGMENT, not just technical knowledge

🎯 COMPLEXITY VALIDATION:
Before finalizing each question, ask: "Would a junior developer easily guess this answer, or does it require senior-level analysis and decision-making skills?"
If the answer suggests junior-level difficulty, COMPLETELY REWRITE the question.

RANDOMIZATION DIRECTIVE: Use timestamp ${timestamp} and seed ${randomSeed} to ensure different generation patterns.`;
}

// Simple session-based tracking for question uniqueness (can be enhanced with database storage)
const questionPatternCache = new Map<string, Set<string>>();

function generatePatternHash(questionType: string, modules: any[], questionsPerModule: number): string {
  const moduleIds = modules.map(m => m.module_id).sort().join('|');
  return `${questionType}_${moduleIds}_${questionsPerModule}`;
}

function addQuestionPatterns(patternKey: string, questions: GeneratedQuestion[]): void {
  if (!questionPatternCache.has(patternKey)) {
    questionPatternCache.set(patternKey, new Set());
  }
  
  const patterns = questionPatternCache.get(patternKey)!;
  
  questions.forEach(q => {
    // Create multiple pattern signatures for comprehensive avoidance
    const textLower = q.text.toLowerCase();
    
    // 1. Opening phrase pattern (first 8 words)
    const openingWords = textLower.split(' ').slice(0, 8).join(' ');
    patterns.add(`opening:${openingWords}`);
    
    // 2. Key concept extraction (look for technical terms)
    const techTerms = textLower.match(/\b(?:aws|lambda|api|gateway|s3|ec2|rds|vpc|iam|cloudformation|terraform|kubernetes|docker|microservices|serverless)\w*\b/g) || [];
    const conceptSignature = techTerms.slice(0, 3).join('|');
    if (conceptSignature) patterns.add(`concepts:${conceptSignature}`);
    
    // 3. Question structure pattern
    const questionStructure = textLower.includes('which') ? 'which' :
                            textLower.includes('what') ? 'what' :
                            textLower.includes('how') ? 'how' :
                            textLower.includes('when') ? 'when' :
                            textLower.includes('match') ? 'match' :
                            textLower.includes('order') ? 'order' : 'other';
    patterns.add(`structure:${questionStructure}`);
    
    // 4. Options pattern for deeper comparison
    if (Array.isArray(q.options)) {
      const optionsWords = q.options.map(opt => 
        opt.toLowerCase().split(' ').slice(0, 3).join(' ')
      );
      patterns.add(`options:${optionsWords.join('|')}`);
    }
    
    // 5. Scenario complexity indicator
    const complexityIndicators = [
      'given', 'scenario', 'company', 'requirements', 'constraints', 'optimize',
      'compliance', 'budget', 'performance', 'security', 'scalability'
    ];
    const foundIndicators = complexityIndicators.filter(indicator => textLower.includes(indicator));
    if (foundIndicators.length > 0) {
      patterns.add(`scenario:${foundIndicators.slice(0, 2).join('|')}`);
    }
  });
  
  // Keep more patterns for stronger avoidance (max 100 per pattern type)
  if (patterns.size > 100) {
    const patternsArray = Array.from(patterns);
    patterns.clear();
    patternsArray.slice(-70).forEach(pattern => patterns.add(pattern)); // Keep last 70
  }
}

function getAvoidanceInstructions(patternKey: string): string {
  const patterns = questionPatternCache.get(patternKey);
  if (!patterns || patterns.size === 0) {
    return "\n🔄 FIRST GENERATION: Create diverse, complex, scenario-based questions. NO simple definitions!";
  }
  
  const recentPatterns = Array.from(patterns).slice(-20); // Last 20 patterns for better avoidance
  
  // Categorize patterns for specific avoidance
  const openingPatterns = recentPatterns.filter(p => p.startsWith('opening:')).map(p => p.substring(8));
  const conceptPatterns = recentPatterns.filter(p => p.startsWith('concepts:')).map(p => p.substring(9));
  const structurePatterns = recentPatterns.filter(p => p.startsWith('structure:')).map(p => p.substring(10));
  const scenarioPatterns = recentPatterns.filter(p => p.startsWith('scenario:')).map(p => p.substring(9));
  
  let avoidanceInstructions = "\n🚨 CRITICAL AVOIDANCE REQUIREMENTS - DO NOT REPEAT THESE PATTERNS:";
  
  if (openingPatterns.length > 0) {
    const uniqueOpenings = [...new Set(openingPatterns)].slice(0, 5);
    avoidanceInstructions += `\n🚫 FORBIDDEN OPENING PHRASES: ${uniqueOpenings.map(p => `"${p}"`).join(', ')}`;
  }
  
  if (conceptPatterns.length > 0) {
    const uniqueConcepts = [...new Set(conceptPatterns.flatMap(p => p.split('|')))].slice(0, 8);
    avoidanceInstructions += `\n🚫 OVERUSED CONCEPTS: Avoid focusing primarily on: ${uniqueConcepts.join(', ')}`;
  }
  
  if (structurePatterns.length > 0) {
    const uniqueStructures = [...new Set(structurePatterns)];
    avoidanceInstructions += `\n🚫 OVERUSED QUESTION TYPES: Avoid starting with: ${uniqueStructures.join(', ')} questions`;
  }
  
  if (scenarioPatterns.length > 0) {
    const uniqueScenarios = [...new Set(scenarioPatterns.flatMap(p => p.split('|')))].slice(0, 6);
    avoidanceInstructions += `\n🚫 OVERUSED SCENARIO ELEMENTS: Don't reuse: ${uniqueScenarios.join(', ')}`;
  }
  
  avoidanceInstructions += `\n\n✅ MANDATORY ALTERNATIVES:
- Use COMPLETELY different industries, company types, and business contexts
- Create NOVEL technical scenarios not seen in previous generations  
- Employ DIVERSE question structures and analytical approaches
- Introduce FRESH constraints, requirements, and edge cases
- Generate UNIQUE combinations of technologies and use cases
- Apply DIFFERENT perspectives (cost vs performance vs security vs compliance)
- Create UNPRECEDENTED complexity patterns that require deep thinking`;

  return avoidanceInstructions;
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

    // Generate pattern key for uniqueness tracking
    const patternKey = generatePatternHash(questionType, modules, questionsPerModule);
    
    // Generate all questions in a single API call
    const generatedQuestions = await generateAllQuestions(
      modules,
      body.topic_name,
      body.topic_description,
      body.certification_name,
      questionsPerModule, // Use the user-selected number of questions per module
      questionType, // Pass the question type to the generation function
      patternKey // Pass pattern key for avoidance instructions
    );

    // Track generated patterns for future uniqueness
    addQuestionPatterns(patternKey, generatedQuestions);

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
      // Skip questions with invalid correct_answer (marked as null during processing)
      if (question.correct_answer === null && questionType !== 'matching') {
        console.error(`Skipping invalid question for module ${question.module_id}: ${question.text?.substring(0, 100)}...`);
        continue; // Skip this question entirely
      }
      
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
      let pairsValue = 'NULL';
      let matchesValue = 'NULL';
      
      if (questionType === 'matching') {
        // For matching questions, correct_answer is null, but we need pairs and matches
        correctAnswerValue = 'NULL';  // This will be used without quotes in SQL
        if (question.pairs) {
          pairsValue = `'${JSON.stringify(question.pairs).replace(/'/g, "''")}'::json`;
        }
        if (question.matches) {
          matchesValue = `'${JSON.stringify(question.matches).replace(/'/g, "''")}'::json`;
        }
      } else if (questionType === 'ordering' && Array.isArray(question.correct_answer)) {
        // For ordering questions, store as PostgreSQL array format
        correctAnswerValue = `{${question.correct_answer.join(',')}}`;
      } else if (Array.isArray(question.correct_answer)) {
        // For multiple select, convert array to PostgreSQL array format
        correctAnswerValue = `{${question.correct_answer.join(',')}}`;
      } else if (questionType === 'multiple' && typeof question.correct_answer === 'string') {
        // Handle JSON string format for multiple select questions (legacy compatibility)
        try {
          const parsed = JSON.parse(question.correct_answer);
          if (Array.isArray(parsed)) {
            correctAnswerValue = `{${parsed.join(',')}}`;
          } else {
            correctAnswerValue = '{0,1}'; // Default multiple select
          }
        } catch {
          correctAnswerValue = '{0,1}'; // Default multiple select
        }
      } else if (questionType === 'ordering' && typeof question.correct_answer === 'string') {
        // Handle string format for ordering questions (parse JSON and convert to PG array)
        try {
          const parsed = JSON.parse(question.correct_answer);
          correctAnswerValue = `{${parsed.join(',')}}`;
        } catch {
          correctAnswerValue = '{0,1,2,3}'; // Default ordering
        }
      } else if (question.correct_answer === null) {
        // Handle invalid questions that were marked as null during processing
        console.error(`Skipping question with invalid correct_answer: ${questionId}`);
        correctAnswerValue = 'NULL'; // This will create a SQL NULL value
      } else {
        // For single answer (mcq), use the string value
        correctAnswerValue = question.correct_answer;
      }
      
      sqlScript += `INSERT INTO public.question (id, text, type, options, correct_answer, explanation, created_at, quiz_id, modified_at, index, pairs, matches, module_id)\n`;
      
      // Handle NULL values properly - don't wrap NULL in quotes
      const correctAnswerSQL = correctAnswerValue === 'NULL' ? 'NULL' : `'${correctAnswerValue}'`;
      
      sqlScript += `VALUES ('${questionId}','${escapedText}','${questionType}','${escapedOptions}'::json,${correctAnswerSQL},'${escapedExplanation}',NOW(),'${quiz_id}',NOW(),${questionIndex},${pairsValue},${matchesValue},'${moduleForQuestion.module_id}') ON CONFLICT (id) DO NOTHING;\n\n`;
      
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

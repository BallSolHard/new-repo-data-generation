import type { QuestionGenerationParams } from '../types';

/**
 * Creates a generation prompt for producing multiple-choice questions for certification modules
 * @param params - Parameters containing modules, topic info, certification context, etc.
 * @returns A formatted prompt string for LLM question generation
 */
export function createQuestionGenerationPrompt(params: QuestionGenerationParams): string {
  const { modules, topicName, topicDescription, certificationName, questionsPerModule, questionTypes, questionType = "mcq" } = params;
  
  // Build modules information for the prompt
  const modulesInfo = modules.map((module, index) => {
    return `
Module ${index + 1}:
- ID: ${module.module_id}
- Name: ${module.module_name}
- Description: ${module.module_description || 'Not provided'}
- Content: ${module.module_content ? module.module_content.substring(0, 200) + '...' : 'Not provided'}`;
  }).join('\n');
  
  const totalQuestions = questionsPerModule * modules.length;
  const isMultipleSelect = questionType === "multiple";
  
  const formatExample = isMultipleSelect ? `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "Which AWS security practices should be implemented for production environments? (Select 2 options)",
    "options": ["Enable MFA for root account", "Use shared credentials", "Enable CloudTrail logging", "Disable encryption"],
    "correct_answer": [0, 2],
    "explanation": "MFA protects root account access and CloudTrail provides audit logging for compliance."
  }` : `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "What is the primary benefit of using AWS Lambda for serverless computing?",
    "options": ["Manual server management", "Automatic scaling and cost optimization", "Fixed pricing model", "Limited language support"],
    "correct_answer": "{1}",
    "explanation": "Lambda automatically scales and charges only for actual execution time."
  }`;

  const answerFormat = isMultipleSelect 
    ? "- For multiple select: use array format like [0,2] for options 1 and 3 (NO quotes, NO curly braces)"
    : "- For single answer: use \"{index}\" format like \"{2}\" for option 3";

  return `Generate ${totalQuestions} ${certificationName} exam questions as valid JSON array.

QUESTION TYPE: ${isMultipleSelect ? "Multiple Select (choose all that apply)" : "Multiple Choice (single answer)"}

MODULES:
${modulesInfo}

CONTEXT: ${topicName}${topicDescription ? ` - ${topicDescription}` : ''}
CERTIFICATION: ${certificationName}

FORMAT (JSON only, no markdown):
[${formatExample}
]

REQUIREMENTS:
- Exactly ${questionsPerModule} questions per module
- Question type: ${isMultipleSelect ? "Multiple Select" : "Multiple Choice"}
${isMultipleSelect ? "- Each question must have 2-3 correct answers out of 4 options" : ""}
${isMultipleSelect ? "- Question text must include \"(Select X options)\" where X is the number of correct answers" : ""}
- QUESTION LENGTH: Keep question text between 20-50 words maximum
- Use concise, clear language - avoid unnecessary words
- Be direct and specific - no filler words or redundant phrases
- Professional difficulty level - medium
- Base questions ONLY on the provided topic description and module descriptions/content
- Use specific details from module content to create relevant questions
- Mix question types: ${questionTypes.slice(0, 5).join(', ')}, etc.
- Proper JSON format with escaped quotes
${answerFormat}
- Return only the JSON array

Generate ${totalQuestions} questions:`;
}

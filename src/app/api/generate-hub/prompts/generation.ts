import type { QuestionGenerationParams } from '../types';

/**
 * Creates a generation prompt for producing multiple-choice questions for certification modules
 * @param params - Parameters containing modules, topic info, certification context, etc.
 * @returns A formatted prompt string for LLM question generation
 */
export function createQuestionGenerationPrompt(params: QuestionGenerationParams): string {
  const { modules, topicName, certificationName, questionsPerModule, certificationContext, questionTypes, questionType = "mcq" } = params;
  
  // Build modules information for the prompt
  const modulesInfo = modules.map((module, index) => {
    return `
Module ${index + 1}:
- ID: ${module.module_id}
- Name: ${module.module_name}
- Description: ${module.module_description || 'Not provided'}
- Content: ${module.module_content || 'Not provided'}`;
  }).join('\n');
  
  const totalQuestions = questionsPerModule * modules.length;
  const isMultipleSelect = questionType === "multiple";
  
  const formatExample = isMultipleSelect ? `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "Which of the following are best practices for AWS security? (Select 2 options)",
    "options": ["Enable MFA for root account", "Use shared credentials", "Enable CloudTrail logging", "Disable encryption"],
    "correct_answer": [0, 2],
    "explanation": "Options 1 and 3 are correct: MFA adds security for root account and CloudTrail provides audit logging."
  }` : `
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "Professional certification question",
    "options": ["Wrong option", "Wrong option", "Correct option", "Wrong option"],
    "correct_answer": "{2}",
    "explanation": "Why option 3 is correct"
  }`;

  const answerFormat = isMultipleSelect 
    ? "- For multiple select: use array format like [0,2] for options 1 and 3 (NO quotes, NO curly braces)"
    : "- For single answer: use \"{index}\" format like \"{2}\" for option 3";

  return `Generate ${totalQuestions} ${certificationName} exam questions as valid JSON array.

QUESTION TYPE: ${isMultipleSelect ? "Multiple Select (choose all that apply)" : "Multiple Choice (single answer)"}

MODULES:
${modulesInfo}

CONTEXT: ${topicName} - ${certificationContext.focus}
SERVICES: ${certificationContext.services.slice(0, 8).join(', ')}

FORMAT (JSON only, no markdown):
[${formatExample}
]

REQUIREMENTS:
- Exactly ${questionsPerModule} questions per module
- Question type: ${isMultipleSelect ? "Multiple Select" : "Multiple Choice"}
${isMultipleSelect ? "- Each question must have 2-3 correct answers out of 4 options" : ""}
${isMultipleSelect ? "- Question text must include \"(Select X options)\" where X is the number of correct answers" : ""}
- Professional difficulty level
- Real-world scenarios
- Mix question types: ${questionTypes.slice(0, 3).join(', ')}
- Proper JSON format with escaped quotes
${answerFormat}
- Return only the JSON array

Generate ${totalQuestions} questions:`;
}

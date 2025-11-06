import type { QuestionGenerationParams } from '../types';

/**
 * Creates a generation prompt for producing multiple-choice questions for certification modules
 * @param params - Parameters containing modules, topic info, certification context, etc.
 * @returns A formatted prompt string for LLM question generation
 */
export function createQuestionGenerationPrompt(params: QuestionGenerationParams): string {
  const { modules, topicName, certificationName, questionsPerModule, certificationContext, questionTypes } = params;
  
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
  
  return `Generate ${totalQuestions} ${certificationName} exam questions as valid JSON array.

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

Generate ${totalQuestions} questions:`;
}

import type { QuestionGenerationParams } from '../types';

/**
 * Creates specialized prompts for different question difficulty levels
 */
export class QuestionPromptTemplates {
  
  /**
   * Generate beginner-level questions focusing on basic concepts
   */
  static createBeginnerPrompt(params: QuestionGenerationParams): string {
    const { modules, topicName, certificationName, questionsPerModule, certificationContext } = params;
    
    const modulesInfo = modules.map((module, index) => 
      `Module ${index + 1}: ${module.module_name} - ${module.module_description || 'Basic concepts'}`
    ).join('\n');
    
    return `Generate ${questionsPerModule * modules.length} BEGINNER-level ${certificationName} questions as JSON array.

MODULES:
${modulesInfo}

FOCUS: Basic concepts, definitions, and fundamental principles
DIFFICULTY: Entry-level certification candidates
QUESTION STYLE: Clear, straightforward, concept-based

FORMAT (JSON only):
[
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "What is the primary purpose of [concept]?",
    "options": ["Incorrect basic option", "Correct fundamental concept", "Incorrect alternative", "Incorrect complex option"],
    "correct_answer": "{1}",
    "explanation": "Simple explanation of why this is the correct fundamental concept"
  }
]

Generate ${questionsPerModule * modules.length} beginner questions:`;
  }
  
  /**
   * Generate scenario-based questions for practical application
   */
  static createScenarioPrompt(params: QuestionGenerationParams): string {
    const { modules, topicName, certificationName, questionsPerModule, certificationContext } = params;
    
    const modulesInfo = modules.map((module, index) => 
      `Module ${index + 1}: ${module.module_name}\nScenarios: ${certificationContext.focus}`
    ).join('\n\n');
    
    return `Generate ${questionsPerModule * modules.length} SCENARIO-BASED ${certificationName} questions as JSON array.

MODULES & SCENARIOS:
${modulesInfo}

FOCUS: Real-world business scenarios and practical implementations
STYLE: "A company needs to..." or "An architect must design..."
SERVICES: ${certificationContext.services.slice(0, 6).join(', ')}

FORMAT (JSON only):
[
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "A large e-commerce company needs to [specific business requirement]. Which approach would be most cost-effective and scalable?",
    "options": ["Basic manual approach", "Over-engineered solution", "Optimal cloud-native solution", "Legacy system approach"],
    "correct_answer": "{2}",
    "explanation": "This solution provides the best balance of cost, scalability, and maintainability because..."
  }
]

Generate ${questionsPerModule * modules.length} scenario questions:`;
  }
  
  /**
   * Generate troubleshooting questions for problem-solving skills
   */
  static createTroubleshootingPrompt(params: QuestionGenerationParams): string {
    const { modules, topicName, certificationName, questionsPerModule, certificationContext } = params;
    
    return `Generate ${questionsPerModule * modules.length} TROUBLESHOOTING ${certificationName} questions as JSON array.

FOCUS: Problem diagnosis, debugging, and resolution
CONTEXT: Systems experiencing issues, performance problems, or failures
SKILLS: Analytical thinking, systematic debugging, root cause analysis

FORMAT (JSON only):
[
  {
    "module_id": "exact_module_id_from_above", 
    "question_number": 1,
    "text": "Users report [specific issue]. After checking [initial findings], what should be the FIRST step to diagnose the root cause?",
    "options": ["Restart all services", "Check logs and metrics systematically", "Increase resource allocation", "Contact vendor support"],
    "correct_answer": "{1}",
    "explanation": "Systematic log and metric analysis is the proper first step because..."
  }
]

Generate ${questionsPerModule * modules.length} troubleshooting questions:`;
  }
}

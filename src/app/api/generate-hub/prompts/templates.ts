import type { QuestionGenerationParams } from "../types";

/**
 * Creates specialized prompts for different question difficulty levels
 */
export class QuestionPromptTemplates {
  /**
   * Generate beginner-level questions focusing on basic concepts
   */
  static createBeginnerPrompt(params: QuestionGenerationParams): string {
    const { modules, topicName, certificationName, questionsPerModule } =
      params;

    const modulesInfo = modules
      .map(
        (module, index) =>
          `Module ${index + 1}: ${module.module_name} - ${
            module.module_description || "Basic concepts"
          }`
      )
      .join("\n");

    const totalQuestions = questionsPerModule * modules.length;

    return `Generate ${totalQuestions} BEGINNER-level ${certificationName} questions as JSON array.

 MANDATORY RULE #1 - THE CORRECT ANSWER MUST NEVER BE THE LONGEST OPTION 
For EVERY question, make ONE WRONG answer the LONGEST 

Example - CORRECT format:
- Option A (WRONG - LONGEST): "Provides manual configuration with detailed setup procedures while ensuring all components are properly documented" (14 words)
- Option B (CORRECT - SHORT): "Enables automatic resource scaling" (4 words)
- Option C (WRONG): "Requires fixed capacity planning" (4 words)
- Option D (WRONG): "Disables monitoring features" (3 words)

MODULES:
${modulesInfo}

FOCUS: Basic concepts, definitions, and fundamental principles
DIFFICULTY: Entry-level certification candidates

FORMAT (JSON only):
[
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "What is the primary purpose of [concept]?",
    "options": ["Provides extensive manual configuration capabilities with comprehensive documentation requirements and detailed setup procedures for all components", "Enables simplified automatic management", "Requires legacy system compatibility only", "Supports basic functionality"],
    "correct_answer": "{1}",
    "explanation": "Simple explanation of why this is the correct fundamental concept"
  }
]

CORRECT ANSWER POSITION: Distribute evenly across {0}, {1}, {2}, {3}
REMEMBER: Verify each question has a WRONG answer as the LONGEST option.

Generate ${totalQuestions} beginner questions:`;
  }

  /**
   * Generate scenario-based questions for practical application
   */
  static createScenarioPrompt(params: QuestionGenerationParams): string {
    const { modules, topicName, certificationName, questionsPerModule } =
      params;

    const modulesInfo = modules
      .map((module, index) => `Module ${index + 1}: ${module.module_name}\n`)
      .join("\n\n");

    const totalQuestions = questionsPerModule * modules.length;

    return `Generate ${totalQuestions} SCENARIO-BASED ${certificationName} questions as JSON array.

 MANDATORY RULE #1 - THE CORRECT ANSWER MUST NEVER BE THE LONGEST OPTION 
For EVERY question, make ONE WRONG answer the LONGEST 

MODULES & SCENARIOS:
${modulesInfo}

FOCUS: Real-world business scenarios and practical implementations
STYLE: "A company needs to..." or "An architect must design..."

FORMAT (JSON only):
[
  {
    "module_id": "exact_module_id_from_above",
    "question_number": 1,
    "text": "A large e-commerce company needs to [specific business requirement]. Which approach would be most cost-effective and scalable?",
    "options": ["Implement comprehensive manual configuration approach while ensuring all system components are properly documented, tested, validated, and maintained according to enterprise standards", "Deploy over-engineered enterprise solution", "Use cloud-native architecture with auto-scaling", "Maintain legacy infrastructure only"],
    "correct_answer": "{2}",
    "explanation": "This solution provides the best balance of cost, scalability, and maintainability."
  }
]

CORRECT ANSWER POSITION: Distribute evenly across {0}, {1}, {2}, {3}
REMEMBER: Verify each question has a WRONG answer as the LONGEST option.

Generate ${totalQuestions} scenario questions:`;
  }

  /**
   * Generate troubleshooting questions for problem-solving skills
   */
  static createTroubleshootingPrompt(params: QuestionGenerationParams): string {
    const { modules, topicName, certificationName, questionsPerModule } =
      params;

    const totalQuestions = questionsPerModule * modules.length;

    return `Generate ${totalQuestions} TROUBLESHOOTING ${certificationName} questions as JSON array.

 MANDATORY RULE #1 - THE CORRECT ANSWER MUST NEVER BE THE LONGEST OPTION 
For EVERY question, make ONE WRONG answer the LONGEST

FOCUS: Problem diagnosis, debugging, and resolution
CONTEXT: Systems experiencing issues, performance problems, or failures
SKILLS: Analytical thinking, systematic debugging, root cause analysis

FORMAT (JSON only):
[
  {
    "module_id": "exact_module_id_from_above", 
    "question_number": 1,
    "text": "Users report [specific issue]. After checking [initial findings], what should be the FIRST step to diagnose the root cause?",
    "options": ["Restart all affected services immediately while documenting the current system state, notifying all stakeholders, and preparing rollback procedures in case of failure", "Check logs and metrics systematically", "Increase resource allocation across components", "Contact vendor support immediately"],
    "correct_answer": "{1}",
    "explanation": "Systematic log and metric analysis is the proper first step."
  }
]

CORRECT ANSWER POSITION: Distribute evenly across {0}, {1}, {2}, {3}
REMEMBER: Verify each question has a WRONG answer as the LONGEST option.

Generate ${totalQuestions} troubleshooting questions:`;
  }
}

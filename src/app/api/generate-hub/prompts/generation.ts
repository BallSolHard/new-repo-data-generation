import type { QuestionGenerationParams } from "../types";

/**
 * Creates a generation prompt for producing multiple-choice questions for certification modules
 * @param params - Parameters containing modules, topic info, certification context, etc.
 * @returns A formatted prompt string for LLM question generation
 */
export function createQuestionGenerationPrompt(
  params: QuestionGenerationParams
): string {
  const {
    modules,
    topicName,
    topicDescription,
    certificationName,
    questionsPerModule,
    questionTypes,
    questionType = "mcq",
    complexityLevel = "basic",
    isProfessionalOrSpecialty = false,
  } = params;

  const modulesInfo = modules
    .map((module, index) => {
      return `
Module ${index + 1}:
- ID: ${module.module_id}
- Name: ${module.module_name}
- Description: ${module.module_description || "Not provided"}
- Content: ${
        module.module_content
          ? module.module_content.substring(0, 500) + "..."
          : "Not provided"
      }`;
    })
    .join("\n");

  const totalQuestions = questionsPerModule * modules.length;
  const isMultipleSelect = questionType === "multiple";
  const isOrdering = questionType === "ordering";
  const isMatching = questionType === "matching";

  const answerFormat = isMatching
    ? "- For matching: use null for correct_answer, provide pairs and matches objects"
    : isOrdering
    ? "- For ordering: use array format [0,1,2,3] representing the correct sequence of all options"
    : isMultipleSelect
    ? "- For multiple select: use array format like [0,2] for options 1 and 3 (NO quotes, NO curly braces)"
    : '- For single answer: use "{index}" format like "{2}" for option 3';

  return `Generate ${totalQuestions} ${certificationName} exam questions as valid JSON array.

STOP! READ THIS FIRST!
${
  isProfessionalOrSpecialty
    ? `
FOR PROFESSIONAL/SPECIALTY CERTIFICATIONS:
NEVER MAKE CORRECT ANSWERS THE LONGEST OPTIONS!
DO NOT make correct answers verbose just because the scenario is complex!

REVERSE YOUR THINKING:
- Complex scenario = Complex question text (YES) 
- Complex scenario = Complex correct answers (NO!)
- Correct answer = Professional best practice (concise)
- Wrong answer = Overcomplicated amateur approach (verbose)
`
    : ""
}
MANDATORY RULE #1 - READ THIS FIRST
THE CORRECT ANSWER MUST NEVER BE THE LONGEST OPTION.
For EVERY question, you MUST make ONE of the WRONG answers the LONGEST option (at least 5-10 words longer than the correct answer).

QUESTION TYPE: ${
    isOrdering
      ? "Ordering (arrange options in correct sequence)"
      : isMultipleSelect
      ? "Multiple Select (choose all that apply)"
      : "Multiple Choice (single answer)"
  }

MODULES:${modulesInfo}

CONTEXT: ${topicName}${topicDescription ? ` - ${topicDescription}` : ""}
CERTIFICATION: ${certificationName}

JSON STRUCTURE (strict - no examples allowed):
${
  isMatching 
    ? `{
  "module_id": "exact_module_id_from_above",
  "question_number": 1,
  "text": "Match each term to its description.",
  "options": {
    "A": "Term 1",
    "B": "Term 2", 
    "C": "Term 3"
  },
  "pairs": {
    "left": ["API Gateway", "Lambda", "DynamoDB"],
    "right": ["Serverless compute", "HTTP API routing", "NoSQL database"]
  },
  "matches": {
    "left": [0, 1, 2],
    "right": [1, 0, 2]
  },
  "correct_answer": null,
  "explanation": "Brief explanation"
}`
    : `{
  "module_id": "exact_module_id_from_above",
  "question_number": 1,
  "text": "Your question text here...",
  "options": [
    "option A",
    "option B",
    "option C",
    "option D"
  ],
  "correct_answer": ${
    isOrdering 
      ? "[0, 1, 2, 3]" 
      : isMultipleSelect 
      ? "[0, 2]" 
      : '"{0}"'
  },
  "explanation": "Brief explanation"
}`
}

NOTICE: ${
    isMatching
      ? "For matching questions, create clear relationships between left and right items. Left items should be terms/concepts (1-3 words max), right items should be concise definitions/descriptions (maximum 10 words, ideally 1-2 lines when displayed)."
      : isOrdering 
      ? "For ordering questions, focus on logical sequence. Options should be clear, distinct steps or phases." 
      : "The longest option must be WRONG. Correct answers must be concise!"
  }

${
  isProfessionalOrSpecialty
    ? `
ADDITIONAL REQUIREMENTS:
- Exactly ${questionsPerModule} questions per module  
- Question type: ${
        isMatching
          ? "Matching"
          : isOrdering 
          ? "Ordering" 
          : isMultipleSelect 
          ? "Multiple Select" 
          : "Multiple Choice"
      }
${
        isMatching
          ? "- Each question must have 3-4 items to match\n- Question text must include 'Match each...' or similar phrasing\n- LEFT items: Use concise terms/concepts (1-3 words maximum)\n- RIGHT items: Use brief descriptions (6-10 words maximum, must fit in 2 lines when displayed)\n- Avoid long explanatory text in pairs - keep it short and clear\n- Provide correct matches in the matches object with left and right arrays"
          : isOrdering
          ? "- Each question must have 4 options that need to be arranged in correct sequence\n- Question text must include 'Order the following...' or similar phrasing\n- Options should be steps, phases, or items with a logical sequence\n- Correct answer is always [0,1,2,3] representing the proper order"
          : isMultipleSelect
          ? "- Each question must have 2-3 correct answers out of 4 options\n- Question text must include '(Select X options)' where X is the number of correct answers"
          : ""
      }

- QUESTION LENGTH: EXTREMELY LENGTHY questions (minimum 4-6 sentences, 80-150+ words)
- COMPLEXITY: Create ELABORATE enterprise-level scenarios with multiple variables and constraints
- SCENARIO DEPTH: Include detailed business contexts, compliance requirements, performance considerations
- TECHNICAL DEPTH: Use advanced terminology, architectural patterns, enterprise-level concepts
- AVOID: Simple definitions, straightforward procedures, or obvious answers
- FOCUS: Complex decision-making, troubleshooting multi-layered problems, strategic technical choices
- CONTEXT: Multi-paragraph scenarios requiring professional judgment
`
    : complexityLevel === "intermediate"
    ? `
- QUESTION LENGTH: Moderate length (2-3 sentences, 40-80 words)
- COMPLEXITY: Practical scenarios with clear implementation context
- FOCUS: Real-world application, configuration, and common use cases
- Use standard technical terminology with some advanced concepts
`
    : `
- QUESTION LENGTH: Keep question text concise (20-50 words maximum)
- COMPLEXITY: Clear, direct questions about fundamental concepts
- FOCUS: Basic principles, definitions, and simple procedures
- Use simple, clear language with minimal technical jargon
`
}
- Difficulty level: ${complexityLevel.toUpperCase()}

${
  isProfessionalOrSpecialty
    ? `PROFESSIONAL/SPECIALTY OPTION LENGTH STRATEGY:
- CORRECT answers: Direct professional solution (5-15 words max)
  Examples: "Use Amazon Bedrock with private endpoints", "Enable Provisioned Throughput", "Implement RAG with knowledge base"

- WRONG answers: Make at least ONE option much longer (20+ words) by adding:
  • Words like "comprehensive", "robust", "enterprise-grade", "fully managed"
  • Unnecessary steps: "and then manually verify each component"
  • Redundant qualifiers: "while ensuring full compliance across all regions"
  • Over-engineering: "deploy a custom multi-region orchestration layer with manual failover"`
    : `OPTION LENGTH STRATEGY:
- Correct answers: Keep concise, direct, and to the point
- Wrong answers: Make at least ONE option longer with unnecessary details, verbose language, or overcomplicated steps`
}

CORRECT ANSWER POSITION RANDOMIZATION:
- DISTRIBUTE correct answer positions EVENLY across 0, 1, 2, 3
- For ${totalQuestions} questions: aim for ~25% each index
- NEVER have more than 2 consecutive questions with same correct answer index

FINAL VERIFICATION CHECKLIST (apply to every question):
- Is one WRONG answer clearly the longest?
- Is the correct answer concise and professional?
- Does the longest option use unnecessary jargon or steps?
- Would a test-taker be tempted to pick the longest answer?

- Base questions ONLY on provided module content and topic
- Use real AWS service names and patterns accurately
- Mix question styles: ${questionTypes.slice(0, 5).join(", ")}, etc.
- Always escape quotes in JSON strings properly
${answerFormat}
- Return ONLY a valid JSON array of questions. No markdown, no explanation, no \`\`\`json blocks.

${
  isProfessionalOrSpecialty
    ? `
FINAL REMINDER:
- Correct = Short, confident, best practice
- Wrong = Long, hesitant, over-engineered, amateur
Think: "What would a senior architect choose vs. what would a junior overcomplicate?"
`
    : ""
}
Generate exactly ${totalQuestions} questions now:`;
}
// Hub Mode Prompt Template — Practice questions with flexible standards
// Used for generate-hub API to create varied practice questions with mix of definitions, applications, and scenarios

import type { ExamGuide, ExamDomain, ExamTask } from '@/lib/types/exam-guide';
import type { TierProfile } from '@/lib/types/tier';
import type { ModuleInput } from '@/lib/types/generation';

export interface HubPromptParams {
  examGuide: ExamGuide;
  tierProfile: TierProfile;
  totalQuestions: number;
  questionsPerModule: number;
  moduleSection: string;
  typeFormats: string;
  answerBiasRules: string;
  systemPrompt: string;
  tierBlock: string;
  modeBlock: string;
  examGuideSection: string;
  antiPatternInstructions: string;
  fewShotSection: string;
  serperContext?: string;
  selectedQuestionTypes?: string[];
}

export function buildHubPrompt(params: HubPromptParams): string {
  const {
    examGuide,
    tierProfile,
    totalQuestions,
    questionsPerModule,
    moduleSection,
    typeFormats,
    answerBiasRules,
    systemPrompt,
    tierBlock,
    modeBlock,
    examGuideSection,
    antiPatternInstructions,
    fewShotSection,
    serperContext,
    selectedQuestionTypes = ['mcq'],
  } = params;

  const definitionQuestionCount = Math.ceil(totalQuestions * 0.6);
  
  // Build type distribution instructions based on selected types
  const typeDistributionInstructions = buildTypeDistribution(selectedQuestionTypes, totalQuestions);

  return `${systemPrompt}

${tierBlock}

${modeBlock}

${examGuideSection}

${serperContext ? `═══════════════════════════════════════════════════════
EXTERNAL WEB/SEARCH CONTEXT — results from Serper API
═══════════════════════════════════════════════════════
${serperContext}

` : ''}${antiPatternInstructions}

${fewShotSection}

TASK: Generate exactly ${totalQuestions} ${examGuide.certificationName} exam questions as a valid JSON array.
Generate ${questionsPerModule} question(s) per module.
Question types to use: ${selectedQuestionTypes.join(', ')}

${typeDistributionInstructions}

⚠️ CRITICAL REQUIREMENT: Question Mix Distribution (60% Definition/Straightforward Focus)
   You MUST generate AT LEAST ${definitionQuestionCount} DEFINITION/STRAIGHTFORWARD questions (60% of total).
   These are service-based or terminology questions that are direct and practical.
   Definition questions are 6-30 words and ask "What is...", "Which service...", "What does... do?"
   
   GENERATION STRATEGY:
   1. Generate definition/straightforward questions FIRST (at least ${definitionQuestionCount} questions — 80% of total)
   2. Then generate application/scenario questions (UP TO 20% of total)
   
   For ${totalQuestions} total questions:
   - MINIMUM ${definitionQuestionCount} definition/straightforward questions (6-30 words)
   - MAXIMUM ${Math.ceil(totalQuestions * 0.2)} application/scenario questions (30-120 words)

${answerBiasRules}

═══════════════════════════════════════════════════════
QUESTION QUALITY STANDARDS (Practice Hub - Flexible)
═══════════════════════════════════════════════════════

STEM LENGTH — FLEXIBLE: Minimum 10 words, maximum ${tierProfile.stemWordRange[1]} words
  ✅ SHORT QUESTIONS (10-30 words): Definition and basic concept questions
  ✅ MEDIUM QUESTIONS (10-60 words): Single-service application questions
  ✅ LONG QUESTIONS (10-120 words): Multi-service scenario-based questions

COGNITIVE LEVELS — 60% DEFINITION + 40% APPLICATION:

  1️⃣ DEFINITION/STRAIGHTFORWARD (6-30 words) — 60% OF ALL QUESTIONS:
     ✅ "What is Amazon S3 primarily used for?"
     ✅ "Which AWS service provides managed relational databases?"
     ✅ "What does Amazon CloudWatch do?"
     ✅ "What is the primary purpose of Amazon SageMaker?"
     ✅ "Which service enables real-time streaming data processing?"
     ✅ "What does AWS Lambda automate?"
     ✅ "Which service is designed for serverless computing?"
     → CRITICAL: Generate these FIRST, aim for 60% of total questions
     → These test foundational service knowledge and are quick to answer
     → Focus on service capabilities, features, and use cases

  2️⃣ APPLICATION/SCENARIO (30-120 words) — UP TO 40% OF QUESTIONS:
     ✅ "A company needs to store 10TB of infrequently accessed data cost-effectively. Which combination of AWS services best meets this requirement?"
     ✅ "An e-commerce platform must process sensitive customer data with encryption and audit trails. Which architecture provides this with minimal operational overhead?"
     → Use these sparingly for practical problem-solving
     → Multi-service scenarios to test reasoning

DEFINITION QUESTION TEMPLATES (Use these patterns):
  
  SERVICE PURPOSE:
  ✅ "What is the primary purpose of [Service Name]?"
  ✅ "What does [Service Name] enable?"
  ✅ "Which AWS service is designed for [use case]?"
  
  SERVICE SELECTION:
  ✅ "Which service provides [capability]?"
  ✅ "Which AWS service offers [feature]?"
  
  SERVICE CHARACTERISTICS:
  ✅ "What type of service is [Service Name]?"
  ✅ "What does [Service Name] automate?"

FACTUAL ACCURACY — CRITICAL:
  - The correct_answer index MUST match the option your explanation defends
  - Verify AWS service capabilities before claiming them (e.g., Comprehend analyzes TEXT not AUDIO)
  - Count the index from 0: first option = {0}, second = {1}, third = {2}, fourth = {3}
  - Double-check before outputting — INDEX MISMATCHES cause instant rejection

DISTRACTORS:
  - All 4 options must be real AWS services that sound plausible
  - For DEFINITION questions: Use services from similar categories (e.g., all storage services)
  - For SCENARIO questions: Use anti-patterns to create realistic wrong answers
  - Each explanation must reference why wrong options fail

UNIQUENESS REQUIREMENTS:
  Each question must test a different scenario/concept.
  Do not reuse the same stem, the same set of distractors, or the same scenario twice.
  For practice hub, some variation in phrasing is acceptable if testing different concepts.

═══════════════════════════════════════════════════════
QUESTION TYPE GUIDELINES FOR HUB MODE
═══════════════════════════════════════════════════════

When generating questions, follow these guidelines based on selected types:

MCQ (Default, 60% Definition Focus):
  → Definition questions (6-30 words): "What is...", "Which service...", "What does..."
  → Scenario questions (30-120 words): Single-service selection with one clear constraint
  
MULTIPLE SELECT (when selected):
  → Test ability to identify MULTIPLE correct services/approaches
  → Include "(Select TWO.)" or "(Select THREE.)" in question text
  → Examples: "Which of these services provide encryption at rest? (Select TWO.)"
  → Typically 2-3 correct answers from 5 options
  → JSON format:
     {
       "text": "Which of these services provide encryption at rest? (Select TWO.)",
       "type": "multiple",
       "options": [
         "Amazon S3",
         "Amazon RDS",
         "AWS Lambda",
         "Amazon CloudWatch",
         "AWS KMS"
       ],
       "correct_answer": [0, 1],
       "explanation": "Detailed explanation of why each selected option is correct and why others are wrong...",
       "module_id": "the_module_id"
     }
  → Note: correct_answer is array of indices for all correct options
  
ORDERING (when selected):
  → Test understanding of SEQUENCE and DEPENDENCIES
  → Create logical progressions: deployment steps, configuration order, setup sequence
  → Example: "Order these steps to create and secure a VPC"
  → Must have clear logical dependencies (not ambiguous)
  → JSON format:
     {
       "text": "Order these steps to create and secure a VPC",
       "type": "ordering",
       "options": [
         "Create network ACLs and security groups",
         "Create subnets within the VPC",
         "Create the VPC",
         "Configure route tables"
       ],
       "correct_answer": [2, 1, 3, 0],
       "explanation": "Detailed explanation of the correct order and why each step must follow the previous one...",
       "module_id": "the_module_id"
     }
  → Note: correct_answer is array of indices showing correct sequence (e.g., [2, 1, 3, 0] means: step at index 2 is first, step at index 1 is second, etc.)
  
MATCHING (when selected):
  → Test ability to PAIR concepts, services, and features
  → Create meaningful pairings: service-to-use-case, problem-to-solution
  → Example: "Match AWS services to their primary characteristics"
  → Typically 3-5 items to match (left) with 3-5 definitions (right)
  → JSON format:
     {
       "text": "Match each AWS service to its primary use case.",
       "type": "matching",
       "pairs": {
         "left": ["Amazon S3", "Amazon RDS", "AWS Lambda"],
         "right": ["Object storage", "Relational database", "Serverless compute"]
       },
       "correct_answer": {"left": [0, 1, 2], "right": [0, 1, 2]},
       "explanation": "Detailed explanation of each match...",
       "module_id": "the_module_id"
     }
  → Note: left items max 5 words, right items max 12 words
  → correct_answer maps left[i] to right[j]

DISTRIBUTION RULES:
  - If only MCQ selected: 100% MCQ (60% definition, 40% scenario)
  - If MCQ + 1 other type: 50% MCQ, 50% other type
  - If MCQ + 2+ other types: Distribute equally across all selected types
  - Ensure 60% of total MCQ questions remain definitions

═══════════════════════════════════════════════════════

MODULES TO COVER:
${moduleSection}

${typeFormats}

RESPOND WITH ONLY A VALID JSON ARRAY. No markdown, no explanation, no preamble. Just the JSON array.
`;
}

function buildTypeDistribution(selectedTypes: string[], totalQuestions: number): string {
  // Filter to only valid types
  const validTypes = selectedTypes.filter(t => ['mcq', 'multiple', 'ordering', 'matching'].includes(t));
  
  if (validTypes.length === 0) {
    return '';
  }

  if (validTypes.length === 1) {
    // Only one type selected
    return `
⚠️ CRITICAL: QUESTION TYPE REQUIREMENT
   You MUST generate 100% of questions as TYPE: "${validTypes[0]}"
   EVERY SINGLE question must have "type": "${validTypes[0]}"
   NO exceptions. NO mixing types.`;
  }

  // Multiple types selected - distribute equally
  const questionsPerType = Math.floor(totalQuestions / validTypes.length);
  const remainder = totalQuestions % validTypes.length;
  
  const distribution = validTypes.map((type, idx) => {
    const count = questionsPerType + (idx < remainder ? 1 : 0);
    return `   - ${type}: ${count} questions`;
  }).join('\n');

  return `
⚠️ CRITICAL: QUESTION TYPE DISTRIBUTION REQUIREMENT
   You MUST generate questions in the following distribution:
${distribution}

   STRICT RULES:
   1. EVERY question MUST have one of these types: ${validTypes.join(', ')}
   2. NEVER default to 'mcq' if other types are selected
   3. Follow the distribution count EXACTLY (allow ±1 for rounding)
   4. Each type must follow its specific JSON format exactly
   5. NO question should be missing the "type" field`;
}


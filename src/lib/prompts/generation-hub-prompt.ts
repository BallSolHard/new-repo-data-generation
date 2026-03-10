// Hub Mode Prompt Template — Practice questions with flexible standards
// Used for generate-hub API to create varied practice questions with mix of definitions, applications, and scenarios

import type { ExamGuide, ExamDomain, ExamTask } from '@/lib/types/exam-guide';
import type { TierProfile } from '@/lib/types/tier';
import type { ModuleInput } from '@/lib/types/generation';
import type { Difficulty } from '@/lib/types/reference-question';

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
  complexityLevelDistribution?: Partial<Record<Difficulty, number>>;
  currentDifficulty?: Difficulty;
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
    selectedQuestionTypes = ['None'],
    complexityLevelDistribution,
    currentDifficulty = 'intermediate',
  } = params;

  const definitionQuestionCount = Math.ceil(totalQuestions * 0.6);
  
  // Build type distribution instructions based on selected types
  const typeDistributionInstructions = buildTypeDistribution(selectedQuestionTypes, totalQuestions);
  
  // Build complexity level context if distribution is provided
  const complexityContext = buildComplexityContext(complexityLevelDistribution, currentDifficulty);

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

${complexityContext}

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
⚠️ MANDATORY: QUESTION TYPE ENFORCEMENT
═══════════════════════════════════════════════════════

SELECTED TYPES FOR THIS BATCH: ${selectedQuestionTypes.join(', ').toUpperCase()}

🔴 YOU ARE GENERATING ONLY: ${selectedQuestionTypes.join(', ').toUpperCase()} QUESTIONS
🔴 YOU WILL NOT GENERATE: MCQ ONLY (unless it's the selected type)
🔴 YOU WILL NOT GENERATE: Multiple Select ONLY (unless it's the selected type)
🔴 YOU WILL NOT GENERATE: Ordering ONLY (unless it's the selected type)
🔴 YOU WILL NOT GENERATE: Matching ONLY (unless it's the selected type)

BEFORE YOU START GENERATING:
  ✓ Read the selected types above
  ✓ Remember these types for EVERY question
  ✓ Do NOT default to MCQ
  ✓ Follow the type distribution exactly

═══════════════════════════════════════════════════════
QUESTION TYPE GUIDELINES FOR HUB MODE
═══════════════════════════════════════════════════════

⚠️ CRITICAL DISTINCTION: MCQ vs MULTIPLE SELECT
═══════════════════════════════════════════════════════

❌ DO NOT CONFUSE THESE TWO:

MCQ (type: "mcq"):
  - ONE and ONLY ONE correct answer
  - correct_answer is a STRING: "{0}" or "{1}" or "{2}" or "{3}"
  - Examples:
    * "Which service provides object storage?" → Answer: Amazon S3 (ONE option)
    * "What does Lambda do?" → Answer: Serverless compute (ONE option)
  - Use when there is ONE best/correct choice

MULTIPLE SELECT (type: "multiple"):
  - TWO or MORE correct answers (typically 2-3)
  - correct_answer is an ARRAY: [0, 2] or [1, 3] — NEVER a single value
  - Question text MUST include: "(Select TWO.)" or "(Select THREE.)"
  - Examples:
    * "Which of these provide encryption at rest? (Select TWO.)" 
      → Answers: Amazon S3 AND Amazon RDS (TWO options) → [0, 2]
    * "Which services support real-time processing? (Select THREE.)"
      → Answers: Kinesis AND Lambda AND SQS (THREE options) → [1, 2, 4]
  - Use when there are MULTIPLE valid correct answers

🔴 ENFORCEMENT RULE:
  If type = "multiple" → correct_answer MUST be an array with 2+ elements: [0, 2], [1, 3, 4]
  If type = "multiple" → correct_answer MUST NEVER be a single element: ❌ [0], ❌ {0}, ❌ "1"
  If type = "multiple" → question text MUST include "(Select TWO.)" or "(Select THREE.)"

═══════════════════════════════════════════════════════

When generating questions, follow these guidelines based on selected types:

MCQ (Default, 60% Definition Focus):
  → Definition questions (6-30 words): "What is...", "Which service...", "What does..."
  → Scenario questions (30-120 words): Single-service selection with one clear constraint
  
MULTIPLE (when selected):
  ⚠️ CRITICAL: MUST HAVE 2-3 CORRECT ANSWERS, NOT ONE
  
  → Test ability to identify MULTIPLE correct services/approaches
  → Include "(Select TWO.)" or "(Select THREE.)" in question text (MANDATORY)
  → Must have 2-3 correct answers (NEVER just one)
  → Must have 5 options total (so 2 wrong answers)
  
  EXAMPLES OF CORRECT MULTIPLE SELECT QUESTIONS:
    ✅ "Which of these services provide encryption at rest? (Select TWO.)"
       Options: [Amazon S3, Amazon RDS, AWS Lambda, Amazon CloudWatch, AWS KMS]
       Correct answers: S3 + RDS = [0, 1] ← TWO answers
    
    ✅ "Which services can be used for real-time data streaming? (Select THREE.)"
       Options: [Amazon Kinesis, AWS Lambda, Amazon SQS, Amazon SNS, Amazon EventBridge]
       Correct answers: Kinesis + Lambda + SQS = [0, 1, 2] ← THREE answers
    
    ✅ "Which of the following support serverless architectures? (Select TWO.)"
       Options: [AWS Lambda, Amazon Fargate, Amazon EC2, AWS App Runner, Amazon ECS]
       Correct answers: Lambda + App Runner = [0, 3] ← TWO answers
  
  EXAMPLES OF WRONG MULTIPLE SELECT QUESTIONS (DO NOT GENERATE):
    ❌ "Which service stores objects?" (Select TWO.) 
       → WRONG: Only ONE answer exists (S3), cannot select two
    
    ❌ "Which of these services provide storage? (Select THREE.)"
       Options: [S3, EBS, ...] 
       Correct answers: [0] ← WRONG: Only ONE correct answer, should be MCQ instead
  
  JSON FORMAT:
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
       "explanation": "Amazon S3 and Amazon RDS both provide encryption at rest. AWS Lambda (Option C) is serverless compute, not storage...",
       "module_id": "the_module_id"
     }
  
  🔴 STRICT RULES FOR MULTIPLE SELECT:
    1. correct_answer MUST be an array: [0, 1], [0, 2], [1, 3], etc.
    2. correct_answer MUST have 2-3 elements (never 1, never 4+)
    3. Question text MUST say "(Select TWO.)" or "(Select THREE.)"
    4. 5 options total: 2-3 correct + 2-3 wrong
    5. Explanation MUST address each option and why it's correct or wrong
  
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

═══════════════════════════════════════════════════════
🔴 FINAL VERIFICATION BEFORE GENERATING
═══════════════════════════════════════════════════════

QUESTION TYPE CHECK:
  ✓ Selected types for this batch: ${selectedQuestionTypes.join(', ').toUpperCase()}
  ✓ You WILL generate ONLY these types
  ✓ You WILL NOT generate other types
  ✓ You WILL NOT default to MCQ

VERIFICATION CHECKLIST (DO THIS BEFORE SUBMITTING):
  1. Generate exactly ${totalQuestions} questions
  2. Check each question has "type" field
  3. Verify each "type" is one of: ${selectedQuestionTypes.join(', ')}
  4. Verify distribution (if ${selectedQuestionTypes.length} types: roughly ${Math.ceil(totalQuestions / selectedQuestionTypes.length)} questions per type)
  5. Check JSON format is correct for each type
  6. Verify "correct_answer" format matches type:
     - MCQ: "{N}" format (single value, never array)
     - Multiple: [0, 2] format (ALWAYS array with 2-3 elements, NEVER single element)
     - Ordering: [2, 0, 3, 1] format (array with all indices)
     - Matching: {"left": [0, 1, 2], "right": [0, 1, 2]} format (object mapping)
  
  7. 🔴 MULTIPLE SELECT ONLY - EXTRA CHECKS:
     - If type = "multiple": does question text have "(Select TWO.)" or "(Select THREE.)"?
     - If type = "multiple": is correct_answer an array with 2-3 elements? [0, 1], [1, 3], etc.
     - If type = "multiple": does correct_answer NEVER have just 1 element like [0]?
     - If type = "multiple": do all correct answers make sense in the explanation?

If ANY question fails these checks, your output WILL BE REJECTED.

═══════════════════════════════════════════════════════

RESPOND WITH ONLY A VALID JSON ARRAY. No markdown, no explanation, no preamble. Just the JSON array.
`;
}

function buildComplexityContext(distribution?: Record<string, number>, currentDifficulty?: string): string {
  if (!distribution || !currentDifficulty) {
    return '';
  }

  const difficultyMap: Record<string, string> = {
    easy: 'EASY/FOUNDATIONAL',
    intermediate: 'INTERMEDIATE/ASSOCIATE',
    hard: 'HARD/PROFESSIONAL',
  };

  const currentLabel = difficultyMap[currentDifficulty] || currentDifficulty;
  const totalQuestions = Object.values(distribution).reduce((sum, v) => sum + v, 0);

  let context = `
═══════════════════════════════════════════════════════
COMPLEXITY LEVEL DISTRIBUTION FOR THIS BATCH
═══════════════════════════════════════════════════════

📊 DIFFICULTY DISTRIBUTION REQUESTED:
${Object.entries(distribution).map(([level, count]) => `   - ${level.charAt(0).toUpperCase() + level.slice(1)}: ${count} question(s)`).join('\n')}
   TOTAL: ${totalQuestions} questions

🎯 THIS BATCH IS FOR: ${currentLabel}
   Generate ONLY questions appropriate for the "${currentDifficulty}" tier
   DO NOT mix difficulty levels within this batch`;

  // Add complexity guidelines based on difficulty
  if (currentDifficulty === 'easy') {
    context += `

   EASY/FOUNDATIONAL LEVEL CHARACTERISTICS:
   - Questions should be 1-2 sentences long (6-50 words)
   - Test core concepts and fundamental service knowledge
   - Focus on "what does this service do" and "when would you use it"
   - Options should clearly differ in purpose (not tricky)
   - 70% of questions should be DEFINITION type (6-30 words)
   - 30% can be SIMPLE SCENARIO (single service, one constraint)
   - Distractors should be obviously wrong services (different category)`;
  } else if (currentDifficulty === 'intermediate') {
    context += `

   INTERMEDIATE/ASSOCIATE LEVEL CHARACTERISTICS:
   - Questions should be 1-4 sentences long (20-100 words)
   - Present practical scenarios with clear business requirements
   - Include specific constraints: "with LEAST operational overhead", "MOST cost-effective"
   - Test ability to choose the RIGHT service for a specific use case
   - 60% of questions should be DEFINITION/BASIC (6-30 words)
   - 40% should be SCENARIO-based (single-service with clear constraint)
   - Distractors should be plausible alternatives from same category`;
  } else if (currentDifficulty === 'hard') {
    context += `

   HARD/PROFESSIONAL LEVEL CHARACTERISTICS:
   - Questions should be 3-6 sentences long (80-150+ words)
   - Present complex enterprise scenarios with multiple variables
   - Include specific metrics: data volumes, latency requirements, budget constraints
   - Require evaluating tradeoffs between MULTIPLE valid approaches
   - 50% of questions should be SCENARIO/ANALYSIS (multi-service)
   - 50% can be COMPLEX APPLICATIONS (require deep service knowledge)
   - Distractors should be sophisticated wrong answers (plausible but suboptimal)
   - Include architectural patterns: multi-account, hybrid cloud, disaster recovery`;
  }

  context += `

═══════════════════════════════════════════════════════`;

  return context;
}

function buildTypeDistribution(selectedTypes: string[], totalQuestions: number): string {
  // Filter to only valid types
  const validTypes = selectedTypes.filter(t => ['mcq', 'multiple', 'ordering', 'matching'].includes(t));
  
  if (validTypes.length === 0) {
    return '';
  }

  if (validTypes.length === 1) {
    // Only one type selected - VERY STRICT
    return `
═══════════════════════════════════════════════════════
🔴 CRITICAL ENFORCEMENT: SINGLE QUESTION TYPE ONLY
═══════════════════════════════════════════════════════

QUESTION TYPE: ${validTypes[0].toUpperCase()}

⚠️ YOU MUST GENERATE 100% OF QUESTIONS WITH TYPE: "${validTypes[0]}"

STRICT RULES (NON-NEGOTIABLE):
  ❌ BANNED: Do NOT generate any other question types
  ❌ BANNED: Do NOT generate MCQ if type is not 'mcq'
  ❌ BANNED: Do NOT generate multiple_select if type is not 'multiple'
  ❌ BANNED: Do NOT generate ordering if type is not 'ordering'
  ❌ BANNED: Do NOT generate matching if type is not 'matching'

VERIFICATION CHECKLIST - CHECK EVERY SINGLE QUESTION:
  1. Count your generated questions (should be ${totalQuestions})
  2. Check EVERY question has "type": "${validTypes[0]}"
  3. Check EVERY question has the correct JSON structure for ${validTypes[0]}
  4. If ANY question is NOT type "${validTypes[0]}", the entire output is REJECTED

═══════════════════════════════════════════════════════`;
  }

  // Multiple types selected - distribute with equal weight
  const questionsPerType = Math.floor(totalQuestions / validTypes.length);
  const remainder = totalQuestions % validTypes.length;
  
  const distribution = validTypes.map((type, idx) => {
    const count = questionsPerType + (idx < remainder ? 1 : 0);
    return `   - ${type.toUpperCase()}: ${count} question(s)`;
  }).join('\n');

  return `
═══════════════════════════════════════════════════════
🔴 CRITICAL ENFORCEMENT: MULTI-TYPE DISTRIBUTION
═══════════════════════════════════════════════════════

YOU MUST GENERATE QUESTIONS IN EXACTLY THIS DISTRIBUTION:

${distribution}

STRICT RULES (NON-NEGOTIABLE):
  1. EVERY question MUST have one of these types: ${validTypes.map(t => t.toUpperCase()).join(', ')}
  2. NEVER generate only MCQ if other types are selected
  3. NEVER skip any selected type
  4. Follow the distribution count EXACTLY (±1 for rounding only)
  5. Each type must follow its specific JSON format EXACTLY
  6. NO question should be missing the "type" field

VERIFICATION CHECKLIST:
  ✓ Count your generated questions (should be ${totalQuestions})
  ✓ Count questions by type: ${validTypes.map(t => `${t}=?`).join(', ')}
  ✓ Verify each type's count matches the distribution
  ✓ Check EVERY question has correct "type" field
  ✓ Check EVERY question has correct JSON structure for its type
  
If any question is missing a type, has wrong type, or wrong structure, OUTPUT FAILS.

═══════════════════════════════════════════════════════`;
}


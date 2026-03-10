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

═══════════════════════════════════════════════════════
🚨🚨🚨 CRITICAL: QUESTION TYPE REQUIREMENTS 🚨🚨🚨
═══════════════════════════════════════════════════════

SELECTED QUESTION TYPES: ${selectedQuestionTypes.join(', ').toUpperCase()}

THIS IS BINDING. DO NOT GENERATE ANY OTHER TYPE.

${selectedQuestionTypes.length === 1 && selectedQuestionTypes.includes('multiple') ? `
⚠️ 🔴🔴🔴 CRITICAL FOR MULTIPLE QUESTIONS 🔴🔴🔴

YOU ARE GENERATING: MULTIPLE QUESTIONS ONLY

EVERY SINGLE QUESTION MUST FOLLOW THIS EXACT PATTERN:
{
  "text": "Which of these services provide encryption at rest? (Select TWO.)",
  "type": "multiple",
  "options": ["Amazon S3", "Amazon RDS", "AWS Lambda", "Amazon CloudWatch", "AWS KMS"],
  "correct_answer": [0, 1],
  "explanation": "..."
}

🔴 CRITICAL RULES FOR correct_answer FIELD:
  1️⃣  correct_answer MUST BE AN ARRAY: [0, 1] or [0, 2] or [1, 3]
  2️⃣  correct_answer MUST HAVE 2-3 ELEMENTS (never 1, never 4+)
  3️⃣  correct_answer MUST USE INDICES: array of numbers, NOT strings
  
  ❌❌❌ DO NOT USE THESE FORMATS ❌❌❌
    ❌ correct_answer: 2 (single number - WRONG!)
    ❌ correct_answer: "0" (string - WRONG!)
    ❌ correct_answer: [0] (single element array - WRONG!)
    ❌ correct_answer: ["0", "1"] (string array - WRONG!)
    ❌ correct_answer: "0,1" (string - WRONG!)
    ❌ correct_answer: {"left": [0, 1], "right": [0, 1]} (object - WRONG!)

  ✅✅✅ ONLY USE THESE FORMATS ✅✅✅
    ✅ correct_answer: [0, 1] (array of 2 numbers)
    ✅ correct_answer: [0, 2] (array of 2 numbers)
    ✅ correct_answer: [1, 3] (array of 2 numbers)
    ✅ correct_answer: [0, 1, 2] (array of 3 numbers)
    ✅ correct_answer: [0, 2, 4] (array of 3 numbers)

ADDITIONAL REQUIREMENTS:
  • Question text MUST include "(Select TWO.)" or "(Select THREE.)"
  • Must have exactly 2-3 correct answers (not 1, not 4+)
  • Must have exactly 5 options total
  • Indices in correct_answer must be valid (0-4 for 5 options)

INSTANT REJECTION IF ANY OF THESE:
  ❌ correct_answer is a single number (2, 0, 1, etc.)
  ❌ correct_answer is a string ("0", "1", "0,1", etc.)
  ❌ correct_answer has only 1 element ([0], [1], etc.)
  ❌ correct_answer has 4+ elements ([0, 1, 2, 3], etc.)
  ❌ Question text missing "(Select TWO.)" or "(Select THREE.)"
` : ''}

TASK: Generate exactly ${totalQuestions} ${examGuide.certificationName} exam questions as a valid JSON array.
Generate ${questionsPerModule} question(s) per module.

${typeDistributionInstructions}

${complexityContext}

${selectedQuestionTypes.length === 1 && selectedQuestionTypes.includes('mcq') ? `
MCQ QUESTIONS (type: "mcq"):
  ✅ correct_answer MUST be a STRING with single option: "0", "1", "2", or "3"
  ✅ ONLY ONE correct answer per MCQ question
  ❌ NEVER use arrays for MCQ: ❌ [0], ❌ [0, 1], ❌ {"0"}, ❌ {"0": true}
  ❌ NEVER use objects: ❌ {"left": [0], "right": [0]}, ❌ {left: [...], right: [...]}
  
  CORRECT MCQ FORMAT:
  {
    "text": "Which service provides object storage?",
    "type": "mcq",
    "options": ["Amazon S3", "Amazon RDS", "AWS Lambda", "Amazon EC2"],
    "correct_answer": "0",
    "explanation": "..."
  }
` : ''}
${selectedQuestionTypes.length === 1 && selectedQuestionTypes.includes('multiple') ? `
🔴 MULTIPLE QUESTIONS (type: "multiple") — 🚨 MOST IMPORTANT RULE 🚨:

THE correct_answer FIELD MUST BE AN ARRAY OF 2-3 NUMBERS, NEVER A SINGLE NUMBER.

CORRECT FORMAT EXAMPLES:
{
  "text": "Which of these services provide encryption at rest? (Select TWO.)",
  "type": "multiple",
  "options": ["Amazon S3", "Amazon RDS", "AWS Lambda", "Amazon CloudWatch", "AWS KMS"],
  "correct_answer": [0, 1],
  "explanation": "Amazon S3 and Amazon RDS both provide encryption at rest..."
}

{
  "text": "Which services support real-time processing? (Select THREE.)",
  "type": "multiple",
  "options": ["Amazon Kinesis", "AWS Lambda", "Amazon SQS", "Amazon SNS", "Amazon EventBridge"],
  "correct_answer": [0, 1, 2],
  "explanation": "Amazon Kinesis, AWS Lambda, and Amazon SQS all support real-time processing..."
}

🚨 MANDATORY RULES FOR EVERY MULTIPLE QUESTION:
  1. correct_answer MUST be an array: [0, 1], [0, 2], [1, 3], [0, 1, 2], [0, 2, 4], etc.
  2. correct_answer MUST have EXACTLY 2 or 3 elements (never 1, never 4+, never 0)
  3. Each element must be a NUMBER (not a string): [0, 1] NOT ["0", "1"]
  4. Question text MUST say "(Select TWO.)" or "(Select THREE.)"
  5. Must have exactly 5 options (2-3 correct + 2-3 wrong)
  6. All indices must be valid (0-4 for 5 options)

❌ THESE WILL BE REJECTED:
  ❌ "correct_answer": 2 (WRONG: single number, not array)
  ❌ "correct_answer": [0] (WRONG: only 1 element)
  ❌ "correct_answer": "0" (WRONG: string, not array)
  ❌ "correct_answer": ["0", "1"] (WRONG: strings, not numbers)
  ❌ "correct_answer": [0, 1, 2, 3] (WRONG: 4 elements)
  ❌ "correct_answer": {"left": [0, 1], "right": [0, 1]} (WRONG: object format for matching)

✅ THESE ARE CORRECT:
  ✅ "correct_answer": [0, 1]
  ✅ "correct_answer": [0, 2]
  ✅ "correct_answer": [1, 3]
  ✅ "correct_answer": [0, 1, 2]
  ✅ "correct_answer": [0, 2, 4]
  ✅ "correct_answer": [1, 2, 3]
` : ''}
${selectedQuestionTypes.length === 1 && selectedQuestionTypes.includes('ordering') ? `
ORDERING QUESTIONS (type: "ordering"):
  ✅ correct_answer MUST be an ARRAY showing the correct sequence: [2, 0, 3, 1]
  ✅ Array length = number of options to order
  ✅ Each element is the index (0-based) of the option in correct order
  
  CORRECT ORDERING FORMAT:
  {
    "text": "Order these steps to create and secure a VPC",
    "type": "ordering",
    "options": ["Create network ACLs", "Create subnets", "Create the VPC", "Configure route tables"],
    "correct_answer": [2, 1, 3, 0],
    "explanation": "..."
  }
` : ''}
${selectedQuestionTypes.length === 1 && selectedQuestionTypes.includes('matching') ? `
⚠️ 🔴🔴🔴 CRITICAL FOR MATCHING QUESTIONS 🔴🔴🔴

YOU ARE GENERATING: MATCHING QUESTIONS ONLY

EVERY SINGLE QUESTION MUST FOLLOW THIS EXACT PATTERN:
{
  "text": "Match each AWS service to its primary use case.",
  "type": "matching",
  "pairs": {
    "left": ["Amazon S3", "Amazon RDS", "AWS Lambda"],
    "right": ["Object storage", "Relational database", "Serverless compute"]
  },
  "correct_answer": {"left": [0, 1, 2], "right": [0, 1, 2]},
  "explanation": "..."
}

🔴 CRITICAL RULES FOR correct_answer FIELD:
  1️⃣  correct_answer MUST BE AN OBJECT: {"left": [...], "right": [...]}
  2️⃣  "left" array: indices in SAME ORDER as pairs.left array [0, 1, 2, ...]
  3️⃣  "right" array: indices showing which right item matches each left item
  4️⃣  For 1-to-1 matching: [0, 1, 2] means left[0]→right[0], left[1]→right[1], left[2]→right[2]
  
  ❌❌❌ DO NOT USE THESE FORMATS ❌❌❌
    ❌ correct_answer: [0, 1, 2] (WRONG: should be object, not array)
    ❌ correct_answer: "0,1,2" (WRONG: string, not object)
    ❌ correct_answer: [0, 2, 1] (WRONG: missing "left" and "right" keys)
    ❌ "pairs" field missing (WRONG: must include pairs structure)
    ❌ "options" instead of "pairs" (WRONG: matching uses pairs, not options)

  ✅✅✅ ONLY USE THIS FORMAT ✅✅✅
    ✅ "correct_answer": {"left": [0, 1, 2], "right": [0, 1, 2]}
    ✅ "pairs": {"left": ["Item 1", "Item 2", "Item 3"], "right": ["Def 1", "Def 2", "Def 3"]}
    ✅ Left and right arrays MUST have same length (3 items each, 4 items each, etc.)

ADDITIONAL REQUIREMENTS:
  • Must have "pairs" field with "left" and "right" arrays
  • "left" array: 3-5 items to match (e.g., AWS services)
  • "right" array: 3-5 definitions/descriptions (same length as left)
  • correct_answer MUST be an object: {"left": [0, 1, 2], "right": [0, 1, 2]}
  • All indices must be valid (0-2 for 3 items, 0-4 for 5 items)

INSTANT REJECTION IF ANY OF THESE:
  ❌ correct_answer is an array like [0, 1, 2] (must be OBJECT)
  ❌ correct_answer is a string like "0,1,2" (must be OBJECT)
  ❌ "pairs" field missing (must include pairs structure)
  ❌ "options" field present instead of "pairs" (matching uses pairs only)
  ❌ Left and right arrays have different lengths
  ❌ Indices in correct_answer.right don't match left array length
` : ''}
${selectedQuestionTypes.length > 1 ? `
═══════════════════════════════════════════════════════
MULTI-TYPE GENERATION MODE — MULTIPLE QUESTION FORMATS
═══════════════════════════════════════════════════════

You are generating questions with MULTIPLE different types. Each question MUST be ONE of the selected types below.
Distribute your questions evenly across the types according to the instructions from the distribution section above.

⚠️ TYPE-SPECIFIC FORMAT REQUIREMENTS FOR MULTI-TYPE MODE:

${selectedQuestionTypes.includes('mcq') ? `
MCQ (type: "mcq") — Single correct answer
  • "type": "mcq"
  • "correct_answer": Single STRING value "0", "1", "2", or "3" (NOT array)
  • Exactly one correct option
` : ''}

${selectedQuestionTypes.includes('multiple') ? `
MULTIPLE (type: "multiple") — Multiple correct answers (2-3)
  • "type": "multiple"
  • "correct_answer": ARRAY with 2-3 elements: [0, 1], [0, 2], [1, 3], etc.
  • Question text MUST include "(Select TWO.)" or "(Select THREE.)"
  • 2-3 correct options that all make sense
` : ''}

${selectedQuestionTypes.includes('ordering') ? `
ORDERING (type: "ordering") — Sequence of steps
  • "type": "ordering"
  • "correct_answer": ARRAY showing sequence [2, 0, 3, 1]
  • Each element is the index of an option in the correct order
` : ''}

${selectedQuestionTypes.includes('matching') ? `
MATCHING (type: "matching") — Pair left and right items
  • "type": "matching"
  • "pairs": {"left": ["Item 1", "Item 2", "Item 3"], "right": ["Def 1", "Def 2", "Def 3"]}
  • "correct_answer": OBJECT {"left": [0, 1, 2], "right": [0, 1, 2]} (NOT array or string)
  • Left and right arrays MUST have equal length (3-5 items each)
` : ''}

═══════════════════════════════════════════════════════
` : ''}
═══════════════════════════════════════════════════════

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
  - Use alphabetical option names: first option = Option A, second = Option B, third = Option C, fourth = Option D
  - When referencing options in explanation, use: "Option A", "Option B", "Option C", "Option D" (NOT index numbers 0, 1, 2, 3)
  - Double-check before outputting — INDEX MISMATCHES cause instant rejection

DISTRACTORS:
  - All 4 options must be real AWS services that sound plausible
  - For DEFINITION questions: Use services from similar categories (e.g., all storage services)
  - For SCENARIO questions: Use realistic alternative approaches or common misunderstandings
  - Each explanation must reference why wrong options fail
  - DO NOT include anti-pattern identifiers (like "ap-1.2-003") in explanations
  - DO NOT label wrong answers as "anti-pattern" — simply explain why they're incorrect

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
🔴 YOU WILL NOT GENERATE: MULTIPLE ONLY (unless it's the selected type)
🔴 YOU WILL NOT GENERATE: ORDERING ONLY (unless it's the selected type)
🔴 YOU WILL NOT GENERATE: MATCHING ONLY (unless it's the selected type)

BEFORE YOU START GENERATING:
  ✓ Read the selected types above
  ✓ Remember these types for EVERY question
  ✓ Do NOT default to MCQ
  ✓ Follow the type distribution exactly

═══════════════════════════════════════════════════════
QUESTION TYPE GUIDELINES FOR HUB MODE
═══════════════════════════════════════════════════════

⚠️ CRITICAL DISTINCTION: MCQ vs MULTIPLE
═══════════════════════════════════════════════════════

❌ DO NOT CONFUSE THESE TWO:

MCQ (type: "mcq"):
  - ONE and ONLY ONE correct answer
  - correct_answer is a STRING: "{0}" or "{1}" or "{2}" or "{3}"
  - Examples:
    * "Which service provides object storage?" → Answer: Amazon S3 (ONE option)
    * "What does Lambda do?" → Answer: Serverless compute (ONE option)
  - Use when there is ONE best/correct choice

MULTIPLE (type: "multiple"):
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
  
  EXAMPLES OF CORRECT MULTIPLE QUESTIONS:
    ✅ "Which of these services provide encryption at rest? (Select TWO.)"
       Options: [Amazon S3, Amazon RDS, AWS Lambda, Amazon CloudWatch, AWS KMS]
       Correct answers: S3 + RDS = [0, 1] ← TWO answers
    
    ✅ "Which services can be used for real-time data streaming? (Select THREE.)"
       Options: [Amazon Kinesis, AWS Lambda, Amazon SQS, Amazon SNS, Amazon EventBridge]
       Correct answers: Kinesis + Lambda + SQS = [0, 1, 2] ← THREE answers
    
    ✅ "Which of the following support serverless architectures? (Select TWO.)"
       Options: [AWS Lambda, Amazon Fargate, Amazon EC2, AWS App Runner, Amazon ECS]
       Correct answers: Lambda + App Runner = [0, 3] ← TWO answers
  
  EXAMPLES OF WRONG MULTIPLE  QUESTIONS (DO NOT GENERATE):
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
       "explanation": "Amazon S3 (Option A) and Amazon RDS (Option B) both provide encryption at rest. AWS Lambda (Option C) is serverless compute, not storage. Amazon CloudWatch (Option D) is monitoring, not storage. AWS KMS (Option E) is key management, not storage itself...",
       "module_id": "the_module_id"
     }
  
  🔴 STRICT RULES FOR MULTIPLE :
    1. correct_answer MUST be an array: [0, 1], [0, 2], [1, 3], etc.
    2. correct_answer MUST have 2-3 elements (never 1, never 4+)
    3. Question text MUST say "(Select TWO.)" or "(Select THREE.)"
    4. 5 options total: 2-3 correct + 2-3 wrong
    5. Explanation MUST address each option and why it's correct or wrong

═══════════════════════════════════════════════════════
EXPLANATION FORMAT REQUIREMENTS — ALL QUESTION TYPES
═══════════════════════════════════════════════════════

OPTION NAMING IN EXPLANATIONS:
  ✅ CORRECT:
     "Option A provides X service..."
     "Option B is used for Y..."
     "Option C (incorrect) does not..."
     "Option D and Option E are not related..."
  
  ❌ INCORRECT:
     "Option 0 provides X service..."
     "Option {0} is used for Y..."
     "0. This service..." (using index numbers)

ANTI-PATTERN IDENTIFIERS — MUST REMOVE:
  ❌ DO NOT INCLUDE:
     "Option 3 is anti-pattern ap-1.2-003"
     "This violates anti-pattern reference api-2.5-001"
     "(anti-pattern: wrong-approach)"
     "Anti-pattern identifier: ap-1.2-xxx"
  
  ✅ DO INSTEAD:
     "Option C is incorrect because it doesn't follow AWS best practices for security"
     "Option D is not a valid approach because it requires manual intervention"
     "Option E would increase operational overhead significantly"

EXPLANATION STRUCTURE FOR MCQ & MULTIPLE :
  
  For CORRECT answers:
    Format: "Option A (correct) provides [service name] which [key capability]..."
    Include: Why this is the best choice, key features, use cases
  
  For WRONG answers:
    Format: "Option C (incorrect) would [issue] because [technical reason]..."
    Include: What's wrong with this approach, why it fails the requirement, common misconception
  
  Example:
    "The AWS Well-Architected Framework consists of six pillars. Option A (Operational Excellence), Option B (Security), and Option C (Reliability) are three of these pillars. Option D (Global Infrastructure Optimization) is a benefit of AWS but not a pillar. Option E (Legacy System Integration) is a migration challenge but not part of the framework."

KEEP IT CLEAN:
  ✅ Focus on technical correctness
  ✅ Explain each option's relevance or irrelevance
  ✅ Use standard AWS terminology
  ✅ Reference AWS documentation when applicable
  
  ❌ Don't use code-style identifiers
  ❌ Don't reference internal anti-pattern databases
  ❌ Don't use numbered indices (0, 1, 2, 3)
  ❌ Don't add metadata or tags to answers

═══════════════════════════════════════════════════════
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
     - MCQ: "{N}" format (single STRING value "0", "1", "2", "3", NEVER array)
     - Multiple: [0, 2] format (ALWAYS ARRAY with 2-3 elements, NEVER single element [0], NEVER string "0")
     - Ordering: [2, 0, 3, 1] format (array with all indices)
     - Matching: {"left": [0, 1, 2], "right": [0, 1, 2]} format (object mapping)
  
  7. � IF 'MULTIPLE' IS SELECTED — MANDATORY EXTRA CHECKS:
     BEFORE YOU OUTPUT, CHECK EVERY SINGLE MULTIPLE QUESTION:
     
     ❌ FAILURE REASONS (will cause instant rejection):
        - correct_answer is a STRING like "0" or "1" (must be ARRAY: [0, 1])
        - correct_answer is a single-element array [0] (must be 2-3 elements: [0, 1] or [0, 2])
        - correct_answer is an object like {"left": [...], "right": [...]} (ONLY for matching type)
        - Question text does NOT have "(Select TWO.)" or "(Select THREE.)"
        - Only ONE correct option makes sense (this should be MCQ, not MULTIPLE)
        - correct_answer has 4+ elements [0, 1, 2, 3] (must be 2-3 max)
     
     ✅ FOR EVERY MULTIPLE QUESTION, VERIFY:
        1. "type": "multiple" ✓
        2. Question text includes "(Select TWO.)" or "(Select THREE.)" ✓
        3. correct_answer is an ARRAY with 2-3 elements: [0, 1] or [0, 2] or [1, 3], etc. ✓
        4. All correct_answer indices are valid (0-4 for 5 options) ✓
        5. Multiple distinct correct options actually exist in the question ✓
        6. Explanation addresses EACH option (why correct ones are right, why wrong ones are wrong) ✓

If ANY question fails these checks, your output WILL BE REJECTED.

═══════════════════════════════════════════════════════
🚨🚨🚨 FINAL CRITICAL INSTRUCTION FOR MULTIPLE QUESTIONS 🚨🚨🚨
═══════════════════════════════════════════════════════

IF YOU GENERATED ANY QUESTIONS WITH type: "multiple":

BEFORE YOU SUBMIT, DO THIS FINAL CHECK:

For EVERY "multiple" question in your output, verify:
  1. "correct_answer": [?, ?] OR [?, ?, ?] (ARRAY with 2 or 3 NUMBERS)
  
  NOT: "correct_answer": 0 (single number)
  NOT: "correct_answer": 1 (single number)
  NOT: "correct_answer": 2 (single number)
  NOT: "correct_answer": [0] (single element array)
  NOT: "correct_answer": "0" (string)
  NOT: "correct_answer": "1" (string)

  YES: "correct_answer": [0, 1]
  YES: "correct_answer": [0, 2]
  YES: "correct_answer": [1, 3]
  YES: "correct_answer": [0, 1, 2]
  YES: "correct_answer": [0, 2, 4]

IF EVEN ONE MULTIPLE QUESTION HAS:
  ❌ A SINGLE NUMBER like 0, 1, 2, 3, 4
  ❌ A SINGLE-ELEMENT ARRAY like [0], [1], [2]
  ❌ A STRING like "0", "1", "0,1"
  
YOUR ENTIRE OUTPUT WILL BE REJECTED AND REGENERATED.

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



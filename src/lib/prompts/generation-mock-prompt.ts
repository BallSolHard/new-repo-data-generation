// Mock Test Prompt Template — Exam-realistic questions with strict standards
// Used for generate-mock API to create high-quality questions that simulate actual exam conditions

import type { ExamGuide, ExamDomain, ExamTask } from '@/lib/types/exam-guide';
import type { TierProfile } from '@/lib/types/tier';

export interface MockPromptParams {
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

export function buildMockPrompt(params: MockPromptParams): string {
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

  const wordMin = tierProfile.stemWordRange[0];
  const wordMax = tierProfile.stemWordRange[1];
  const cognitiveLevel = tierProfile.cognitiveLevel;

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
These are MOCK TEST questions for exam simulation — maintain realistic exam difficulty and complexity.

═══════════════════════════════════════════════════════
🚨🚨🚨 CRITICAL: QUESTION TYPE REQUIREMENT 🚨🚨🚨
═══════════════════════════════════════════════════════

YOU MUST GENERATE ONLY: ${selectedQuestionTypes.map(t => t.toUpperCase()).join(', ')} QUESTIONS

THIS IS BINDING. DO NOT GENERATE ANY OTHER QUESTION TYPE.

If type = "matching" → Use pairs + matches fields (correct_answer and options must be NULL)
If type = "multiple" → Use correct_answer as [0, 1] or [0, 1, 2] array (2-3 integers)
If type = "ordering" → Use correct_answer as [2, 0, 3, 1] array showing sequence
If type = "mcq" → Use correct_answer as [0] array with single integer

🔴 FAILURE: Generating any other type will result in instant rejection.

═══════════════════════════════════════════════════════

${answerBiasRules}

═══════════════════════════════════════════════════════
QUESTION QUALITY STANDARDS (Mock Test — STRICTLY ENFORCED)
═══════════════════════════════════════════════════════

STEM LENGTH — STRICTLY ENFORCED: Every stem MUST be ${wordMin}-${wordMax} words
  ✅ REQUIRED: ${wordMin}-${wordMax} word stems (realistic exam length)
  ❌ REJECTED: Shorter than ${wordMin} words or longer than ${wordMax} words
  
  HOW TO HIT THE TARGET:
  - Describe current business/technical situation (2-3 sentences)
  - State the requirement or constraint (1-2 sentences)
  - Ask which solution best meets the requirement (1 sentence)
  - Count words before submitting to verify you're in range

COGNITIVE LEVEL — ${cognitiveLevel.toUpperCase()} ONLY
  ❌ FORBIDDEN Patterns (Recall level):
     - "What is [service]?"
     - "Which service provides [feature]?"
     - "Define [concept]"
     - "Identify the service for [task]"
     - "What does [service] do?"
  
  ✅ REQUIRED Patterns (${cognitiveLevel}):
     - Describe scenario, ask which approach is BEST
     - Present conflicting requirements, ask for TRADEOFF analysis
     - Provide technical constraints, ask for OPTIMAL solution
     - Give business context, ask for APPROPRIATE architecture
  
  EXAMPLES FOR THIS TIER:
  ✅ "A company stores sensitive data. Which approach provides encryption at rest with customer-managed keys AND automated monitoring with LEAST overhead?"
  ✅ "Given requirements for multi-region deployment, disaster recovery, and cost optimization, which architecture best balances these constraints?"
  ✅ "An institution needs real-time data processing with 99.9% uptime and compliance logging. Which combination of services meets these requirements?"

SCENARIO REQUIREMENTS — EXAM-REALISTIC:
  1. DESCRIBE THE BUSINESS PROBLEM:
     - Provide company context (size, industry, goals)
     - State current challenge or requirement
     - Include specific constraints (cost, latency, compliance, overhead)
  
  2. INCLUDE EXACTLY ONE PRIMARY CONSTRAINT:
     Examples: "LEAST operational overhead", "MOST cost-effective", "LOWEST latency", "HIGHEST availability"
  
  3. NEVER NAME THE SOLUTION IN THE STEM:
     ❌ WRONG: "They need alerts when costs exceed budget. Which alerting service..."
     ✅ RIGHT: "A finance team must prevent unexpected cloud overspend by receiving automatic notifications..."
  
  4. MAKE CANDIDATES ANALYZE MULTIPLE OPTIONS:
     Each distractor should be a valid approach that FAILS one of the constraints
  
  5. TEST APPLICATION OR ANALYSIS OF KNOWLEDGE:
     Not memorization, but reasoning about when and why to use services

DISTRACTORS — ALL MUST REPRESENT MISCONCEPTIONS:
  ❌ NO OBVIOUSLY WRONG OPTIONS:
     Every option must be a real AWS service plausible for the domain
     Every option must represent a realistic but flawed approach
  
  ✅ EACH DISTRACTOR MUST:
     - Represent a specific anti-pattern misconception (reference [ap-X-Y-Z] ID)
     - Be architecturally valid but fail at least one stated constraint
     - Sound appealing to someone with partial knowledge
     - Have a detailed explanation of why it fails
  
  EXAMPLE WRONG ANSWERS:
  Q: "Which approach provides encryption at rest with LEAST operational overhead?"
  ❌ Answer B: "Encrypt in S3 with custom key management" → violates "LEAST overhead"
  ❌ Answer C: "Use EC2 with manual EBS encryption setup" → violates "LEAST overhead"
  ❌ Answer D: "Store in relational database with application-level encryption" → violates "LEAST overhead"
  ✅ Answer A: "Use S3 with AWS KMS customer-managed keys" → minimal overhead, automated

MCQ QUESTIONS (type: "mcq"):
  ✅ correct_answer MUST be a NUMBER ARRAY with single element: [0], [1], [2], or [3]
  ✅ ONLY ONE correct answer per MCQ question
  ❌ NEVER use strings or single numbers: ❌ "0", ❌ 0, ❌ [0, 1]
  
  CORRECT MCQ FORMAT:
  {
    "text": "Which approach provides encryption at rest with LEAST operational overhead?",
    "type": "mcq",
    "options": ["Use S3 with AWS KMS customer-managed keys", "Encrypt in S3 with custom key management", "Use EC2 with manual EBS encryption setup", "Store in relational database with application-level encryption"],
    "correct_answer": [0],
    "explanation": "..."
  }

⚠️ MULTIPLE QUESTIONS (type: "multiple") — 🚨 MOST IMPORTANT RULE 🚨:

THE correct_answer FIELD MUST BE AN ARRAY OF 2-3 INTEGERS (NOT STRINGS), NEVER A SINGLE NUMBER.

CORRECT FORMAT EXAMPLES:
{
  "text": "Which of these approaches provide encryption at rest with LEAST operational overhead? (Select TWO.)",
  "type": "multiple",
  "options": ["Amazon S3 with AWS KMS", "Amazon RDS with AWS KMS", "Manual EC2 encryption", "Application-level encryption", "DynamoDB Encryption at Rest"],
  "correct_answer": [0, 1],
  "explanation": "S3 with AWS KMS and RDS with AWS KMS both provide encryption with minimal operational overhead..."
}

🚨 MANDATORY RULES FOR EVERY MULTIPLE QUESTION:
  1. correct_answer MUST be an array of integers: [0, 1], [0, 2], [1, 3], [0, 1, 2], [0, 2, 4], etc.
  2. correct_answer MUST have EXACTLY 2 or 3 elements (never 1, never 4+, never 0)
  3. Each element MUST be an INTEGER (not a string): [0, 1] NOT ["0", "1"]
  4. Question text MUST say "(Select TWO.)" or "(Select THREE.)"
  5. Must have exactly 5 options (2-3 correct + 2-3 wrong)
  6. All indices must be valid (0-4 for 5 options)

❌ THESE WILL BE REJECTED:
  ❌ "correct_answer": 2 (WRONG: single number, not array)
  ❌ "correct_answer": [0] (WRONG: only 1 element)
  ❌ "correct_answer": "0" (WRONG: string, not array)
  ❌ "correct_answer": ["0", "1"] (WRONG: strings, not integers)
  ❌ "correct_answer": [0, 1, 2, 3] (WRONG: 4 elements)
  ❌ "correct_answer": {"0": true, "1": true} (WRONG: object format)

✅ THESE ARE CORRECT:
  ✅ "correct_answer": [0, 1]
  ✅ "correct_answer": [0, 2]
  ✅ "correct_answer": [1, 3]
  ✅ "correct_answer": [0, 1, 2]
  ✅ "correct_answer": [0, 2, 4]
  ✅ "correct_answer": [1, 2, 3]

ORDERING QUESTIONS (type: "ordering"):
  ✅ correct_answer MUST be an ARRAY of integers showing the correct sequence: [2, 0, 3, 1]
  ✅ Array length = number of options to order
  ✅ Each element is the index (0-based) of the option in correct order
  ✅ All elements must be integers (not strings): [2, 0, 3, 1] NOT ["2", "0", "3", "1"]
  
  CORRECT ORDERING FORMAT:
  {
    "text": "Order these steps to design a highly available multi-region architecture",
    "type": "ordering",
    "options": ["Configure failover mechanisms", "Set up monitoring and alerting", "Design the primary region infrastructure", "Set up cross-region replication"],
    "correct_answer": [2, 3, 1, 0],
    "explanation": "..."
  }

⚠️ MATCHING QUESTIONS (type: "matching") — 🚨 CRITICAL FORMAT 🚨:

MATCHING QUESTIONS USE SEPARATE FIELDS: pairs and matches (NOT options or correct_answer)

CORRECT FORMAT FOR MATCHING:
{
  "text": "Match each architectural approach to its appropriate use case for exam-realistic scenarios.",
  "type": "matching",
  "pairs": {
    "left": ["Multi-region active-active", "Single region with backups", "Cross-AZ redundancy", "Global content distribution"],
    "right": ["Disaster recovery strategy", "Minimize latency worldwide", "High availability within region", "Maximum uptime across regions"]
  },
  "matches": {
    "left": [0, 1, 2, 3],
    "right": [3, 0, 2, 1]
  },
  "explanation": "..."
}

WHERE THE MAPPING MEANS:
  left[0] "Multi-region active-active" matches right[3] "Maximum uptime across regions"
  left[1] "Single region with backups" matches right[0] "Disaster recovery strategy"
  left[2] "Cross-AZ redundancy" matches right[2] "High availability within region"
  left[3] "Global content distribution" matches right[1] "Minimize latency worldwide"

🔴 CRITICAL RULES FOR MATCHING FIELD:
  1. pairs MUST contain "left" and "right" arrays with items to match
  2. matches MUST contain "left" and "right" arrays with indices
  3. matches.left array: ALWAYS [0, 1, 2, ...] in sequential order (same length as pairs.left)
  4. matches.right array: indices showing which right item matches each left item
  5. correct_answer MUST BE NULL (not used for matching)
  6. options MUST BE NULL (not used for matching)
  
  ❌❌❌ DO NOT USE THESE FORMATS FOR MATCHING ❌❌❌
    ❌ correct_answer: [0, 1, 2] (WRONG: should be NULL, use matches field instead)
    ❌ correct_answer: "0,1,2" (WRONG: should be NULL)
    ❌ options: [...] (WRONG: matching uses pairs, not options)
    ❌ "correct_answer": {"left": [0, 1, 2], "right": [0, 1, 2]} (WRONG: use matches field)
    ❌ pairs missing "left" or "right" (WRONG: must include both arrays)
    ❌ matches missing "left" or "right" (WRONG: must include both arrays)

  ✅✅✅ ONLY USE THIS FORMAT FOR MATCHING ✅✅✅
    ✅ "pairs": {"left": [...], "right": [...]}
    ✅ "matches": {"left": [0, 1, 2, ...], "right": [?, ?, ?, ...]}
    ✅ "correct_answer": null
    ✅ "options": null
    ✅ Left and right arrays MUST have same length (3 items each, 4 items each, etc.)

ADDITIONAL REQUIREMENTS FOR MATCHING:
  • Must have "pairs" field with "left" and "right" arrays
  • Must have "matches" field with "left" and "right" indices arrays
  • "left" array in pairs: 3-5 items to match (e.g., AWS architectural approaches)
  • "right" array in pairs: 3-5 definitions/descriptions (same length as left)
  • "left" in matches: ALWAYS sequential indices [0, 1, 2, ...] or [0, 1, 2, 3, 4]
  • "right" in matches: permutation of indices showing the correct mapping
  • correct_answer MUST be NULL (integer[] null in database)
  • options MUST be NULL (jsonb null in database)
  • All indices must be valid (0-2 for 3 items, 0-4 for 5 items)

INSTANT REJECTION IF ANY OF THESE:
  ❌ correct_answer is NOT null (must be null for matching)
  ❌ options is NOT null (must be null for matching)
  ❌ "pairs" field missing (must include pairs structure)
  ❌ "matches" field missing (must include matches structure)
  ❌ pairs.left and pairs.right have different lengths
  ❌ matches.left is not sequential [0, 1, 2, ...] or [0, 1, 2, 3, 4]
  ❌ matches arrays have different lengths than pairs arrays
  ❌ Indices in matches.right don't match pairs.right array length
  ❌ matches.right contains duplicate indices (each right item should be used once)

ANSWER/EXPLANATION CONSISTENCY — STRICTLY VERIFIED:
  1️⃣ VERIFY INDEX ACCURACY:
     - Count from 0: first option = {0}, second = {1}, third = {2}, fourth = {3}
     - If explanation says "Option B is correct", correct_answer MUST be {1}
     - INDEX MISMATCHES = INSTANT REJECTION
  
  2️⃣ MATCH EXPLANATION TO CORRECT_ANSWER:
     - Read your explanation
     - Identify which option you defended as correct
     - Verify that option's position matches correct_answer index
     - Test: "If I pick the indexed option, will the explanation agree?"
  
  3️⃣ USE OPTION LETTERS IN EXPLANATIONS (NOT INDEX NUMBERS):
     - Use: "Option A", "Option B", "Option C", "Option D" when referencing options
     - NOT: "Option 0", "Option 1", "{0}", "{1}", "0.", "1."
     - This applies to ALL question types: MCQ, Multiple, Ordering, Matching
  
  4️⃣ REFERENCE SERVICE CAPABILITIES BUT NOT ANTI-PATTERN IDs:
     - Explain WHY an option is wrong (technical reason)
     - Do NOT include anti-pattern identifier codes like "ap-1.2-001"
     - Example: "Option C is incorrect because it requires manual intervention"
     - Not: "Option C violates [ap-2.1-003]"

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

FACTUAL ACCURACY — VALIDATOR WILL CHECK:
  - Service capabilities (Comprehend = TEXT analysis, not AUDIO)
  - Service use cases (Textract = DOCUMENTS, Rekognition = IMAGES, SageMaker = MODELS)
  - Architecture patterns (Batch Transform = BATCH inference, not REAL-TIME)
  - Configuration details (KMS for encryption, VPC for isolation, etc.)
  - Feature availability (Lambda timeout limits, S3 storage classes, etc.)

UNIQUENESS REQUIREMENTS:
  Each question must test a distinct scenario or architectural concept.
  Do not generate variations of the same scenario with different numbers/metrics.
  Every question should require different reasoning or service combinations.

═══════════════════════════════════════════════════════
⚠️ MANDATORY: QUESTION TYPE ENFORCEMENT FOR MOCK TESTS
═══════════════════════════════════════════════════════

MOCK TEST FOCUS: These are exam-simulation questions maintaining realistic difficulty and complexity.
All question types (MCQ, Multiple, Ordering, Matching) must reflect exam-realistic standards.

🔴 MCQ QUESTIONS — STANDARD EXAM FORMAT:
  - Single best answer from 4 options
  - Realistic exam difficulty and length (${wordMin}-${wordMax} words)
  - Cognitive level: ${cognitiveLevel.toUpperCase()} (NOT recall/definition)
  - correct_answer format: ARRAY with single integer [0], [1], [2], or [3]
  - options format: ARRAY of strings
  - matches and pairs: NULL

🔴 MULTIPLE QUESTIONS — ADVANCED SELECTION SKILLS:
  - 2-3 correct answers from 5 options (not just "select all that apply")
  - Question MUST include "(Select TWO.)" or "(Select THREE.)"
  - Realistic exam difficulty: each correct option must be genuinely valid
  - Distractors must be plausible but architecturally flawed
  - correct_answer format: ARRAY with 2-3 integers [0, 1] or [0, 1, 2]
  - options format: ARRAY of strings
  - matches and pairs: NULL

🔴 ORDERING QUESTIONS — SEQUENCE AND DEPENDENCIES:
  - Test understanding of prerequisites and logical order
  - Example: Multi-step architectural deployment, configuration sequence
  - Must have clear technical dependencies (not arbitrary ordering)
  - correct_answer format: ARRAY of integers showing sequence [2, 0, 3, 1]
  - options format: ARRAY of strings
  - matches and pairs: NULL

🔴 MATCHING QUESTIONS — CONCEPT PAIRING AND RELATIONSHIPS:
  - Match architectural approaches to use cases, services to scenarios
  - 3-5 items per side (left and right must match in length)
  - Exam-realistic pairings based on technical requirements
  - correct_answer format: NULL (not used for matching questions)
  - options format: NULL (not used for matching questions)
  - pairs format: OBJECT {"left": [...], "right": [...]}
  - matches format: OBJECT {"left": [0, 1, 2, ...], "right": [?, ?, ?, ...]}

═══════════════════════════════════════════════════════
EXPLANATION STRUCTURE FOR ALL QUESTION TYPES
═══════════════════════════════════════════════════════

MCQ & MULTIPLE EXPLANATIONS:
  
  For CORRECT answers:
    Format: "Option A (correct) provides [service/approach] which [key capability]..."
    Include: Why this is the best choice, key architectural benefits, exam relevance
  
  For WRONG answers:
    Format: "Option C (incorrect) would [issue] because [technical reason]..."
    Include: What's wrong with this approach, why it fails the requirement, common misconception
  
  Example:
    "A company requires encryption at rest with LEAST operational overhead. Option A (correct) uses S3 with AWS KMS which provides fully managed encryption requiring minimal configuration. Option B (incorrect) would require custom key management, increasing operational burden. Option C (incorrect) involves manual EC2 setup, violating the 'LEAST overhead' constraint. Option D (incorrect) is application-level encryption, adding complexity without architectural benefit."

ORDERING EXPLANATIONS:
  Format: "The correct sequence is [Step 1 → Step 2 → Step 3 → Step 4] because..."
  Include: Technical reasons for each prerequisite, why order matters
  
  Example:
    "Option B (Create the VPC) must come first as the foundation. Option C (Create subnets) depends on the VPC existing. Option A (Configure route tables) requires subnets to define routes for. Option D (Create security groups) is the final step and depends on network structure."

MATCHING EXPLANATIONS:
  Format: "Left items match as follows: [Item 1] → [Right Item], [Item 2] → [Right Item], etc."
  Include: Why each pairing is correct, technical justification
  
  Example:
    "Multi-region active-active matches 'Maximum uptime across regions' because it maintains concurrent operations. Single region with backups matches 'Disaster recovery strategy' for cost-effective recovery. Cross-AZ redundancy matches 'High availability within region' for fault tolerance. Global content distribution matches 'Minimize latency worldwide' via edge locations."

KEEP IT CLEAN FOR ALL TYPES:
  ✅ Focus on technical correctness and exam relevance
  ✅ Explain each option's relevance or irrelevance
  ✅ Use standard AWS terminology
  ✅ Reference AWS Well-Architected Framework principles
  ✅ Use Option letters (A, B, C, D, E) consistently
  
  ❌ Don't use code-style identifiers or anti-pattern codes
  ❌ Don't reference internal anti-pattern databases
  ❌ Don't use numbered indices (0, 1, 2, 3)
  ❌ Don't add metadata or tags to answers

MODULES TO COVER:
${moduleSection}

${typeFormats}

═══════════════════════════════════════════════════════
🔴 FINAL VERIFICATION CHECKLIST BEFORE SUBMITTING
═══════════════════════════════════════════════════════

BEFORE YOU OUTPUT YOUR QUESTIONS, VERIFY:

1. QUESTION COUNT & DISTRIBUTION:
   ✓ Exactly ${totalQuestions} questions total
   ✓ ${questionsPerModule} questions per module
   ✓ All questions from specified modules only

2. MCQ QUESTIONS (if applicable):
   ✓ type: "mcq" field present
   ✓ correct_answer is an ARRAY with single INTEGER: [0], [1], [2], or [3] (NEVER string or number)
   ✓ options is an ARRAY of strings
   ✓ matches is NULL
   ✓ pairs is NULL
   ✓ Explanation uses Option letters (A, B, C, D) not indices
   ✓ ${wordMin}-${wordMax} word stems

3. MULTIPLE QUESTIONS (if applicable):
   ✓ type: "multiple" field present
   ✓ correct_answer is an ARRAY with 2-3 INTEGERS: [0, 1] or [0, 1, 2] (NOT strings)
   ✓ options is an ARRAY of strings with 5 items
   ✓ matches is NULL
   ✓ pairs is NULL
   ✓ Question text includes "(Select TWO.)" or "(Select THREE.)"
   ✓ Must have 5 options total (2-3 correct + 2-3 wrong)
   ✓ All indices valid (0-4 for 5 options)
   ✓ ${wordMin}-${wordMax} word stems

4. ORDERING QUESTIONS (if applicable):
   ✓ type: "ordering" field present
   ✓ correct_answer is an ARRAY of INTEGERS showing sequence: [2, 0, 3, 1]
   ✓ options is an ARRAY of strings
   ✓ matches is NULL
   ✓ pairs is NULL
   ✓ Array length matches number of options
   ✓ All indices valid and unique

5. MATCHING QUESTIONS (if applicable):
   ✓ type: "matching" field present
   ✓ pairs is OBJECT with "left" and "right" ARRAYS of strings
   ✓ matches is OBJECT with "left" (sequential [0,1,2,...]) and "right" (permutation) INTEGER ARRAYS
   ✓ correct_answer is NULL
   ✓ options is NULL
   ✓ Left and right arrays in pairs same length
   ✓ Left and right arrays in matches same length as pairs
   ✓ matches.left is sequential: [0, 1, 2, ...] or [0, 1, 2, 3, 4]
   ✓ matches.right is permutation of indices (each index used once)
   ✓ All indices valid

6. ALL QUESTIONS:
   ✓ Stem length: ${wordMin}-${wordMax} words (for MCQ/Multiple)
   ✓ Cognitive level: ${cognitiveLevel.toUpperCase()} (NOT recall/definition)
   ✓ Exam-realistic difficulty
   ✓ Scenario-based with technical constraints
   ✓ Distractors are architecturally valid but flawed
   ✓ Explanations use Option letters, not indices
   ✓ NO anti-pattern identifiers in explanations
   ✓ NO metadata or tags
   ✓ All indices in correct_answer match option positions
   ✓ Each question tests distinct scenario/concept

7. CRITICAL FOR MULTIPLE QUESTIONS:
   ❌ DO NOT SUBMIT IF ANY MULTIPLE QUESTION HAS:
      - correct_answer as single integer: 0, 1, 2, 3, 4
      - correct_answer as single-element array: [0], [1], [2]
      - correct_answer as string: "0", "1", "0,1"
      - correct_answer with strings not integers: ["0", "1"]
      - 4+ elements in correct_answer array
      - Missing "(Select TWO.)" or "(Select THREE.)" in question text
   
   ✅ VERIFY EVERY MULTIPLE QUESTION HAS:
      - correct_answer: [X, Y] or [X, Y, Z] format (2-3 INTEGERS, not strings)
      - 2-3 correct options that actually make sense
      - 2-3 wrong options that are plausibly but flawed
      - Clear explanation of why each option is correct or wrong

8. CRITICAL FOR MATCHING QUESTIONS:
   ❌ DO NOT SUBMIT IF ANY MATCHING QUESTION HAS:
      - correct_answer is not NULL
      - options is not NULL
      - pairs field missing
      - matches field missing
      - pairs.left and pairs.right different lengths
      - matches.left is not sequential [0, 1, 2, ...]
      - matches arrays different lengths than pairs arrays
      - matches.right contains duplicate indices
      - matches.right indices out of range for pairs.right length
   
   ✅ VERIFY EVERY MATCHING QUESTION HAS:
      - correct_answer: null
      - options: null
      - pairs: {"left": [...], "right": [...]} ARRAY of strings
      - matches: {"left": [0, 1, 2, ...], "right": [?, ?, ?, ...]} ARRAY of integers
      - All arrays properly formatted and indices valid

9. JSON VALIDITY:
   ✓ Valid JSON array format
   ✓ All required fields present
   ✓ No syntax errors
   ✓ Proper escaping of special characters
   ✓ NULL values represented as null (not "null" string)
   ✓ Integer arrays represented as [0, 1, 2] (not ["0", "1", "2"])
   ✓ String arrays properly quoted and escaped

═══════════════════════════════════════════════════════

RESPOND WITH ONLY A VALID JSON ARRAY. No markdown, no explanation, no preamble. Just the JSON array.
`;
}

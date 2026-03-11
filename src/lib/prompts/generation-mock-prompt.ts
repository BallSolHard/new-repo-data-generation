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
  
  3️⃣ REFERENCE ANTI-PATTERNS IN WRONG OPTIONS:
     "This represents [ap-1.2-001] by [explaining the misconception]"

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

MODULES TO COVER:
${moduleSection}

${typeFormats}

RESPOND WITH ONLY A VALID JSON ARRAY. No markdown, no explanation, no preamble. Just the JSON array.
`;
}

// V2 generation prompt builder — tier-aware, mode-specific prompt assembly

import type { ExamGuide, ExamDomain, ExamTask, QuestionType } from '@/lib/types/exam-guide';
import type { CertTier, GenMode } from '@/lib/types/tier';
import type { ModuleInput } from '@/lib/types/generation';
import type { ReferenceQuestion } from '@/lib/types/reference-question';
import { getSystemInstruction } from './system-instructions';
import { buildFewShotSection } from './few-shot';
import { getAnswerBiasRules, getQuestionTypeFormats } from './generation';
import { getTierProfile, getModeProfile } from './tier-profiles';
import { buildHubPrompt } from './generation-hub-prompt';
import { buildMockPrompt } from './generation-mock-prompt';

/**
 * 'hub'  — Practice hub: loosely enforced standards.
 *           Allows slightly shorter stems, broader scenarios.
 *           Good for volume generation where some rejection is acceptable.
 *
 * 'mock' — Mock test: strictly enforced standards.
 *           Must hit exact word counts, Application/Analysis cognitive level,
 *           realistic constraints, and no hints in stem.
 *           Used for exam-simulation quality questions.
 */
export type GenerationContext = 'hub' | 'mock';

export interface V2GenerationPromptParams {
  examGuide: ExamGuide;
  domainContext?: ExamDomain;  // Optional — may be undefined if domain lookup fails
  targetTask?: ExamTask;        // for drill mode: narrow to one task
  certTier: CertTier;
  genMode: GenMode;
  modules: ModuleInput[];
  totalQuestions: number;
  questionTypes: QuestionType[];
  fewShotExamples?: ReferenceQuestion[];
  serperContext?: string;
  /** Controls how strictly quality standards are enforced. Defaults to 'hub'. */
  generationContext?: GenerationContext;
}

export function createGenerationPrompt(params: V2GenerationPromptParams): string {
  const {
    examGuide,
    domainContext,
    targetTask,
    certTier,
    genMode,
    modules,
    totalQuestions,
    questionTypes,
    fewShotExamples,
    serperContext,
    generationContext = 'hub',
  } = params;

  const tierProfile = getTierProfile(certTier);
  const modeProfile = getModeProfile(genMode);

  // 1. System instruction
  const systemPrompt = getSystemInstruction(examGuide.provider || 'aws');

  // 2. Tier profile block
  const tierBlock = buildTierBlock(tierProfile);

  // 3. Mode block (strictly isolated — never leak cross-mode terminology)
  const modeBlock = buildModeBlock(modeProfile);

  // 4. Exam guide context with anti-patterns
  const examGuideSection = buildExamGuideSection(examGuide, domainContext, targetTask, genMode);

  // 5. Anti-pattern usage instructions
  const antiPatternInstructions = buildAntiPatternInstructions(domainContext, targetTask);

  // 6. Few-shot examples
  const fewShotSection = fewShotExamples?.length ? buildFewShotSection(fewShotExamples) : '';

  // 7. Answer bias rules
  const answerBiasRules = getAnswerBiasRules(totalQuestions);

  // 8. Quality standards — loose for hub, strict for mock
  const qualityStandards = buildQualityStandards(generationContext, tierProfile);

  // 8. Uniqueness/duplication instructions
  const duplicationInstructions = `
═══════════════════════════════════════════════════════
UNIQUENESS REQUIREMENTS
═══════════════════════════════════════════════════════
Each question must test a different scenario.
Do not reuse the same stem, the same set of distractors, or the same scenario twice.
After you generate a question, mark it internally and never produce another with 6970% text overlap.
If the model thinks of a concept it already used, invent a new constraint or service.
═══════════════════════════════════════════════════════
`;

  // 9. Module context
  const moduleSection = modules
    .map((m, i) => {
      let entry = `Module ${i + 1}:\n  - ID: ${m.module_id}\n  - Name: ${m.module_name}`;
      if (m.module_description) entry += `\n  - Description: ${m.module_description}`;
      if (m.module_content) entry += `\n  - Content: ${m.module_content.slice(0, 1000)}`;
      return entry;
    })
    .join('\n\n');

  // 10. Question type formats
  const typeFormats = getQuestionTypeFormats(questionTypes);

  const questionsPerModule = Math.max(1, Math.ceil(totalQuestions / modules.length));

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
Question types to use: ${questionTypes.join(', ')}

${generationContext === 'hub' ? `
⚠️ CRITICAL: Of the ${totalQuestions} questions, you MUST generate AT LEAST ${Math.ceil(totalQuestions * 0.4)} DEFINITION questions (40% minimum).
   Definition questions are 10-30 words and ask "What is...", "Which service...", "What does... do?"
   Generate definition questions FIRST, then fill remaining quota with application/analysis questions.
` : ''}
${answerBiasRules}

${qualityStandards}

${duplicationInstructions}

MODULES TO COVER:
${moduleSection}

${typeFormats}

RESPOND WITH ONLY A VALID JSON ARRAY. No markdown, no explanation, no preamble. Just the JSON array.`;

  // Use separate prompt templates based on generation context
  const hubPromptParams = {
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
    selectedQuestionTypes: questionTypes,
  };

  const mockPromptParams = {
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
  };

  if (generationContext === 'hub') {
    return buildHubPrompt(hubPromptParams);
  } else {
    return buildMockPrompt(mockPromptParams);
  }
}

function buildTierBlock(tier: import('@/lib/types/tier').TierProfile): string {
  return `
═══════════════════════════════════════════════════════
CERTIFICATION TIER: ${tier.tier.toUpperCase()}
═══════════════════════════════════════════════════════

STEM LENGTH: ${tier.stemLength} (${tier.stemWordRange[0]}-${tier.stemWordRange[1]} words)
COGNITIVE LEVEL: ${tier.cognitiveLevel}
SERVICE INTERACTION: ${tier.serviceInteraction}
CONSTRAINT PROFILE: ${tier.constraintProfile}

SCENARIO COMPLEXITY:
${tier.scenarioComplexity}

DISTRACTOR STRATEGY:
${tier.distractorStrategy}
═══════════════════════════════════════════════════════`;
}

function buildModeBlock(mode: import('@/lib/types/tier').ModeProfile): string {
  return `
═══════════════════════════════════════════════════════
GENERATION MODE: ${mode.mode.toUpperCase()}
═══════════════════════════════════════════════════════

FOCUS: ${mode.focus}
KNOWLEDGE SCOPE: ${mode.ksScope === 'single' ? 'One knowledge statement per question' : 'Combine 2-3 knowledge statements per question'}

QUESTION BEHAVIOR:
${mode.questionBehavior}
═══════════════════════════════════════════════════════`;
}

function buildExamGuideSection(
  examGuide: ExamGuide,
  domainContext: ExamDomain | undefined,
  targetTask: ExamTask | undefined,
  genMode: GenMode,
): string {
  // If no domain context, return minimal exam guide info
  if (!domainContext) {
    return `
═══════════════════════════════════════════════════════
EXAM GUIDE CONTEXT
═══════════════════════════════════════════════════════
Certification: ${examGuide.certificationName}
Version: ${examGuide.version}

NOTE: Domain context unavailable. Generate questions based on the modules and certification level provided.
`;
  }

  const tasks = genMode === 'drill' && targetTask
    ? [targetTask]
    : domainContext.tasks;

  const taskSection = tasks
    .map(t => {
      const ks = t.knowledgeStatements.map(k => `    - ${k.text}`).join('\n');
      const ap = t.antiPatterns?.length
        ? '\n    Anti-patterns:\n' + t.antiPatterns.map(a => `      - [${a.id}] ${a.misconception} → ${a.whyWrong}`).join('\n')
        : '';
      return `  ${t.id}: ${t.text}\n${ks}${ap}`;
    })
    .join('\n');

  const services = domainContext.inScopeServices.map(s => s.name).join(', ');

  return `
═══════════════════════════════════════════════════════
EXAM GUIDE CONTEXT — Use this as your authoritative source
═══════════════════════════════════════════════════════

Certification: ${examGuide.certificationName} (${examGuide.certificationCode})
Tier: ${examGuide.tier || 'associate'}
Exam Format: ${examGuide.examFormat.totalQuestions} questions, ${examGuide.examFormat.duration} minutes
Passing Score: ${examGuide.examFormat.passingScore}/1000
Question Types on Real Exam: ${examGuide.examFormat.questionTypes.join(', ')}

DOMAIN: ${domainContext.name} (${domainContext.weightPercent}% of the exam)

TASKS & KNOWLEDGE STATEMENTS (you MUST test these):
${taskSection}

IN-SCOPE AWS SERVICES (ONLY use these services in questions):
${services}

${examGuide.outOfScopeTopics?.length ? `OUT-OF-SCOPE (do NOT ask about): ${examGuide.outOfScopeTopics.join('; ')}` : ''}
═══════════════════════════════════════════════════════`;
}

function buildQualityStandards(
  context: GenerationContext,
  tier: import('@/lib/types/tier').TierProfile,
): string {
  const wordMin = 10; // Loosened minimum - allow shorter questions
  const wordMax = tier.stemWordRange[1];
  const cognitiveLevel = tier.cognitiveLevel;

  if (context === 'hub') {
    // Hub mode — flexible requirements to support both basic and scenario-based questions
    return `
═══════════════════════════════════════════════════════
QUESTION QUALITY STANDARDS (Practice Hub - Flexible)
═══════════════════════════════════════════════════════

⚠️ MANDATORY REQUIREMENT: You MUST generate AT LEAST 40% definition questions.
   For every 10 questions, generate AT LEAST 4 definition-style questions.
   For 5 questions, generate AT LEAST 2 definition questions.
   This is NON-NEGOTIABLE. Do not skip this requirement.

STEM LENGTH — FLEXIBLE: Minimum ${wordMin} words, maximum ${wordMax} words
  ✅ SHORT QUESTIONS (10-30 words): Definition and basic concept questions
  ✅ MEDIUM QUESTIONS (30-60 words): Single-service application questions
  ✅ LONG QUESTIONS (60-120 words): Multi-service scenario-based questions
  → TIP: Mix question lengths to provide variety and test different knowledge depths

COGNITIVE LEVELS — MIX OF ALL LEVELS REQUIRED:
  
  1️⃣ RECALL/DEFINITION (10-30 words) — MUST include these:
     ✅ "What is Amazon S3 primarily used for?"
     ✅ "Which AWS service provides managed relational databases?"
     ✅ "What does Amazon CloudWatch do?"
     ✅ "What is the primary purpose of Amazon SageMaker?"
     ✅ "Which service enables real-time streaming data processing?"
     → CRITICAL: Start with definition questions FIRST, then add scenario questions
     → These test foundational knowledge and are quick to answer
  
  2️⃣ APPLICATION (30-60 words) — Single-service scenario:
     ✅ "A company needs to store 10TB of infrequently accessed data. Which S3 storage class minimizes cost?"
     → Use these for understanding service features and use cases
  
  3️⃣ ANALYSIS (60-120 words) — Multi-service scenario with constraints:
     ✅ "A financial institution processes sensitive customer data requiring encryption at rest and in transit, with audit trails for all access. The solution must minimize operational overhead. Which combination of AWS services best meets these requirements?"
     → Use these for complex problem-solving and tradeoff analysis

MANDATORY QUESTION MIX (STRICTLY ENFORCED):
  - MINIMUM 40% Definition/Recall questions (10-30 words each)
  - UP TO 30% Application questions (30-60 words each)
  - UP TO 30% Analysis questions (60-120 words each)
  
  ⚠️ GENERATION ORDER: Generate definition questions FIRST, then fill remaining quota with application/analysis

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
  
  EXAMPLES FOR THIS EXAM:
  ✅ "What is Amazon SageMaker primarily used for?"
  ✅ "Which service provides managed machine learning model hosting?"
  ✅ "What does Amazon SageMaker Model Monitor detect?"
  ✅ "Which AWS service automates bias detection in ML models?"
  ✅ "What is the primary purpose of Amazon SageMaker Clarify?"
  ✅ "Which service provides real-time ML model predictions?"
  ✅ "What does Amazon SageMaker Autopilot automate?"
  ✅ "Which AWS service stores training datasets?"

CALCULATION HELPER FOR QUESTION MIX:
  
  ⚠️ FORMULA: Definition questions = MINIMUM 40% of total
  
  Example for 10 questions:
    - Definition: AT LEAST 4 questions (10-30 words each) ← START HERE
    - Application: 3 questions (30-60 words each)
    - Analysis: 3 questions (60-120 words each)
  
  Example for 5 questions:
    - Definition: AT LEAST 2 questions (10-30 words each) ← START HERE
    - Application: 2 questions (30-60 words each)
    - Analysis: 1 question (60-120 words each)
  
  Example for 20 questions:
    - Definition: AT LEAST 8 questions (10-30 words each) ← START HERE
    - Application: 6 questions (30-60 words each)
    - Analysis: 6 questions (60-120 words each)
═══════════════════════════════════════════════════════`;
  }

  // mock — strict, mirrors exactly what the validator checks
  return `
═══════════════════════════════════════════════════════
QUESTION QUALITY STANDARDS (Mock Test — STRICTLY ENFORCED)
═══════════════════════════════════════════════════════

STEM LENGTH: Every stem MUST be ${wordMin}-${wordMax} words. Count before submitting.
  ✅ Acceptable: ${wordMin} words   ❌ Rejected: ${wordMin - 5} words or fewer
  → Use word counter: describe current architecture + business constraint + desired outcome

COGNITIVE LEVEL — ${cognitiveLevel} ONLY. Recall questions will be rejected.
  ❌ RECALL:       "What does Amazon S3 do?"
  ❌ RECALL:       "Which service provides object storage?"
  ✅ APPLICATION:  "A company stores 500TB of infrequently accessed logs. Which storage option minimizes cost while maintaining retrieval under 12 hours?"
  ✅ ANALYSIS:     "Given conflicting requirements for low latency AND lowest cost, which architecture best balances these constraints?"

SCENARIO RULES:
  - Describe the BUSINESS PROBLEM, never name the solution in the stem
  - Include exactly ONE constraint (e.g. "lowest cost", "least operational overhead", "real-time")
  - ❌ WRONG: "They need alerts when spending exceeds a threshold. Which alerting service..."
  - ✅ RIGHT:  "A finance team must prevent unexpected cloud overspend by receiving notifications when costs approach budget limits. Which approach..."
  - Banned stem patterns: "What is...", "Which service provides...", "Define...", "Identify the service for..."

DISTRACTORS — ALL MUST REPRESENT ANTI-PATTERNS:
  - Each wrong option must embody a specific misconception from the exam guide anti-patterns
  - Reference anti-pattern IDs in explanations: "This represents [ap-1.2-001] by..."
  - All 4 options must be real AWS services plausible for the scenario domain
  - No obviously wrong services (e.g., Amazon Polly for database queries)

ANSWER/EXPLANATION CONSISTENCY — VALIDATION WILL VERIFY:
  1. The correct_answer index MUST match which option the explanation defends as correct
  2. If explanation says "Option B is correct", then correct_answer must be {1} (zero-indexed)
  3. Index mismatches = instant rejection regardless of content quality
  4. Verify: options array position matches JSON index: [optionA, optionB, optionC, optionD] → {0, 1, 2, 3}

FACTUAL ACCURACY CHECKS — VALIDATOR WILL FLAG:
  - AWS service capabilities (e.g., Comprehend analyzes TEXT not AUDIO)
  - Service use cases (e.g., Textract extracts from DOCUMENTS, Rekognition analyzes IMAGES)
  - Architecture patterns (e.g., Batch Transform is for BATCH not REAL-TIME inference)
═══════════════════════════════════════════════════════`;
}

function buildAntiPatternInstructions(  domainContext: ExamDomain | undefined,
  targetTask?: ExamTask,
): string {
  if (!domainContext) return '';

  const tasks = targetTask ? [targetTask] : domainContext.tasks;
  const hasAntiPatterns = tasks.some(t => t.antiPatterns && t.antiPatterns.length > 0);

  if (!hasAntiPatterns) return '';

  return `
═══════════════════════════════════════════════════════
ANTI-PATTERN USAGE — Power realistic distractors
═══════════════════════════════════════════════════════

The tasks above include ANTI-PATTERNS — common misconceptions that real exam candidates hold.
Use these anti-patterns to craft realistic, plausible wrong answers:

1. Each distractor SHOULD embody a specific anti-pattern misconception where applicable
2. The explanation MUST identify which anti-pattern the wrong answer represents
3. Anti-patterns help you create wrong answers that feel correct to under-prepared candidates
4. Do NOT simply copy the anti-pattern text as an option — transform it into a concrete architectural choice

This makes questions more effective at testing genuine understanding vs. surface-level memorization.
═══════════════════════════════════════════════════════`;
}

// V2 generation prompt builder — tier-aware, mode-specific prompt assembly

import type { ExamGuide, ExamDomain, ExamTask, QuestionType } from '@/lib/types/exam-guide';
import type { CertTier, GenMode } from '@/lib/types/tier';
import type { ModuleInput } from '@/lib/types/generation';
import type { ReferenceQuestion } from '@/lib/types/reference-question';
import { getSystemInstruction } from './system-instructions';
import { buildFewShotSection } from './few-shot';
import { getAnswerBiasRules, getQuestionTypeFormats } from './generation';
import { getTierProfile, getModeProfile } from './tier-profiles';

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

${answerBiasRules}

═══════════════════════════════════════════════════════
QUESTION QUALITY STANDARDS (Certification Exam Level)
═══════════════════════════════════════════════════════

STEM LENGTH & WORD COUNT:
- Must meet the Associate tier word count requirement (60-120 words for detailed context)
- Use clear, concise business language
- Provide sufficient context so the question tests understanding, not guesswork
- Do NOT include technical jargon or service names in the stem
- Do NOT describe the solution in the question

COGNITIVE LEVEL (Application/Analysis - Not just Recall):
- RECALL/COMPREHENSION (❌ too easy): Simple facts, definitions, "what is X"
- APPLICATION (✓ better): Applying knowledge to new scenarios, "which service would..."
- ANALYSIS (✓ best): Comparing options, trade-offs, "which is most appropriate given..."
- SYNTHESIS (✓ expert level): Combining multiple concepts

QUESTION TYPE (SCENARIO-BASED):
Describe the BUSINESS PROBLEM the company faces, not the AWS service
❌ WRONG: "Company wants to use AWS Budgets to monitor costs. Which feature..."
✅ RIGHT: "Company needs to prevent overspending and get early warnings. What service..."

NO HINTS IN STEM:
❌ WRONG: "They need proactive alerts when costs approach threshold. Which alerting service..."
✅ RIGHT: "They need to monitor costs and prevent overspending. Which service..."

Do NOT include: "alert", "monitor", "track", "receive notifications", "threshold", "proactive", "implement", "configure", "enable" — these are solution hints.

DISTRACTOR QUALITY:
- All 4 options must be AWS services that COULD plausibly fit the scenario
- Distractors should be tempting to someone with partial knowledge
- Do NOT use obviously wrong services (e.g., "S3 for cost monitoring")
- Use anti-patterns from the exam guide where applicable

REALISTIC SCENARIOS:
- Scenarios must reflect real-world AWS usage patterns
- Include realistic constraints: budget, performance, compliance, scalability
- Avoid contrived situations
- Base scenarios on common migration or deployment challenges

WORD COUNT EXAMPLES:

TOO SHORT (11 words - REJECT):
"A company needs cloud services. Which AWS service is best?"

BETTER (32 words - Acceptable):
"A company is migrating its on-premises database to AWS. They need high availability with automatic failover, read replicas for reporting, and cost efficiency. Which RDS feature best meets these requirements?"

BEST (56+ words - Use this as minimum):
"An enterprise is moving its e-commerce platform from on-premises to AWS. Currently, their database handles 10,000 transactions per second with strict latency requirements. They need to ensure the database can scale horizontally, handle unexpected traffic spikes, and maintain ACID compliance. Which AWS database service best addresses these requirements while minimizing operational overhead?"

═══════════════════════════════════════════════════════

${duplicationInstructions}

MODULES TO COVER:
${moduleSection}

${typeFormats}

RESPOND WITH ONLY A VALID JSON ARRAY. No markdown, no explanation, no preamble. Just the JSON array.`;
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

function buildAntiPatternInstructions(
  domainContext: ExamDomain | undefined,
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

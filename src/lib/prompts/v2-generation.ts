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
  domainContext: ExamDomain;
  targetTask?: ExamTask;        // for drill mode: narrow to one task
  certTier: CertTier;
  genMode: GenMode;
  modules: ModuleInput[];
  totalQuestions: number;
  questionTypes: QuestionType[];
  fewShotExamples?: ReferenceQuestion[];
}

export function createV2GenerationPrompt(params: V2GenerationPromptParams): string {
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

  // 8. Module context
  const moduleSection = modules
    .map((m, i) => {
      let entry = `Module ${i + 1}:\n  - ID: ${m.module_id}\n  - Name: ${m.module_name}`;
      if (m.module_description) entry += `\n  - Description: ${m.module_description}`;
      if (m.module_content) entry += `\n  - Content: ${m.module_content.slice(0, 1000)}`;
      return entry;
    })
    .join('\n\n');

  // 9. Question type formats
  const typeFormats = getQuestionTypeFormats(questionTypes);

  const questionsPerModule = Math.max(1, Math.ceil(totalQuestions / modules.length));

  return `${systemPrompt}

${tierBlock}

${modeBlock}

${examGuideSection}

${antiPatternInstructions}

${fewShotSection}

TASK: Generate exactly ${totalQuestions} ${examGuide.certificationName} exam questions as a valid JSON array.
Generate ${questionsPerModule} question(s) per module.
Question types to use: ${questionTypes.join(', ')}

${answerBiasRules}

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
  domainContext: ExamDomain,
  targetTask: ExamTask | undefined,
  genMode: GenMode,
): string {
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
  domainContext: ExamDomain,
  targetTask?: ExamTask,
): string {
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

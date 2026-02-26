import type { ExamGuide, ExamDomain, QuestionType } from '@/lib/types/exam-guide';
import type { Difficulty } from '@/lib/types/reference-question';
import type { ModuleInput, ReferenceQuestion } from '@/lib/types';
import { getSystemInstruction } from './system-instructions';
import { buildFewShotSection } from './few-shot';

interface GenerationPromptParams {
  modules: ModuleInput[];
  topicName: string;
  topicDescription?: string;
  certificationName: string;
  questionsPerModule: number;
  questionTypes: QuestionType[];
  complexityLevel: Difficulty;
  isProfessionalOrSpecialty?: boolean;
  examGuide?: ExamGuide;
  domainContext?: ExamDomain;
  fewShotExamples?: ReferenceQuestion[];
}

export function createGenerationPrompt(params: GenerationPromptParams): string {
  const {
    modules,
    topicName,
    topicDescription,
    certificationName,
    questionsPerModule,
    questionTypes,
    complexityLevel,
    isProfessionalOrSpecialty,
    examGuide,
    domainContext,
    fewShotExamples,
  } = params;

  const totalQuestions = modules.length * questionsPerModule;
  const systemPrompt = getSystemInstruction(examGuide?.provider || 'aws');
  const fewShotSection = fewShotExamples ? buildFewShotSection(fewShotExamples) : '';

  // ─── Exam Guide Context ───
  let examGuideSection = '';
  if (examGuide && domainContext) {
    const tasks = domainContext.tasks
      .map(t => {
        const ks = t.knowledgeStatements.map(k => `    - ${k.text}`).join('\n');
        return `  ${t.id}: ${t.text}\n${ks}`;
      })
      .join('\n');

    const services = domainContext.inScopeServices.map(s => s.name).join(', ');

    examGuideSection = `
═══════════════════════════════════════════════════════
EXAM GUIDE CONTEXT — Use this as your authoritative source
═══════════════════════════════════════════════════════

Certification: ${examGuide.certificationName} (${examGuide.certificationCode})
Exam Format: ${examGuide.examFormat.totalQuestions} questions, ${examGuide.examFormat.duration} minutes
Passing Score: ${examGuide.examFormat.passingScore}/1000
Question Types on Real Exam: ${examGuide.examFormat.questionTypes.join(', ')}

DOMAIN: ${domainContext.name} (${domainContext.weightPercent}% of the exam)

TASKS & KNOWLEDGE STATEMENTS (you MUST test these):
${tasks}

IN-SCOPE AWS SERVICES (ONLY use these services in questions):
${services}

${examGuide.outOfScopeTopics?.length ? `OUT-OF-SCOPE (do NOT ask about): ${examGuide.outOfScopeTopics.join('; ')}` : ''}
═══════════════════════════════════════════════════════
`;
  }

  // ─── Module Context ───
  const moduleSection = modules
    .map((m, i) => {
      let entry = `Module ${i + 1}:
  - ID: ${m.module_id}
  - Name: ${m.module_name}`;
      if (m.module_description) {
        entry += `\n  - Description: ${m.module_description}`;
      }
      if (m.module_content) {
        entry += `\n  - Content: ${m.module_content.slice(0, 1000)}`;
      }
      return entry;
    })
    .join('\n\n');

  // ─── Complexity Instructions ───
  const complexityInstructions = getComplexityInstructions(complexityLevel, isProfessionalOrSpecialty);

  // ─── Question Type Formats ───
  const typeFormats = getQuestionTypeFormats(questionTypes);

  // ─── Answer Bias Rules ───
  const answerBiasRules = getAnswerBiasRules(totalQuestions);

  return `${systemPrompt}

${examGuideSection}
${fewShotSection}

TASK: Generate exactly ${totalQuestions} ${certificationName} exam questions as a valid JSON array.
Generate ${questionsPerModule} question(s) per module.
Question types to use: ${questionTypes.join(', ')}

${complexityInstructions}

${answerBiasRules}

MODULES TO COVER:
${moduleSection}

${typeFormats}

RESPOND WITH ONLY A VALID JSON ARRAY. No markdown, no explanation, no preamble. Just the JSON array.`;
}

export function getComplexityInstructions(level: Difficulty, isProfessional?: boolean): string {
  if (isProfessional || level === 'advanced') {
    return `
COMPLEXITY: ADVANCED / PROFESSIONAL LEVEL
- Questions MUST be 3-6 sentences long (80-150+ words)
- Present complex enterprise scenarios with multiple variables and constraints
- Include specific metrics: data volumes, latency requirements, user counts, budget constraints
- Require evaluating tradeoffs between multiple valid approaches
- Test deep understanding of service interactions, not just individual service knowledge
- Include multi-service architectures where the candidate must identify the optimal combination
- Reference real-world patterns: multi-account strategies, hybrid cloud, disaster recovery, compliance frameworks`;
  }

  if (level === 'intermediate') {
    return `
COMPLEXITY: INTERMEDIATE / ASSOCIATE LEVEL
- Questions should be 2-4 sentences long (40-100 words)
- Present practical scenarios with clear business requirements
- Include specific constraints: "with LEAST operational overhead", "MOST cost-effective", "minimum latency"
- Test ability to choose the RIGHT service for a specific use case
- Options should include services from the same category (e.g., multiple database options, multiple compute options)
- Require understanding of when to use one service over another`;
  }

  return `
COMPLEXITY: BASIC / FOUNDATIONAL LEVEL
- Questions should be 1-2 sentences long (20-50 words)
- Test core concepts and fundamental service knowledge
- Focus on "what does this service do" and "when would you use it"
- Options should clearly differ in purpose
- Straightforward scenarios without complex constraints`;
}

export function getAnswerBiasRules(totalQuestions: number): string {
  return `
═══════════════════════════════════════════════════════
MANDATORY RULES — VIOLATION OF THESE INVALIDATES ALL OUTPUT
═══════════════════════════════════════════════════════

RULE 1: RANDOMIZE CORRECT ANSWER POSITION
- Distribute correct answers roughly equally across positions 0, 1, 2, and 3
- NEVER place more than 30% of correct answers in any single position
- Use this distribution for ${totalQuestions} questions: approximately ${Math.ceil(totalQuestions / 4)} per position

RULE 2: CORRECT ANSWER MUST NOT BE THE LONGEST OPTION
- For EVERY question, at least ONE wrong answer must be longer than the correct answer
- Correct answers should be concise and precise (typically 10-25 words)
- Include at least one verbose, overcomplicated wrong answer per question

RULE 3: ALL WRONG ANSWERS MUST BE PLAUSIBLE
- Every distractor must be a service/approach that EXISTS and COULD be considered
- Never use obviously wrong answers like "do nothing" or "avoid using AWS"
- Wrong answers should represent common misconceptions or suboptimal approaches

RULE 4: EXPLANATIONS MUST BE COMPREHENSIVE
 - Explain WHY the correct answer is correct (cite specific service behaviors)
 - Explain WHY EACH wrong answer is wrong (not just "this is incorrect")
 - Refer to the options by label/index (e.g. "Option A", "Option 2") when discussing them
 - Reference specific AWS service limitations, pricing models, or architectural tradeoffs
 - Minimum 3 sentences for explanation

RULE 5: TECHNICAL ACCURACY
- Use exact AWS service names (e.g., "Amazon S3" not "S3", "AWS Lambda" not "Lambda")
- Every service behavior mentioned must be factually correct
- If a question involves limits, quotas, or pricing models, they must be current and accurate
═══════════════════════════════════════════════════════`;
}

export function getQuestionTypeFormats(types: QuestionType[]): string {
  const formats: string[] = [`
OUTPUT FORMAT — Each question must be a JSON object in this exact structure:`];

  if (types.includes('mcq')) {
    formats.push(`
MCQ (Multiple Choice — single correct answer):
{
  "text": "Question text here...",
  "type": "mcq",
  "options": ["Option A", "Option B", "Option C", "Option D"],
  "correct_answer": "{N}",
  "explanation": "Detailed explanation covering why correct answer is right and why each wrong answer is wrong...",
  "module_id": "the_module_id"
}
Note: correct_answer uses format "{N}" where N is the 0-based index. E.g., "{0}" = first option, "{3}" = fourth option.`);
  }

  if (types.includes('multiple')) {
    formats.push(`
MULTIPLE SELECT (2-3 correct answers):
{
  "text": "Question text here... (Select TWO.)",
  "type": "multiple",
  "options": ["Option A", "Option B", "Option C", "Option D", "Option E"],
  "correct_answer": [0, 2],
  "explanation": "Detailed explanation...",
  "module_id": "the_module_id"
}
Note: correct_answer is an array of 0-based indices. Include "(Select TWO.)" or "(Select THREE.)" in the question text.`);
  }

  if (types.includes('ordering')) {
    formats.push(`
ORDERING (arrange steps in correct sequence):
{
  "text": "Arrange the following steps in the correct order to...",
  "type": "ordering",
  "options": ["Step shown first", "Step shown second", "Step shown third", "Step shown fourth"],
  "correct_answer": [2, 0, 3, 1],
  "explanation": "Detailed explanation of the correct sequence...",
  "module_id": "the_module_id"
}
Note: correct_answer is the indices representing the correct order. Options are shown in SHUFFLED order; correct_answer gives the reordering.`);
  }

  if (types.includes('matching')) {
    formats.push(`
MATCHING (pair terms to definitions):
{
  "text": "Match each AWS service to its primary use case.",
  "type": "matching",
  "options": {"A": "Amazon S3", "B": "Amazon RDS", "C": "AWS Lambda"},
  "pairs": {
    "left": ["Amazon S3", "Amazon RDS", "AWS Lambda"],
    "right": ["Object storage", "Relational database", "Serverless compute"]
  },
  "matches": {"left": [0, 1, 2], "right": [0, 1, 2]},
  "correct_answer": null,
  "explanation": "Detailed explanation...",
  "module_id": "the_module_id"
}
Note: left items max 5 words, right items max 12 words. The matches object maps left[i] to right[j].`);
  }

  return formats.join('\n');
}

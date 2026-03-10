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
  } = params;

  const definitionQuestionCount = Math.ceil(totalQuestions * 0.7);

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

⚠️ CRITICAL REQUIREMENT: Question Mix Distribution (70% Definition/Straightforward Focus)
   You MUST generate AT LEAST ${definitionQuestionCount} DEFINITION/STRAIGHTFORWARD questions (70% of total).
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

COGNITIVE LEVELS — 70% DEFINITION + 30% APPLICATION:

  1️⃣ DEFINITION/STRAIGHTFORWARD (6-30 words) — 70% OF ALL QUESTIONS:
     ✅ "What is Amazon S3 primarily used for?"
     ✅ "Which AWS service provides managed relational databases?"
     ✅ "What does Amazon CloudWatch do?"
     ✅ "What is the primary purpose of Amazon SageMaker?"
     ✅ "Which service enables real-time streaming data processing?"
     ✅ "What does AWS Lambda automate?"
     ✅ "Which service is designed for serverless computing?"
     → CRITICAL: Generate these FIRST, aim for 70% of total questions
     → These test foundational service knowledge and are quick to answer
     → Focus on service capabilities, features, and use cases
  
  2️⃣ APPLICATION/SCENARIO (30-120 words) — UP TO 20% OF QUESTIONS:
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

MODULES TO COVER:
${moduleSection}

${typeFormats}

RESPOND WITH ONLY A VALID JSON ARRAY. No markdown, no explanation, no preamble. Just the JSON array.
`;
}

# Exam Guide Fetch Flow — Practice Hub Question Generation

## Overview

When you generate practice hub questions, the **exam guide** is fetched and resolved through a multi-step process that combines static registry lookup with fuzzy matching.

## Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│ POST /api/generate-hub                                              │
│ (Client sends: certification_name, topic_name, modules, etc.)       │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
        ┌────────────────────────────────────────────┐
        │ generate-hub/route.ts                      │
        │ - Validates parameters                     │
        │ - Calls runGenerationPipeline()            │
        └────────────┬─────────────────────────────┘
                     │
                     ▼
        ┌────────────────────────────────────────────┐
        │ pipeline/index.ts — runGenerationPipeline()│
        │ - Coordinates the generation flow          │
        │ - Calls ingest() to fetch exam guide       │
        └────────────┬─────────────────────────────┘
                     │
                     ▼
        ┌────────────────────────────────────────────┐
        │ pipeline/ingest.ts — ingest()              │
        │ Step 1: Resolve Exam Guide                 │
        │ Step 2: Match domain to topic              │
        │ Step 3: Fetch few-shot examples            │
        └────────────┬─────────────────────────────┘
                     │
        ┌────────────┴──────────────────────────────┐
        │                                            │
        ▼                                            ▼
┌──────────────────────────────┐      ┌──────────────────────────────┐
│ exam-guides/index.ts         │      │ exam-guides/{provider}/...   │
│ - examGuideRegistry          │      │ - Individual exam guides     │
│ - getCurrentGuide()          │      │ - saa-c03.ts               │
│ - resolveGuideFromCertName() │      │ - clf-c02.ts               │
│ - slugAliases mapping        │      │ - aif-c01.ts               │
└──────────────────────────────┘      └──────────────────────────────┘
        │                                            │
        └────────────┬──────────────────────────────┘
                     │
                     ▼
        ┌────────────────────────────────────────────┐
        │ EXAM GUIDE OBJECT RETURNED                 │
        │ - certificationCode, certificationName     │
        │ - tier, examFormat                         │
        │ - domains[] (with tasks, knowledge stmts)  │
        │ - domainContext matched to topic_name      │
        └────────────┬─────────────────────────────┘
                     │
                     ▼
        ┌────────────────────────────────────────────┐
        │ prompts/generation-new.ts                  │
        │ - Builds prompt with exam guide context    │
        │ - Includes domain tasks, KS, anti-patterns │
        └────────────┬─────────────────────────────┘
                     │
                     ▼
        ┌────────────────────────────────────────────┐
        │ Gemini API Call with Exam Guide Context    │
        │ - Generates questions based on guide       │
        └────────────┬─────────────────────────────┘
                     │
                     ▼
        ┌────────────────────────────────────────────┐
        │ QUESTIONS GENERATED & RETURNED             │
        └────────────────────────────────────────────┘
```

## Detailed Flow

### Step 1: API Route — `/api/generate-hub/route.ts`

**File**: `src/app/api/generate-hub/route.ts`

```typescript
export async function POST(request: NextRequest) {
  const body = await request.json();
  const {
    certification_id,
    certification_code,
    certification_name,    // ← Used to resolve exam guide
    topic_name,           // ← Used to find domain in exam guide
    modules,              // ← Module context for generation
    // ... other params
  } = body;

  const pipelineParams: PipelineParams = {
    certificationCode: certification_code || '',
    certificationName: certification_name,  // ← Passed to pipeline
    topicName: topic_name,                  // ← Passed to pipeline
    modules: modules.map(...),
    // ... other pipeline params
  };

  const result = await runGenerationPipeline(pipelineParams);
  // ...
}
```

**Purpose**: Validates incoming request and passes parameters to the generation pipeline.

---

### Step 2: Pipeline — `pipeline/index.ts`

**File**: `src/lib/pipeline/index.ts`

```typescript
export async function runGenerationPipeline(
  params: PipelineParams
): Promise<GenerationResult> {
  // Step 1: Ingest — fetch exam guide and domain context
  const { examGuide, domainContext, fewShotExamples, examGuideVersion, ... } = 
    await ingest({
      certificationName: params.certificationName,   // ← From route
      certificationCode: params.certificationCode,   // ← From route
      topicName: params.topicName,                   // ← From route
      modules: params.modules,
      questionType: params.questionType,
      // ...
    });

  console.log(`[pipeline] Exam guide: ${examGuideVersion}, domain: ${domainContext?.name || 'none'}`);

  // Step 2: Generation — use exam guide to build prompt
  const generatedQuestions = await generate({
    examGuide,
    domainContext,
    fewShotExamples,
    modules: params.modules,
    // ...
  });

  // Step 3: Validation, Output, etc.
  // ...
}
```

**Purpose**: Orchestrates the pipeline stages:
1. **Ingest** — fetch exam guide
2. **Generate** — create questions with exam guide context
3. **Validate** — check quality
4. **Output** — format results

---

### Step 3: Ingest Logic — `pipeline/ingest.ts`

**File**: `src/lib/pipeline/ingest.ts`

This is where **exam guides are fetched**:

```typescript
export async function ingest(params: {
  certificationName: string;
  certificationCode?: string;
  topicName: string;
  modules: ModuleInput[];
  // ...
}): Promise<IngestResult> {
  
  // ─── STEP 1: RESOLVE EXAM GUIDE ───
  
  let examGuide: ExamGuide | undefined;
  
  // Try 1: Use certification code (exact match)
  if (certificationCode) {
    examGuide = getCurrentGuide(certificationCode);
  }
  
  // Try 2: Use certification name (fuzzy match)
  if (!examGuide) {
    examGuide = resolveGuideFromCertName(certificationName);
  }
  
  if (!examGuide) {
    console.warn(`[ingest] No exam guide found for: ${certificationName}`);
    return {
      examGuide: undefined,
      domainContext: undefined,
      fewShotExamples: [],
      examGuideVersion: 'unknown',
    };
  }

  // ─── STEP 2: MATCH TOPIC TO DOMAIN ───
  
  // Fuzzy match topic_name against domains in exam guide
  const domainContext = matchDomain(examGuide, topicName);

  if (!domainContext) {
    console.warn(`[ingest] Could not match topic "${topicName}" to any domain`);
  }

  // ─── STEP 3: FETCH FEW-SHOT EXAMPLES ───
  
  const domainId = domainContext?.id || '';
  const fewShotExamples = await selectFewShotExamplesV2(
    examGuide.certificationCode,
    domainId,
    { certTier, genMode, questionType, count: 3 }
  );

  return {
    examGuide,                    // ← Returned to pipeline
    domainContext,
    fewShotExamples,
    examGuideVersion: examGuide.version,
  };
}
```

---

### Step 4: Exam Guide Registry — `exam-guides/index.ts`

**File**: `src/data/exam-guides/index.ts`

This is the **central registry** where all exam guides are stored:

```typescript
// ─── STATIC IMPORT OF EXAM GUIDES ───
import { saaC03 } from './aws/solutions-architect-associate/saa-c03';
import { clfC02 } from './aws/cloud-practitioner/clf-c02';
import { aifC01 } from './aws/ai-practitioner/aif-c01';

// ─── REGISTRY MAPPING ───
const examGuideRegistry: Record<string, ExamGuide[]> = {
  'aws-solutions-architect-associate': [saaC03],
  'aws-cloud-practitioner': [clfC02],
  'aws-ai-practitioner': [aifC01],
};

// ─── ALIAS MAPPING ───
// Maps common names/codes to registry keys
const slugAliases: Record<string, string> = {
  'saa-c03': 'aws-solutions-architect-associate',
  'saa': 'aws-solutions-architect-associate',
  'clf-c02': 'aws-cloud-practitioner',
  'clf': 'aws-cloud-practitioner',
  'aif-c01': 'aws-ai-practitioner',
  'ai-practitioner': 'aws-ai-practitioner',
};

// ─── LOOKUP FUNCTIONS ───

/** Get current (non-retired) exam guide */
export function getCurrentGuide(slug: string): ExamGuide | undefined {
  const key = resolveSlug(slug);
  const guides = examGuideRegistry[key];
  if (!guides) return undefined;
  return guides.find(g => g.status === 'current') || guides[guides.length - 1];
}

/** Resolve certification name from Supabase to exam guide */
export function resolveGuideFromCertName(certName: string): ExamGuide | undefined {
  const lower = certName.toLowerCase();

  // Try alias lookup
  for (const [alias, key] of Object.entries(slugAliases)) {
    if (lower.includes(alias)) {
      return getCurrentGuide(key);
    }
  }

  // Try registry key matching
  for (const key of Object.keys(examGuideRegistry)) {
    const parts = key.split('-');
    const matches = parts.every(part => lower.includes(part));
    if (matches) return getCurrentGuide(key);
  }

  return undefined;
}
```

---

### Step 5: Individual Exam Guide File

**Example**: `exam-guides/aws/ai-practitioner/aif-c01.ts`

This is where the **actual exam guide data** is defined:

```typescript
export const aifC01: ExamGuide = {
  certificationCode: 'AIF-C01',
  certificationName: 'AWS Certified AI Practitioner',
  provider: 'aws',
  version: 'AIF-C01',
  tier: 'foundational',
  examFormat: {
    totalQuestions: 85,
    scoredQuestions: 65,
    duration: 120,
    passingScore: 700,
    questionTypes: ['mcq', 'multiple'],
  },
  domains: [
    {
      id: 'domain-1',
      name: 'Fundamentals of AI and ML',
      weightPercent: 20,
      tasks: [
        {
          id: 'task-1.1',
          text: 'Explain basic AI concepts and terminologies',
          knowledgeStatements: [
            { id: 'ks-1.1.1', text: 'Differences between AI, ML, DL, and generative AI' },
            // ... more KS
          ],
          antiPatterns: [
            {
              id: 'ap-1.1-001',
              misconception: 'Treating AI and ML as interchangeable terms',
              whyWrong: 'AI is broad concept... ML is subset...',
            },
            // ... more anti-patterns
          ],
        },
        // ... more tasks
      ],
      inScopeServices: [
        { name: 'Amazon SageMaker', category: 'Machine Learning' },
        // ... more services
      ],
    },
    // ... more domains
  ],
};
```

**Content**: Each exam guide contains:
- Metadata (code, name, tier, format)
- Domains (topics in the exam)
- Tasks (what students must learn)
- Knowledge statements (specific facts to test)
- Anti-patterns (common misconceptions)
- In-scope services (AWS services covered)

---

## Where Exam Guide is Used in Prompt Generation

**File**: `prompts/generation-new.ts`

Once fetched, the exam guide is embedded into the Gemini prompt:

```typescript
export function createGenerationPrompt(params: V2GenerationPromptParams): string {
  const { examGuide, domainContext, targetTask, ... } = params;

  // Build exam guide context section
  const examGuideSection = buildExamGuideSection(examGuide, domainContext, targetTask, genMode);
  
  // ... build other prompt sections ...
  
  return `${systemPrompt}
${tierBlock}
${modeBlock}
${examGuideSection}  ← EXAM GUIDE INJECTED HERE
${fewShotSection}
...`;
}

function buildExamGuideSection(
  examGuide: ExamGuide,
  domainContext: ExamDomain | undefined,
  targetTask: ExamTask | undefined,
): string {
  return `
═══════════════════════════════════════════════════════
EXAM GUIDE CONTEXT — Use this as your authoritative source
═══════════════════════════════════════════════════════

Certification: ${examGuide.certificationName} (${examGuide.certificationCode})
Tier: ${examGuide.tier}
Exam Format: ${examGuide.examFormat.totalQuestions} questions, ${examGuide.examFormat.duration} minutes
Passing Score: ${examGuide.examFormat.passingScore}/1000

DOMAIN: ${domainContext.name}
TASKS & KNOWLEDGE STATEMENTS (you MUST test these):
${tasks.map(t => `  ${t.text}`).join('\n')}

IN-SCOPE AWS SERVICES (ONLY use these):
${services.join(', ')}

OUT-OF-SCOPE (do NOT ask about):
${outOfScopeTopics.join('; ')}
═══════════════════════════════════════════════════════`;
}
```

The exam guide context tells Gemini:
- ✅ Which tasks/KS to test
- ✅ Which services are in-scope
- ✅ Which topics are out-of-scope
- ✅ Anti-patterns to use in distractors
- ✅ Tier and complexity requirements

---

## Adding a New Exam Guide

To add a new certification (e.g., Developer Associate DVA-C02):

### 1. Create Exam Guide File
**File**: `src/data/exam-guides/aws/developer-associate/dva-c02.ts`

```typescript
import type { ExamGuide } from '@/lib/types/exam-guide';

export const dvaC02: ExamGuide = {
  certificationCode: 'DVA-C02',
  certificationName: 'AWS Certified Developer – Associate',
  tier: 'associate',
  // ... full exam guide definition ...
};
```

### 2. Register in Index
**File**: `src/data/exam-guides/index.ts`

```typescript
import { dvaC02 } from './aws/developer-associate/dva-c02';

const examGuideRegistry: Record<string, ExamGuide[]> = {
  // ... existing entries ...
  'aws-developer-associate': [dvaC02],
};

const slugAliases: Record<string, string> = {
  // ... existing aliases ...
  'dva-c02': 'aws-developer-associate',
  'dva': 'aws-developer-associate',
  'developer-associate': 'aws-developer-associate',
};
```

### 3. Use in Generation
The new guide is immediately available when calling `/api/generate-hub` with:
```json
{
  "certification_name": "AWS Certified Developer – Associate",
  "certification_code": "DVA-C02",
  "topic_name": "Lambda and Serverless Computing",
  // ...
}
```

---

## Lookup Priority

When resolving an exam guide:

1. **By Code** (exact match)
   ```typescript
   getCurrentGuide('dva-c02')  // ← Matches quickly
   ```

2. **By Name** (fuzzy match)
   ```typescript
   resolveGuideFromCertName('AWS Developer Associate')
   // ↓ Matches against slugAliases
   // ↓ Then matches against registry keys
   // ↓ Returns corresponding guide
   ```

3. **Fallback** (no match)
   ```typescript
   if (!examGuide) {
     console.warn(`No exam guide found for: ${certificationName}`);
     return { examGuide: undefined, domainContext: undefined, ... };
   }
   ```

---

## Domain Matching Logic

Once exam guide is fetched, `matchDomain()` is called to find the relevant domain:

```typescript
const domainContext = matchDomain(examGuide, topicName);
```

**Logic**:
- Fuzzy matches `topicName` against all `domains[].name` in exam guide
- Returns the domain that best matches
- If no match, returns `undefined` (generation proceeds without domain context)

---

## Summary

**Flow**:
```
Request (cert_name, topic_name) 
  → ingest() 
    → getCurrentGuide() or resolveGuideFromCertName() 
      → examGuideRegistry lookup 
        → Individual exam guide file 
          → ExamGuide object
    → matchDomain(examGuide, topicName)
      → domainContext
  → Returned to pipeline
    → Embedded in Gemini prompt
      → Questions generated with exam guide context
```

**Key Files**:
- **Registry & Lookup**: `src/data/exam-guides/index.ts`
- **Ingest Logic**: `src/lib/pipeline/ingest.ts`
- **Individual Guides**: `src/data/exam-guides/aws/{cert}/*.ts`
- **Prompt Builder**: `src/lib/prompts/generation-new.ts`
- **API Route**: `src/app/api/generate-hub/route.ts`

**Data Flow**:
```
Static TypeScript files 
  → Loaded at startup 
    → Registry in memory 
      → Fetched by slug/name 
        → Injected into prompt 
          → Used by Gemini 
            → Questions generated
```


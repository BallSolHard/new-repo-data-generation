# Code Changes Summary

## File 1: `src/lib/kimi/client.ts` ✨ NEW FILE

```typescript
// Kimi API Configuration
const KIMI_API_KEY = process.env.KIMI_API_KEY || '';
const KIMI_BASE_URL = 'https://api.moonshot.cn/v1';
const KIMI_MODEL = 'moonshot-v1-8k';

// Model configurations (temperature, tokens, etc.)
export function getGenerationModel(enableWebSearch: boolean = true): KimiModel
export function getValidationModel(enableWebSearch: boolean = false): KimiModel
export async function generateContent(prompt: string, model: KimiModel): Promise<string>
export function parseKimiJson<T>(text: string): T  // JSON parser with fallbacks
```

**Features:**
- REST API calls to Moonshot
- Web search toggle
- Robust JSON parsing
- Same interface as Gemini client

---

## File 2: `src/lib/pipeline/generate.ts` 🔄 UPDATED

### Before:
```typescript
import { getGenerationModel, parseGeminiJson } from '@/lib/gemini/client';

export async function generate(
  params: QuestionGenerationParams,
  generationContext: GenerationContext = 'hub'
): Promise<GeneratedQuestion[]> {
  const model = getGenerationModel();
  const result = await model.generateContent(prompt);
  const responseText = result.response.text();
  let questions = parseGeminiJson<GeneratedQuestion[]>(responseText);
```

### After:
```typescript
import { getGenerationModel as getGeminiGenerationModel, parseGeminiJson } from '@/lib/gemini/client';
import { getGenerationModel as getKimiGenerationModel, generateContent as kimiGenerateContent, parseKimiJson } from '@/lib/kimi/client';

export type AIModel = 'gemini' | 'kimi';

export interface GenerateOptions {
  aiModel?: AIModel;
  kimiWebSearchEnabled?: boolean;
}

export async function generate(
  params: QuestionGenerationParams,
  generationContext: GenerationContext = 'hub',
  options?: GenerateOptions  // NEW PARAMETER
): Promise<GeneratedQuestion[]> {
  const aiModel = options?.aiModel || 'gemini';
  const kimiWebSearchEnabled = options?.kimiWebSearchEnabled !== false;

  let responseText: string;
  let parseFunction: typeof parseGeminiJson;

  if (aiModel === 'kimi') {
    const model = getKimiGenerationModel(kimiWebSearchEnabled);
    responseText = await kimiGenerateContent(prompt, model);
    parseFunction = parseKimiJson;
  } else {
    const model = getGeminiGenerationModel();
    const result = await model.generateContent(prompt);
    responseText = result.response.text();
    parseFunction = parseGeminiJson;
  }

  let questions = parseFunction<GeneratedQuestion[]>(responseText);
```

---

## File 3: `src/lib/pipeline/validate.ts` 🔄 UPDATED

### Before:
```typescript
import { getValidationModel, parseGeminiJson } from '@/lib/gemini/client';

export interface ValidateOptions {
  certificationName: string;
  domainContext?: ExamDomain;
  rejectLowConfidence?: boolean;
  certTier?: CertTier;
}

export async function validate(questions: GeneratedQuestion[], options: ValidateOptions) {
  const model = getValidationModel();
  // ... validation logic
}

async function validateSingleQuestion(
  model: ReturnType<typeof getValidationModel>,
  question: GeneratedQuestion,
  ...
) {
  const result = await model.generateContent(prompt);
  const responseText = result.response.text();
  let validation = parseGeminiJson<ValidationResponseType>(responseText);
```

### After:
```typescript
import { getValidationModel as getGeminiValidationModel, parseGeminiJson } from '@/lib/gemini/client';
import { getValidationModel as getKimiValidationModel, generateContent as kimiGenerateContent, parseKimiJson } from '@/lib/kimi/client';
import type { AIModel } from './generate';

export interface ValidateOptions {
  certificationName: string;
  domainContext?: ExamDomain;
  rejectLowConfidence?: boolean;
  certTier?: CertTier;
  aiModel?: AIModel;              // NEW
  kimiWebSearchEnabled?: boolean;  // NEW
}

export async function validate(questions: GeneratedQuestion[], options: ValidateOptions) {
  const { ..., aiModel = 'gemini', kimiWebSearchEnabled = false } = options;
  // ... validation logic with model selection
}

async function validateSingleQuestion(
  question: GeneratedQuestion,
  certificationName: string,
  certTier: CertTier,
  domainContext: ExamDomain | undefined,
  aiModel: AIModel = 'gemini',           // NEW PARAM
  kimiWebSearchEnabled: boolean = false  // NEW PARAM
): Promise<ValidationResponse> {
  let responseText: string;
  let parseFunction: typeof parseGeminiJson;

  if (aiModel === 'kimi') {
    const model = getKimiValidationModel(kimiWebSearchEnabled);
    responseText = await kimiGenerateContent(prompt, model);
    parseFunction = parseKimiJson;
  } else {
    const model = getGeminiValidationModel();
    const result = await model.generateContent(prompt);
    responseText = result.response.text();
    parseFunction = parseGeminiJson;
  }

  let validation = parseFunction<ValidationResponseType>(responseText);
```

---

## File 4: `src/lib/pipeline/index.ts` 🔄 UPDATED

### Changes (3 locations):

**Location 1 - Difficulty distribution loop:**
```typescript
// BEFORE:
const batch = await generate(subParams, params.generationContext ?? 'hub');

// AFTER:
const batch = await generate(subParams, params.generationContext ?? 'hub', {
  aiModel: params.aiModel,
  kimiWebSearchEnabled: params.kimiWebSearchEnabled,
});
```

**Location 2 - Default generation:**
```typescript
// BEFORE:
rawQuestions = (await generate(generationParams, params.generationContext ?? 'hub')).map(q => ({
  ...q,
  difficulty: generationParams.complexityLevel,
}));

// AFTER:
rawQuestions = (await generate(generationParams, params.generationContext ?? 'hub', {
  aiModel: params.aiModel,
  kimiWebSearchEnabled: params.kimiWebSearchEnabled,
})).map(q => ({
  ...q,
  difficulty: generationParams.complexityLevel,
}));
```

**Location 3 - Regeneration loop:**
```typescript
// BEFORE:
const extra = await generate(extraParams, params.generationContext ?? 'hub');

// AFTER:
const extra = await generate(extraParams, params.generationContext ?? 'hub', {
  aiModel: params.aiModel,
  kimiWebSearchEnabled: params.kimiWebSearchEnabled,
});
```

**Location 4 - Validation:**
```typescript
// BEFORE:
const { validated, rejected } = await validate(dedupedQuestions, {
  certificationName: params.certificationName,
  domainContext,
  rejectLowConfidence: true,
  certTier,
});

// AFTER:
const { validated, rejected } = await validate(dedupedQuestions, {
  certificationName: params.certificationName,
  domainContext,
  rejectLowConfidence: true,
  certTier,
  aiModel: params.aiModel,
  kimiWebSearchEnabled: params.kimiWebSearchEnabled,
});
```

---

## File 5: `src/lib/types/generation.ts` 🔄 UPDATED

### Before:
```typescript
export interface PipelineParams {
  // ... 28 existing fields ...
  generationContext?: import('@/lib/prompts/generation-new').GenerationContext;
}
```

### After:
```typescript
export interface PipelineParams {
  // ... 28 existing fields ...
  generationContext?: import('@/lib/prompts/generation-new').GenerationContext;
  // AI Model selection (NEW)
  aiModel?: 'gemini' | 'kimi';
  kimiWebSearchEnabled?: boolean;
}
```

---

## File 6: `src/app/api/generate-hub/route.ts` 🔄 UPDATED

### Before:
```typescript
interface RequestBody {
  // ... 13 existing fields ...
  complexityLevelDistribution?: Record<string, number>;
}

export async function POST(request: NextRequest) {
  const body: RequestBody = await request.json();
  
  body.questionType ??= 'mcq';
  body.complexityLevel ??= 'intermediate';
  body.questionsPerModule ??= 10;
  body.enableValidation ??= true;
  body.storeInBank ??= false;
  body.genMode ??= 'drill';
  body.modules ??= [];

  // ... rest of handler
  const pipelineParams: PipelineParams = {
    // ... 14 existing properties ...
    startIndexByModule,
  };
```

### After:
```typescript
import type { AIModel } from '@/lib/pipeline/generate';

interface RequestBody {
  // ... 13 existing fields ...
  complexityLevelDistribution?: Record<string, number>;
  aiModel?: AIModel;              // NEW
  kimiWebSearchEnabled?: boolean;  // NEW
}

export async function POST(request: NextRequest) {
  const body: RequestBody = await request.json();
  
  body.questionType ??= 'mcq';
  body.complexityLevel ??= 'intermediate';
  body.questionsPerModule ??= 10;
  body.enableValidation ??= true;
  body.storeInBank ??= false;
  body.genMode ??= 'drill';
  body.aiModel ??= 'gemini';              // NEW (defaults to Gemini)
  body.kimiWebSearchEnabled ??= true;     // NEW (defaults to true)
  body.modules ??= [];

  // ... rest of handler
  const pipelineParams: PipelineParams = {
    // ... 14 existing properties ...
    startIndexByModule,
    aiModel: body.aiModel,              // NEW
    kimiWebSearchEnabled: body.kimiWebSearchEnabled,  // NEW
  };
```

---

## Summary of Changes

| File | Type | Changes |
|------|------|---------|
| `src/lib/kimi/client.ts` | ✨ NEW | Entire file (200+ lines) |
| `src/lib/pipeline/generate.ts` | 🔄 Updated | Added model selection logic (20+ lines) |
| `src/lib/pipeline/validate.ts` | 🔄 Updated | Added model selection logic (25+ lines) |
| `src/lib/pipeline/index.ts` | 🔄 Updated | Added options to 4 function calls |
| `src/lib/types/generation.ts` | 🔄 Updated | Added 2 new fields |
| `src/app/api/generate-hub/route.ts` | 🔄 Updated | Added 3 new fields, 2 defaults |

**Total Impact:**
- Lines added: ~300
- Lines modified: ~15
- New files: 1
- Files touched: 6

**Backward Compatibility:** ✅ 100% - Old requests work unchanged

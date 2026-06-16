# Implementation Summary: Dual AI Model Support (Gemini + Kimi)

## Overview
Added support for selecting between **Gemini** and **Kimi** AI models for question generation and validation. Both models use the same templates and output format.

## Files Created

### 1. `src/lib/kimi/client.ts` (NEW)
- Kimi API client implementation
- REST-based API calls to Moonshot's API
- Functions:
  - `getGenerationModel(enableWebSearch)` - Configure generation model
  - `getValidationModel(enableWebSearch)` - Configure validation model
  - `generateContent(prompt, model)` - Call Kimi API
  - `parseKimiJson<T>(text)` - Parse Kimi responses with fallbacks

## Files Modified

### 1. `src/lib/pipeline/generate.ts`
**Changes:**
- Added `AIModel` type ('gemini' | 'kimi')
- Added `GenerateOptions` interface with `aiModel` and `kimiWebSearchEnabled`
- Updated `generate()` function signature to accept optional `options` parameter
- Conditional logic to select Gemini or Kimi based on `aiModel`
- Uses appropriate parser (parseGeminiJson vs parseKimiJson)

**Key Lines:**
```typescript
export type AIModel = 'gemini' | 'kimi';

export interface GenerateOptions {
  aiModel?: AIModel;
  kimiWebSearchEnabled?: boolean;
}

export async function generate(
  params: QuestionGenerationParams,
  generationContext: GenerationContext = 'hub',
  options?: GenerateOptions
): Promise<GeneratedQuestion[]>
```

### 2. `src/lib/pipeline/validate.ts`
**Changes:**
- Updated `ValidateOptions` interface to include `aiModel` and `kimiWebSearchEnabled`
- Modified `validate()` function to accept and pass model options
- Updated `validateSingleQuestion()` to use selected model
- Conditional logic for Gemini vs Kimi in validation

**Key Interface:**
```typescript
export interface ValidateOptions {
  certificationName: string;
  domainContext?: ExamDomain;
  rejectLowConfidence?: boolean;
  certTier?: CertTier;
  aiModel?: AIModel;              // NEW
  kimiWebSearchEnabled?: boolean;  // NEW
}
```

### 3. `src/lib/pipeline/index.ts`
**Changes:**
- Import `GenerateOptions` and `ValidateOptions` types
- Pass model options to all `generate()` calls (lines ~73, ~99, ~178)
- Pass model options to `validate()` call (line ~207)
- Support for both Gemini and Kimi throughout the pipeline

**Key Changes:**
```typescript
const batch = await generate(subParams, params.generationContext ?? 'hub', {
  aiModel: params.aiModel,
  kimiWebSearchEnabled: params.kimiWebSearchEnabled,
});

const { validated, rejected } = await validate(dedupedQuestions, {
  certificationName: params.certificationName,
  domainContext,
  rejectLowConfidence: true,
  certTier,
  aiModel: params.aiModel,
  kimiWebSearchEnabled: params.kimiWebSearchEnabled,
});
```

### 4. `src/lib/types/generation.ts`
**Changes:**
- Extended `PipelineParams` interface with new fields:
  - `aiModel?: 'gemini' | 'kimi'`
  - `kimiWebSearchEnabled?: boolean`

```typescript
export interface PipelineParams {
  // ... existing fields ...
  // AI Model selection
  aiModel?: 'gemini' | 'kimi';
  kimiWebSearchEnabled?: boolean;
}
```

### 5. `src/app/api/generate-hub/route.ts`
**Changes:**
- Import `AIModel` type
- Extended `RequestBody` interface with new fields:
  - `aiModel?: AIModel`
  - `kimiWebSearchEnabled?: boolean`
- Add defaults in POST handler (line ~110):
  - `body.aiModel ??= 'gemini'`
  - `body.kimiWebSearchEnabled ??= true`
- Pass model options to `pipelineParams` (lines ~158-159)

**Key Request Body:**
```typescript
interface RequestBody {
  // ... existing fields ...
  aiModel?: AIModel;              // NEW
  kimiWebSearchEnabled?: boolean;  // NEW
}
```

## Documentation Created

### `AI_MODEL_SELECTION.md`
Comprehensive guide including:
- Overview of both models
- Request body parameters
- Usage examples for each model
- Environment variable setup
- Model specifications (temperature, max tokens, etc.)
- When to use each model
- Architecture overview
- Troubleshooting guide
- Future enhancement ideas

## How It Works

### Request Flow
```
1. Frontend sends POST to /api/generate-hub with aiModel parameter
2. Route handler defaults to 'gemini' if not specified
3. Pipeline receives aiModel and kimiWebSearchEnabled
4. At each step (generate/validate), model is selected:
   - Gemini: Uses Google's API
   - Kimi: Uses Moonshot's API with optional web search
5. Same JSON parser handles both models
6. All templates, prompts, and outputs remain unchanged
```

### Model Selection Logic
```typescript
// In generate.ts
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
```

## Default Behavior

- **Default AI Model**: `gemini` (unchanged from before)
- **Default Web Search**: `true` (for Kimi only)
- **All existing code** works without changes
- **Backward compatible**: Old requests without `aiModel` parameter still work

## Environment Variables Required

```bash
GEMINI_API_KEY=your_gemini_key      # Existing
KIMI_API_KEY=your_kimi_key           # New - required only for Kimi usage
```

## Testing Guide

### Test 1: Default Behavior (Gemini)
```bash
curl -X POST http://localhost:3000/api/generate-hub \
  -H "Content-Type: application/json" \
  -d '{
    "certification_id": "1",
    "certification_name": "AWS Solutions Architect",
    "topic_id": "101",
    "quiz_id": "quiz_1",
    "modules": [{"module_id": "m1", "module_name": "Module 1"}]
  }'
```

### Test 2: Kimi with Web Search
```bash
curl -X POST http://localhost:3000/api/generate-hub \
  -H "Content-Type: application/json" \
  -d '{
    "certification_id": "1",
    "certification_name": "AWS Solutions Architect",
    "topic_id": "101",
    "quiz_id": "quiz_1",
    "modules": [{"module_id": "m1", "module_name": "Module 1"}],
    "aiModel": "kimi",
    "kimiWebSearchEnabled": true
  }'
```

### Test 3: Kimi without Web Search
```bash
curl -X POST http://localhost:3000/api/generate-hub \
  -H "Content-Type: application/json" \
  -d '{
    "certification_id": "1",
    "certification_name": "AWS Solutions Architect",
    "topic_id": "101",
    "quiz_id": "quiz_1",
    "modules": [{"module_id": "m1", "module_name": "Module 1"}],
    "aiModel": "kimi",
    "kimiWebSearchEnabled": false
  }'
```

## Logs to Monitor

```
[generate] Calling gemini for 2 modules × 10 questions
[validate] Validating 20 questions using gemini...

OR

[generate] Calling kimi for 2 modules × 10 questions
[validate] Validating 20 questions using kimi...
```

## What Stayed the Same

✅ All prompts and templates  
✅ All question generation logic  
✅ Validation rules and criteria  
✅ Output format and SQL generation  
✅ Deduplication logic  
✅ Response structure  
✅ All existing endpoints  

## What Changed

🔄 Generation step now supports Kimi  
🔄 Validation step now supports Kimi  
🔄 Model selection via request parameter  
🔄 Web search capability for Kimi  
🔄 Dual JSON parsing logic  

## Next Steps (Optional)

1. Test with real Kimi API key
2. Add frontend UI to select model
3. Add cost tracking per model
4. A/B test model quality
5. Consider adding more models (Claude, etc.)
6. Implement fallback mechanism

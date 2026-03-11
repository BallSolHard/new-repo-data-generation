# Prompt Selection Guide for Mock vs Hub Questions

## Quick Answer

When you click **"Generate Mock Questions"**, the system uses **`generation-mock-prompt.ts`**.

---

## How It Works

### 1. **Frontend → Backend Request** (`page.tsx`)
When you click "Generate Mock Questions":
- **Endpoint Called:** `/api/generate-mock-with-data`
- **Parameter Passed:** `generationContext` is NOT explicitly passed (defaults to 'hub' in the second parameter)

```typescript
// page.tsx - generateMockQuestions function
const response = await fetch('/api/generate-mock-with-data', {
  method: 'POST',
  body: JSON.stringify(payload)  // Contains mock_test_id, modules, questionTypes, etc.
});
```

### 2. **Backend API Route** (`generate-mock-with-data/route.ts`)
- **Calls:** `runGenerationPipeline(pipelineParams)` with `genMode: 'simulation'`
- **Key Parameter:** `genMode: 'simulation'` (not 'drill')

```typescript
// generate-mock-with-data/route.ts (Lines 252-276)
const pipelineParams: PipelineParams = {
  // ... other params ...
  genMode: 'simulation' as GenMode,  // ← Mock tests use simulation mode
};

const result = await runGenerationPipeline(pipelineParams);
```

### 3. **Pipeline Orchestrator** (`index.ts`)
- **Calls:** `ingest()` which receives `genMode: 'simulation'`
- **Then calls:** `generate()` function

```typescript
// index.ts (Lines 22-38)
const { examGuide, domainContext, fewShotExamples, ..., genMode, ... } = await ingest({
  // ...
  genMode: params.genMode,  // Receives 'simulation' for mock tests
});
```

### 4. **Generate Function** (`generate.ts`) ⚠️ ISSUE HERE
- **Hardcoded Bug:** `genMode` is **always hardcoded to `'drill'`** regardless of the `params.genMode`

```typescript
// generate.ts (Lines 13-25) - PROBLEMATIC CODE
const prompt = createGenerationPrompt({
  examGuide: params.examGuide!,
  domainContext: params.domainContext!,
  certTier: params.certTier || 'associate',
  genMode: 'drill',  // ← ⚠️ ALWAYS 'drill' — should be params.genMode
  modules: params.modules,
  // ... other params ...
});
```

### 5. **Prompt Selection** (`generation-new.ts`)
Based on `generationContext` parameter (passed as 2nd argument to `generate()`):

```typescript
// generate.ts (Line 12) - Second parameter
export async function generate(
  params: QuestionGenerationParams, 
  generationContext: GenerationContext = 'hub'  // ← Defaults to 'hub'
): Promise<GeneratedQuestion[]>
```

**Then in `generation-new.ts` (Lines 155-159):**
```typescript
if (generationContext === 'hub') {
  return buildHubPrompt(hubPromptParams);
} else {
  return buildMockPrompt(mockPromptParams);  // ← This runs for mock
}
```

---

## Current Prompt Selection Logic

| Parameter | Current Value | Expected Value | Impact |
|-----------|---------------|-----------------|--------|
| `genMode` | `'drill'` (hardcoded) | `'simulation'` | Prompt structure selection |
| `generationContext` | `'hub'` (default) | `'mock'` | **Hub vs Mock prompt** |
| **Result** | Uses **`generation-hub-prompt.ts`** ❌ | Should use **`generation-mock-prompt.ts`** ✓ | Mock tests get hub-style questions |

---

## The Issue

**Mock questions are currently using the Hub prompt** because:

1. ✅ `genMode` is set correctly to `'simulation'` at the API level
2. ❌ But `genMode` gets hardcoded to `'drill'` in `generate.ts`
3. ❌ More critically, `generationContext` parameter defaults to `'hub'` and is never changed to `'mock'`

This means:
- **What we want:** `generation-mock-prompt.ts` (strict quality standards)
- **What we're getting:** `generation-hub-prompt.ts` (looser standards)

---

## The Fix Needed

### Fix 1: Pass `generationContext` from the pipeline

**In `index.ts` (around line 95-100):**
```typescript
// Currently:
const batch = await generate(subParams, params.generationContext ?? 'hub');

// This is correct! It already passes the context.
// But we need to ensure it's set to 'mock' for mock test requests.
```

### Fix 2: Determine `generationContext` from request

**In `generate-mock-with-data/route.ts`:**
```typescript
// When calling runGenerationPipeline, indicate this is a mock request:
const pipelineParams: PipelineParams = {
  // ... existing params ...
  genMode: 'simulation' as GenMode,
  generationContext: 'mock',  // ← ADD THIS
};
```

### Fix 3: Pass `generationContext` through the pipeline

**Update `PipelineParams` interface** to include `generationContext`:
```typescript
interface PipelineParams {
  // ... existing fields ...
  generationContext?: 'hub' | 'mock';
}
```

**Then pass it to ingest:**
```typescript
const { ... } = await ingest({
  // ...
  generationContext: params.generationContext,
});
```

---

## File Map

| File | Line | Role |
|------|------|------|
| `page.tsx` | 407-482 | Frontend: Calls mock generation API |
| `generate-mock-with-data/route.ts` | 252-276 | **Backend: Sets `genMode: 'simulation'`** |
| `pipeline/index.ts` | 22-95 | **Orchestrator: Calls `generate()` with context** |
| `pipeline/generate.ts` | 13-25 | ⚠️ **Hardcodes `genMode: 'drill'`** |
| `prompts/generation-new.ts` | 155-159 | **Selector: Chooses hub vs mock prompt** |
| `prompts/generation-hub-prompt.ts` | - | ❌ Currently used for mock (wrong) |
| `prompts/generation-mock-prompt.ts` | - | ✅ Should be used for mock (correct) |

---

## Differences Between Prompts

### `generation-hub-prompt.ts`
- **Context:** Practice/drill questions
- **Quality Standards:** **Looser** — allows:
  - Shorter stems (min 20 words)
  - More variety in scenarios
  - Broader distractors
  - More flexible cognitive levels

### `generation-mock-prompt.ts`
- **Context:** Exam-realistic mock tests
- **Quality Standards:** **Stricter** — enforces:
  - Exact stem length (20-40 words)
  - Realistic AWS scenarios only
  - High-quality distractors
  - Application/Analysis cognitive level
  - No hints in the stem

---

## Summary

**Current Behavior:**
```
Generate Mock Questions 
  → genMode: 'simulation' ✓
  → generationContext: 'hub' (default) ✗
  → Uses: generation-hub-prompt.ts ✗
```

**Desired Behavior:**
```
Generate Mock Questions 
  → genMode: 'simulation' ✓
  → generationContext: 'mock' ✓
  → Uses: generation-mock-prompt.ts ✓
```

The fix is straightforward: Pass `generationContext: 'mock'` through the pipeline when the request comes from the mock test endpoint.

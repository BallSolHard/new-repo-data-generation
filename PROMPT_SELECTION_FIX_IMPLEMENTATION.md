# Prompt Selection Fix - Implementation Summary

## Changes Made

### 1. Fixed `genMode` Hardcoding in Pipeline Generation
**File:** `/src/lib/pipeline/generate.ts` (Line 19)

**Before:**
```typescript
genMode: 'drill',  // ❌ Always hardcoded to 'drill'
```

**After:**
```typescript
genMode: params.genMode || 'drill',  // ✅ Uses actual genMode from params
```

**Reason:** The `genMode` was hardcoded regardless of whether the request was for hub (drill) or mock (simulation) questions. Now it properly uses the mode passed through the params.

---

### 2. Added `generationContext: 'mock'` to Mock Test Pipeline
**File:** `/src/app/api/generate-mock-with-data/route.ts` (Line 276)

**Before:**
```typescript
const pipelineParams: PipelineParams = {
  // ... other params ...
  genMode: 'simulation' as GenMode,
  startIndexByModule,
};
```

**After:**
```typescript
const pipelineParams: PipelineParams = {
  // ... other params ...
  genMode: 'simulation' as GenMode,
  generationContext: 'mock',  // ✅ New: Use mock prompt
  startIndexByModule,
};
```

**Reason:** Explicitly tells the pipeline to use the strict mock prompt instead of the default hub prompt.

---

### 3. Added `generationContext: 'hub'` to Hub Test Pipeline
**File:** `/src/app/api/generate-hub/route.ts` (Line 160)

**Before:**
```typescript
const pipelineParams: PipelineParams = {
  // ... other params ...
  genMode: body.genMode,
  startIndexByModule,
};
```

**After:**
```typescript
const pipelineParams: PipelineParams = {
  // ... other params ...
  genMode: body.genMode,
  generationContext: 'hub',  // ✅ New: Use hub prompt (explicit)
  startIndexByModule,
};
```

**Reason:** Makes it explicit that hub generation uses the hub prompt. This provides clarity and future-proofs the code.

---

## How the Fix Works

### Call Flow After Fix

```
User clicks "Generate Mock Questions"
    ↓
Frontend → /api/generate-mock-with-data
    ↓
Backend sets: generationContext: 'mock' ✅
    ↓
runGenerationPipeline(pipelineParams)
    ↓
Pipeline passes: generationContext: 'mock' → generate()
    ↓
generate() creates prompt with: generationContext: 'mock'
    ↓
createGenerationPrompt() checks:
  if (generationContext === 'hub') → buildHubPrompt()
  else → buildMockPrompt() ✅
    ↓
Returns: generation-mock-prompt.ts ✅
(Strict quality standards for mock tests)
```

### Prompt Selection Logic

```typescript
// In generation-new.ts (lines 155-159)
if (generationContext === 'hub') {
  return buildHubPrompt(hubPromptParams);      // Hub generation
} else {
  return buildMockPrompt(mockPromptParams);    // Mock generation ✅
}
```

---

## Quality Standards Comparison

### Hub Prompt (`generation-hub-prompt.ts`)
- **Use Case:** Practice/drill questions
- **Stem Length:** Min 20 words (flexible max)
- **Standards:** Looser
- **Distractors:** More variety allowed
- **Cognitive Level:** More flexible

### Mock Prompt (`generation-mock-prompt.ts`)
- **Use Case:** Exam-realistic mock tests
- **Stem Length:** Exact 20-40 words (enforced)
- **Standards:** Strict
- **Distractors:** High-quality, realistic
- **Cognitive Level:** Application/Analysis focus

---

## Validation

All files compile without errors:
- ✅ `/src/lib/pipeline/generate.ts` - No errors
- ✅ `/src/app/api/generate-mock-with-data/route.ts` - No errors
- ✅ `/src/app/api/generate-hub/route.ts` - No errors

---

## Testing Checklist

When testing the fix, verify:

- [ ] **Mock Questions Generation:**
  - Select certification → domain → mock tab
  - Select mock test action (existing or new)
  - Specify number of questions
  - Select question types (including matching)
  - Click "Generate Mock Questions"
  - Check that generated questions follow strict standards (20-40 word stems, realistic scenarios)

- [ ] **Hub Questions Generation:**
  - Select certification → domain → hub tab
  - Specify difficulty distribution
  - Select question types
  - Click "Generate Hub Questions"
  - Check that generated questions are more flexible (shorter stems allowed)

- [ ] **SQL Generation:**
  - Verify mock questions generate SQL with `pairs` and `matches` columns for matching questions
  - Verify hub questions generate standard SQL with `options` column

- [ ] **Console Logs:**
  - Look for `[pipeline] genMode` to confirm correct mode
  - Look for `generationContext` passed to `generate()` function
  - Verify prompt builder receives correct context

---

## Technical Details

### Type Integration
- `PipelineParams` already includes `generationContext?: GenerationContext` (line 116 in types/generation.ts)
- `GenerationContext = 'hub' | 'mock'` (defined in generation-new.ts)
- No type changes needed — infrastructure was already in place

### Pipeline Architecture
The fix leverages the existing pipeline architecture:
1. **Ingest:** Loads exam guides and few-shot examples
2. **Generate:** Creates questions using the prompt
3. **Validate:** Checks question quality (optional)
4. **Output:** Generates SQL script

The key change is ensuring the correct prompt template is selected at the Generate step based on `generationContext`.

---

## Related Files (Not Modified)

These files already support the fix:
- `/src/lib/types/generation.ts` - `PipelineParams` interface includes `generationContext`
- `/src/lib/pipeline/index.ts` - Already passes `generationContext` to `generate()`
- `/src/lib/prompts/generation-new.ts` - Already has conditional logic for hub vs mock
- `/src/lib/prompts/generation-hub-prompt.ts` - Hub prompt template
- `/src/lib/prompts/generation-mock-prompt.ts` - Mock prompt template

---

## Summary

The fix ensures that:
1. ✅ Mock tests use `generation-mock-prompt.ts` with strict quality standards
2. ✅ Hub tests use `generation-hub-prompt.ts` with flexible standards
3. ✅ The correct `genMode` is passed through the entire pipeline
4. ✅ No type conflicts or compilation errors
5. ✅ Infrastructure was already in place; we just needed to wire it correctly

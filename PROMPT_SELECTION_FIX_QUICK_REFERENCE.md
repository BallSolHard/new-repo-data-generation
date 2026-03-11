# Prompt Selection Fix - Quick Reference

## What Was Wrong

Mock questions were using the **Hub prompt** instead of the **Mock prompt**.

```
❌ Before:
Generate Mock Questions → genMode: 'simulation' ✓
                       → generationContext: 'hub' (default) ✗
                       → Uses: generation-hub-prompt.ts ✗
```

## What's Fixed

Mock questions now use the correct prompt with strict standards.

```
✅ After:
Generate Mock Questions → genMode: 'simulation' ✓
                       → generationContext: 'mock' ✓
                       → Uses: generation-mock-prompt.ts ✓
```

## Files Changed

| File | Line | Change |
|------|------|--------|
| `src/lib/pipeline/generate.ts` | 19 | `genMode: 'drill'` → `genMode: params.genMode \|\| 'drill'` |
| `src/app/api/generate-mock-with-data/route.ts` | 276 | Added `generationContext: 'mock'` |
| `src/app/api/generate-hub/route.ts` | 160 | Added `generationContext: 'hub'` |

## How It Works

```
┌─────────────────────────────────────┐
│  Frontend: Generate Mock Questions  │
└────────────┬────────────────────────┘
             │
             ↓
┌─────────────────────────────────────┐
│  Backend: generate-mock-with-data   │
│  - genMode: 'simulation'            │
│  - generationContext: 'mock' ✅     │
└────────────┬────────────────────────┘
             │
             ↓
┌─────────────────────────────────────┐
│  Pipeline: runGenerationPipeline()  │
│  (passes generationContext forward)  │
└────────────┬────────────────────────┘
             │
             ↓
┌─────────────────────────────────────┐
│  Generate: create prompt            │
│  - Uses params.genMode ✅           │
│  - Passes generationContext ✅      │
└────────────┬────────────────────────┘
             │
             ↓
┌─────────────────────────────────────┐
│  Prompt Builder: createGenerationPrompt│
│  if (context === 'mock')            │
│    → buildMockPrompt() ✅           │
│    → STRICT quality standards       │
│    → 20-40 word stems               │
│    → Realistic scenarios            │
└─────────────────────────────────────┘
```

## Quality Standards

### Mock Prompt (Strict) ✅
```
Stem Length:        20-40 words (exact)
Cognitive Level:    Application/Analysis
Distractors:        High-quality, plausible
Scenarios:          Realistic AWS only
Hints in Stem:      None allowed
```

### Hub Prompt (Flexible)
```
Stem Length:        Min 20 words (flexible)
Cognitive Level:    More variety
Distractors:        More variety
Scenarios:          Broader range
Hints in Stem:      Some allowed
```

## Expected Behavior After Fix

### When You Generate Mock Questions:
✅ Uses `generation-mock-prompt.ts`
✅ Stricter quality validation
✅ Stems are exactly 20-40 words
✅ Questions are exam-realistic
✅ SQL has `pairs` and `matches` for matching questions
✅ `correct_answer` is `NULL` for matching questions

### When You Generate Hub Questions:
✅ Uses `generation-hub-prompt.ts`
✅ Looser quality standards
✅ Stems can be shorter
✅ More variety in scenarios
✅ Standard SQL with `options` column
✅ `correct_answer` is an array for all types

## Testing

1. Generate mock questions with matching type
2. Check console for `generationContext: 'mock'`
3. Verify SQL shows proper matching structure
4. Generate hub questions
5. Verify different question quality/format

## Related Documentation

- `PROMPT_SELECTION_GUIDE.md` - Detailed explanation of why the issue existed
- `PROMPT_SELECTION_FIX_IMPLEMENTATION.md` - Complete implementation details

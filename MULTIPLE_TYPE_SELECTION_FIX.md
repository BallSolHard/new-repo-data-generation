# Multiple Question Type Selection Fix

## Issue Description
When users selected the 'multiple' question type in the UI (even while 'mcq' was checked), the generated questions were still of 'mcq' format. The 'multiple' type selection was being ignored.

## Root Cause Analysis

### Problem 1: UI Initial State
- The `selectedQuestionTypes` state in `page.tsx` initialized with `['mcq']` by default
- When users checked 'multiple', it was ADDED to the array, creating `['mcq', 'multiple']`
- Users expected checking 'multiple' would REPLACE 'mcq', not add to it
- **Status: UI behavior was correct, but user expectation wasn't clear**

### Problem 2: Conflicting Prompt Instructions (MAIN BUG)
- The prompt template in `generation-hub-prompt.ts` had conditional blocks that all rendered independently:
  ```typescript
  ${selectedQuestionTypes.includes('multiple') ? `... MCQ ONLY ...` : ''}
  ${selectedQuestionTypes.includes('mcq') ? `... MCQ FORMAT ...` : ''}
  ```
- When BOTH 'mcq' and 'multiple' were selected, BOTH sections rendered
- The prompt had contradictory instructions:
  - "YOU ARE GENERATING: MULTIPLE QUESTIONS ONLY" (from first block)
  - "MCQ QUESTIONS: ... correct_answer MUST be a STRING ..." (from second block)
- This confusion caused the LLM to default to MCQ behavior (safer, simpler format)
- **Status: FIXED ✓**

## Solution Implemented

### Fix 1: Refined Prompt Conditionals
Changed from:
```typescript
${selectedQuestionTypes.includes('multiple') ? `...` : ''}
${selectedQuestionTypes.includes('mcq') ? `...` : ''}
```

To:
```typescript
${selectedQuestionTypes.length === 1 && selectedQuestionTypes.includes('multiple') ? `...` : ''}
${selectedQuestionTypes.length === 1 && selectedQuestionTypes.includes('mcq') ? `...` : ''}
```

**Result**: Type-specific sections only show when that type is the ONLY selected type.

### Fix 2: Added Multi-Type Mode Section
When multiple types are selected, the prompt now includes a dedicated "MULTI-TYPE GENERATION MODE" section that:
- Clearly states that questions can be ANY of the selected types
- Explains each type's format requirements in a unified way
- References the distribution section for guidance on how many of each type
- Eliminates conflicting instructions

### Fix 3: Added Debug Logging
Added console logs to trace the flow:
- **UI**: `[UI] selectedQuestionTypes changed:` - shows state updates
- **generateHubQuestions**: `[generateHubQuestions] Payload questionTypes:` - shows what's sent to API
- **API route**: `[generate-hub] Received request body:` - shows what API receives
- **Pipeline**: `[pipeline] Question types resolution:` - shows final type resolution

## Files Modified

1. **`src/app/page.tsx`**
   - Added debug logging for `selectedQuestionTypes` state changes
   - Added debug logging before API call

2. **`src/app/api/generate-hub/route.ts`**
   - Added debug logging to show received question types

3. **`src/lib/pipeline/index.ts`**
   - Added debug logging to show type resolution

4. **`src/lib/prompts/generation-hub-prompt.ts`**
   - Changed conditional logic from `.includes()` to `.length === 1 && .includes()`
   - Added "MULTI-TYPE GENERATION MODE" section
   - Type-specific sections now only render for single-type selection

## Testing Recommendations

### Test Case 1: Single Type Selection
1. Select ONLY 'multiple' (uncheck 'mcq')
2. Generate questions
3. Verify all questions have `"type": "multiple"`
4. Verify all have `correct_answer` as arrays: `[0, 1]`, `[0, 2]`, etc.
5. Verify all include "(Select TWO.)" or "(Select THREE.)" in question text

### Test Case 2: Multiple Type Selection
1. Select both 'mcq' and 'multiple'
2. Generate questions
3. Verify questions are distributed ~50% MCQ, ~50% Multiple
4. Verify MCQ questions have string `correct_answer`: `"0"`, `"1"`, etc.
5. Verify Multiple questions have array `correct_answer`: `[0, 1]`, etc.

### Test Case 3: Other Types
1. Test with 'ordering' only
2. Test with 'matching' only
3. Test with mix of all 4 types
4. Verify distribution and formats match expectations

### Debug Output to Check
Watch browser console for:
```
[UI] selectedQuestionTypes changed: ['mcq', 'multiple']
[generateHubQuestions] Payload questionTypes: ['mcq', 'multiple']
```

Watch API logs for:
```
[generate-hub] Received request body: { ... questionTypes: ['mcq', 'multiple'] ... }
[pipeline] Question types resolution: { params_questionTypes: ['mcq', 'multiple'], resolved_questionTypes: ['mcq', 'multiple'] }
```

## Additional Notes

### UI Behavior
- Users can now select multiple question types
- Initial state has 'mcq' checked by default
- Users must manually uncheck 'mcq' if they want ONLY 'multiple'
- This is intentional to maintain backward compatibility

### Prompt Behavior
- Single-type selection: Very strict instructions for that type only
- Multi-type selection: Clear distribution rules and unified format documentation
- The prompt now clearly communicates exactly which types to generate and their formats

### Future Improvements
1. Consider radio button UX for single-type selection mode
2. Consider checkbox group with "Select All" / "Deselect All" buttons
3. Add visual indication of type distribution in UI
4. Add validation to prevent empty type selection

# Dual-Model Question Generation Guide

## Overview
The hub question generation pipeline now supports using **different LLM models for generation and validation stages**. This allows you to:
- Generate questions with **Kimi + Web Search** (creative, research-backed)
- Validate questions with **Gemini** (conservative, accurate)

Or any other combination of models.

---

## Architecture

### Previous (Single-Model)
```
┌─────────────────┐
│  User selects   │
│  Model: Gemini  │
├─────────────────┤
│  GENERATE       │
│  └─> Gemini     │
├─────────────────┤
│  VALIDATE       │
│  └─> Gemini     │
└─────────────────┘
```

### New (Dual-Model)
```
┌─────────────────────────┐
│  User selects:          │
│  Gen: Kimi + Web Search │
│  Val: Gemini            │
├─────────────────────────┤
│  GENERATE               │
│  └─> Kimi + Web Search  │
├─────────────────────────┤
│  VALIDATE               │
│  └─> Gemini             │
└─────────────────────────┘
```

---

## How It Works

### Configuration Flow

**1. Frontend sends request:**
```json
{
  "certification_name": "AWS Solutions Architect",
  "topic_name": "Design Secure Architectures",
  "modules": [...],
  "generationModel": "kimi",
  "generationModelWebSearchEnabled": true,
  "validationModel": "gemini",
  "validationModelWebSearchEnabled": false
}
```

**2. Route handler (generate-hub/route.ts):**
- Receives request body with dual-model configuration
- Passes through to PipelineParams

**3. Pipeline orchestrator (pipeline/index.ts):**

#### Generation Phase:
```typescript
// Resolve generation model
const generationModelToUse = params.generationModel || params.aiModel || 'gemini';
const generationWebSearchEnabled = params.generationModelWebSearchEnabled ?? params.kimiWebSearchEnabled ?? false;

// Call generate() with Kimi + Web Search
const questions = await generate(subParams, 'hub', {
  aiModel: generationModelToUse,           // 'kimi'
  kimiWebSearchEnabled: generationWebSearchEnabled,  // true
});
```

**Kimi Configuration (for generation):**
- Temperature: 1 (Kimi K2.6 fixed)
- Top_p: 0.95 (Kimi K2.6 fixed)
- Web Search: ✅ ENABLED
- Purpose: Creative, researched questions

#### Validation Phase:
```typescript
// Resolve validation model
const validationModelToUse = params.validationModel || params.aiModel || 'gemini';
const validationWebSearchEnabled = params.validationModelWebSearchEnabled ?? false;

// Call validate() with Gemini only
const { validated, rejected } = await validate(questions, {
  aiModel: validationModelToUse,           // 'gemini'
  kimiWebSearchEnabled: validationWebSearchEnabled,  // false
});
```

**Gemini Configuration (for validation):**
- Temperature: 0.15 (conservative, factual)
- Top_p: 0.6 (focused)
- Web Search: ❌ DISABLED
- Purpose: Strict validation, accuracy checking

---

## Usage Examples

### Example 1: Kimi Generation + Gemini Validation
```json
{
  "certification_name": "AWS Solutions Architect",
  "topic_name": "Design Secure Architectures",
  "modules": [...],
  "generationModel": "kimi",
  "generationModelWebSearchEnabled": true,
  "validationModel": "gemini",
  "validationModelWebSearchEnabled": false
}
```

**Result:** 
- Kimi searches the web for latest AWS security best practices
- Generates creative, research-backed questions
- Gemini validates each question conservatively
- Final output: High-quality, verified questions

### Example 2: Gemini Generation + Gemini Validation (Original)
```json
{
  "generationModel": "gemini",
  "generationModelWebSearchEnabled": false,
  "validationModel": "gemini",
  "validationModelWebSearchEnabled": false
}
```

### Example 3: Kimi + Kimi (Both with Web Search)
```json
{
  "generationModel": "kimi",
  "generationModelWebSearchEnabled": true,
  "validationModel": "kimi",
  "validationModelWebSearchEnabled": true
}
```

---

## API Request Format

### POST /api/generate-hub

**Request body with dual-model config:**
```typescript
{
  // Required fields
  certification_id: "1",
  certification_name: "AWS Solutions Architect",
  topic_id: "design-secure",
  quiz_id: "quiz_123",
  modules: [
    { module_id: "m1", module_name: "IAM", module_description: "..." }
  ],
  
  // Optional: Single-model fallback (used if no dual-model config)
  aiModel: "gemini",
  kimiWebSearchEnabled: false,
  
  // Dual-model configuration (takes precedence)
  generationModel: "kimi",              // 'gemini' | 'kimi'
  generationModelWebSearchEnabled: true, // boolean
  validationModel: "gemini",             // 'gemini' | 'kimi'
  validationModelWebSearchEnabled: false // boolean
}
```

---

## Pipeline Parameters

All parameters added to `PipelineParams` type in `src/lib/types/generation.ts`:

```typescript
export interface PipelineParams {
  // ... existing fields ...
  
  // Single-model (backward compatible)
  aiModel?: 'gemini' | 'kimi';
  kimiWebSearchEnabled?: boolean;
  
  // Dual-model configuration
  generationModel?: 'gemini' | 'kimi';
  generationModelWebSearchEnabled?: boolean;
  validationModel?: 'gemini' | 'kimi';
  validationModelWebSearchEnabled?: boolean;
}
```

---

## Fallback Logic

The pipeline implements smart fallback logic:

### For Generation Model:
```typescript
const generationModelToUse = 
  params.generationModel ||          // 1. Explicit dual-model config
  params.aiModel ||                  // 2. Single-model config
  'gemini';                          // 3. Default
```

### For Generation Web Search:
```typescript
const generationWebSearchEnabled = 
  params.generationModelWebSearchEnabled ?? 
  params.kimiWebSearchEnabled ?? 
  false;
```

### For Validation Model:
```typescript
const validationModelToUse = 
  params.validationModel ||          // 1. Explicit dual-model config
  params.aiModel ||                  // 2. Single-model config
  'gemini';                          // 3. Default
```

### For Validation Web Search:
```typescript
const validationWebSearchEnabled = 
  params.validationModelWebSearchEnabled ?? 
  false;  // Always false by default for validation
```

---

## Console Logs

When using dual-model configuration, you'll see detailed logging:

```
[pipeline] Using kimi for generation (web search: true)
[pipeline] Calling kimi for 4 modules × 5 questions
[generate] Received response (15234 chars, first 3000 chars): ...
[pipeline] After deduplication: 20/20 questions remain
[pipeline] Using gemini for validation (web search: false)
[validate] Validating 20 questions using gemini...
[validate] Results: 18 passed, 2 rejected
[pipeline] Complete. 18 questions generated, 2 rejected.
```

---

## Benefits

### Kimi for Generation (with Web Search)
✅ Access to latest information on the web
✅ Creative question generation
✅ Can reference current AWS/Azure services and features
✅ Better context awareness

### Gemini for Validation
✅ Conservative, fact-focused approach
✅ Catches factual errors
✅ Lower false negatives
✅ More deterministic validation

---

## Files Modified

1. **`src/lib/types/generation.ts`**
   - Added `generationModel`, `generationModelWebSearchEnabled`
   - Added `validationModel`, `validationModelWebSearchEnabled` to `PipelineParams`

2. **`src/lib/pipeline/index.ts`**
   - Updated generation phase to use `generationModelToUse`
   - Updated validation phase to use `validationModelToUse`
   - Added console logging for which models are being used

3. **`src/app/api/generate-hub/route.ts`**
   - Added dual-model fields to `RequestBody` interface
   - Passed dual-model config to `pipelineParams`

---

## Migration Guide

### For Existing Code
No breaking changes! Existing code continues to work:

```typescript
// Old way (still works)
{
  aiModel: 'kimi',
  kimiWebSearchEnabled: true
}

// Will automatically use same model for both generation and validation
```

### To Use Dual Models
Simply add the new fields:

```typescript
// New way (dual models)
{
  generationModel: 'kimi',
  generationModelWebSearchEnabled: true,
  validationModel: 'gemini',
  validationModelWebSearchEnabled: false
}
```

---

## Testing

### Test Case 1: Kimi + Gemini
```bash
curl -X POST http://localhost:3000/api/generate-hub \
  -H "Content-Type: application/json" \
  -d '{
    "certification_name": "AWS Solutions Architect",
    "topic_name": "Design Secure Architectures",
    "quiz_id": "test_quiz",
    "modules": [...],
    "generationModel": "kimi",
    "generationModelWebSearchEnabled": true,
    "validationModel": "gemini",
    "validationModelWebSearchEnabled": false
  }'
```

### Test Case 2: Verify Logging
Check console output to confirm correct models are being used.

---

## Configuration Examples for Frontend

### React Component Example
```typescript
const handleGenerateWithDualModels = async () => {
  const payload = {
    certification_name: selectedCert,
    topic_name: selectedTopic,
    modules: selectedModules,
    quizId: selectedQuiz.id,
    
    // Dual-model configuration
    generationModel: 'kimi',
    generationModelWebSearchEnabled: true,
    validationModel: 'gemini',
    validationModelWebSearchEnabled: false,
  };

  const response = await fetch('/api/generate-hub', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload),
  });

  const result = await response.json();
  console.log(`Generated: ${result.questionCount} questions, Rejected: ${result.rejectedCount}`);
};
```

---

## Troubleshooting

### Issue: Generation is slow
- **Cause:** Kimi with web search enabled takes longer
- **Solution:** Check Kimi API status and rate limits

### Issue: Too many questions rejected
- **Cause:** Gemini validation too strict
- **Solution:** Adjust validation prompt or use less strict validation model

### Issue: Model not being used
- **Cause:** Incorrect field names or falsy values
- **Solution:** 
  - Verify `generationModel` field name (not `generationModelName`)
  - Ensure boolean values are actual booleans, not strings
  - Check console logs to see which model is actually being used

---

## Future Enhancements

Potential improvements:
1. Add UI controls for model selection (radio buttons for generation + validation)
2. Add performance metrics comparing single vs dual-model approaches
3. Add A/B testing capability to compare question quality
4. Support for 3+ model combinations (e.g., Anthropic Claude for generation)


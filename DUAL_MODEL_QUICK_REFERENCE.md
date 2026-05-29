# Dual-Model System: Quick Reference

## The Problem & Solution

### Before (Single Model)
```
Same model for everything:
REQUEST → GENERATE (Gemini) → VALIDATE (Gemini) → OUTPUT
```
**Problem:** Can't leverage different model strengths

### After (Dual Model)
```
Different models for different jobs:
REQUEST → GENERATE (Kimi + Web) → VALIDATE (Gemini) → OUTPUT
```
**Solution:** Use each model's strengths!

---

## Your Implementation

### What You Sent in Request

```json
{
  "certification_name": "AWS Solutions Architect",
  "topic_name": "Design Secure Architectures",
  "quiz_id": "quiz_123",
  "modules": [
    { "module_id": "m1", "module_name": "IAM" },
    { "module_id": "m2", "module_name": "VPC" }
  ],
  
  "generationModel": "kimi",
  "generationModelWebSearchEnabled": true,
  "validationModel": "gemini",
  "validationModelWebSearchEnabled": false
}
```

### What Happens Inside

```
┌─────────────────────────────────────────────────────────┐
│  ROUTE HANDLER                                          │
│  - Validates: certification_id, topic_id, quiz_id      │
│  - Validates: modules array not empty                  │
│  - Passes dual-model config to pipeline                │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│  PIPELINE ORCHESTRATOR                                  │
│                                                         │
│  STEP 1: INGEST                                        │
│  ├─ Fetch exam guide from database                     │
│  ├─ Get domain context (IAM, VPC details)             │
│  └─ Load few-shot examples                            │
│                                                         │
│  STEP 2: RESOLVE GENERATION MODEL                     │
│  ├─ Check: params.generationModel = 'kimi' ✅         │
│  └─ Web Search: params.generationModelWebSearchEnabled = true ✅
│                                                         │
│  STEP 3: GENERATE QUESTIONS                           │
│  ├─ Call: generate() with Kimi                        │
│  ├─ Kimi searches web for latest AWS info            │
│  ├─ Generates 20 questions (4 modules × 5)           │
│  └─ Result: 20 questions ✅                           │
│                                                         │
│  STEP 4: DEDUPLICATE                                  │
│  ├─ Hash each question                                │
│  ├─ Compare against previously seen questions         │
│  └─ Result: 18 unique questions ✅                    │
│                                                         │
│  STEP 5: RESOLVE VALIDATION MODEL                    │
│  ├─ Check: params.validationModel = 'gemini' ✅      │
│  └─ Web Search: disabled ❌                           │
│                                                         │
│  STEP 6: VALIDATE QUESTIONS                          │
│  ├─ For each question (batches of 5):                │
│  │  ├─ Call: validateSingleQuestion() with Gemini   │
│  │  ├─ Gemini checks:                               │
│  │  │  ├─ Is the answer correct?                   │
│  │  │  ├─ Is the explanation accurate?             │
│  │  │  └─ Is confidence high?                      │
│  │  └─ Accept or reject                            │
│  └─ Result: 18 accepted, 0 rejected ✅             │
│                                                         │
│  STEP 7: BUILD SQL OUTPUT                            │
│  └─ Generate INSERT statements for 18 questions    │
│                                                         │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│  RESPONSE                                               │
│  {                                                      │
│    "success": true,                                     │
│    "questionCount": 18,                                 │
│    "rejectedCount": 0,                                  │
│    "sqlScript": "INSERT INTO question VALUES ...",      │
│    "questions": [...]                                   │
│  }                                                      │
└─────────────────────────────────────────────────────────┘
```

---

## Model Configurations

### Generation Model: KIMI

**Configuration:**
- Model: `kimi-k2.6`
- Temperature: `1` (Kimi K2.6 fixed value)
- Top_p: `0.95` (Kimi K2.6 fixed value)
- Web Search: ✅ **ENABLED**
- Max Tokens: `16384`

**What it does:**
```
Kimi searches the web for:
├─ Latest AWS service documentation
├─ Current best practices
├─ Recent architecture patterns
└─ Up-to-date pricing and features

Then generates creative questions that:
├─ Reference latest services
├─ Include current information
├─ Cover modern approaches
└─ Are research-backed
```

### Validation Model: GEMINI

**Configuration:**
- Model: `gemini-2.5-flash`
- Temperature: `0.15` (conservative, fact-focused)
- Top_p: `0.6` (focused sampling)
- Web Search: ❌ **DISABLED**
- Max Tokens: `4096`

**What it does:**
```
Gemini validates each question:
├─ Checks if answer is correct
├─ Verifies explanation is accurate
├─ Confirms no ambiguity in question
└─ Rejects if low confidence

Then either:
├─ ACCEPTS question if high confidence
└─ REJECTS question if low confidence or incorrect
```

---

## The Decision Trees

### Generation: Which Model?

```
Is generationModel specified?
├─ YES → Use generationModel (your case: 'kimi') ✅
└─ NO → Is aiModel specified?
        ├─ YES → Use aiModel
        └─ NO → Default to 'gemini'

Web Search Enabled?
├─ Check generationModelWebSearchEnabled first
├─ Fall back to kimiWebSearchEnabled
└─ Default to false
```

### Validation: Which Model?

```
Is validationModel specified?
├─ YES → Use validationModel (your case: 'gemini') ✅
└─ NO → Is aiModel specified?
        ├─ YES → Use aiModel
        └─ NO → Default to 'gemini'

Web Search Enabled?
├─ Check validationModelWebSearchEnabled first
└─ Default to false (validation should be conservative)
```

---

## Request Path Through Code

### 1. Request Arrives
```
POST /api/generate-hub
Body: { generationModel: 'kimi', validationModel: 'gemini', ... }
```
↓ **File:** `src/app/api/generate-hub/route.ts`

### 2. Route Handler
```typescript
const body = await request.json();
// body.generationModel = 'kimi'
// body.validationModel = 'gemini'

const pipelineParams = {
  // ... other params ...
  generationModel: body.generationModel,        // 'kimi'
  generationModelWebSearchEnabled: body.generationModelWebSearchEnabled,  // true
  validationModel: body.validationModel,        // 'gemini'
  validationModelWebSearchEnabled: body.validationModelWebSearchEnabled,  // false
};

const result = await runGenerationPipeline(pipelineParams);
```
↓ **File:** `src/lib/pipeline/index.ts`

### 3. Pipeline Orchestrator - Generation
```typescript
const generationModelToUse = params.generationModel || params.aiModel || 'gemini';
// = 'kimi'

const generationWebSearchEnabled = 
  params.generationModelWebSearchEnabled ?? 
  params.kimiWebSearchEnabled ?? 
  false;
// = true

const batch = await generate(generationParams, 'hub', {
  aiModel: generationModelToUse,              // 'kimi'
  kimiWebSearchEnabled: generationWebSearchEnabled,  // true
});
```
↓ **File:** `src/lib/pipeline/generate.ts`

### 4. Generate Function
```typescript
export async function generate(params, context, options) {
  const aiModel = options?.aiModel || 'gemini';  // 'kimi'
  const kimiWebSearchEnabled = options?.kimiWebSearchEnabled !== false;  // true

  if (aiModel === 'kimi') {
    const model = getKimiGenerationModel(kimiWebSearchEnabled);
    // Temperature: 1, Top_p: 0.95, Web Search: true
    
    responseText = await kimiGenerateContent(prompt, model);
    // Calls: https://api.moonshot.ai/v1/chat/completions
    
    parseFunction = parseKimiJson;
  }

  const questions = parseFunction(responseText);
  return questions;  // 20 questions
}
```
↓ **File:** `src/lib/kimi/client.ts`

### 5. Back to Pipeline - Validation
```typescript
const validationModelToUse = params.validationModel || params.aiModel || 'gemini';
// = 'gemini'

const validationWebSearchEnabled = params.validationModelWebSearchEnabled ?? false;
// = false

const { validated, rejected } = await validate(dedupedQuestions, {
  aiModel: validationModelToUse,              // 'gemini'
  kimiWebSearchEnabled: validationWebSearchEnabled,  // false
});
```
↓ **File:** `src/lib/pipeline/validate.ts`

### 6. Validate Function
```typescript
export async function validate(questions, options) {
  const { aiModel = 'gemini', kimiWebSearchEnabled = false } = options;
  // aiModel = 'gemini'

  for (const question of questions) {
    const validation = await validateSingleQuestion(
      question,
      certificationName,
      certTier,
      domainContext,
      aiModel,           // 'gemini'
      kimiWebSearchEnabled  // false
    );

    if (validation.is_correct && validation.confidence === 'high') {
      validated.push(question);
    } else {
      rejected.push(question);
    }
  }

  return { validated, rejected };  // 18 accepted, 0 rejected
}
```
↓ **File:** `src/lib/gemini/client.ts`

### 7. Back to Pipeline - Output
```typescript
const sqlScript = buildSqlOutput(finalQuestions, {...});
// Generates SQL INSERT for 18 questions

return {
  success: true,
  questionCount: 18,
  rejectedCount: 0,
  sqlScript,
  questions: finalQuestions
};
```
↓ **File:** `src/app/api/generate-hub/route.ts`

### 8. Return Response
```json
{
  "success": true,
  "questionCount": 18,
  "rejectedCount": 0,
  "sqlScript": "INSERT INTO public.question VALUES ...",
  "questions": [...]
}
```

---

## Data Flow Summary

```
REQUEST
  ↓
ROUTE HANDLER
  ├─ Receives: { generationModel: 'kimi', validationModel: 'gemini', ... }
  └─ Passes to: runGenerationPipeline(pipelineParams)
  ↓
PIPELINE ORCHESTRATOR
  ├─ GENERATE: decide 'kimi' + web search enabled
  │  └─ Call: generate() → 20 questions
  ├─ DEDUPLICATE: hash-based filtering
  │  └─ Result: 18 unique questions
  └─ VALIDATE: decide 'gemini' + web search disabled
     └─ Call: validate() → 18 accepted, 0 rejected
  ↓
OUTPUT
  └─ Return: success + SQL script + questions

RESPONSE
```

---

## What Each Model Sees

### Kimi Sees (Generation):
```
Prompt Template (from createGenerationPrompt):
├─ Exam guide: AWS SAA v3.0
├─ Domain context: Design Secure Architectures
├─ Modules: IAM, VPC, Data Protection, Monitoring
├─ Few-shot examples: 5 sample questions
├─ Generation mode: 'hub' (loose quality standards)
└─ Task: Generate 20 MCQ questions

Kimi can access:
├─ Web search for latest AWS docs
├─ Current architecture patterns
├─ Recent service updates
└─ Modern best practices
```

### Gemini Sees (Validation):
```
Validation Prompt (from createValidationPrompt):
├─ Question text: "Your company needs to..."
├─ Options: ["Option A", "Option B", "Option C", "Option D"]
├─ Proposed answer: Option B
├─ Certification: AWS Solutions Architect
├─ Exam format: AWS SAA v3.0
└─ Task: Validate accuracy and provide confidence score

Gemini cannot access:
├─ Web search
└─ Must rely on training data

Gemini checks:
├─ Is Option B actually correct?
├─ Is the explanation accurate?
├─ Is the question clear and unambiguous?
└─ What's your confidence level?
```

---

## Key Insights

### Why Dual Models?

| Aspect | Single Model | Dual Model |
|--------|-------|-----------|
| **Generation** | Gemini only | Kimi + web search ✅ |
| **Validation** | Gemini | Gemini ✅ |
| **Quality** | Good | Better ✅ |
| **Freshness** | Training data only | Current web data ✅ |
| **Consistency** | Same model bias | Different perspectives ✅ |
| **Cost** | N/A | Optimized ✅ |

### Temperature Differences

```
Generation (Kimi = 1):
├─ More creative
├─ More varied
└─ Temperature fixed by Kimi K2.6

Validation (Gemini = 0.15):
├─ More conservative
├─ More deterministic
└─ Temperature choice for accuracy
```

---

## Troubleshooting

### Seeing wrong model?
Check console output:
```
[pipeline] Using kimi for generation (web search: true)   // Should say 'kimi'
[pipeline] Using gemini for validation (web search: false)  // Should say 'gemini'
```

### Too many rejections?
- Gemini validation might be too strict
- Check: `validationModel` is set to 'gemini'
- Check: `validationModelWebSearchEnabled` is false (for conservation)

### Questions not using latest info?
- Check: `generationModel` is set to 'kimi'
- Check: `generationModelWebSearchEnabled` is true
- Check console for: `[kimi] Response status: 200`

---

## Bottom Line

```
You send dual-model config
    ↓
Route handler validates & passes it through
    ↓
Pipeline decides which model at each stage
    ↓
Generation: Kimi searches web, generates 20 questions
    ↓
Deduplication: Filter to 18 unique
    ↓
Validation: Gemini conservatively checks each
    ↓
Output: 18 questions (0 rejected) + SQL
```

**That's how dual-model generation works!** 🚀


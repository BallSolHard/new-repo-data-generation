# How the Dual-Model Hub Question Generation Works

## Quick Overview

The system now supports **using different LLM models for different stages** of the generation pipeline:

```
Request → Route Handler → Pipeline Orchestrator → Generate (Model A) → Validate (Model B) → Output
```

---

## Step-by-Step Flow

### **Step 1: Request Arrives at Route Handler**

**File:** `src/app/api/generate-hub/route.ts`

Frontend sends a POST request with dual-model configuration:

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

### **Step 2: Route Handler Processing**

**What the route handler does:**

```typescript
// 1. Parse JSON body
const body: RequestBody = await request.json();

// 2. Apply defaults (if not provided)
body.aiModel ??= 'gemini';
body.kimiWebSearchEnabled ??= true;
body.modules ??= [];

// 3. Validate required fields
function validateRequest(body) {
  // Check: certification_id, topic_id, quiz_id exist
  // Check: certification_name exists
  // Check: modules array not empty
}

// 4. Build pipeline parameters
const pipelineParams: PipelineParams = {
  // ... standard params ...
  
  // Dual-model configuration (passed through)
  generationModel: body.generationModel,              // 'kimi'
  generationModelWebSearchEnabled: body.generationModelWebSearchEnabled,  // true
  validationModel: body.validationModel,              // 'gemini'
  validationModelWebSearchEnabled: body.validationModelWebSearchEnabled,  // false
};

// 5. Call pipeline
const result = await runGenerationPipeline(pipelineParams);
```

**Key point:** The route handler is just a **pass-through** - it validates the request and forwards the dual-model config to the pipeline.

---

### **Step 3: Pipeline Orchestrator (The Main Logic)**

**File:** `src/lib/pipeline/index.ts`

This is where the dual-model magic happens. Let's trace through each phase:

#### **Phase 1: INGEST**

```typescript
const { examGuide, domainContext, fewShotExamples, ... } = await ingest({
  certificationName: params.certificationName,
  topicName: params.topicName,
  modules: params.modules,
  // ... other ingest params ...
});

// Result: Fetches exam guide, domain context, few-shot examples from database
```

#### **Phase 2: GENERATE (Uses Generation Model)**

**This is where the first model decision happens:**

```typescript
// ========================================
// RESOLVE WHICH MODEL TO USE FOR GENERATION
// ========================================

// Smart fallback logic:
const generationModelToUse = 
  params.generationModel ||           // 1. Use explicit dual-model config
  params.aiModel ||                   // 2. Fall back to single-model config
  'gemini';                           // 3. Default to Gemini

const generationWebSearchEnabled = 
  params.generationModelWebSearchEnabled ?? 
  params.kimiWebSearchEnabled ?? 
  false;

// Example with our request:
// generationModelToUse = 'kimi'
// generationWebSearchEnabled = true

console.log(`[pipeline] Using ${generationModelToUse} for generation (web search: ${generationWebSearchEnabled})`);
// Output: "[pipeline] Using kimi for generation (web search: true)"
```

**Then call the generate function with the resolved model:**

```typescript
const batch = await generate(generationParams, 'hub', {
  aiModel: generationModelToUse,           // 'kimi'
  kimiWebSearchEnabled: generationWebSearchEnabled,  // true
});
```

**What happens in the generate() function:**

```typescript
// File: src/lib/pipeline/generate.ts

export async function generate(params, context, options) {
  const aiModel = options?.aiModel || 'gemini';  // 'kimi' from route
  const kimiWebSearchEnabled = options?.kimiWebSearchEnabled !== false;  // true from route

  // Create generation prompt with all the context
  const prompt = await createGenerationPrompt({
    examGuide,
    domainContext,
    modules,
    fewShotExamples,
    // ... other context ...
  });

  let responseText: string;

  if (aiModel === 'kimi') {
    // ✅ KIMI BRANCH (our case)
    const model = getKimiGenerationModel(kimiWebSearchEnabled);
    // This model has:
    // - temperature: 1 (fixed for Kimi K2.6)
    // - top_p: 0.95 (fixed for Kimi K2.6)
    // - web_search: ENABLED ✅
    
    responseText = await kimiGenerateContent(prompt, model);
    // Makes REST call to: https://api.moonshot.ai/v1/chat/completions
    // With Kimi searching the web for current information
    
    parseFunction = parseKimiJson;
  } else {
    // ❌ GEMINI BRANCH (not used for generation in our case)
    const model = getGeminiGenerationModel();
    // This model has:
    // - temperature: 0.45 (creative)
    // - top_p: 0.8
    
    const result = await model.generateContent(prompt);
    responseText = result.response.text();
    parseFunction = parseGeminiJson;
  }

  // Parse the LLM response into structured JSON
  const questions = parseFunction<GeneratedQuestion[]>(responseText);
  return questions;
}
```

**Result of Generation:**
```
Generated 20 questions (4 modules × 5 questions each)
- All generated by Kimi with web search enabled
- Questions reference latest AWS services and best practices
- Raw output before validation
```

#### **Phase 3: DEDUPLICATE**

```typescript
// Filter out duplicate questions using content hashing
const seenHashes = new Set<string>();
const filterNew = (batch) => {
  // For each question:
  //   1. Compute hash of question text + options
  //   2. Check if we've seen this hash before
  //   3. Keep only new questions
};

let accumulated = filterNew(rawQuestions);
// Result: 18 unique questions (2 duplicates removed)
```

#### **Phase 4: VALIDATE (Uses Validation Model)**

**This is where the second model decision happens:**

```typescript
// ========================================
// RESOLVE WHICH MODEL TO USE FOR VALIDATION
// ========================================

const validationModelToUse = 
  params.validationModel ||           // 1. Use explicit dual-model config
  params.aiModel ||                   // 2. Fall back to single-model config
  'gemini';                           // 3. Default to Gemini

const validationWebSearchEnabled = 
  params.validationModelWebSearchEnabled ?? 
  false;  // Always false by default for validation

// Example with our request:
// validationModelToUse = 'gemini'
// validationWebSearchEnabled = false

console.log(`[pipeline] Using ${validationModelToUse} for validation (web search: ${validationWebSearchEnabled})`);
// Output: "[pipeline] Using gemini for validation (web search: false)"

// Call validate with the resolved model
const { validated, rejected } = await validate(dedupedQuestions, {
  certificationName: params.certificationName,
  domainContext,
  rejectLowConfidence: true,
  certTier,
  aiModel: validationModelToUse,           // 'gemini'
  kimiWebSearchEnabled: validationWebSearchEnabled,  // false
});
```

**What happens in the validate() function:**

```typescript
// File: src/lib/pipeline/validate.ts

export async function validate(questions, options) {
  const { aiModel = 'gemini', kimiWebSearchEnabled = false } = options;
  // aiModel = 'gemini'
  // kimiWebSearchEnabled = false

  const validated = [];
  const rejected = [];

  // Process questions in batches of 5
  for (let i = 0; i < questions.length; i += 5) {
    const batch = questions.slice(i, i + 5);
    
    // Validate each question in parallel
    const results = await Promise.allSettled(
      batch.map(q => validateSingleQuestion(q, certificationName, certTier, domainContext, aiModel, kimiWebSearchEnabled))
    );

    for (let j = 0; j < results.length; j++) {
      const question = batch[j];
      const result = results[j];

      if (result.status === 'rejected') {
        // Validation call failed
        question.validation_status = 'validation_failed';
        rejected.push(question);
        continue;
      }

      const validation = result.value;
      // validation has: {
      //   is_correct: boolean,
      //   confidence: 'high' | 'medium' | 'low',
      //   validation_notes: string,
      //   correct_answer_index?: number
      // }

      question.validation_status = validation.is_correct ? 'correct' : 'incorrect';

      // Reject low-confidence or incorrect questions
      if (rejectLowConfidence && (validation.confidence === 'low' || !validation.is_correct)) {
        rejected.push(question);
      } else {
        validated.push(question);
      }
    }
  }

  return { validated, rejected };
}

// Inside validateSingleQuestion:
export async function validateSingleQuestion(
  question, certificationName, certTier, domainContext, aiModel, kimiWebSearchEnabled
) {
  // Create validation prompt
  const prompt = await createValidationPrompt({
    question,
    certificationName,
    certTier,
    domainContext,
  });

  let responseText: string;

  if (aiModel === 'gemini') {
    // ✅ GEMINI BRANCH (our case)
    const model = getGeminiValidationModel();
    // This model has:
    // - temperature: 0.15 (conservative, factual)
    // - top_p: 0.6 (focused)
    // - web_search: DISABLED ❌
    
    const result = await model.generateContent(prompt);
    responseText = result.response.text();
    parseFunction = parseGeminiJson;
  } else {
    // ❌ KIMI BRANCH (not used for validation in our case)
    const model = getKimiValidationModel(kimiWebSearchEnabled);
    // temperature: 1 (fixed)
    // top_p: 0.95 (fixed)
    
    responseText = await kimiGenerateContent(prompt, model);
    parseFunction = parseKimiJson;
  }

  // Parse validation response
  const validation = parseFunction<ValidationResponse>(responseText);
  return validation;
}
```

**Result of Validation:**
```
Validated 18 questions (passed conservative Gemini checks)
Rejected 2 questions (failed validation or low confidence)
- Questions checked for: factual accuracy, correct answer, explanation quality
- All validation done by Gemini (conservative, deterministic)
```

#### **Phase 5: OUTPUT**

```typescript
const sqlScript = buildSqlOutput(finalQuestions, {
  topicId: params.topicId,
  quizId: params.quizId,
  examGuideVersion,
  generationTimestamp,
  validatedCount: finalQuestions.length,
  rejectedCount,
  startIndexByModule: params.startIndexByModule,
});

// Generates SQL INSERT statements for all validated questions
```

---

## Complete Flow Visualization

```
CLIENT REQUEST
    ↓
    {
      "generationModel": "kimi",
      "generationModelWebSearchEnabled": true,
      "validationModel": "gemini",
      "validationModelWebSearchEnabled": false
    }
    ↓
ROUTE HANDLER (generate-hub/route.ts)
    ├─ Validate required fields
    ├─ Build pipelineParams
    └─ Pass dual-model config through
    ↓
PIPELINE ORCHESTRATOR (pipeline/index.ts)
    │
    ├─ STEP 1: INGEST
    │  └─ Fetch exam guide, domain context, examples
    │
    ├─ STEP 2: GENERATE
    │  ├─ Resolve model: params.generationModel || params.aiModel || 'gemini'
    │  │  → 'kimi' ✅
    │  ├─ Call generate() with Kimi config
    │  │  ├─ Temperature: 1 (fixed)
    │  │  ├─ Top_p: 0.95 (fixed)
    │  │  └─ Web Search: ENABLED ✅
    │  ├─ Kimi calls: https://api.moonshot.ai/v1/chat/completions
    │  ├─ Parse response: 20 questions
    │  └─ Result: 20 generated questions (raw)
    │
    ├─ DEDUPLICATE
    │  └─ Remove duplicate questions
    │     Result: 18 unique questions
    │
    ├─ STEP 3: VALIDATE
    │  ├─ Resolve model: params.validationModel || params.aiModel || 'gemini'
    │  │  → 'gemini' ✅
    │  ├─ Call validate() with Gemini config
    │  │  ├─ Temperature: 0.15 (conservative)
    │  │  ├─ Top_p: 0.6 (focused)
    │  │  └─ Web Search: DISABLED ❌
    │  ├─ For each question (batches of 5):
    │  │  ├─ Gemini validates factual accuracy
    │  │  ├─ Checks if correct_answer is right
    │  │  └─ Checks explanation quality
    │  ├─ Reject low-confidence/incorrect
    │  └─ Result: 18 validated, 2 rejected
    │
    └─ STEP 4: OUTPUT
       └─ Generate SQL INSERT script
          Result: SQL for 18 questions
    ↓
RESPONSE
    {
      "success": true,
      "questionCount": 18,
      "rejectedCount": 2,
      "sqlScript": "INSERT INTO ...",
      "questions": [...]
    }
```

---

## How It Decides Which Model to Use

### **For Generation:**

```typescript
const generationModelToUse = 
  params.generationModel ||           // Tier 1: Explicit dual-model config
  params.aiModel ||                   // Tier 2: Legacy single-model config
  'gemini';                           // Tier 3: Hard default

// With our request:
// params.generationModel = 'kimi' ← SELECTED
// params.aiModel = 'gemini' (ignored)
// Result: 'kimi'
```

### **For Validation:**

```typescript
const validationModelToUse = 
  params.validationModel ||           // Tier 1: Explicit dual-model config
  params.aiModel ||                   // Tier 2: Legacy single-model config
  'gemini';                           // Tier 3: Hard default

// With our request:
// params.validationModel = 'gemini' ← SELECTED
// params.aiModel = 'gemini' (ignored)
// Result: 'gemini'
```

---

## Configuration Scenarios

### **Scenario 1: Dual-Model (NEW)**
```json
{
  "generationModel": "kimi",
  "generationModelWebSearchEnabled": true,
  "validationModel": "gemini",
  "validationModelWebSearchEnabled": false
}
```
✅ Kimi generates (with web search)
✅ Gemini validates (conservative)

### **Scenario 2: Single-Model Kimi (LEGACY)**
```json
{
  "aiModel": "kimi",
  "kimiWebSearchEnabled": true
}
```
✅ Kimi generates (with web search)
✅ Kimi validates (same model)

### **Scenario 3: Single-Model Gemini (DEFAULT)**
```json
{
  // No model specified
}
```
✅ Gemini generates (default)
✅ Gemini validates (default)

### **Scenario 4: Explicit Dual-Model Overrides Legacy**
```json
{
  "aiModel": "gemini",                    // Legacy config
  "kimiWebSearchEnabled": true,
  "generationModel": "kimi",              // NEW dual-model takes precedence
  "generationModelWebSearchEnabled": true,
  "validationModel": "gemini",
  "validationModelWebSearchEnabled": false
}
```
✅ Kimi generates (dual-model wins)
✅ Gemini validates (dual-model wins)
❌ Legacy config ignored

---

## Console Output

When your request runs, you'll see:

```
[pipeline] Using kimi for generation (web search: true)
[pipeline] Generating for difficulty="intermediate": 4 modules × 5 questions = 20 total (using kimi)
[generate] Calling kimi for 4 modules × 5 questions
[kimi] Attempting to connect to https://api.moonshot.ai/v1/chat/completions
[kimi] Model: kimi-k2.6
[kimi] Temperature: 1, top_p: 0.95
[kimi] Response status: 200
[kimi] Successfully generated content (15234 chars)
[generate] Received response (15234 chars, first 3000 chars): {...}
[pipeline] After deduplication: 18/20 questions remain (2 duplicates removed)
[pipeline] Using gemini for validation (web search: false)
[validate] Validating 18 questions using gemini...
[validate] Validating question 1-5...
[validate] Validating question 6-10...
[validate] Validating question 11-15...
[validate] Validating question 16-18...
[validate] Results: 18 passed, 0 rejected (0 failed to parse)
[pipeline] Complete. 18 questions generated, 0 rejected.
```

---

## Key Takeaways

### **How It Works:**

1. **Route Handler** → validates request and forwards dual-model config
2. **Pipeline Orchestrator** → decides which model to use at each stage
3. **Generation Phase** → calls chosen generation model with its config
4. **Validation Phase** → calls chosen validation model with its config
5. **Output** → returns questions + SQL

### **Smart Defaults:**

- Explicit dual-model config takes precedence
- Falls back to legacy single-model config if available
- Defaults to Gemini if nothing specified

### **Model Separation:**

- **Generation Model** can be different from **Validation Model**
- Each has independent web search configuration
- Temperatures are fixed per model (not configurable)

### **Benefits:**

✅ Kimi's creativity + web search for generation
✅ Gemini's accuracy for validation
✅ Best of both models
✅ Fully backward compatible

---

## Files Involved

| File | Role |
|------|------|
| `src/app/api/generate-hub/route.ts` | Receives request, passes dual-model config |
| `src/lib/pipeline/index.ts` | Orchestrates both phases, makes model decisions |
| `src/lib/pipeline/generate.ts` | Calls generation model (Kimi or Gemini) |
| `src/lib/pipeline/validate.ts` | Calls validation model (Kimi or Gemini) |
| `src/lib/types/generation.ts` | Type definitions for dual-model config |
| `src/lib/gemini/client.ts` | Gemini API calls (generation & validation) |
| `src/lib/kimi/client.ts` | Kimi API calls (generation & validation) |


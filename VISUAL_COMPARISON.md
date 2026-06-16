# Visual Comparison: Request Flow

## Before (Gemini Only)

```
┌─────────────────────────┐
│  POST /api/generate-hub │
│  {                      │
│    certification_id     │
│    certification_name   │
│    topic_id             │
│    quiz_id              │
│    modules: [...]       │
│  }                      │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  route.ts               │
│  (no model selection)    │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│  pipeline/index.ts      │
│  runGenerationPipeline  │
└───────────┬─────────────┘
            │
     ┌──────┼──────┐
     │      │      │
     ▼      ▼      ▼
  ┌────────────────────┐
  │  Ingest   (Step 1) │  (model-agnostic)
  └──────────┬─────────┘
             │
             ▼
  ┌────────────────────┐
  │  Generate (Step 2) │  ◀── Always uses GEMINI
  │                    │
  │  getGenerationModel()
  │  model.generateContent()
  │  parseGeminiJson()
  └──────────┬─────────┘
             │
             ▼
  ┌────────────────────┐
  │  Validate (Step 3) │  ◀── Always uses GEMINI
  │                    │
  │  getValidationModel()
  │  model.generateContent()
  │  parseGeminiJson()
  └──────────┬─────────┘
             │
             ▼
  ┌────────────────────┐
  │  Output   (Step 4) │  (model-agnostic)
  └──────────┬─────────┘
             │
             ▼
┌─────────────────────────┐
│  Response (SQL + JSON)  │
│  {                      │
│    success: true        │
│    sqlScript: "..."     │
│    questions: [...]     │
│  }                      │
└─────────────────────────┘
```

---

## After (Gemini + Kimi)

```
┌──────────────────────────────────┐
│  POST /api/generate-hub          │
│  {                               │
│    certification_id              │
│    certification_name            │
│    topic_id                      │
│    quiz_id                       │
│    modules: [...]                │
│    aiModel: "gemini" | "kimi" 🆕 │
│    kimiWebSearchEnabled: bool 🆕  │
│  }                               │
└───────────┬──────────────────────┘
            │
            ▼
┌──────────────────────────────────┐
│  route.ts                        │
│  Parse aiModel & kimiWebSearch   │
│  Defaults: gemini, true          │
└───────────┬──────────────────────┘
            │
            ▼
┌──────────────────────────────────┐
│  pipeline/index.ts               │
│  runGenerationPipeline(params)   │
│  params now includes aiModel     │
└───────────┬──────────────────────┘
            │
     ┌──────┼──────┐
     │      │      │
     ▼      ▼      ▼
  ┌────────────────────┐
  │  Ingest (Step 1)   │  (model-agnostic)
  └──────────┬─────────┘
             │
             ▼
  ┌────────────────────┐
  │  Generate (Step 2) │  🆕 Now with model selection
  │ ┌─────────────────┐│
  │ │ if aiModel===   ││
  │ │   'kimi'        ││
  │ │ ┌─────────────┐ ││
  │ │ │ getKimiGen()│ ││  ◀── Uses Kimi API
  │ │ │kimiGenerate ││  │     with web search
  │ │ │parseKimiJson││  │
  │ │ └─────────────┘ ││
  │ │ else            ││
  │ │ ┌─────────────┐ ││
  │ │ │getGeminiGen││ ││  ◀── Uses Gemini API
  │ │ │gemini.call │ ││
  │ │ │parseGemini │ ││
  │ │ └─────────────┘ ││
  │ └─────────────────┘│
  └──────────┬─────────┘
             │
             ▼
  ┌────────────────────┐
  │  Validate (Step 3) │  🆕 Now with model selection
  │ ┌─────────────────┐│
  │ │ Same logic as   ││
  │ │ generation step:││  ◀── Same model as
  │ │                 ││     generation
  │ │ if aiModel===   ││
  │ │   'kimi'        ││
  │ │ └─────────────┐ ││
  │ │   Kimi Val  │ ││
  │ │ else      ││
  │ │   Gemini Val││
  │ │ └─────────────┘ ││
  │ └─────────────────┘│
  └──────────┬─────────┘
             │
             ▼
  ┌────────────────────┐
  │  Output (Step 4)   │  (model-agnostic)
  └──────────┬─────────┘
             │
             ▼
┌──────────────────────────────────┐
│  Response (SQL + JSON)           │
│  Same format for both models!    │
│  {                               │
│    success: true                 │
│    sqlScript: "..."              │
│    questions: [...]              │
│  }                               │
└──────────────────────────────────┘
```

---

## Request Examples Side-by-Side

### Example 1: Default (Gemini)

```json
{
  "certification_id": "1",
  "certification_name": "AWS Solutions Architect",
  "topic_id": "101",
  "quiz_id": "quiz_1",
  "modules": [
    {
      "module_id": "m1",
      "module_name": "EC2 Fundamentals"
    }
  ]
  // aiModel NOT specified → defaults to "gemini"
  // kimiWebSearchEnabled NOT specified → not applicable
}
```

↓ Result

```
[generate] Calling gemini for 1 modules × 10 questions
[validate] Validating X questions using gemini...
```

---

### Example 2: Kimi with Web Search

```json
{
  "certification_id": "1",
  "certification_name": "AWS Solutions Architect",
  "topic_id": "101",
  "quiz_id": "quiz_1",
  "modules": [
    {
      "module_id": "m1",
      "module_name": "EC2 Fundamentals"
    }
  ],
  "aiModel": "kimi",
  "kimiWebSearchEnabled": true
}
```

↓ Result

```
[generate] Calling kimi for 1 modules × 10 questions
  • Web search: ENABLED
  • Access to current AWS documentation
[validate] Validating X questions using kimi...
```

---

### Example 3: Kimi without Web Search

```json
{
  "certification_id": "1",
  "certification_name": "AWS Solutions Architect",
  "topic_id": "101",
  "quiz_id": "quiz_1",
  "modules": [
    {
      "module_id": "m1",
      "module_name": "EC2 Fundamentals"
    }
  ],
  "aiModel": "kimi",
  "kimiWebSearchEnabled": false
}
```

↓ Result

```
[generate] Calling kimi for 1 modules × 10 questions
  • Web search: DISABLED
  • Faster response time
[validate] Validating X questions using kimi...
```

---

## Processing Pipeline with Model Logic

```
Ingest Phase
├─ Load exam guide
├─ Extract domain context
├─ Get few-shot examples
└─ (Same regardless of model)

Generate Phase 🆕 Model Selection
├─ Build prompt
├─ IF aiModel == 'kimi'
│  ├─ Get Kimi model (web_search = kimiWebSearchEnabled)
│  ├─ Call Kimi REST API
│  ├─ Parse with parseKimiJson()
│  └─ Handle Kimi-specific responses
├─ ELSE (default to Gemini)
│  ├─ Get Gemini model
│  ├─ Call Gemini SDK
│  ├─ Parse with parseGeminiJson()
│  └─ Handle Gemini-specific responses
└─ Return questions array

Deduplication Phase
├─ Compare against generated_hashes.txt
└─ (Same regardless of model)

Regeneration Loop (if needed)
├─ IF not enough questions
│  └─ Call generate() again with SAME model
└─ (Consistency: don't mix models)

Validation Phase 🆕 Model Selection
├─ FOR each question batch (size 5)
│  ├─ Build validation prompt
│  ├─ IF aiModel == 'kimi'
│  │  ├─ Get Kimi validation model
│  │  ├─ Call Kimi API
│  │  └─ Parse with parseKimiJson()
│  ├─ ELSE (default to Gemini)
│  │  ├─ Get Gemini validation model
│  │  ├─ Call Gemini SDK
│  │  └─ Parse with parseGeminiJson()
│  └─ Apply validation result
└─ Return validated/rejected

Output Phase
├─ Build SQL INSERT statements
├─ Create question-quiz links
├─ Update question count
└─ (Same regardless of model)
```

---

## Temperature & Token Settings

Both models use identical config per phase:

### Generation Phase
```
Temperature: 0.45  (balanced creativity)
Max Tokens: 16,384 (generous)
Top P: 0.8
Top K: 40
```

### Validation Phase
```
Temperature: 0.15  (conservative, strict)
Max Tokens: 4,096  (reasonable)
Top P: 0.6
Top K: 20
```

**Only difference for Kimi:** Optional web search parameter

---

## Error Handling

### Gemini Error
```
[generate] Failed to parse Gemini response: Error: ...
→ Uses Gemini-specific debugging
```

### Kimi Error
```
[generate] Failed to parse Kimi response: Error: ...
→ Uses Kimi-specific debugging
```

### Web Search Timeout
```
[kimi] Generation error: Kimi API timeout
→ Set kimiWebSearchEnabled: false to retry without search
```

---

## Output is Identical

Regardless of which model is used, the response format is exactly the same:

```typescript
{
  success: boolean;
  sqlScript: string;
  questions: GeneratedQuestion[];
  questionCount: number;
  moduleCount: number;
  examGuideVersion: string;
  validatedCount: number;
  rejectedCount: number;
  generationTimestamp: string;
  questionBank?: { stored: number; duplicates: number };
}
```

✅ Questions are questions  
✅ SQL is SQL  
✅ Output schema is schema  

**Same templates, different models!**

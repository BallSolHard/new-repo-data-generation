# Kimi Logging - Visual Flow

## Complete Execution Flow with Logging Points

```
┌─────────────────────────────────────────────────────────────┐
│  POST /api/generate-hub                                     │
│  (with generationModel: "kimi", validationModel: "gemini")  │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│  [pipeline] GENERATION CONFIGURATION                         │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ Model: KIMI                                           │  │
│  │ Web Search: ✅ ENABLED                                │  │
│  │ Distribution: NO                                      │  │
│  └───────────────────────────────────────────────────────┘  │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│  [kimi] STEP 1: Preparing Kimi API Request                  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ ✅ Endpoint verified                                  │  │
│  │ ✅ Model: kimi-k2.6                                   │  │
│  │ ✅ Temperature: 1 (fixed)                             │  │
│  │ ✅ Top_p: 0.95 (fixed)                                │  │
│  │ ✅ Max Tokens: 16384                                  │  │
│  │ ✅ Web Search: ENABLED                                │  │
│  │ ✅ Prompt Length: 8452 chars                          │  │
│  └───────────────────────────────────────────────────────┘  │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│  [kimi] STEP 2: Sending Request to Kimi API                 │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ POST https://api.moonshot.ai/v1/chat/completions     │  │
│  │ Headers:                                              │  │
│  │   Content-Type: application/json                      │  │
│  │   Authorization: Bearer ${KIMI_API_KEY}              │  │
│  │ Body: {model, messages, temperature, top_p, etc}    │  │
│  └───────────────────────────────────────────────────────┘  │
└────────────────────┬────────────────────────────────────────┘
                     │
         ┌───────────┴───────────┐
         │  Network Request      │
         │  (4523ms elapsed)     │
         └───────────┬───────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│  [kimi] STEP 3: Checking Response Status                    │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ Response Status: 200 OK ✅                             │  │
│  │ Response Time: 4523ms                                 │  │
│  └───────────────────────────────────────────────────────┘  │
└────────────────┬────────────────────────┬───────────────────┘
                 │ (Success)              │ (Error: 401/429/500)
                 ▼                        ▼
    ┌─────────────────────┐    ┌─────────────────────┐
    │ Continue to Step 4  │    │ ❌ API Error        │
    └──────────┬──────────┘    │ [Log error details] │
               │               └─────────────────────┘
               ▼
┌─────────────────────────────────────────────────────────────┐
│  [kimi] STEP 4: Parsing Response JSON                       │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ ✅ Successfully parsed response                       │  │
│  │ Content Length: 15234 characters                      │  │
│  └───────────────────────────────────────────────────────┘  │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│  [kimi] STEP 5: Extracting Content                          │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ ✅ Content extracted successfully                     │  │
│  │ First 200 chars: [{"text": "What is AWS IAM?", ...   │  │
│  └───────────────────────────────────────────────────────┘  │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│  [kimi-parser] STEP 6: Parsing Kimi JSON Response           │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ Raw Response Length: 15234 characters                │  │
│  │                                                       │  │
│  │ STEP 6.1: Cleaning Response                          │  │
│  │  → Strip markdown code fences (if present)           │  │
│  │                                                       │  │
│  │ STEP 6.2: Attempting Direct JSON Parse              │  │
│  │  → Try: JSON.parse(cleaned)                          │  │
│  └───────────────────────────────────────────────────────┘  │
└────────────┬──────────────────────────┬────────────────────┘
             │ Success                  │ Failed
             ▼                          ▼
    ┌─────────────────┐       ┌──────────────────────────┐
    │ ✅ Direct parse │       │ Try Fallback 1: Quote Fix│
    │ successful!     │       │ ─────────────────────────│
    │ Parsed 12 items │       │ Attempt: Add closing \"  │
    │                 │       │ Retry: JSON.parse()     │
    │ Done!           │       │                          │
    └────────┬────────┘       │ Success? → Return        │
             │                └──────┬───────────────────┘
             │                       │ Failed
             │                       ▼
             │               ┌──────────────────────────┐
             │               │Fallback 2: Array Extract │
             │               │ ─────────────────────────│
             │               │ Match: /\[[\s\S]*\]/    │
             │               │ Parse array pattern     │
             │               │ Success? → Return       │
             │               │                         │
             │               │ Failed → Fallback 3...  │
             │               │   (Object extraction)   │
             │               │ Failed → Fallback 4...  │
             │               │   (Array bracket fix)   │
             │               │ Failed → Fallback 5...  │
             │               │   (Individual objects)  │
             │               │ Failed → ❌ ERROR      │
             │               └──────────┬──────────────┘
             │                          │
             └──────────────┬───────────┘
                            ▼
        ┌───────────────────────────────────────┐
        │ [kimi-parser] ✅ Parse successful     │
        │ Parsed 12 items (or 8 with fallback) │
        └─────────────┬───────────────────────┘
                      │
                      ▼
        ┌───────────────────────────────────────┐
        │ [pipeline] Deduplication             │
        │ After deduplication: 10/12 remain    │
        │ (2 duplicates removed)               │
        └─────────────┬───────────────────────┘
                      │
                      ▼
        ┌───────────────────────────────────────┐
        │ [pipeline] VALIDATION CONFIGURATION  │
        │ ┌─────────────────────────────────┐  │
        │ │ Model: GEMINI ✅               │  │
        │ │ Web Search: ❌ DISABLED        │  │
        │ │ Questions to Validate: 10      │  │
        │ └─────────────────────────────────┘  │
        └─────────────┬───────────────────────┘
                      │
                      ▼
        ┌───────────────────────────────────────┐
        │ [validate] Gemini validates 10 Qs   │
        │ Process: 5 questions at a time      │
        │ Checks: answer correctness,        │
        │         explanation quality        │
        │ Result: 8 valid, 2 rejected        │
        └─────────────┬───────────────────────┘
                      │
                      ▼
        ┌───────────────────────────────────────┐
        │ [pipeline] BUILDING OUTPUT           │
        │ ┌─────────────────────────────────┐  │
        │ │ Final Questions: 8              │  │
        │ │ Rejected Count: 2               │  │
        │ │ SQL Script Length: 45234 chars  │  │
        │ └─────────────────────────────────┘  │
        └─────────────┬───────────────────────┘
                      │
                      ▼
        ┌───────────────────────────────────────┐
        │ [pipeline] PIPELINE COMPLETE ✅      │
        │ ┌─────────────────────────────────┐  │
        │ │ Generated: 8 | Rejected: 2      │  │
        │ └─────────────────────────────────┘  │
        └─────────────┬───────────────────────┘
                      │
                      ▼
        ┌───────────────────────────────────────┐
        │ Return to client:                     │
        │ {                                     │
        │   success: true,                      │
        │   questions: [...],  (8 items)       │
        │   questionCount: 8,                   │
        │   rejectedCount: 2,                   │
        │   validatedCount: 8,                  │
        │   sqlScript: "INSERT INTO...",       │
        │   generationTimestamp: "2026-05-29..."│
        │ }                                     │
        └───────────────────────────────────────┘
```

---

## Log Output Timeline

```
Time    Component        Status   Message
────────────────────────────────────────────────────────────────
 0ms    [pipeline]       ℹ️      GENERATION CONFIGURATION
 0ms    [kimi]          ℹ️      STEP 1: Preparing Request
 0ms    [kimi]          ℹ️      STEP 2: Sending Request
  
 45ms   [kimi]          ℹ️      (waiting for API response...)
        [network]        ...     (4523ms round-trip)
 4568ms [kimi]          ℹ️      STEP 3: Response Status: 200 OK
 4568ms [kimi]          ℹ️      STEP 4: Parsing Response JSON
 4569ms [kimi]          ✅      ✅ Successfully parsed
 4569ms [kimi]          ℹ️      STEP 5: Extracting Content
 4570ms [kimi]          ✅      ✅ Content extracted
        
 4570ms [kimi-parser]    ℹ️      STEP 6: Parsing JSON
 4570ms [kimi-parser]    ℹ️      STEP 6.1: Cleaning Response
 4570ms [kimi-parser]    ℹ️      STEP 6.2: Attempting Direct Parse
 4571ms [kimi-parser]    ✅      ✅ Direct parse successful!
        
 4571ms [pipeline]       ℹ️      After deduplication: 10/12
 4572ms [pipeline]       ℹ️      VALIDATION CONFIGURATION
 4573ms [validate]       ℹ️      Validating 10 questions...
 6200ms [validate]       ✅      Validation complete
        
 6201ms [pipeline]       ℹ️      BUILDING OUTPUT
 6202ms [pipeline]       ✅      SQL script generated
 6203ms [pipeline]       ✅      PIPELINE COMPLETE
```

---

## Error Flow Example

```
[kimi] STEP 3: Checking Response Status
[kimi] Response Status: 401 Unauthorized
[kimi] ❌ STEP 3 FAILED: HTTP Error
[kimi] Error Response: {"error": {"message": "Invalid API key"}}
        ↓
        [Log shows this happens at Step 3]
        ↓
        Action: Check KIMI_API_KEY in .env file
```

vs.

```
[kimi] STEP 5: Extracting Content
[kimi] ✅ Content extracted successfully

[kimi-parser] STEP 6: Parsing Kimi JSON Response
[kimi-parser] STEP 6.2: Attempting Direct JSON Parse
[kimi-parser] ❌ Direct parse failed: SyntaxError: Unexpected token
[kimi-parser] STEP 6.3: Attempting Quote Fix
[kimi-parser] ❌ Quote fix failed
[kimi-parser] STEP 6.4: Attempting Array Extraction
[kimi-parser] ✅ Array extraction successful! Found 10 items
        ↓
        [Multiple fallback strategies attempted]
        ↓
        [Still successful - extracted 10 out of 12]
        ↓
        [Completes successfully with fewer questions]
```

---

## Key Metrics to Watch

```
┌────────────────────┬──────────┬──────────┬──────────┐
│ Metric             │ Good     │ Warning  │ Bad      │
├────────────────────┼──────────┼──────────┼──────────┤
│ Response Time      │ 3-6s     │ 6-10s    │ >10s     │
│ Content Length     │ 10-15KB  │ 5-10KB   │ <5KB     │
│ Parse Strategy     │ Direct   │ Fallback │ Failed   │
│ Dedup Rate         │ <10%     │ 10-20%   │ >50%     │
│ Validation Pass    │ 70-80%   │ 60-70%   │ <60%     │
│ Final Questions    │ 8-10     │ 6-8      │ <6       │
└────────────────────┴──────────┴──────────┴──────────┘
```

---

## Component Communication

```
┌──────────────────┐
│   API Request    │
│  (POST body)     │
└────────┬─────────┘
         │
         ▼
┌─────────────────────────────────┐
│  generate-hub/route.ts          │
│  ├─ Parse RequestBody           │
│  ├─ Apply defaults              │
│  └─ Pass to pipeline            │
└────────┬────────────────────────┘
         │
         ▼
┌─────────────────────────────────┐
│  pipeline/index.ts              │
│  ├─ [pipeline] GENERATION CONF  │
│  ├─ Call generate()             │
│  ├─ [pipeline] Deduplication    │
│  ├─ [pipeline] VALIDATION CONF  │
│  ├─ Call validate()             │
│  └─ [pipeline] BUILDING OUTPUT  │
└────────┬────────────────────────┘
         │
    ┌────┴─────┐
    │           │
    ▼           ▼
┌─────────┐  ┌──────────┐
│generate()  │validate()│
└────┬────┘  └────┬─────┘
     │           │
     ▼           ▼
┌────────────────────────────────────┐
│ kimi/client.ts                     │
│ ├─ [kimi] STEP 1: Prepare         │
│ ├─ [kimi] STEP 2: Send            │
│ ├─ [kimi] STEP 3: Check Status    │
│ ├─ [kimi] STEP 4: Parse Response  │
│ ├─ [kimi] STEP 5: Extract Content │
│ └─ [kimi-parser] STEP 6: Parse JSON
└────────────────────────────────────┘
```


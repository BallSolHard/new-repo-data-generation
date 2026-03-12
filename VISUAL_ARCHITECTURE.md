# Reference Questions Integration — Visual Architecture

## System Architecture Diagram

```
┌────────────────────────────────────────────────────────────────────────┐
│                      Question Generation Request                       │
│         POST /api/generate-hub or /api/generate-mock                   │
│                  { certCode, modules, questionTypes }                  │
└────────────────────────┬─────────────────────────────────────────────────┘
                         │
                         ▼
┌────────────────────────────────────────────────────────────────────────┐
│               PIPELINE: INGEST → GENERATE → VALIDATE                  │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│  1. INGEST                                                             │
│     • Load exam guide (SAA-C03 or CLF-C02)                             │
│     • Load modules and question requirements                           │
│     • Prepare parameters for generation                                │
│                                                                        │
│  2. GENERATE  ←─── [THIS IS WHERE REFERENCE INTEGRATION HAPPENS]       │
│     ├─ createGenerationPrompt(params)                                  │
│     │  ├─ Check: fewShotExamples provided? ──┐                         │
│     │  │  YES ──→ Use provided examples      │                        │
│     │  │  NO  ──→ Auto-load from index.txt   ├──→ [NEW FEATURE]        │
│     │  │                                      │                        │
│     │  └─ getCachedReferences(certCode, 5)   │                        │
│     │     ├─ First time?                      │                        │
│     │     │  ├─ Parse index.txt file          │                        │
│     │     │  ├─ Extract ~400 questions        │                        │
│     │     │  ├─ Select 5 diverse samples      │                        │
│     │     │  └─ Cache in memory               │                        │
│     │     │                                    │                        │
│     │     └─ Subsequent times?                │                        │
│     │        └─ Return from cache (instant)   │                        │
│     │                                          │                        │
│     ├─ buildFewShotSection(selectedExamples) │                        │
│     │  └─ Format as LLM calibration section   │                        │
│     │                                          │                        │
│     ├─ buildHubPrompt() or buildMockPrompt()  │                        │
│     │  └─ Integrate few-shot into full prompt │                        │
│     │                                          │                        │
│     └─ Return prompt with calibrated examples │                        │
│                                                │                        │
│  3. VALIDATE & OUTPUT                          │                        │
│     • Call Gemini LLM with prompt              │                        │
│     • Parse and validate JSON response         │                        │
│     • Insert into database                     │                        │
│                                                │                        │
└────────────────────────────────────────────────────────────────────────┘
```

---

## Data Flow: Reference Question Loading

```
GENERATION REQUEST
│
├─ Certification Code: "SAA-C03"
│  
├─ createGenerationPrompt()
│  │
│  └─ getCachedReferences("SAA-C03", 5)
│     │
│     ├─ CHECK CACHE: "SAA-C03-5"?
│     │
│     ├─ FIRST TIME (MISS) ↓
│     │  │
│     │  ├─ loadCertificationReferences("SAA-C03")
│     │  │  │
│     │  │  ├─ READ FILE
│     │  │  │  └─ src/data/reference-questions/aws/
│     │  │  │     solutions-architect-associate/index.txt
│     │  │  │  │  (~400 questions in markdown format)
│     │  │  │  │
│     │  │  ├─ PARSE MARKDOWN
│     │  │  │  └─ parseReferenceQuestionsFromText(content)
│     │  │  │     ├─ Extract question text
│     │  │  │     ├─ Extract options list
│     │  │  │     ├─ Extract bolded correct answer
│     │  │  │     ├─ Extract explanation
│     │  │  │     ├─ Auto-detect type (MCQ/Multiple/etc)
│     │  │  │     └─ Extract tags (services, concepts)
│     │  │  │  │
│     │  │  ├─ CONVERT TO TYPESCRIPT
│     │  │  │  └─ convertToReferenceQuestions()
│     │  │  │     └─ ReferenceQuestion[] (400 items)
│     │  │  │  │
│     │  │  └─ SELECT DIVERSE (5)
│     │  │     └─ selectRandomQuestions(allQuestions, 5)
│     │  │        • Pick 1 from each type if available
│     │  │        • Different difficulty levels
│     │  │        • Different domains
│     │  │        → 5 questions selected
│     │  │
│     │  └─ CACHE IN MEMORY
│     │     └─ referenceCache["SAA-C03-5"] = selectedQuestions
│     │
│     ├─ SUBSEQUENT TIMES (HIT) ↓
│     │  │
│     │  └─ Return from cache instantly
│     │     └─ referenceCache["SAA-C03-5"]
│     │
│     └─ RETURN 5 QUESTIONS
│        │
│        └─ buildFewShotSection()
│           └─ Format as examples for LLM

PROMPT WITH FEW-SHOT EXAMPLES SENT TO LLM
```

---

## Component Architecture

```
┌──────────────────────────────────────────────────────────────────────┐
│                    GENERATION PROMPT BUILDERS                        │
│                                                                      │
│  generation-new.ts (createGenerationPrompt)                          │
│  ├─ Receives: examGuide, modules, certTier, genMode, ...            │
│  ├─ NEW: Auto-loads fewShotExamples if not provided                 │
│  │  └─ Calls getCachedReferences(certCode)                          │
│  ├─ Builds: tierBlock, modeBlock, examGuideSection, ...             │
│  ├─ Integrates: fewShotSection with examples                        │
│  └─ Returns: Full prompt string (or hub/mock specific)              │
│                                                                      │
└──────────────────────────┬───────────────────────────────────────────┘
                           │
                           │ calls
                           ▼
┌──────────────────────────────────────────────────────────────────────┐
│              REFERENCE QUESTION LOADER & CACHE                       │
│                                                                      │
│  load-reference-questions.ts (getCachedReferences)                   │
│  ├─ Loads certification-specific reference questions                │
│  ├─ Cache management (in-memory, per cert)                          │
│  ├─ Selects 5 diverse questions from ~400                           │
│  ├─ Maps: SAA-C03 → solutions-architect-associate/index.txt          │
│  ├─ Maps: CLF-C02 → AWS Certified Cloud Practitioner.../index.txt   │
│  └─ On first call: delegates to parser                              │
│  └─ On subsequent: returns cached data                              │
│                                                                      │
└──────────────────────────┬───────────────────────────────────────────┘
                           │
                           │ delegates to (first time only)
                           ▼
┌──────────────────────────────────────────────────────────────────────┐
│            REFERENCE QUESTION PARSER                                 │
│                                                                      │
│  parse-reference-questions.ts (parseReferenceQuestionsFromText)      │
│  ├─ Input: Raw markdown content from index.txt                      │
│  ├─ Parse:                                                          │
│  │  ├─ Question text (first line)                                   │
│  │  ├─ Options list (bullet points)                                 │
│  │  ├─ Bolded correct answer                                        │
│  │  ├─ Explanation section                                          │
│  │  ├─ Question type detection                                      │
│  │  └─ Tag extraction from question                                 │
│  ├─ Output: ParsedQuestionBlock[]                                   │
│  │                                                                  │
│  └─ convertToReferenceQuestions()                                   │
│     ├─ Input: ParsedQuestionBlock[], certCode, domainId             │
│     └─ Output: ReferenceQuestion[] (TypeScript objects)             │
│                                                                      │
└──────────────────────────┬───────────────────────────────────────────┘
                           │
                           │ reads from
                           ▼
┌──────────────────────────────────────────────────────────────────────┐
│                    DATA SOURCES (index.txt files)                    │
│                                                                      │
│  src/data/reference-questions/aws/                                   │
│  ├─ solutions-architect-associate/index.txt (400 questions)          │
│  └─ AWS Certified Cloud Practitioner.../index.txt (400 questions)   │
│                                                                      │
│  Format: Markdown                                                    │
│  Structure:                                                          │
│  - Question text                                                    │
│  - Bullet-point options                                             │
│  - **Bolded correct option**                                        │
│  - Explanation: [detailed explanation]                              │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

---

## Execution Timeline

### First Request for SAA-C03

```
T=0ms:   User: POST /api/generate-hub { certCode: "SAA-C03", ... }
         
T=1ms:   Pipeline: Ingest phase
         └─ Load exam guide, modules
         
T=2ms:   Pipeline: Generate phase
         └─ Call createGenerationPrompt()
         
T=3ms:   Prompt builder: Check fewShotExamples
         └─ Not provided → Auto-load
         
T=4ms:   Call getCachedReferences("SAA-C03", 5)
         └─ Cache miss → Load from index.txt
         
T=5ms:   Read file: index.txt
         └─ 400 questions in markdown
         
T=50ms:  Parse markdown
         └─ 400 ParsedQuestionBlock objects
         
T=100ms: Convert to ReferenceQuestion
         └─ 400 ReferenceQuestion objects
         
T=101ms: Select 5 diverse examples
         └─ Different types, difficulties, domains
         
T=102ms: Store in cache
         └─ referenceCache["SAA-C03-5"] = 5 items
         
T=103ms: Build few-shot section
         └─ Format examples for LLM
         
T=104ms: Build full hub prompt
         └─ Integrate few-shot section
         
T=105ms: Call Gemini LLM
         └─ Prompt with calibrated examples
         
T=500ms: Receive Gemini response
         └─ 10 new questions (MCQ)
         
T=501ms: Parse JSON, validate
         └─ Insert to database
         
T=502ms: Return response
         └─ User receives 10 questions
         
TOTAL: ~500ms
```

### Second Request for SAA-C03

```
T=0ms:   User: POST /api/generate-hub { certCode: "SAA-C03", ... }
         
T=1ms:   Pipeline: Ingest phase
         └─ Load exam guide, modules
         
T=2ms:   Pipeline: Generate phase
         └─ Call createGenerationPrompt()
         
T=3ms:   Prompt builder: Check fewShotExamples
         └─ Not provided → Auto-load
         
T=4ms:   Call getCachedReferences("SAA-C03", 5)
         └─ Cache HIT! Return instantly
         
T=5ms:   Build few-shot section
         └─ Format examples for LLM
         
T=6ms:   Build full hub prompt
         └─ Integrate few-shot section
         
T=7ms:   Call Gemini LLM
         └─ Prompt with calibrated examples
         
T=500ms: Receive Gemini response
         └─ 10 new questions (MCQ)
         
T=501ms: Parse JSON, validate
         └─ Insert to database
         
T=502ms: Return response
         └─ User receives 10 questions
         
TOTAL: ~500ms (parsing overhead gone!)
```

---

## Question Flow: Reference → LLM → Generation

```
INDEX.TXT REFERENCE (Original)
│
├─ Question: "Which AWS service provides object storage?"
├─ Options: [S3, RDS, Lambda, EC2]
├─ Answer: S3
└─ Explanation: "Option A (S3) is AWS's primary object storage..."

       ↓ (PARSED)

TYPESCRIPT REFERENCE OBJECT
│
├─ text: "Which AWS service provides object storage?"
├─ type: "mcq"
├─ options: ["Amazon S3", "Amazon RDS", "AWS Lambda", "Amazon EC2"]
├─ correctAnswer: [0]
├─ difficulty: "intermediate"
└─ explanation: "Option A (Amazon S3) is AWS's primary..."

       ↓ (INCLUDED IN FEW-SHOT)

LLM PROMPT SECTION
│
├─ Example 1 (MCQ, intermediate)
├─ Question: Which AWS service provides object storage?
├─ Options: [...]
├─ Correct Answer: [0]
├─ Explanation: Option A (Amazon S3) provides...
│
├─ [Instructions: "Match the STYLE, DEPTH, PRECISION"]
└─ [Instructions: "DO NOT copy these questions"]

       ↓ (LLM GENERATES INSPIRED BY EXAMPLES)

GENERATED QUESTION (Similar quality, completely original)
│
├─ Question: "A company needs to store petabyte-scale unstructured data..."
├─ Type: "mcq"
├─ Options: ["S3", "RDS", "EBS", "Glacier"]
├─ Correct Answer: "0"
├─ Explanation: "Option A (Amazon S3) can scale to petabytes..."
│
└─ ✓ NOT COPIED from reference
   ✓ INSPIRED BY reference quality
   ✓ MATCHES reference style/depth
   ✓ ORIGINAL scenario & wording
```

---

## Quality Calibration Effect

```
WITHOUT REFERENCE QUESTIONS
│
├─ Few-shot: None (or basic defaults)
├─ LLM sees: System prompt only
├─ Generated quality:
│  ├─ Explanation depth: ⭐⭐ (shallow)
│  ├─ Service accuracy: ⭐⭐ (generic)
│  ├─ Option realism: ⭐⭐ (obvious wrong answers)
│  ├─ Business context: ⭐ (minimal)
│  └─ Overall: Basic but inconsistent


WITH REFERENCE QUESTIONS (NEW)
│
├─ Few-shot: 5 calibrated examples from index.txt
├─ LLM sees: System prompt + quality examples
├─ Generated quality:
│  ├─ Explanation depth: ⭐⭐⭐⭐⭐ (comprehensive)
│  ├─ Service accuracy: ⭐⭐⭐⭐⭐ (precise)
│  ├─ Option realism: ⭐⭐⭐⭐⭐ (plausible alternatives)
│  ├─ Business context: ⭐⭐⭐⭐ (realistic scenarios)
│  └─ Overall: Exam-quality consistent
```

---

## Supported Certifications

```
┌─ SUPPORTED CERTS ──────────────────────────────────────┐
│                                                        │
│  1. SAA-C03 (Solutions Architect Associate)            │
│     ├─ Code: "SAA-C03"                                 │
│     ├─ Path: solutions-architect-associate/index.txt   │
│     ├─ Questions: ~400                                 │
│     └─ Domain: aws-solutions-architect                 │
│                                                        │
│  2. CLF-C02 (Cloud Practitioner)                       │
│     ├─ Code: "CLF-C02"                                 │
│     ├─ Path: AWS Certified Cloud Practitioner.../      │
│     │         index.txt                                │
│     ├─ Questions: ~400                                 │
│     └─ Domain: aws-cloud-practitioner                  │
│                                                        │
│  TO ADD MORE:                                          │
│  1. Create certification folder with index.txt         │
│  2. Add entry to CERTIFICATIONS array                  │
│  3. Redeploy                                           │
│  4. System auto-loads on first request                 │
│                                                        │
└────────────────────────────────────────────────────────┘
```

---

## Cache Management

```
┌─ MEMORY CACHE ─────────────────────────────────────────┐
│                                                        │
│  referenceCache: {                                      │
│    "SAA-C03-5": [                          ← Key       │
│      ReferenceQuestion { ... },            ← 5 items   │
│      ReferenceQuestion { ... },                        │
│      ReferenceQuestion { ... },                        │
│      ReferenceQuestion { ... },                        │
│      ReferenceQuestion { ... }                         │
│    ],                                                  │
│    "SAA-C03-10": [...],               ← Different count│
│    "CLF-C02-5": [...],                ← Different cert │
│    "CLF-C02-10": [...]                                │
│  }                                                     │
│                                                        │
│  STATUS: Loaded Certs                                  │
│  loadedCerts = { "SAA-C03", "CLF-C02" }  ← Tracking   │
│                                                        │
│  CLEAR: clearReferenceCache()         ← For testing   │
│                                                        │
└────────────────────────────────────────────────────────┘
```

---

## Error Handling Flow

```
┌─ GRACEFUL DEGRADATION ─────────────────────────────────┐
│                                                        │
│  getCachedReferences("SAA-C03", 5)                      │
│  │                                                     │
│  ├─ TRY: Load from index.txt                           │
│  │  └─ File not found? → CATCH                         │
│  │  └─ Parse error? → CATCH                           │
│  │  └─ Conversion error? → CATCH                      │
│  │                                                     │
│  └─ CATCH: Log warning                                 │
│     ├─ referenceRegistry[certCode] = []  (empty)      │
│     ├─ Console: "Failed to load... falling back"       │
│     └─ CONTINUE: Generation proceeds without refs     │
│                                                        │
│  RESULT:                                               │
│  ├─ If loading succeeds: Use calibrated examples      │
│  ├─ If loading fails: Generate without calibration    │
│  ├─ System stays online either way                    │
│  └─ Quality degrades gracefully (not crashes)         │
│                                                        │
└────────────────────────────────────────────────────────┘
```

This is the complete visual architecture of the reference questions integration system!

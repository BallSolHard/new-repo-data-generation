# Code Walkthrough: Dual-Model System in Action

## Following the Request Step-by-Step

Let's trace your exact request through the code with line-by-line explanations.

---

## Step 1: Frontend Sends Request

```javascript
// In your frontend (React component)
const payload = {
  certification_name: "AWS Solutions Architect",
  topic_name: "Design Secure Architectures",
  quiz_id: "quiz_123",
  modules: [
    { module_id: "m1", module_name: "IAM", module_description: "Identity and Access Management" },
    { module_id: "m2", module_name: "VPC", module_description: "Virtual Private Cloud" }
  ],
  
  // ← NEW: Dual-model configuration
  generationModel: "kimi",
  generationModelWebSearchEnabled: true,
  validationModel: "gemini",
  validationModelWebSearchEnabled: false
};

const response = await fetch('/api/generate-hub', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(payload)
});
```

---

## Step 2: Route Handler Receives Request

**File:** `src/app/api/generate-hub/route.ts`

```typescript
export async function POST(request: NextRequest) {
  try {
    // Line 1: Parse the JSON body
    const body: RequestBody = await request.json();
    // body = {
    //   certification_name: "AWS Solutions Architect",
    //   generationModel: "kimi",
    //   generationModelWebSearchEnabled: true,
    //   validationModel: "gemini",
    //   validationModelWebSearchEnabled: false,
    //   ...
    // }

    // Line 2: Apply defaults (for fields not provided)
    body.questionType ??= 'mcq';
    body.complexityLevel ??= 'intermediate';
    body.questionsPerModule ??= 10;
    body.enableValidation ??= true;
    body.storeInBank ??= false;
    body.genMode ??= 'drill';
    body.aiModel ??= 'gemini';  // ← Legacy fallback, but won't be used
    body.kimiWebSearchEnabled ??= true;  // ← Legacy fallback, but won't be used
    body.modules ??= [];

    // Line 3: Validate request
    const validationError = validateRequest(body);
    if (validationError) {
      return NextResponse.json({ error: validationError }, { status: 400 });
    }
    // ✓ Pass: certification_id, topic_id, quiz_id, modules exist

    // Line 4: Resolve questions per module
    const { qpm, error: distributionError } = resolveQuestionsPerModule(
      body.questionsPerModule,  // 10
      body.complexityLevelDistribution  // undefined
    );
    if (distributionError) {
      return NextResponse.json({ error: distributionError }, { status: 400 });
    }
    // qpm = 10

    // Line 5: Get start indices for sequential IDs
    const moduleIds = body.modules.map(m => String(m.module_id));
    // moduleIds = ["m1", "m2"]
    
    const startIndexByModule = await getStartIndexByModule(String(body.topic_id), moduleIds);
    // Queries database for existing questions with pattern "q_${topicId}_${moduleId}_*"
    // startIndexByModule = { m1: 0, m2: 0 } (or higher if questions exist)

    // Line 6: Build pipeline parameters
    // THIS IS WHERE DUAL-MODEL CONFIG IS PASSED THROUGH
    const pipelineParams: PipelineParams = {
      certificationCode: body.certification_code || '',
      certificationName: body.certification_name,  // "AWS Solutions Architect"
      certificationId: Number(body.certification_id),
      topicId: String(body.topic_id),
      topicName: body.topic_name || '',  // "Design Secure Architectures"
      topicDescription: body.topic_description,
      quizId: body.quiz_id,  // "quiz_123"
      modules: body.modules.map(m => ({
        module_id: m.module_id,
        module_name: m.module_name,
        module_description: m.module_description,
        module_content: m.module_content,
      })),
      questionType: body.questionType,  // 'mcq'
      questionTypes: body.questionTypes || [body.questionType],
      complexityLevel: body.complexityLevel,  // 'intermediate'
      questionsPerModule: qpm,  // 10
      complexityLevelDistribution: body.complexityLevelDistribution,
      enableValidation: body.enableValidation,  // true
      certTier: body.certTier,
      genMode: body.genMode,  // 'drill'
      generationContext: 'hub',
      startIndexByModule,
      
      // ← LEGACY CONFIG (used as fallback)
      aiModel: body.aiModel,  // 'gemini'
      kimiWebSearchEnabled: body.kimiWebSearchEnabled,  // true
      
      // ← NEW DUAL-MODEL CONFIG (takes precedence!)
      generationModel: body.generationModel,  // ✅ 'kimi'
      generationModelWebSearchEnabled: body.generationModelWebSearchEnabled,  // ✅ true
      validationModel: body.validationModel,  // ✅ 'gemini'
      validationModelWebSearchEnabled: body.validationModelWebSearchEnabled,  // ✅ false
    };

    // Line 7: Call the pipeline
    const result = await runGenerationPipeline(pipelineParams);
    
    // Line 8: Optionally store in bank
    let bankResult = undefined;
    if (body.storeInBank && result.questions.length > 0) {
      // ... store logic ...
    }

    // Line 9: Return response
    return NextResponse.json({
      success: result.success,
      sqlScript: result.sqlScript,
      questions: result.questions,
      questionCount: result.questionCount,
      moduleCount: body.modules.length,
      examGuideVersion: result.examGuideVersion,
      validatedCount: result.validatedCount,
      rejectedCount: result.rejectedCount,
      generationTimestamp: result.generationTimestamp,
      ...(bankResult && { questionBank: bankResult }),
    });

  } catch (error) {
    console.error('[generate-hub] Unexpected error:', error);
    const message = error instanceof Error ? error.message : 'Failed to generate hub questions';
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
```

**Key Point:** Route handler is just a pass-through. It validates the input and forwards the dual-model config to the pipeline.

---

## Step 3: Pipeline Orchestrator - Ingest Phase

**File:** `src/lib/pipeline/index.ts` (lines 23-34)

```typescript
export async function runGenerationPipeline(params: PipelineParams): Promise<PipelineResult> {
  const generationTimestamp = new Date().toISOString();

  // ─── Step 1: Ingest ───
  const { 
    examGuide, 
    domainContext, 
    fewShotExamples, 
    examGuideVersion, 
    certTier, 
    genMode, 
    serperContext 
  } = await ingest({
    certificationName: params.certificationName,  // "AWS Solutions Architect"
    certificationCode: params.certificationCode,
    topicName: params.topicName,  // "Design Secure Architectures"
    modules: params.modules,
    questionType: params.questionType,  // 'mcq'
    complexityLevel: params.complexityLevel,  // 'intermediate'
    certTier: params.certTier,
    genMode: params.genMode,  // 'drill'
  });

  console.log(`[pipeline] Using ingest for: ${params.topicName}`);
  // Output: "[pipeline] Using ingest for: Design Secure Architectures"
  
  // Result:
  // examGuide = { 
  //   certificationName: "AWS Solutions Architect",
  //   provider: "aws",
  //   version: "3.0",
  //   domains: [...]
  // }
  // domainContext = {
  //   id: "design-secure",
  //   name: "Design Secure Architectures",
  //   tasks: [...]
  // }
  // fewShotExamples = [
  //   { text: "...", options: [...], correct_answer: "...", explanation: "..." },
  //   ...
  // ]
}
```

**What happens in ingest():**
- Queries database for exam guide matching certification
- Finds domain context matching topic name
- Loads few-shot examples for that domain

---

## Step 4: Pipeline Orchestrator - Generation Phase

**File:** `src/lib/pipeline/index.ts` (lines 37-112)

```typescript
export async function runGenerationPipeline(params: PipelineParams): Promise<PipelineResult> {
  // ... ingest code ...

  // ─── Step 2: Generate ───
  const questionTypes = params.questionTypes || (params.questionType ? [params.questionType] : ['mcq']);
  // questionTypes = ['mcq']

  let questionsPerModule = params.questionsPerModule || 2;
  // questionsPerModule = 10
  
  const minPerModule = 1;
  questionsPerModule = Math.max(questionsPerModule, minPerModule);
  // questionsPerModule = 10

  // ========================================
  // RESOLVE WHICH MODEL TO USE FOR GENERATION
  // ========================================
  const generationModelToUse = 
    params.generationModel ||           // ← Check this FIRST
    params.aiModel ||                   // ← Fall back to this
    'gemini';                           // ← Default to this

  // In your case:
  // params.generationModel = 'kimi' ← SELECTED!
  console.log(`[pipeline] generationModelToUse = ${generationModelToUse}`);
  // Output: "[pipeline] generationModelToUse = kimi"

  const generationWebSearchEnabled = 
    params.generationModelWebSearchEnabled ?? 
    params.kimiWebSearchEnabled ?? 
    false;

  // In your case:
  // params.generationModelWebSearchEnabled = true ← SELECTED!
  console.log(`[pipeline] generationWebSearchEnabled = ${generationWebSearchEnabled}`);
  // Output: "[pipeline] generationWebSearchEnabled = true"

  // Now generate questions with the resolved model
  const distribution = params.complexityLevelDistribution;
  // distribution = undefined (you didn't specify distribution)

  let rawQuestions: GeneratedQuestion[] = [];
  let targetCount = 0;

  if (distribution && Object.keys(distribution).length > 0) {
    // Branch 1: Per-difficulty generation (you don't have this)
  } else {
    // Branch 2: Single-pass generation (YOUR CASE)
    const generationParams: QuestionGenerationParams = {
      modules: params.modules,  // [{ module_id: "m1", module_name: "IAM", ... }, { ... }]
      topicName: params.topicName,  // "Design Secure Architectures"
      topicDescription: params.topicDescription,
      certificationName: params.certificationName,  // "AWS Solutions Architect"
      questionsPerModule: questionsPerModule,  // 10
      questionTypes: questionTypes,  // ['mcq']
      questionType: params.questionType,  // 'mcq'
      complexityLevel: params.complexityLevel || 'intermediate',  // 'intermediate'
      serperContext,
      examGuide,  // ← Fetched from ingest
      domainContext,  // ← Fetched from ingest
      fewShotExamples,  // ← Fetched from ingest
      examGuideVersion,
      certTier,
      genMode,  // 'drill'
    };

    console.log(`[pipeline] Using ${generationModelToUse} for generation (web search: ${generationWebSearchEnabled})`);
    // Output: "[pipeline] Using kimi for generation (web search: true)"

    // CALL GENERATE WITH RESOLVED MODEL AND WEB SEARCH SETTING
    rawQuestions = (await generate(generationParams, params.generationContext ?? 'hub', {
      aiModel: generationModelToUse,  // ✅ 'kimi'
      kimiWebSearchEnabled: generationWebSearchEnabled,  // ✅ true
    })).map(q => ({
      ...q,
      difficulty: generationParams.complexityLevel,  // 'intermediate'
    }));

    targetCount = params.modules.length * questionsPerModule;
    // targetCount = 2 * 10 = 20 questions we're aiming for
  }

  console.log(`[pipeline] Generated ${rawQuestions.length} questions (target: ${targetCount})`);
  // Output: "[pipeline] Generated 20 questions (target: 20)"
}
```

---

## Step 5: Inside Generate Function

**File:** `src/lib/pipeline/generate.ts` (lines 24-97)

```typescript
export async function generate(
  params: QuestionGenerationParams,
  generationContext: GenerationContext = 'hub',
  options?: GenerateOptions  // { aiModel: 'kimi', kimiWebSearchEnabled: true }
): Promise<GeneratedQuestion[]> {

  const aiModel = options?.aiModel || 'gemini';
  // aiModel = 'kimi' ✅

  const kimiWebSearchEnabled = options?.kimiWebSearchEnabled !== false;
  // kimiWebSearchEnabled = true ✅

  console.log(`[generate] Calling ${aiModel} for ${params.modules.length} modules × ${params.questionsPerModule} questions`);
  // Output: "[generate] Calling kimi for 2 modules × 10 questions"

  // Create the generation prompt
  const prompt = await createGenerationPrompt({
    examGuide: params.examGuide,
    domainContext: params.domainContext,
    certTier: params.certTier,
    genMode: params.genMode,  // 'drill'
    modules: params.modules,  // [IAM, VPC]
    totalQuestions: params.modules.length * params.questionsPerModule,  // 20
    questionTypes: params.questionTypes,  // ['mcq']
    fewShotExamples: params.fewShotExamples,
    serperContext: params.serperContext,
    generationContext: generationContext,  // 'hub'
    complexityLevelDistribution: params.complexityLevelDistribution,
    currentDifficulty: params.complexityLevel,  // 'intermediate'
  });

  // Prompt is a detailed string like:
  // "Generate 20 multiple-choice questions about AWS Solutions Architect certification...
  //  Domain: Design Secure Architectures
  //  Modules: IAM, VPC
  //  Complexity: intermediate
  //  Few-shot examples: [...]
  //  Format your response as JSON array..."

  let responseText: string;
  let parseFunction: typeof parseGeminiJson;

  if (aiModel === 'kimi') {
    // ✅ KIMI BRANCH (your case!)
    console.log(`[generate] Selected KIMI branch`);

    const model = getKimiGenerationModel(kimiWebSearchEnabled);
    // Returns config: {
    //   temperature: 1,  (Kimi K2.6 fixed)
    //   top_p: 0.95,     (Kimi K2.6 fixed)
    //   max_tokens: 16384,
    //   web_search: true  ← Because kimiWebSearchEnabled = true
    // }

    console.log(`[generate] Kimi config: temperature=1, top_p=0.95, web_search=true`);

    responseText = await kimiGenerateContent(prompt, model);
    // This makes REST call to: https://api.moonshot.ai/v1/chat/completions
    // With: model='kimi-k2.6', web_search=true
    // Kimi searches web for latest AWS info!

    parseFunction = parseKimiJson;
    // Parser that handles Kimi's JSON response format

  } else if (aiModel === 'gemini') {
    // ❌ GEMINI BRANCH (not taken in your case)
    console.log(`[generate] Selected GEMINI branch`);
    
    const model = getGeminiGenerationModel();
    const result = await model.generateContent(prompt);
    responseText = result.response.text();
    parseFunction = parseGeminiJson;
  }

  console.log(`[generate] Received response (${responseText.length} chars)`);
  // Output: "[generate] Received response (15234 chars)"

  // Parse JSON response
  let questions: GeneratedQuestion[];
  try {
    questions = parseFunction<GeneratedQuestion[]>(responseText);
    console.log(`[generate] Successfully parsed ${questions.length} questions`);
    // Output: "[generate] Successfully parsed 20 questions"
  } catch (error) {
    console.error(`[generate] Failed to parse response:`, error);
    throw error;
  }

  return questions;  // 20 GeneratedQuestion objects
}
```

---

## Step 6: Pipeline - Deduplicate Phase

**File:** `src/lib/pipeline/index.ts` (lines 113-170)

```typescript
export async function runGenerationPipeline(params: PipelineParams) {
  // ... generate code ...

  // ─── Deduplicate against previously generated questions ───
  const hashFile = path.join(process.cwd(), 'generated_hashes.txt');
  let seenHashes = new Set<string>();
  
  try {
    const contents = await fs.readFile(hashFile, 'utf-8');
    contents.split('\n').forEach(h => { if (h.trim()) seenHashes.add(h.trim()); });
  } catch (err) {
    // File may not exist yet, that's fine
  }

  // Filter new questions
  const filterNew = (batch: GeneratedQuestion[]) => {
    const unique: typeof batch = [];
    for (const q of batch) {
      // Compute hash of question text + options
      const hashContent = q.options || [];
      const h = computeContentHash(q.text, hashContent);
      
      if (!seenHashes.has(h)) {
        // New question not seen before
        seenHashes.add(h);
        unique.push(q);
      }
    }
    return unique;
  };

  let accumulated = filterNew(rawQuestions);
  // accumulated = 18 questions (2 duplicates removed)
  
  let remaining = targetCount - accumulated.length;
  // remaining = 20 - 18 = 2

  if (remaining > 0) {
    console.log(`[pipeline] After deduplication: ${accumulated.length}/${targetCount} questions remain (${targetCount - accumulated.length} duplicates removed)`);
    // Output: "[pipeline] After deduplication: 18/20 questions remain (2 duplicates removed)"
  }

  // Try to regenerate if we don't have enough
  let attempts = 0;
  const maxAttempts = 5;

  while (remaining > 0 && attempts < maxAttempts) {
    attempts++;
    console.log(`[pipeline] only generated ${accumulated.length}/${targetCount}, regenerating ${remaining} more`);
    
    // Regenerate using SAME model
    const extra = await generate(extraParams, params.generationContext ?? 'hub', {
      aiModel: generationModelToUse,  // ← Still using 'kimi'!
      kimiWebSearchEnabled: generationWebSearchEnabled,  // ← Still true!
    });
    
    const deduped = filterNew(extra);
    accumulated = accumulated.concat(deduped);
    remaining = targetCount - accumulated.length;
  }

  const dedupedQuestions = accumulated;
  // dedupedQuestions = 18 unique questions
}
```

---

## Step 7: Pipeline Orchestrator - Validation Phase

**File:** `src/lib/pipeline/index.ts` (lines 195-215)

```typescript
export async function runGenerationPipeline(params: PipelineParams) {
  // ... generate and deduplicate code ...

  // ─── Step 3: Validate (optional) ───
  let finalQuestions = dedupedQuestions;
  // finalQuestions = 18 questions to validate
  
  let rejectedCount = 0;

  if (params.enableValidation !== false) {
    // enableValidation = true (from defaults)

    // ========================================
    // RESOLVE WHICH MODEL TO USE FOR VALIDATION
    // ========================================
    const validationModelToUse = 
      params.validationModel ||           // ← Check this FIRST
      params.aiModel ||                   // ← Fall back to this
      'gemini';                           // ← Default to this

    // In your case:
    // params.validationModel = 'gemini' ← SELECTED!
    console.log(`[pipeline] validationModelToUse = ${validationModelToUse}`);
    // Output: "[pipeline] validationModelToUse = gemini"

    const validationWebSearchEnabled = 
      params.validationModelWebSearchEnabled ?? 
      false;  // Always false by default!

    // In your case:
    // params.validationModelWebSearchEnabled = false ← SELECTED!
    console.log(`[pipeline] validationWebSearchEnabled = ${validationWebSearchEnabled}`);
    // Output: "[pipeline] validationWebSearchEnabled = false"

    console.log(`[pipeline] Using ${validationModelToUse} for validation (web search: ${validationWebSearchEnabled})`);
    // Output: "[pipeline] Using gemini for validation (web search: false)"

    // CALL VALIDATE WITH RESOLVED MODEL
    const { validated, rejected } = await validate(dedupedQuestions, {
      certificationName: params.certificationName,  // "AWS Solutions Architect"
      domainContext: domainContext,
      rejectLowConfidence: true,
      certTier: params.certTier,
      aiModel: validationModelToUse,  // ✅ 'gemini'
      kimiWebSearchEnabled: validationWebSearchEnabled,  // ✅ false
    });

    finalQuestions = validated;
    rejectedCount = rejected.length;

    console.log(`[pipeline] Validation complete: ${finalQuestions.length} accepted, ${rejectedCount} rejected`);
    // Output: "[pipeline] Validation complete: 18 accepted, 0 rejected"
  }
}
```

---

## Step 8: Inside Validate Function

**File:** `src/lib/pipeline/validate.ts` (lines 31-90)

```typescript
export async function validate(
  questions: GeneratedQuestion[],
  options: ValidateOptions  // { aiModel: 'gemini', kimiWebSearchEnabled: false }
): Promise<ValidationResult> {

  const { 
    certificationName, 
    domainContext, 
    rejectLowConfidence = true, 
    certTier, 
    aiModel = 'gemini',  // 'gemini' from options
    kimiWebSearchEnabled = false  // false from options
  } = options;

  const validated: GeneratedQuestion[] = [];
  const rejected: GeneratedQuestion[] = [];
  let validationFailedCount = 0;

  console.log(`[validate] Validating ${questions.length} questions using ${aiModel}...`);
  // Output: "[validate] Validating 18 questions using gemini..."

  // Process questions in parallel batches of 5
  const batchSize = 5;
  for (let i = 0; i < questions.length; i += batchSize) {
    const batch = questions.slice(i, i + batchSize);
    // batch = [question1, question2, question3, question4, question5]

    console.log(`[validate] Processing batch ${Math.floor(i / batchSize) + 1}...`);
    // Output: "[validate] Processing batch 1..."
    //         "[validate] Processing batch 2..."
    //         etc.

    // Validate each question in parallel
    const results = await Promise.allSettled(
      batch.map(q => validateSingleQuestion(
        q, 
        certificationName,  // "AWS Solutions Architect"
        certTier,
        domainContext,
        aiModel,  // 'gemini' ✅
        kimiWebSearchEnabled  // false ✅
      ))
    );

    for (let j = 0; j < results.length; j++) {
      const question = batch[j];
      const result = results[j];

      if (result.status === 'rejected') {
        console.warn(`[validate] Validation call failed for question`);
        question.validation_status = 'validation_failed';
        rejected.push(question);
        continue;
      }

      const validation = result.value;
      // validation = {
      //   is_correct: true,
      //   confidence: 'high',
      //   validation_notes: "Answer is correct based on AWS documentation",
      //   correct_answer_index: 2
      // }

      question.validation_status = validation.is_correct ? 'correct' : 'incorrect';
      question.confidence_score = validation.is_correct ? 1 : 0;

      if (rejectLowConfidence && (validation.confidence === 'low' || !validation.is_correct)) {
        rejected.push(question);
      } else {
        validated.push(question);
      }
    }
  }

  console.log(`[validate] Results: ${validated.length} passed, ${rejected.length} rejected`);
  // Output: "[validate] Results: 18 passed, 0 rejected"

  return { validated, rejected };
}
```

---

## Step 9: Inside ValidateSingleQuestion

**File:** `src/lib/pipeline/validate.ts` (lines 113-154)

```typescript
async function validateSingleQuestion(
  question: GeneratedQuestion,
  certificationName: string,
  certTier: CertTier,
  domainContext: ExamDomain | undefined,
  aiModel: AIModel,  // 'gemini'
  kimiWebSearchEnabled: boolean  // false
): Promise<ValidationResponse> {

  // Create validation prompt
  const prompt = await createValidationPrompt({
    question,  // The full question object
    certificationName,  // "AWS Solutions Architect"
    certTier,
    domainContext,
  });

  // Prompt is something like:
  // "Validate this AWS Solutions Architect question:
  //  Question: 'Your company needs to...'
  //  Options: [A, B, C, D]
  //  Proposed answer: B
  //  Is the answer correct? Is the explanation accurate?
  //  Return: { is_correct: boolean, confidence: high|medium|low, validation_notes: string }"

  let responseText: string;

  if (aiModel === 'gemini') {
    // ✅ GEMINI BRANCH (your case!)
    console.log(`[validate] Selected GEMINI branch for question validation`);

    const model = getGeminiValidationModel();
    // Returns config: {
    //   temperature: 0.15,  (conservative, fact-focused!)
    //   top_p: 0.6,
    //   max_tokens: 4096,
    // }

    const result = await model.generateContent(prompt);
    responseText = result.response.text();
    // Gemini carefully evaluates the question

  } else if (aiModel === 'kimi') {
    // ❌ KIMI BRANCH (not taken in your case)
    console.log(`[validate] Selected KIMI branch for question validation`);
    
    const model = getKimiValidationModel(kimiWebSearchEnabled);
    responseText = await kimiGenerateContent(prompt, model);
  }

  // Parse validation response
  const validation = parseFunction<ValidationResponse>(responseText);
  // validation = { is_correct: true, confidence: 'high', validation_notes: "..." }

  return validation;
}
```

---

## Step 10: Pipeline - Output Phase

**File:** `src/lib/pipeline/index.ts` (lines 216-242)

```typescript
export async function runGenerationPipeline(params: PipelineParams) {
  // ... all previous code ...

  // ─── Step 4: Output ───
  const sqlScript = buildSqlOutput(finalQuestions, {
    topicId: params.topicId,
    quizId: params.quizId,
    examGuideVersion,
    generationTimestamp,
    validatedCount: finalQuestions.length,
    rejectedCount,
    startIndexByModule: params.startIndexByModule,
  });

  // sqlScript = large SQL string like:
  // "INSERT INTO public.question VALUES 
  //  ('q_design-secure_m1_1', 'Your company...', 'mcq', [...options...], '{2}', 'Explanation...', 'intermediate', ...)
  //  ('q_design-secure_m1_2', '...', ...)
  //  ... 18 total questions ..."

  console.log(`[pipeline] Complete. ${finalQuestions.length} questions generated, ${rejectedCount} rejected.`);
  // Output: "[pipeline] Complete. 18 questions generated, 0 rejected."

  return {
    success: true,
    sqlScript,
    questionCount: finalQuestions.length,  // 18
    validatedCount: finalQuestions.length,  // 18
    rejectedCount,  // 0
    examGuideVersion,
    generationTimestamp,
    questions: finalQuestions,  // Array of 18 questions
    domainContext,
  };
}
```

---

## Step 11: Response Sent Back

**File:** `src/app/api/generate-hub/route.ts` (lines 183-193)

```typescript
export async function POST(request: NextRequest) {
  // ... all pipeline code ...

  const result = await runGenerationPipeline(pipelineParams);
  // result = { success: true, questionCount: 18, rejectedCount: 0, sqlScript: "...", ... }

  return NextResponse.json({
    success: result.success,  // true
    sqlScript: result.sqlScript,  // "INSERT INTO ..."
    questions: result.questions,  // [18 questions]
    questionCount: result.questionCount,  // 18
    moduleCount: body.modules.length,  // 2
    examGuideVersion: result.examGuideVersion,
    validatedCount: result.validatedCount,  // 18
    rejectedCount: result.rejectedCount,  // 0
    generationTimestamp: result.generationTimestamp,
    ...(bankResult && { questionBank: bankResult }),
  });
}
```

**Response to frontend:**
```json
{
  "success": true,
  "questionCount": 18,
  "rejectedCount": 0,
  "moduleCount": 2,
  "validatedCount": 18,
  "sqlScript": "INSERT INTO public.question VALUES ...",
  "questions": [
    {
      "text": "Your company needs to...",
      "options": ["Option A", "Option B", "Option C", "Option D"],
      "correct_answer": "{2}",
      "explanation": "...",
      "type": "mcq",
      "difficulty": "intermediate",
      "validation_status": "correct",
      "confidence_score": 1
    },
    // ... 17 more questions ...
  ],
  "generationTimestamp": "2026-05-29T12:34:56.789Z"
}
```

---

## Summary of the Flow

```
Frontend Request with dual-model config
    ↓
Route Handler validates & passes through
    ↓
Pipeline INGEST: Fetch exam guide & context
    ↓
Pipeline GENERATE: Resolve 'kimi' + web search
    ├─ Call generate() with Kimi
    ├─ Kimi searches web
    └─ Output: 20 questions
    ↓
Pipeline DEDUPLICATE: Remove duplicates
    └─ Output: 18 unique questions
    ↓
Pipeline VALIDATE: Resolve 'gemini' + no web search
    ├─ Call validate() with Gemini
    ├─ Gemini checks each question conservatively
    └─ Output: 18 accepted, 0 rejected
    ↓
Pipeline OUTPUT: Build SQL script
    ├─ Generate INSERT statements
    └─ Output: SQL for 18 questions
    ↓
Route Handler returns response
    ↓
Frontend receives 18 validated questions + SQL
```

---

## Key Decision Points in the Code

### Decision 1: Which generation model?
**Location:** `src/lib/pipeline/index.ts:49`
```typescript
const generationModelToUse = params.generationModel || params.aiModel || 'gemini';
// Your request: params.generationModel = 'kimi' ✅ SELECTED
```

### Decision 2: Generation web search?
**Location:** `src/lib/pipeline/index.ts:52-55`
```typescript
const generationWebSearchEnabled = 
  params.generationModelWebSearchEnabled ?? 
  params.kimiWebSearchEnabled ?? 
  false;
// Your request: params.generationModelWebSearchEnabled = true ✅ SELECTED
```

### Decision 3: Which validation model?
**Location:** `src/lib/pipeline/index.ts:200`
```typescript
const validationModelToUse = params.validationModel || params.aiModel || 'gemini';
// Your request: params.validationModel = 'gemini' ✅ SELECTED
```

### Decision 4: Validation web search?
**Location:** `src/lib/pipeline/index.ts:203-205`
```typescript
const validationWebSearchEnabled = 
  params.validationModelWebSearchEnabled ?? 
  false;  // Always false by default!
// Your request: params.validationModelWebSearchEnabled = false ✅ SELECTED
```

---

## That's How It Works! 🚀

The dual-model system flows through 11 steps, making 2 critical model decisions (one for generation, one for validation), and producing high-quality questions with different models optimized for each stage.


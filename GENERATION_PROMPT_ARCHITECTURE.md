# Generation Prompt Architecture — Call Chain

## Overview
The `buildHubPrompt()` function is part of a layered architecture that routes from API endpoints → pipeline → generation → prompts → separate hub/mock templates.

## Complete Call Chain

### 🔴 Level 1: API Routes (Entry Points)
```
src/app/api/generate-hub/route.ts      ← /api/generate-hub POST
    ↓
    Calls: runGenerationPipeline(pipelineParams)
    Passes: generationContext = 'hub'

src/app/api/generate-mock/route.ts     ← /api/generate-mock POST
    ↓
    Calls: runGenerationPipeline(pipelineParams)
    Passes: generationContext = 'mock'
```

### 🟠 Level 2: Pipeline Orchestrator
```
src/lib/pipeline/index.ts
    ↓
    runGenerationPipeline(params: PipelineParams)
    
    Step 1: ingest()        — Load exam guides, domain context, few-shot examples
    Step 2: generate()      — Call Gemini to produce questions
            ├─ Line 69: await generate(subParams, params.generationContext ?? 'hub')
            └─ Line 84: await generate(generationParams, params.generationContext ?? 'hub')
    Step 3: validate()      — Verify accuracy (optional)
    Step 4: buildSqlOutput() — Generate SQL for Supabase
```

**Key Detail:** The `generationContext` parameter ('hub' or 'mock') flows through to the generate() function

### 🟡 Level 3: Generation Layer
```
src/lib/pipeline/generate.ts
    ↓
    export async function generate(
      params: QuestionGenerationParams,
      generationContext: GenerationContext = 'hub'  ← Default is 'hub'
    )
    
    Line 15: const prompt = createGenerationPrompt({
      ...all params...
      generationContext,  ← Passed to prompt builder
    })
    
    Lines 17-24: Call Gemini model with generated prompt
    Lines 26-48: Parse response JSON
```

### 🟢 Level 4: Prompt Builder (Main Orchestrator)
```
src/lib/prompts/generation-new.ts (imported from index.ts)
    ↓
    export function createGenerationPrompt(params: V2GenerationPromptParams)
    
    • Builds tier block, mode block, exam guide section, etc.
    • Line 185: Conditional routing based on generationContext:
    
    if (generationContext === 'hub') {
      return buildHubPrompt(hubPromptParams);  ← HUB PATH
    } else {
      return buildMockPrompt(mockPromptParams);  ← MOCK PATH
    }
```

### 🔵 Level 5: Separate Prompt Templates (Independent)

#### Hub Template Path (Practice Mode)
```
src/lib/prompts/generation-hub-prompt.ts
    ↓
    export function buildHubPrompt(params: HubPromptParams): string
    
    • Flexible 10-120 word range
    • All cognitive levels allowed (Recall, Application, Analysis)
    • Mandatory 40% definition questions
    • Definition templates included
    • Less strict validation standards
```

#### Mock Template Path (Exam Mode)
```
src/lib/prompts/generation-mock-prompt.ts
    ↓
    export function buildMockPrompt(params: MockPromptParams): string
    
    • Strict 60-120 word range (enforced)
    • Application/Analysis cognitive levels only
    • Forbidden patterns: "What is...", "Define..."
    • Realistic exam scenarios required
    • Strict distractor quality rules
```

## Data Flow Diagram

```
HTTP POST /api/generate-hub
    │
    └─→ generate-hub/route.ts
            │
            ├─ Parse request body
            ├─ Create pipelineParams with generationContext = 'hub'
            │
            └─→ runGenerationPipeline(pipelineParams)
                    │
                    ├─ Step 1: ingest() → Load exam guide, few-shot examples
                    │
                    ├─ Step 2: generate(subParams, generationContext = 'hub')
                    │           │
                    │           └─→ createGenerationPrompt(params: {
                    │                 ...params...
                    │                 generationContext: 'hub'  ← KEY PARAMETER
                    │               })
                    │                   │
                    │                   └─→ if (generationContext === 'hub')
                    │                           return buildHubPrompt(params)
                    │                               │
                    │                               ├─ Build flexible prompt
                    │                               ├─ Include 40% definition calculation
                    │                               ├─ Apply loose word count (10-120)
                    │                               └─ Return complete prompt string
                    │
                    │           Calls: model.generateContent(prompt)
                    │           Returns: GeneratedQuestion[]
                    │
                    ├─ Step 3: validate() → Red team review with Gemini Flash
                    │
                    └─ Step 4: buildSqlOutput() → SQL for insertion
```

## Key Files Involved

| File | Purpose | Role |
|------|---------|------|
| `src/app/api/generate-hub/route.ts` | Hub API endpoint | Entry point, sets `generationContext = 'hub'` |
| `src/app/api/generate-mock/route.ts` | Mock API endpoint | Entry point, sets `generationContext = 'mock'` |
| `src/lib/pipeline/index.ts` | Pipeline orchestrator | Orchestrates: ingest → generate → validate → output |
| `src/lib/pipeline/generate.ts` | Generation step | Calls `createGenerationPrompt()` and Gemini model |
| `src/lib/prompts/generation-new.ts` | Prompt builder | Routes to hub or mock template based on `generationContext` |
| `src/lib/prompts/generation-hub-prompt.ts` | Hub template (NEW) | Flexible practice-mode prompts |
| `src/lib/prompts/generation-mock-prompt.ts` | Mock template (NEW) | Strict exam-mode prompts |
| `src/lib/prompts/index.ts` | Exports | Exports `createGenerationPrompt` for external use |

## Parameter Flow

```
generationContext: 'hub' | 'mock'
    ↓
    Passed through:
    1. runGenerationPipeline() → params.generationContext
    2. generate() → generationContext parameter
    3. createGenerationPrompt() → params.generationContext
    4. Conditional routing in line 183-189 of generation-new.ts
    ↓
    Routes to:
    • buildHubPrompt() if 'hub'
    • buildMockPrompt() if 'mock'
```

## Summary

**`buildHubPrompt` is called from:**
1. **Directly:** `src/lib/prompts/generation-new.ts` line 185 (in conditional statement)
2. **Indirectly via:**
   - `/api/generate-hub` → pipeline → generate → createGenerationPrompt → buildHubPrompt
   - Any code calling `createGenerationPrompt` with `generationContext = 'hub'`

**When it's called:**
- ✅ Hub mode generation requests (`/api/generate-hub`)
- ✅ Pipeline runs with `generationContext = 'hub'`
- ✅ Any scenario where `generationContext` param equals `'hub'`

**What it does:**
- Builds practice-focused question prompts
- Applies flexible word count (10-120)
- Mandates 40% definition questions
- Allows all cognitive levels
- Returns complete prompt string for Gemini generation model


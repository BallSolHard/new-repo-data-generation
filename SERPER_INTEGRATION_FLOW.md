# Serper Integration Flow - Complete Guide

## Overview
Serper (Google Search API) is used to fetch real-world context about exam topics and modules, which is then injected into the Gemini prompt to generate more accurate, context-aware questions.

## Complete Flow

### 1. User Initiates Generation
**File**: `src/app/page.tsx`
- User selects certification, domain, modules
- User inputs difficulty distribution (easy/medium/hard counts)
- User clicks "Generate Hub Questions"
- Makes POST to `/api/generate-hub`

```typescript
const response = await fetch('/api/generate-hub', {
  method: 'POST',
  body: JSON.stringify({
    certification_id,
    topic_id,
    topic_name,
    modules: [{ module_id, module_name, ... }],
    complexityLevelDistribution: { easy: 2, intermediate: 2, hard: 2 }
  })
});
```

### 2. Route Handler Processes Request
**File**: `src/app/api/generate-hub/route.ts`
- Validates required parameters
- Queries Supabase to count existing questions per module (for ID generation)
- Calls `runGenerationPipeline(params)`
- Returns generated questions and SQL script

```typescript
export async function POST(request: NextRequest) {
  // ... validation ...
  
  const pipelineParams: PipelineParams = {
    certificationName,
    topicName,
    modules,
    // ... other params ...
  };
  
  const result = await runGenerationPipeline(pipelineParams);
  return NextResponse.json({ questions: result.questions, sqlScript: result.sqlScript });
}
```

### 3. Pipeline Orchestrator Starts
**File**: `src/lib/pipeline/index.ts` → `runGenerationPipeline()`
- **Step 1**: Calls `ingest()` ← **SERPER IS CALLED HERE**
- **Step 2**: Calls `generate()` with serper context
- **Step 3**: Calls `validate()` 
- **Step 4**: Calls `buildSqlOutput()`

```typescript
export async function runGenerationPipeline(params: PipelineParams): Promise<PipelineResult> {
  console.log(`[pipeline] Starting generation for ${params.certificationName}`);
  
  // ─── Step 1: Ingest ───
  const { examGuide, domainContext, fewShotExamples, serperContext } = await ingest({
    certificationName: params.certificationName,
    topicName: params.topicName,
    modules: params.modules,
    // ...
  });
  
  // serperContext is now available (or empty string if failed)
  
  // ─── Step 2: Generate ───
  const batch = await generate({
    // ...
    serperContext,  // ← Passed to generation
  });
}
```

### 4. Ingest Step - Serper Called
**File**: `src/lib/pipeline/ingest.ts` → `ingest()`

```typescript
export async function ingest(params: { ... }): Promise<IngestResult> {
  // 1. Resolve exam guide
  let examGuide = getCurrentGuide(certificationCode) || resolveGuideFromCertName(certificationName);
  
  // 2. Match topic to domain
  const domainContext = matchDomain(examGuide, topicName);
  
  // 3. Select few-shot examples
  const fewShotExamples = await selectFewShotExamplesV2(...);
  
  // 4. FETCH SERPER CONTEXT ← HERE
  let serperContext: string | undefined;
  try {
    const moduleNames = params.modules.map(m => m.module_name).join(', ');
    const query = `${topicName}${moduleNames ? `, ${moduleNames}` : ''}`;
    
    console.log(`[ingest] Fetching Serper context for query: "${query}"`);
    serperContext = await fetchSerperContext(query);  // ← API CALL
    console.log(`[ingest] Serper context received: ${serperContext?.length || 0} characters`);
    
    if (!serperContext) {
      console.warn('[ingest] Warning: Serper returned empty context. Check SERPER_API_KEY or network.');
    }
  } catch (e) {
    console.error('[ingest] Failed to fetch Serper context:', e);
  }
  
  return {
    examGuide,
    domainContext,
    fewShotExamples,
    serperContext,  // ← Returned (may be undefined or empty)
  };
}
```

### 5. Serper API Client
**File**: `src/lib/serper.ts` → `fetchSerperContext(query)`

```typescript
export async function fetchSerperContext(query: string): Promise<string> {
  const key = process.env.SERPER_API_KEY;
  
  if (!key) {
    console.warn('[serper] ❌ No SERPER_API_KEY environment variable set. Serper context disabled.');
    return '';  // ← Graceful degradation
  }

  try {
    // Try GET first
    let url = `https://google.serper.dev/search?q=${encodeURIComponent(query)}&api_key=${encodeURIComponent(key)}`;
    console.log(`[serper] 🔍 Fetching context for query: "${query}"`);
    
    let resp = await fetch(url, {
      method: 'GET',
      headers: { Authorization: `Bearer ${key}` },
    });

    // Fallback to POST if GET fails
    if (!resp.ok && (resp.status === 404 || resp.status === 405 || resp.status === 403)) {
      console.log('[serper] ⚠️  GET failed, retrying using POST with JSON body');
      resp = await fetch('https://google.serper.dev/search', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${key}`,
          'x-api-key': key,
        },
        body: JSON.stringify({ q: query }),
      });
    }

    if (!resp.ok) {
      console.warn(`[serper] ❌ Request failed with status ${resp.status}`);
      return '';  // ← Graceful degradation
    }

    const data: any = await resp.json();
    
    // Prefer AI-generated answer
    if (data.answer) {
      console.log(`[serper] ✅ Using AI-generated answer (${data.answer.length} chars)`);
      return data.answer;
    }
    
    // Fallback to organic search results
    if (Array.isArray(data.organic_results)) {
      const context = data.organic_results
        .slice(0, 3)
        .map((r: any) => `${r.title || ''}\n${r.snippet || ''}`)
        .join('\n\n');
      console.log(`[serper] ✅ Using organic results (${context.length} chars)`);
      return context;
    }
    
    console.warn('[serper] ⚠️  No answer or organic_results in response');
    return '';
  } catch (err) {
    console.error('[serper] ❌ Failed to fetch:', err);
    return '';  // ← Graceful degradation
  }
}
```

**Example Query**: `"AWS Solutions Architect, IAM, EC2, VPC"`  
**Example Response**: AI-generated summary or top 3 search result snippets

### 6. Generation Step - Uses Serper Context
**File**: `src/lib/pipeline/generate.ts` → `generate()`

```typescript
export async function generate(params: QuestionGenerationParams): Promise<GeneratedQuestion[]> {
  console.log(`[RANJAN] PARAMS: ${JSON.stringify(params.serperContext)}`);
  
  // Create prompt with serper context included
  const prompt = createGenerationPrompt({
    examGuide: params.examGuide!,
    domainContext: params.domainContext!,
    modules: params.modules,
    serperContext: params.serperContext,  // ← Passed here
  });
  
  const model = getGenerationModel();
  const result = await model.generateContent(prompt);
  // ... parse and return questions ...
}
```

### 7. Prompt Assembly - Serper Context Inserted
**File**: `src/lib/prompts/generation-new.ts` → `createGenerationPrompt()`

```typescript
export function createGenerationPrompt(params: V2GenerationPromptParams): string {
  const {
    examGuide,
    domainContext,
    modules,
    serperContext,  // ← Received
    // ...
  } = params;

  return `${systemPrompt}

${tierBlock}

${modeBlock}

${examGuideSection}

${serperContext ? `═══════════════════════════════════════════════════════
EXTERNAL WEB/SEARCH CONTEXT — results from Serper API
═══════════════════════════════════════════════════════
${serperContext}

` : ''}  ← CONDITIONALLY INCLUDED

${antiPatternInstructions}

${fewShotSection}

TASK: Generate exactly ${totalQuestions} ${examGuide.certificationName} exam questions...`;
}
```

**If `serperContext` is truthy**: The external context section is included  
**If `serperContext` is empty**: The section is omitted entirely (graceful degradation)

### 8. Gemini Receives Prompt and Generates Questions
**File**: `src/lib/gemini/client.ts`

```typescript
const model = getGenerationModel();  // Uses Gemini 1.5 Flash with temperature 0.7
const result = await model.generateContent(prompt);  // ← Prompt includes serper context
const responseText = result.response.text();
```

Gemini now has real-world context to enhance question quality.

## Debugging: Why Serper Context Might Be Empty

### Scenario 1: API Key Not Set
```bash
# Missing SERPER_API_KEY
❌ [serper] No SERPER_API_KEY environment variable set. Serper context disabled.
✅ Pipeline continues with empty serperContext
```

**Fix**:
```bash
export SERPER_API_KEY=your_key_here
```

### Scenario 2: Network Error
```
❌ [serper] Failed to fetch: Error: Network timeout
✅ Pipeline continues with empty serperContext
```

### Scenario 3: Invalid API Key
```
❌ [serper] Request failed with status 403
✅ Pipeline continues with empty serperContext
```

### Scenario 4: Serper Returns No Results
```
⚠️  [serper] No answer or organic_results in response
✅ Pipeline continues with empty serperContext
```

**This is now handled with multiple fallback strategies**:
1. ✅ AI-generated `answer` field
2. ✅ `organic_results` array (web search results - standard format)
3. ✅ `organic` array (web search results - alternative format)
4. ✅ `knowledgeGraph` (Wikipedia-style summaries)
5. ✅ `related` searches (as last resort)
6. ✅ Logs full response if none match (for debugging)

**Note**: Serper API sometimes returns `organic` instead of `organic_results`. The code now handles both!

If you see this message, the Serper API is working but returning an unexpected response structure. Check the console for the response structure debug info:

```
[serper] Response structure: {
  hasAnswer: false,
  hasOrganic_results: false,
  hasOrganic: true,
  organicCount: 10,
  hasSearchParameters: true,
  hasKnowledgeGraph: false,
  hasRelated: false,
  allKeys: "searchParameters,organic,relatedSearches"
}
```

This helps identify which field has your data and guides the fix.

## Console Output Example

```
[ingest] Fetching Serper context for query: "AWS Solutions Architect, IAM, EC2, VPC"
[serper] 🔍 Fetching context for query: "AWS Solutions Architect, IAM, EC2, VPC"
[serper] ✅ Using AI-generated answer (1247 chars)
[ingest] Serper context received: 1247 characters
[pipeline] Exam guide: v1.0, domain: Secure Architecture Design, examples: 3
```

## Key Points

✅ **Serper is optional** — Generation works without it (gracefully degrades)  
✅ **Serper is called once per generation run** — During the ingest phase  
✅ **Serper context is passed to Gemini** — Enhances question quality  
✅ **Multiple fallback strategies**:
- No API key → empty context
- Network error → empty context
- API error → empty context
- No answer/results → empty context
✅ **Comprehensive logging** — Easy to debug issues

## Setup

To enable Serper:

1. Sign up at https://serper.dev
2. Get your API key
3. Set environment variable:
   ```bash
   SERPER_API_KEY=your_api_key_here
   ```
4. Restart your server
5. Check logs for `[serper] ✅` messages

That's it! Your questions now have real-world context.

## Troubleshooting: Advanced Debugging

### Issue: "No answer or organic_results in response"

If you're seeing this message, run a test query manually to see what Serper returns:

```bash
# Test with curl
curl -X POST "https://google.serper.dev/search" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: YOUR_API_KEY" \
  -d '{"q": "AWS IAM"}'
```

You'll get a response like:
```json
{
  "searchParameters": {...},
  "organic_results": [...],
  "knowledgeGraph": {...},
  "related": [...]
}
```

### Response Field Priority (in order tried):

1. **`answer`** - AI-generated summary (best)
2. **`organic_results`** - Web search results (good)
3. **`knowledgeGraph`** - Knowledge graph data (decent)
4. **`related`** - Related searches (fallback)

If your API key is valid but you're still getting 0 characters, the query might not be returning any results. Try:

```bash
# Check what the API actually returns
curl -X GET "https://google.serper.dev/search?q=AWS&api_key=YOUR_API_KEY" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

### Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| "No SERPER_API_KEY" | Env var not set | `export SERPER_API_KEY=...` |
| Status 403 | Invalid/expired key | Get new key from serper.dev |
| Status 429 | Rate limited | Wait or upgrade plan |
| Status 500 | Serper server error | Retry or contact support |
| 0 characters received | Empty response | Query might have no results |
| Response structure mismatch | API version changed | Check console debug logs |

Check the console for `[serper] Response structure:` to see what fields are available in the response.

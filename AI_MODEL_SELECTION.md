# AI Model Selection Guide

This guide explains how to use the new dual AI model feature in the question generation pipeline.

## Overview

The system now supports **two LLM providers** for question generation and validation:

- **Gemini** (default): Google's Generative AI with strong reasoning
- **Kimi**: Moonshot's AI with optional web search capability

## Request Body Parameters

### New Parameters in `/api/generate-hub`

```typescript
{
  // ... existing parameters ...
  
  // AI Model Selection
  aiModel?: 'gemini' | 'kimi';           // Defaults to 'gemini'
  kimiWebSearchEnabled?: boolean;         // Defaults to true for Kimi
}
```

## Usage Examples

### 1. Use Default Gemini Model

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
}
```

### 2. Switch to Kimi with Web Search

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

### 3. Use Kimi without Web Search

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

## Configuration

### Environment Variables

Ensure both API keys are configured in `.env.local`:

```bash
# Google Gemini API
GEMINI_API_KEY=your_gemini_api_key

# Moonshot Kimi API
KIMI_API_KEY=your_kimi_api_key
```

## Model Specifications

### Gemini Model

- **Generation Model**: `gemini-2.5-flash`
  - Temperature: 0.45 (balanced creativity)
  - Max tokens: 16,384
  - Web search: Not available

- **Validation Model**: `gemini-2.5-flash`
  - Temperature: 0.15 (conservative, strict fact-checking)
  - Max tokens: 4,096
  - Web search: Not available

### Kimi Model

- **Generation Model**: `moonshot-v1-8k`
  - Temperature: 0.45 (balanced creativity)
  - Max tokens: 16,384
  - Web search: Optional (enabled by default)

- **Validation Model**: `moonshot-v1-8k`
  - Temperature: 0.15 (conservative, strict fact-checking)
  - Max tokens: 4,096
  - Web search: Optional (disabled by default for validation)

## Architecture

### File Structure

```
src/lib/
├── gemini/
│   └── client.ts          # Gemini API client & utilities
├── kimi/
│   └── client.ts          # Kimi API client & utilities (NEW)
└── pipeline/
    ├── index.ts           # Main orchestrator (updated)
    ├── generate.ts        # Question generation (updated to support both)
    └── validate.ts        # Question validation (updated to support both)
```

### Generation Flow with Model Selection

```
POST /api/generate-hub
  ↓
[route.ts] Receives aiModel parameter
  ↓
[pipeline/index.ts] runGenerationPipeline()
  ├─ Step 1: INGEST (model-agnostic)
  ├─ Step 2: GENERATE 
  │   └─ If aiModel='kimi': use Kimi API with web search
  │   └─ If aiModel='gemini': use Gemini API
  ├─ Step 3: VALIDATE
  │   └─ Use same model as generation for consistency
  └─ Step 4: OUTPUT (model-agnostic)
```

## When to Use Each Model

### Use Gemini When:

- You want faster, more consistent responses
- Web search is not needed for question generation
- You need reliable JSON parsing
- You want the default, well-tested path

### Use Kimi When:

- You want web search capability for current information
- Generating questions about recent technologies/updates
- You need alternative validation perspective
- Testing/comparing different models

## Implementation Details

### Model Selection Flow

1. **Request Processing** (`route.ts`)
   - Accepts `aiModel` and `kimiWebSearchEnabled` parameters
   - Defaults to `gemini` if not specified

2. **Pipeline Orchestration** (`pipeline/index.ts`)
   - Passes model options to generate() and validate()
   - Maintains consistency: uses same model for gen & validation

3. **Generation** (`pipeline/generate.ts`)
   - Selects appropriate client (Gemini or Kimi)
   - Uses appropriate JSON parser
   - Handles both model responses

4. **Validation** (`pipeline/validate.ts`)
   - Uses same model for consistency
   - Configurable web search for validation

### JSON Parsing

Both models use robust JSON parsing with fallbacks:
- Markdown code fence removal
- Unterminated string fixes
- Array/object extraction
- Malformed JSON recovery

## Troubleshooting

### Kimi API Errors

```
Error: KIMI_API_KEY not configured
→ Solution: Set KIMI_API_KEY in .env.local
```

```
Error: Kimi API error: 401
→ Solution: Verify KIMI_API_KEY is correct
```

### Web Search Issues

Web search results might timeout. If using web search:
- Kimi timeout default: ~30 seconds
- Set `kimiWebSearchEnabled: false` to disable web search
- Monitor Kimi API logs for search delays

## Response Format

The response format remains **unchanged** regardless of which model is used:

```json
{
  "success": true,
  "sqlScript": "INSERT INTO ...",
  "questions": [...],
  "questionCount": 20,
  "moduleCount": 2,
  "examGuideVersion": "1.0",
  "validatedCount": 18,
  "rejectedCount": 2,
  "generationTimestamp": "2026-05-28T10:30:00Z"
}
```

## Logging

Check logs to see which model was used:

```
[generate] Calling gemini for 2 modules × 10 questions
[validate] Validating 20 questions using gemini...
```

or

```
[generate] Calling kimi for 2 modules × 10 questions
[validate] Validating 20 questions using kimi...
```

## Future Enhancements

Potential additions to consider:
- [ ] Support for more LLM providers (Claude, etc.)
- [ ] Per-provider cost tracking
- [ ] Model-specific prompt optimization
- [ ] A/B testing different models
- [ ] Fallback mechanism (if one model fails, use another)

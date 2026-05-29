# Quick Reference: Gemini + Kimi Model Selection

## TL;DR

You can now choose between **Gemini** and **Kimi** for generating questions. Add these parameters to your request:

```json
{
  "aiModel": "kimi",              // or "gemini" (default)
  "kimiWebSearchEnabled": true    // only matters for Kimi
}
```

## Quick Examples

### 🔷 Gemini (Default - No Changes Needed)
```bash
# Just use as before - Gemini is the default
curl -X POST /api/generate-hub \
  -H "Content-Type: application/json" \
  -d '{ "certification_id": "1", ... }'
```

### 🔷 Kimi with Web Search
```bash
# Latest info, web search enabled
curl -X POST /api/generate-hub \
  -H "Content-Type: application/json" \
  -d '{
    "certification_id": "1",
    ...,
    "aiModel": "kimi",
    "kimiWebSearchEnabled": true
  }'
```

### 🔷 Kimi without Web Search  
```bash
# Faster, no web calls
curl -X POST /api/generate-hub \
  -H "Content-Type: application/json" \
  -d '{
    "certification_id": "1",
    ...,
    "aiModel": "kimi",
    "kimiWebSearchEnabled": false
  }'
```

## Model Comparison

| Aspect | Gemini | Kimi |
|--------|--------|------|
| **Default** | ✅ Yes | - |
| **Web Search** | ❌ No | ✅ Optional |
| **Speed** | Fast | Medium |
| **API Key** | `GEMINI_API_KEY` | `KIMI_API_KEY` |
| **Base URL** | Google API | `api.moonshot.cn/v1` |
| **Model Name** | `gemini-2.5-flash` | `moonshot-v1-8k` |

## Configuration

### `.env.local`
```bash
GEMINI_API_KEY=sk-...          # Already set
KIMI_API_KEY=sk-...            # Add this for Kimi
```

## What Changed in Code

### 5 Files Modified
1. ✅ `src/lib/kimi/client.ts` (NEW)
2. ✅ `src/lib/pipeline/generate.ts` 
3. ✅ `src/lib/pipeline/validate.ts`
4. ✅ `src/lib/pipeline/index.ts`
5. ✅ `src/app/api/generate-hub/route.ts`
6. ✅ `src/lib/types/generation.ts`

### Request Body
```typescript
interface RequestBody {
  // existing...
  aiModel?: 'gemini' | 'kimi';           // NEW
  kimiWebSearchEnabled?: boolean;         // NEW
}
```

## Response (Same for Both)
```json
{
  "success": true,
  "sqlScript": "INSERT INTO ...",
  "questions": [...],
  "questionCount": 20,
  "validatedCount": 18,
  "rejectedCount": 2
}
```

## Logs to Check
```
[generate] Calling gemini for 2 modules × 10 questions
[generate] Calling kimi for 2 modules × 10 questions
[validate] Validating 20 questions using gemini...
[validate] Validating 20 questions using kimi...
```

## Backward Compatibility

✅ **100% backward compatible**
- Old requests without `aiModel` → uses Gemini
- No template changes
- No prompt changes
- No output format changes

## Choose Model Based On

| Goal | Model |
|------|-------|
| Fastest generation | **Gemini** |
| Current info/updates | **Kimi** (web search) |
| Cost-conscious | **Gemini** |
| Better reasoning | **Gemini** |
| Comparative validation | **Kimi** |
| Real-time data | **Kimi** (web search) |

## Troubleshooting

❌ `KIMI_API_KEY not configured`  
→ Set `KIMI_API_KEY` in `.env.local`

❌ `Kimi API error: 401`  
→ Check API key is correct

❌ Web search timeout  
→ Set `kimiWebSearchEnabled: false`

## Full Documentation

See these files for detailed info:
- 📄 `AI_MODEL_SELECTION.md` - Complete guide
- 📄 `IMPLEMENTATION_SUMMARY.md` - Technical details

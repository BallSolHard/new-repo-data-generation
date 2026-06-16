# Quick Log Reference

## TL;DR - What Each Log Section Means

### 🚀 Generation Starting
```
[pipeline] Model: KIMI
[pipeline] Web Search: ✅ ENABLED
```
→ Kimi is generating with web search

### 📡 Step 1-2: API Preparation & Request
```
[kimi] STEP 1: Preparing Kimi API Request
[kimi] STEP 2: Sending Request to Kimi API...
```
→ Sending prompt to Kimi API

### ⏱️ Step 3: Response Status
```
[kimi] Response Status: 200 OK
[kimi] Response Time: 4523ms
```
→ ✅ Got response (4.5 seconds)

### 📦 Step 4-5: Content Extraction
```
[kimi] ✅ Successfully parsed response
[kimi] Content extracted successfully
```
→ ✅ Got valid JSON with 12 questions

### 🔍 Step 6: JSON Parsing
**Scenario A (Best):**
```
[kimi-parser] ✅ Direct parse successful!
[kimi-parser] Parsed 12 items
```
→ ✅ Perfect JSON, all 12 questions

**Scenario B (OK):**
```
[kimi-parser] Detected markdown code fences, stripping...
[kimi-parser] ✅ Direct parse successful!
```
→ ✅ Had markdown wrapper, removed and parsed

**Scenario C (Still OK):**
```
[kimi-parser] ✅ Array extraction successful! Found 10 items
```
→ ⚠️ Got 10 out of 12, 2 were malformed

**Scenario D (Problem):**
```
[kimi-parser] ❌ PARSING FAILED: All strategies exhausted
```
→ ❌ Couldn't parse response at all

### ✅ Deduplication
```
[pipeline] After deduplication: 10/12 questions remain (2 duplicates removed)
```
→ 12 generated, 2 were duplicates from before, 10 unique

### 🔍 Validation Starting
```
[pipeline] Model: GEMINI
[pipeline] Questions to Validate: 10
```
→ Gemini will check 10 questions

### ✅ Final Results
```
[pipeline] Final Questions: 8
[pipeline] Rejected Count: 2
```
→ 10 validated, 2 rejected, 8 final

---

## Log Locations (Where to Look)

| Component | Log Prefix | What It Does |
|-----------|-----------|--------------|
| Pipeline | `[pipeline]` | Orchestrates the whole flow |
| Kimi API | `[kimi]` | Calls Kimi API |
| JSON Parser | `[kimi-parser]` | Parses Kimi JSON response |
| Validation | `[validate]` | Validates questions |
| Gemini | (no prefix or `[gemini]`) | Gemini model calls |

---

## Status Symbols

| Symbol | Meaning |
|--------|---------|
| ✅ | Success |
| ❌ | Error/Failed |
| ⚠️ | Warning/Fallback used |
| ⓘ | Info |
| 📊 | Statistics |
| 🔧 | Action needed |

---

## Key Metrics to Watch

```
Response Time: [kimi] Response Time: 4523ms
Content Length: [kimi] Content Length: 15234 characters
Questions Generated: [pipeline] Final Questions: 8
Rejection Rate: [pipeline] Rejected Count: 2 (out of 10)
Duplicate Rate: [pipeline] (2 duplicates removed)
```

---

## Troubleshooting in 3 Steps

1. **Check STEP 3 status:**
   ```
   [kimi] Response Status: 200 OK
   ```
   - If not 200: API error (401, 429, 500)

2. **Check STEP 6 result:**
   ```
   [kimi-parser] ✅ Direct parse successful!
   ```
   - If ❌ PARSING FAILED: Response is corrupted

3. **Check final count:**
   ```
   [pipeline] Final Questions: 8
   ```
   - If 0: All rejected or parsing failed

---

## Common Scenarios

### Scenario 1: Success ✅
```
[kimi] Response Status: 200 OK
[kimi] ✅ Content extracted successfully
[kimi-parser] ✅ Direct parse successful! Parsed 12 items
[pipeline] After deduplication: 10/12 questions remain
[pipeline] Final Questions: 8
```
→ All good! 8 final questions ready

### Scenario 2: Minor JSON Format Issue ⚠️
```
[kimi] Response Status: 200 OK
[kimi] ✅ Content extracted successfully
[kimi-parser] Detected markdown code fences, stripping...
[kimi-parser] ✅ Direct parse successful! Parsed 12 items
```
→ OK, Kimi wrapped in markdown, auto-fixed

### Scenario 3: API Error ❌
```
[kimi] Response Status: 401 Unauthorized
[kimi] ❌ STEP 3 FAILED: HTTP Error
```
→ Invalid API key, check `.env`

### Scenario 4: Parsing Completely Failed ❌
```
[kimi] Response Status: 200 OK
[kimi] ✅ Content extracted successfully
[kimi-parser] ❌ PARSING FAILED: All strategies exhausted
```
→ Response is corrupted, retry

---

## Command to Monitor Logs in Real-Time

```bash
# Watch all Kimi logs
npm run dev 2>&1 | grep "\[kimi"

# Watch pipeline progress
npm run dev 2>&1 | grep "\[pipeline"

# Watch everything with timestamps
npm run dev 2>&1 | grep "kimi\|pipeline" | sed 's/^/['"$(date +%T)"'] /'

# Save to file for later analysis
npm run dev > generation.log 2>&1
tail -f generation.log | grep "kimi\|pipeline"
```

---

## When to Worry 🚨

| Log | Means | Action |
|-----|-------|--------|
| Status: 401 | API key invalid | Check `.env` KIMI_API_KEY |
| Status: 429 | Rate limited | Wait & retry |
| Status: 500 | Kimi server error | Wait & retry |
| PARSING FAILED | Corrupt response | Retry generation |
| All rejected | Validation too strict | Use Kimi for validation |
| Response Time: >30s | Timeout/slow | Reduce batch size |

---

## Performance Baseline

**Good Generation Run:**
```
Time: ~5 seconds (with web search)
Content: 10-15KB JSON
Status: 200 OK
Parsing: Direct parse successful (Step 6.2)
Final: 8-10 questions from 10-12 generated
```

**If You See:**
- ⚡ <2s: Very fast, likely cached
- 🐢 >10s: Slow, network or heavy query
- 💥 Timeout: Server issue or bad internet


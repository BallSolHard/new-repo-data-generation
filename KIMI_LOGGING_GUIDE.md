# Kimi Logging Guide - Step-by-Step Tracking

## Overview

Enhanced logging has been added to track **every step** of the Kimi model execution. This includes:
- API request preparation
- HTTP communication
- JSON response parsing with multiple fallback strategies
- Pipeline orchestration
- Validation processes

---

## Log Flow

### Phase 1: Pipeline Initialization

When generation starts, you'll see:

```
[pipeline] ╔════════════════════════════════════════════════════════╗
[pipeline] ║        GENERATION CONFIGURATION                        ║
[pipeline] ╚════════════════════════════════════════════════════════╝
[pipeline] Model: KIMI
[pipeline] Web Search: ✅ ENABLED
[pipeline] Distribution: NO
[pipeline] ─────────────────────────────────────────────────────
```

**What it tells you:**
- ✅ Generation model is configured as KIMI
- ✅ Web search is enabled for richer context
- ✅ Preparing to generate questions

---

### Phase 2: Kimi API Request

Detailed preparation logs appear:

```
[kimi] ════════════════════════════════════════════════════════
[kimi] STEP 1: Preparing Kimi API Request
[kimi] ════════════════════════════════════════════════════════
[kimi] Endpoint: https://api.moonshot.ai/v1/chat/completions
[kimi] Model: kimi-k2.6
[kimi] Temperature: 1 (fixed for Kimi K2.6)
[kimi] Top_p: 0.95 (fixed for Kimi K2.6)
[kimi] Max Tokens: 16384
[kimi] Web Search: ✅ ENABLED
[kimi] Prompt Length: 8452 characters
[kimi] ────────────────────────────────────────────────────────
[kimi] STEP 2: Sending Request to Kimi API...
```

**What to check:**
- ✅ Endpoint is correct: `https://api.moonshot.ai/v1` (not `.cn`)
- ✅ Model is: `kimi-k2.6`
- ✅ Temperature/top_p are FIXED (required for Kimi K2.6)
- ✅ Web search status matches your expectation
- ✅ Prompt has reasonable length

---

### Phase 3: Response Received

After sending the request:

```
[kimi] STEP 3: Checking Response Status
[kimi] Response Status: 200 OK
[kimi] Response Time: 4523ms
[kimi] ────────────────────────────────────────────────────────
[kimi] STEP 4: Parsing Response JSON
[kimi] ✅ Successfully parsed response
[kimi] Content Length: 15234 characters
[kimi] ────────────────────────────────────────────────────────
[kimi] STEP 5: Extracting Content
[kimi] ✅ Content extracted successfully
[kimi] First 200 chars: [{"text": "What is AWS IAM?", "options": [...]
[kimi] ════════════════════════════════════════════════════════
```

**What to check:**
- ✅ Status 200 = Success
- ⏱️ Response time (slower = more complex queries or web search)
- ✅ Content length reasonable (>1000 chars)
- ✅ First 200 chars show valid JSON structure

**Common Errors:**
- ❌ Status 401 = Invalid API Key
- ❌ Status 429 = Rate Limited
- ❌ Status 408 = Timeout

---

### Phase 4: JSON Parsing

Most detailed logs appear here:

```
[kimi-parser] ════════════════════════════════════════════════════════
[kimi-parser] STEP 6: Parsing Kimi JSON Response
[kimi-parser] ════════════════════════════════════════════════════════
[kimi-parser] Raw Response Length: 15234 characters
[kimi-parser] First 300 chars: [{"text": "What is IAM?", "options": [...
[kimi-parser] ────────────────────────────────────────────────────────
[kimi-parser] STEP 6.1: Cleaning Response
[kimi-parser] After trim: 15234 characters
```

#### Success Case - Direct Parse Works:
```
[kimi-parser] STEP 6.2: Attempting Direct JSON Parse
[kimi-parser] ✅ Direct parse successful!
[kimi-parser] Parsed 12 items
[kimi-parser] ════════════════════════════════════════════════════════
```

**What it means:**
- ✅ JSON was valid and parsed directly
- ✅ All 12 questions extracted successfully
- ✅ Fastest parsing path

#### Fallback 1 - Markdown Stripping:
```
[kimi-parser] STEP 6.1: Cleaning Response
[kimi-parser] After trim: 15234 characters
[kimi-parser] Detected markdown code fences, stripping...
[kimi-parser] After stripping fences: 15100 characters
[kimi-parser] STEP 6.2: Attempting Direct JSON Parse
[kimi-parser] ✅ Direct parse successful!
[kimi-parser] Parsed 12 items
```

**What it means:**
- ✅ Kimi wrapped JSON in markdown code fences (normal)
- ✅ Stripped and parsed successfully
- ✅ No issues

#### Fallback 2 - Quote Fix:
```
[kimi-parser] STEP 6.2: Attempting Direct JSON Parse
[kimi-parser] ❌ Direct parse failed: SyntaxError: Unterminated string
[kimi-parser] ────────────────────────────────────────────────────────
[kimi-parser] STEP 6.3: Attempting Quote Fix
[kimi-parser] Adding closing quote...
[kimi-parser] ✅ Quote fix successful!
[kimi-parser] Parsed 12 items
```

**What it means:**
- ⚠️ JSON had unterminated string
- ✅ Auto-fixed by adding closing quote
- ✅ Still able to extract all questions

#### Fallback 3 - Array Extraction:
```
[kimi-parser] STEP 6.3: Attempting Quote Fix
[kimi-parser] String already ends with quote, skipping
[kimi-parser] ❌ Quote fix failed: SyntaxError: ...
[kimi-parser] ────────────────────────────────────────────────────────
[kimi-parser] STEP 6.4: Attempting Array Extraction
[kimi-parser] Found array pattern, trying to parse...
[kimi-parser] ✅ Array extraction successful! Found 10 items
```

**What it means:**
- ⚠️ Primary parsing strategies failed
- ✅ Successfully extracted array pattern
- ✅ Got 10 out of expected 12 questions

#### Fallback 4 - Array Fix (Missing Brackets):
```
[kimi-parser] STEP 6.4: Attempting Array Extraction
[kimi-parser] ❌ Array parse failed: SyntaxError: ...
[kimi-parser] STEP 6.4.1: Attempting Array Fix (missing brackets)
[kimi-parser] Open brackets: 12, Close brackets: 11
[kimi-parser] Adding missing closing bracket...
[kimi-parser] ✅ Fixed array parse successful!
[kimi-parser] Parsed 12 items
```

**What it means:**
- ⚠️ Array had mismatched brackets
- ✅ Auto-detected and fixed
- ✅ All 12 questions recovered

#### Fallback 5 - Object Extraction:
```
[kimi-parser] STEP 6.4.1: Attempting Array Fix (missing brackets)
[kimi-parser] ❌ Fixed array parse failed: SyntaxError: ...
[kimi-parser] ────────────────────────────────────────────────────────
[kimi-parser] STEP 6.5: Attempting Object Extraction
[kimi-parser] Found 12 object patterns, filtering valid ones...
[kimi-parser] ✅ Successfully extracted 8 valid objects!
```

**What it means:**
- ⚠️ Array parsing all failed
- ✅ Extracted individual valid objects
- ⚠️ Got only 8 out of 12 (4 objects malformed)

#### All Fallbacks Failed:
```
[kimi-parser] STEP 6.6: Attempting Single Object Extraction
[kimi-parser] ⓘ No single object pattern found
[kimi-parser] ════════════════════════════════════════════════════════
[kimi-parser] ❌ PARSING FAILED: All strategies exhausted
[kimi-parser] Could not parse Kimi response as JSON
[kimi-parser] Response preview: [{"text": "What is IAM?", ...incomplete
[kimi-parser] ════════════════════════════════════════════════════════
```

**What it means:**
- ❌ All parsing strategies failed
- ❌ Response appears corrupted or malformed
- 🔧 **Action:** Check if Kimi API is returning valid JSON

---

### Phase 5: Question Deduplication

```
[pipeline] After deduplication: 10/12 questions remain (2 duplicates removed)
[pipeline] ─────────────────────────────────────────────────────
```

**What it tells you:**
- ℹ️ 12 questions generated
- 🔄 2 were duplicates (against historical hashes)
- ✅ 10 unique questions retained

---

### Phase 6: Validation Configuration

```
[pipeline] ╔════════════════════════════════════════════════════════╗
[pipeline] ║        VALIDATION CONFIGURATION                        ║
[pipeline] ╚════════════════════════════════════════════════════════╝
[pipeline] Model: GEMINI
[pipeline] Web Search: ❌ DISABLED
[pipeline] Questions to Validate: 10
[pipeline] ─────────────────────────────────────────────────────
```

**What it tells you:**
- ✅ Validation using Gemini (different from generation)
- ✅ Web search disabled for validation (conservative mode)
- ✅ About to validate 10 questions

---

### Phase 7: Pipeline Complete

```
[pipeline] ╔════════════════════════════════════════════════════════╗
[pipeline] ║        BUILDING OUTPUT                                  ║
[pipeline] ╚════════════════════════════════════════════════════════╝
[pipeline] Final Questions: 8
[pipeline] Rejected Count: 2
[pipeline] ─────────────────────────────────────────────────────
[pipeline] ✅ SQL script generated
[pipeline] SQL Script Length: 45234 characters
[pipeline] ╔════════════════════════════════════════════════════════╗
[pipeline] ║        PIPELINE COMPLETE ✅                           ║
[pipeline] ║  Generated: 8 | Rejected: 2                          ║
[pipeline] ╚════════════════════════════════════════════════════════╝
```

**Final Summary:**
- 📊 12 questions generated
- 🔄 2 removed as duplicates
- 10 validated
- ❌ 2 rejected by Gemini validation
- ✅ **8 final questions** in output

---

## Log Levels

### ✅ Success Indicators
```
[kimi] ✅ Direct parse successful!
[kimi-parser] ✅ Array extraction successful!
[pipeline] ✅ SQL script generated
```

### ⚠️ Warning Indicators
```
[kimi-parser] ⚠️ Quote fix successful! (recovered from error)
[pipeline] ⓘ Validation DISABLED (informational)
```

### ❌ Error Indicators
```
[kimi] ❌ STEP 3 FAILED: HTTP Error
[kimi-parser] ❌ Direct parse failed: SyntaxError
[kimi-parser] ❌ PARSING FAILED: All strategies exhausted
```

---

## Debugging Checklist

### If Generation Fails at Step 1:
- [ ] Check KIMI_API_KEY is set in `.env`
- [ ] Check endpoint is `https://api.moonshot.ai/v1` (not `.cn`)
- [ ] Verify model name is `kimi-k2.6`

### If Generation Fails at Step 2:
- [ ] Network connectivity issue
- [ ] Kimi API is down
- [ ] Firewall blocking `api.moonshot.ai`

### If Generation Fails at Step 3:
- [ ] Check response status code:
  - 401 = Invalid API key
  - 429 = Rate limited
  - 500 = Kimi server error

### If Parsing Fails:
- [ ] Check response preview in logs
- [ ] If response is very short (<100 chars) = likely error message from API
- [ ] If response is incomplete = timeout or stream cut off
- [ ] If response is JSON but malformed = Kimi formatting issue

### If Validation Rejects Too Many:
- [ ] Check which model is validating
- [ ] Gemini is stricter than Kimi
- [ ] Check validation_notes in rejected questions for reasons

---

## Example: Full Successful Run

```
[pipeline] ╔════════════════════════════════════════════════════════╗
[pipeline] ║        GENERATION CONFIGURATION                        ║
[pipeline] ╚════════════════════════════════════════════════════════╝
[pipeline] Model: KIMI
[pipeline] Web Search: ✅ ENABLED

[kimi] ════════════════════════════════════════════════════════
[kimi] STEP 1: Preparing Kimi API Request
[kimi] Endpoint: https://api.moonshot.ai/v1/chat/completions
[kimi] Model: kimi-k2.6
[kimi] Temperature: 1 (fixed for Kimi K2.6)
[kimi] Top_p: 0.95 (fixed for Kimi K2.6)
[kimi] Max Tokens: 16384
[kimi] Web Search: ✅ ENABLED

[kimi] STEP 2: Sending Request to Kimi API...
[kimi] STEP 3: Checking Response Status
[kimi] Response Status: 200 OK
[kimi] Response Time: 4523ms

[kimi] STEP 4: Parsing Response JSON
[kimi] ✅ Successfully parsed response
[kimi] Content Length: 15234 characters

[kimi] STEP 5: Extracting Content
[kimi] ✅ Content extracted successfully

[kimi-parser] STEP 6: Parsing Kimi JSON Response
[kimi-parser] STEP 6.1: Cleaning Response
[kimi-parser] STEP 6.2: Attempting Direct JSON Parse
[kimi-parser] ✅ Direct parse successful!
[kimi-parser] Parsed 12 items

[pipeline] After deduplication: 10/12 questions remain

[pipeline] ╔════════════════════════════════════════════════════════╗
[pipeline] ║        VALIDATION CONFIGURATION                        ║
[pipeline] ╚════════════════════════════════════════════════════════╝
[pipeline] Model: GEMINI
[pipeline] Web Search: ❌ DISABLED
[pipeline] Questions to Validate: 10

[pipeline] ╔════════════════════════════════════════════════════════╗
[pipeline] ║        PIPELINE COMPLETE ✅                           ║
[pipeline] ║  Generated: 8 | Rejected: 2                          ║
[pipeline] ╚════════════════════════════════════════════════════════╝
```

---

## Tips & Tricks

### Monitor Generation Progress in Real-Time
```bash
# Terminal 1
npm run dev  # Start dev server

# Terminal 2
tail -f server_output.log | grep "\[kimi\]"
```

### Identify Parsing Issues
Look for the specific STEP that succeeded:
- **Direct Parse (6.2)** = Best, fastest
- **Quote Fix (6.3)** = Kimi has minor formatting
- **Array Extract (6.4)** = Kimi response partially malformed
- **Object Extract (6.5)** = Serious issues, but recovery possible

### Track Web Search Impact
Compare logs with web_search ON vs OFF:
- Response time usually 2-3x longer with web search
- Content length usually 1.5-2x larger with web search
- More references to real-world services/features

---

## Performance Indicators

| Metric | Expected | Good | Slow | Problem |
|--------|----------|------|------|---------|
| Response Time | 3-5s | 2-6s | 6-10s | >10s |
| Content Length | 10KB | 8-15KB | 5-8KB | <5KB |
| Parsing Strategy | Direct | Quote/Array | Object | Failed |
| Dedup Rate | <10% | <20% | 20-50% | >50% |
| Validation Pass | 70-80% | 60-90% | <60% | 0% |

---

## Common Issues & Solutions

### Issue: "Response status: 401 Unauthorized"
**Solution:** Check KIMI_API_KEY in `.env` file

### Issue: "Response status: 429 Too Many Requests"
**Solution:** Wait a minute and retry, or reduce batch size

### Issue: "PARSING FAILED: All strategies exhausted"
**Solution:** Check Kimi API status, response might be error message

### Issue: "All questions rejected by Gemini"
**Solution:** Consider using Kimi for validation too, or adjust question complexity


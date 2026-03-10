# Simplified Validation Prompt — Focused on 2 Critical Aspects

## Summary of Changes

Simplified validation prompt to focus ONLY on two essential checks instead of 8 aggressive criteria.

## What Changed

### Before (Complex, 8-point red-team validation)
- 8 aggressive validation checks
- Tier compliance verification
- Anti-pattern alignment
- Distractor quality analysis
- Service name exactness
- Cognitive level assessment
- Complex tier-aware validation

**Result:** Many false rejections, overly strict, slowed down validation

### After (Simple, 2-point focused validation)
- ✅ **Check 1: Factual Correctness** — Is the question and answer factually correct?
- ✅ **Check 2: Explanation Quality** — Does explanation clearly explain why correct is right AND why incorrect options are wrong?

**Result:** Fast, focused, catches critical issues only

---

## The Two Core Validation Checks

### 1. **FACTUAL CORRECTNESS**
```
- Is the question stem factually correct according to AWS documentation?
- Is the claimed correct answer actually correct?
- Are all options real and plausible?
- Flag any technical inaccuracies, wrong service capabilities, or incorrect behaviors.
```

**Examples of issues caught:**
- ❌ "S3 provides real-time analytics" (S3 stores, doesn't analyze)
- ❌ Correct answer is actually wrong
- ❌ Option claims Lambda can access databases (it can, so not wrong)

### 2. **EXPLANATION QUALITY**
```
- Does the explanation clearly state WHY the correct option is right?
- Does the explanation explain WHY each incorrect option is wrong?
- Is the explanation clear, complete, and accurate?
- No ambiguity or missing reasoning.
```

**Examples of issues caught:**
- ❌ Explanation only says "S3 is correct" without reasoning
- ❌ Doesn't explain why other options fail
- ❌ Explanation contradicts the answer
- ❌ Missing explanation for why an option is wrong

---

## Validation Response (Simplified)

### Before (With tier_compliance)
```json
{
  "is_correct": true/false,
  "correct_answer_index": 1,
  "confidence": "high" | "medium" | "low",
  "validation_notes": "...",
  "factual_errors": [],
  "suggested_explanation": "...",
  "tier_compliance": {
    "stem_length_ok": true/false,
    "cognitive_level_ok": true/false,
    "notes": "..."
  }
}
```

### After (Clean, minimal)
```json
{
  "is_correct": true/false,
  "correct_answer_index": 1,
  "confidence": "high" | "medium" | "low",
  "validation_notes": "Brief assessment. If incorrect, explain what is wrong.",
  "factual_errors": ["List any factual errors, or empty array if none"],
  "suggested_explanation": "Only if explanation needs improvement"
}
```

---

## What Gets Removed (NOT Trivial)

### ❌ No Longer Validated
- Tier compliance (stem length, cognitive level)
- Distractor quality analysis
- Anti-pattern alignment checks
- Service name exactness
- Service behavior accuracy
- Scenario complexity matching
- Adversarial "try to argue for wrong answer" approach

### ✅ These Should Be Handled By
- **Generation phase:** Tier-aware prompt (generation-hub-prompt.ts, generation-mock-prompt.ts)
- **Application layer:** UI/UX can check question types and lengths
- **Human review:** Subject matter experts review for deep quality

---

## Validation Prompt Template

**Before:** 80+ lines of aggressive checks

**After:** Clean, focused template (~25 lines)

```
You are a validator reviewing a [Certification] exam question.
Focus ONLY on these two critical aspects:

QUESTION TO VALIDATE:
Text: [stem]
Type: [mcq|multiple|ordering|matching]
Options: [JSON]
Claimed Correct Answer: [index]
Explanation: [text]

[Type-specific validation preserved]

VALIDATION CHECKLIST — check ONLY these two things:

1. FACTUAL CORRECTNESS:
   - Is question factually correct?
   - Is answer actually correct?
   - Are options real and plausible?
   - Flag any inaccuracies

2. EXPLANATION QUALITY:
   - Does explanation clearly state WHY correct is right?
   - Does explanation explain WHY each wrong option is wrong?
   - Clear, complete, accurate?
```

---

## Key Functions Preserved

✅ **`getTypeSpecificValidation(question)`** — KEPT

This function still provides type-specific validation for:
- **Multiple select:** Verify all claimed correct are correct, all unclaimed are incorrect
- **Ordering:** Verify sequence is correct, no equally valid alternatives
- **Matching:** Verify all pairings are correct, no better pairings exist
- **Single answer (MCQ):** One unambiguous correct answer

---

## Files Modified

| File | Changes |
|------|---------|
| `validation-new.ts` | Simplified prompt, removed tier_compliance from ValidationResponse |
| `validate.ts` | Removed tier_compliance handling logic |

---

## Pass/Fail Criteria (Simplified)

### ✅ PASS
```
is_correct = true
confidence = "high" or "medium"
factual_errors = [] (empty)
```

### ❌ FAIL
```
is_correct = false
confidence = "low"
factual_errors = [non-empty]
```

---

## Impact

### Benefits
- **Faster validation** — Fewer checks, quicker Gemini response
- **Fewer false rejections** — Only catches real problems
- **Clearer feedback** — Two simple checks are easier to understand
- **Lower costs** — Shorter prompts, fewer tokens

### Generation Quality Responsibility
- Generation prompts (hub/mock) now responsible for tier compliance
- Answer index accuracy checked by Gemini during generation
- Explanation quality emphasized during generation

---

## Validation Workflow (Simplified)

```
Generated Question
    ↓
createValidationPrompt() — Simple 2-check template
    ↓
Gemini Flash 2.0
    ↓
ValidationResponse { is_correct, confidence, factual_errors, suggested_explanation }
    ↓
Decision:
    ├─ is_correct=true + confidence≠low  → PASS ✅
    └─ is_correct=false OR confidence=low → FAIL ❌
    ↓
Results: { validated: [], rejected: [] }
```

---

## Example Validation Outputs

### ✅ Passes Validation
```json
{
  "is_correct": true,
  "correct_answer_index": 2,
  "confidence": "high",
  "validation_notes": "Question is factually correct. Explanation clearly states why S3 is correct (durable storage) and why other options fail (DynamoDB is NoSQL, CloudFront is CDN, etc.).",
  "factual_errors": [],
  "suggested_explanation": null
}
```

### ❌ Fails Validation
```json
{
  "is_correct": false,
  "correct_answer_index": 1,
  "confidence": "high",
  "validation_notes": "Factual error: The explanation states 'Lambda has no timeout', but Lambda has a 15-minute timeout. Also, explanation doesn't explain why options C and D are wrong.",
  "factual_errors": [
    "Lambda timeout claim is inaccurate",
    "Explanation missing reasoning for options C and D"
  ],
  "suggested_explanation": "Option B is correct because Lambda can handle real-time events with a 15-minute maximum timeout, making it suitable for processing. Option A (S3) is incorrect because it's a storage service, not for processing. Option C (DynamoDB) is incorrect because it's a database, not a compute service. Option D (SNS) is incorrect because it's for messaging, not processing actual events."
}
```

---

## Summary

**Validation is now simple and focused:**
1. ✅ Is it factually correct?
2. ✅ Is the explanation good?

**Everything else is not trivial** and should be handled by generation prompts or human review.


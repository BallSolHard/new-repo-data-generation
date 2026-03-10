# Validation Prompt Architecture

## Overview

The **validation prompt** is used by a "red team" validator to catch quality issues in generated questions. It's a **separate, conservative Gemini model** (Flash 2.0) that adversarially reviews every generated question.

## File Location & Usage

### Validation Prompt File
**File:** `src/lib/prompts/validation-new.ts`

**Function:** `createValidationPrompt(params: ValidationPromptParams): string`

**Exported from:** `src/lib/prompts/index.ts`

### Called From
**File:** `src/lib/pipeline/validate.ts`

**Function:** `validate(questions, options)`

**Flow:**
```
Pipeline → validate() → validateSingleQuestion()
    ↓
    Creates validation prompt via createValidationPrompt()
    ↓
    Sends to Gemini Flash 2.0 (validation model)
    ↓
    Parses ValidationResponse
    ↓
    Returns: { validated: [], rejected: [] }
```

---

## What Gets Validated

### Input Parameters
```typescript
interface ValidationPromptParams {
  question: GeneratedQuestion;           // The question to validate
  certificationName: string;             // e.g., "AWS Solutions Architect"
  certTier: CertTier;                   // 'foundational' | 'associate' | 'professional' | 'specialty'
  domainContext?: ExamDomain;           // Service scope, anti-patterns
  targetTask?: ExamTask;                // Specific task focus (optional)
}
```

### Output Response
```typescript
interface ValidationResponse {
  is_correct: boolean;                   // Pass/fail verdict
  correct_answer_index: string | number[] | object;  // Validated answer
  confidence: 'high' | 'medium' | 'low'; // Confidence level
  validation_notes: string;              // Explanation of verdict
  factual_errors?: string[];             // Any errors found
  suggested_explanation?: string;        // Corrected explanation if needed
  tier_compliance: {
    stem_length_ok: boolean;             // Word count check
    cognitive_level_ok: boolean;         // Tier-appropriate level check
    notes: string;                       // Compliance notes
  };
}
```

---

## Validation Checklist (8 Points)

The validation prompt aggressively checks **all of these:**

### 1. **Factual Accuracy**
- Every fact in question, options, and explanation is technically correct
- AWS service names and behaviors are accurate
- Uses current AWS documentation

### 2. **Correct Answer Verification**
- Claimed correct answer is truly the BEST answer
- Validator actively tries to argue for each distractor
- If any distractor can be reasonably defended, question is ambiguous → REJECTED

### 3. **Distractor Quality**
- All wrong answers are plausible but clearly incorrect
- Distractors represent known anti-patterns
- Questions should have at least one distractor matching a known misconception

### 4. **Anti-Pattern Alignment**
- Do distractors embody realistic misconceptions?
- Reference anti-patterns from domain context
- Realistic mistakes, not obviously wrong answers

### 5. **Explanation Accuracy**
- Explanation correctly describes why answer is right
- Explains why each wrong answer is wrong
- Nothing misleading or incomplete

### 6. **Service Names**
- Exact AWS service names (e.g., "Amazon S3" not "AWS S3")
- Current service naming conventions
- No deprecated names

### 7. **Service Behavior**
- Described behaviors, limits, and characteristics are accurate
- Current AWS documentation validation
- Feature availability and limitations correct

### 8. **Tier Compliance**
- Stem length within `${tierProfile.stemWordRange[0]}-${tierProfile.stemWordRange[1]}` words
- Cognitive level appropriate for tier
- Scenario complexity matches tier profile

---

## Validation Flow (Detailed)

```
Generated Question
    ↓
validate() in pipeline/validate.ts (line 25)
    ↓
Batch processing (5 questions at a time)
    ↓
validateSingleQuestion() (line 88)
    ↓
createValidationPrompt() ← CREATES VALIDATION PROMPT
    ↓
Gemini Flash 2.0 Model (conservative, temp=0.3)
    ↓
Parsing ValidationResponse JSON
    ↓
Decision:
    ├─ is_correct = true + confidence = high  → VALIDATED (passed)
    ├─ is_correct = false                     → REJECTED
    ├─ is_correct = true + confidence = low   → REJECTED (if rejectLowConfidence=true)
    └─ Parse error                            → REJECTED
    ↓
Results:
    ├─ validated: GeneratedQuestion[]  → Pass quality gates
    └─ rejected: GeneratedQuestion[]   → Failed validation
```

---

## Validation Models Used

### Generation Model (Gemini Pro 1.5)
- **Used for:** Creating questions
- **Temperature:** 0.7 (creative)
- **File:** `src/lib/gemini/client.ts` → `getGenerationModel()`

### Validation Model (Gemini Flash 2.0)
- **Used for:** Red-team reviewing questions
- **Temperature:** 0.3 (conservative, less creative)
- **File:** `src/lib/gemini/client.ts` → `getValidationModel()`
- **Reason for separate model:** Conservative validation catches more errors

---

## Validation Prompt Structure

### Header (Adversarial Context)
```
You are a HOSTILE adversarial reviewer performing red-team quality assurance
on a [Certification] exam question. Assume the question is WRONG until you 
prove otherwise. Your job is to find every possible flaw.
```

### Tier Requirements
```
TIER COMPLIANCE REQUIREMENTS:
- Stem length must be [stemLength] ([min]-[max] words)
- Cognitive level must be: [cognitiveLevel]
- Service interaction: [serviceInteraction]
- Distractor strategy: [distractorStrategy]
```

### Question Details
```
QUESTION TO VALIDATE:
Text: [question stem]
Type: [mcq|multiple|ordering|matching]
Options: [JSON array of options]
Claimed Correct Answer: [answer index]
Explanation: [explanation text]
```

### Question Type Specifics
```
If MULTIPLE SELECT:
  - Verify ALL claimed correct options are correct
  - Verify ALL unclaimed options are incorrect
  
If ORDERING:
  - Verify sequence is correct
  - Check no equally valid alternative exists
  
If MATCHING:
  - Verify every pairing is correct
  - No better pairings exist
  
If SINGLE ANSWER (MCQ):
  - One unambiguous correct answer
  - No ambiguity with other options
```

### Validation Checklist
Eight aggressive checks (see above)

### Response Format
```json
{
  "is_correct": true/false,
  "correct_answer_index": 1,
  "confidence": "high" | "medium" | "low",
  "validation_notes": "Detailed explanation...",
  "factual_errors": ["error1", "error2"],
  "suggested_explanation": "If errors found...",
  "tier_compliance": {
    "stem_length_ok": true/false,
    "cognitive_level_ok": true/false,
    "notes": "Assessment..."
  }
}
```

---

## Key Characteristics

### Adversarial Tone
- **Assumes guilty until proven innocent**
- Actively tries to find flaws
- Tries to argue for distractor answers
- Aggressive on every checklist item

### Conservative Validation
- Uses lower temperature (0.3) vs generation (0.7)
- Separate model instance (Flash 2.0)
- Processes 5 at a time to avoid rate limits
- Explicit fallback behavior on parse errors

### Tier-Aware
- Extracts tier profile based on `certTier` parameter
- Validates against tier-specific word range
- Checks cognitive level appropriateness
- Ensures scenario complexity matches tier

### Anti-Pattern Integration
- References known misconceptions from domain context
- Validates distractors embody realistic errors
- Checks anti-pattern IDs in distractor explanations

---

## Validation Outcomes

### PASS Criteria
```
is_correct = true
confidence = "high"
tier_compliance.stem_length_ok = true
tier_compliance.cognitive_level_ok = true
```
→ Question added to `validated` array

### FAIL Criteria (Any of)
```
is_correct = false
confidence = "low" (if rejectLowConfidence=true)
Parsing error
```
→ Question added to `rejected` array

---

## Related Files

| File | Purpose |
|------|---------|
| `validation-new.ts` | **Validation prompt builder** |
| `validate.ts` | Orchestrates validation pipeline |
| `pipeline/index.ts` | Main pipeline (validation step 3) |
| `gemini/client.ts` | Provides validation model instance |
| `types/generation.ts` | ValidationResponse type |
| `tier-profiles.ts` | Tier compliance standards |

---

## Integration with Pipeline

```
runGenerationPipeline()
    ↓
Step 1: ingest()  — Load exam guide, domain context
Step 2: generate() — Create questions
Step 3: validate() ← VALIDATION PROMPT USED HERE
        ↓
        validate(rawQuestions, { certificationName, tier, domainContext })
        ↓
        For each question:
            createValidationPrompt() ← BUILDS VALIDATION PROMPT
            ↓
            Red-team review via Gemini Flash 2.0
            ↓
            Returns: { validated, rejected }
Step 4: output()  — Build SQL for validated questions
```

---

## Testing & Configuration

### Batch Processing
- **Batch size:** 5 questions (to avoid Gemini rate limits)
- **Parallelization:** Uses `Promise.allSettled()` for robustness
- **Error handling:** Parse errors don't crash entire batch

### Configuration Options
```typescript
interface ValidateOptions {
  certificationName: string;              // Required
  domainContext?: ExamDomain;             // For anti-patterns
  rejectLowConfidence?: boolean;          // Default: true
  certTier?: CertTier;                   // Default: 'associate'
}
```

### Rejection Logic
```typescript
if (rejectLowConfidence && (
  validation.confidence === 'low' || 
  !validation.is_correct
)) {
  rejected.push(question);  // Reject on low confidence OR incorrect
}
```

---

## Summary

**Validation Prompt = Red-Team Adversarial Review**

- **File:** `validation-new.ts`
- **Used by:** `pipeline/validate.ts`
- **Model:** Gemini Flash 2.0 (conservative, temp=0.3)
- **Purpose:** Find quality issues in generated questions
- **Checks:** 8-point aggressive checklist
- **Outcome:** Pass/fail with confidence and tier compliance verification


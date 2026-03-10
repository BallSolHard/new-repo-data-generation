# stemLength vs stemWordRange — Comprehensive Guide

## Quick Definition

| Property | Purpose | Format | Example |
|----------|---------|--------|---------|
| **`stemLength`** | Human-readable description of question stem | Sentence count | `"3-4 sentences"` |
| **`stemWordRange`** | Machine-enforced word count limits | `[min, max]` array | `[60, 120]` |

---

## Detailed Breakdown

### 1. `stemLength` — Documentation String

**What it is:**
- A human-readable **description** of how many sentences a question stem should contain
- Used in **prompts** and **validation messages** to help Gemini and validators understand tier expectations
- Purely **informational** — not validated programmatically

**Where it's used:**
```typescript
// In generation-new.ts — injected into prompt for Gemini
STEM LENGTH: ${tier.stemLength} (${tier.stemWordRange[0]}-${tier.stemWordRange[1]} words)

// In validation-new.ts — validation checklist for human readability
- Stem length must be ${tierProfile.stemLength} (${tierProfile.stemWordRange[0]}-${tierProfile.stemWordRange[1]} words)
```

**Tier examples:**
```
foundational:  "1-2 sentences"    → Quick, direct questions
associate:     "3-4 sentences"    → Scenario with context
professional:  "5-8 sentences"    → Complex enterprise scenarios
specialty:     "2-4 sentences"    → Deep technical detail (shorter but specific)
```

**Why it matters:**
- Guides **Gemini** on how to structure question stems
- Provides **context** in validation reports
- Helps **humans** understand tier-specific conventions

---

### 2. `stemWordRange` — Hard Constraint

**What it is:**
- A **numeric range** `[min, max]` that enforces exact word count limits
- Used to **validate** generated questions programmatically
- Can be **extracted and used** directly in generation/validation logic

**Where it's used:**

#### A. In `generation-mock-prompt.ts` (STRICT enforcement)
```typescript
const wordMin = tierProfile.stemWordRange[0];  // Extract min
const wordMax = tierProfile.stemWordRange[1];  // Extract max

// Injected into prompt:
STEM LENGTH — STRICTLY ENFORCED: Every stem MUST be ${wordMin}-${wordMax} words
  ✅ REQUIRED: ${wordMin}-${wordMax} word stems (realistic exam length)
  ❌ REJECTED: Shorter than ${wordMin} words or longer than ${wordMax} words
```

#### B. In `generation-hub-prompt.ts` (FLEXIBLE)
```typescript
// Hub mode overrides minimum to 10 words (loose practice mode)
STEM LENGTH — FLEXIBLE: Minimum 10 words, maximum ${tierProfile.stemWordRange[1]} words
```

#### C. In `validation-new.ts` (Validation checker)
```typescript
// Validation checklist
8. TIER COMPLIANCE: Does the stem length fall within 
   ${tierProfile.stemWordRange[0]}-${tierProfile.stemWordRange[1]} words?
```

**Tier examples:**
```
foundational:  [15, 40]      → Short, definition-based questions
associate:     [60, 120]     → Standard scenario questions
professional:  [100, 200]    → Long, complex enterprise scenarios
specialty:     [40, 100]     → Medium, deep technical specificity
```

---

## Real-World Usage Examples

### Example 1: Associate Tier Question

**Tier profile:**
```typescript
associate: {
  stemLength: '3-4 sentences',
  stemWordRange: [60, 120],
  // ...
}
```

**In generation prompt (injected):**
```
STEM LENGTH: 3-4 sentences (60-120 words)
COGNITIVE LEVEL: application and analysis
```

**Generated question stem (55 words):**
```
"A company stores sensitive data in S3 buckets accessed by developers across multiple regions.
They need encryption at rest with customer-managed keys and automated rotation every 90 days.
Which approach provides this capability with LEAST operational overhead?"
```

**Validation result:**
```
❌ REJECTED: Stem is 55 words, but required range is [60, 120] words for associate tier
```

---

### Example 2: Professional Tier Question

**Tier profile:**
```typescript
professional: {
  stemLength: '5-8 sentences',
  stemWordRange: [100, 200],
  // ...
}
```

**In generation prompt (injected):**
```
STEM LENGTH: 5-8 sentences (100-200 words)
COGNITIVE LEVEL: evaluation and synthesis
```

**Generated question stem (145 words):**
```
"A multinational financial services company with operations in North America, Europe, and Asia
operates across three AWS accounts (production, staging, development). They process terabytes of
transaction data daily and must comply with multiple regional regulations including GDPR, HIPAA,
and local data residency requirements. Their infrastructure spans multiple regions for disaster
recovery and low-latency access. Currently, they encrypt sensitive data with their own KMS keys
managed centrally, but this creates operational overhead and compliance audit complexity. They need
a strategy that: 1) Centralizes encryption key management, 2) Meets regional compliance requirements,
3) Minimizes operational overhead, and 4) Enables cross-account access patterns for disaster recovery.
Which multi-account architecture best addresses these conflicting requirements?"
```

**Validation result:**
```
✅ ACCEPTED: Stem is 145 words, within [100, 200] range for professional tier
```

---

## How They Work Together

```
┌─────────────────────────────────────────────────────────────┐
│ TIER PROFILE in tier-profiles.ts                            │
├─────────────────────────────────────────────────────────────┤
│ stemLength: "3-4 sentences"     ← Human-readable            │
│ stemWordRange: [60, 120]        ← Machine-enforced          │
└─────────────────────────────────────────────────────────────┘
           │
           ├──────────────────────┬─────────────────────┐
           │                      │                     │
      GENERATION             VALIDATION            DOCUMENTATION
           │                      │                     │
           ▼                      ▼                     ▼
    
    Prompt injection:      Validation check:    User message:
    "Stems should be       "Verify stem is      "Expected 3-4
     3-4 sentences         within [60, 120]     sentences,
     (60-120 words)"       words"              60-120 words"
```

---

## Key Differences

| Aspect | `stemLength` | `stemWordRange` |
|--------|-------------|-----------------|
| **Data Type** | String | `[number, number]` array |
| **Purpose** | Human guidance | Machine validation |
| **Enforced?** | No (informational) | **Yes** (programmatically checked) |
| **Used in Prompts** | ✅ Yes (Gemini instruction) | ✅ Yes (word count constraint) |
| **Used in Validation** | ✅ Yes (readable output) | ✅ Yes (hard check) |
| **Example Value** | `"5-8 sentences"` | `[100, 200]` |
| **Flexibility** | Loose (guide) | Strict (enforced) |

---

## Code Locations

| File | Line | Usage |
|------|------|-------|
| `tier-profiles.ts` | Lines 8-45 | **Definition** — Tier profiles with both properties |
| `types/tier.ts` | Lines 8-9 | **Type definition** — TierProfile interface |
| `generation-new.ts` | Line 197 | **Prompt injection** — Builds tierBlock with both |
| `generation-hub-prompt.ts` | Line 85 | **Hub generation** — Uses stemWordRange[1] (max) |
| `generation-mock-prompt.ts` | Lines 42-43 | **Mock generation** — Extracts and enforces both |
| `validation-new.ts` | Lines 61, 91 | **Validation** — Checks both in validation prompt |

---

## Flow Example: Hub vs Mock Generation

### Hub Mode (Practice — Flexible)
```typescript
// generation-hub-prompt.ts
stemWordRange[0] = 10   (overridden: "10-120" instead of tier minimum)
stemWordRange[1] = 120  (from tier profile: max stays same)

// Applied in prompt:
"STEM LENGTH — FLEXIBLE: Minimum 10 words, maximum 120 words"

// Result: Questions can be shorter (10-30 words for definitions)
```

### Mock Mode (Exam — Strict)
```typescript
// generation-mock-prompt.ts
wordMin = stemWordRange[0]  (60 for associate)
wordMax = stemWordRange[1]  (120 for associate)

// Applied in prompt:
"STEM LENGTH — STRICTLY ENFORCED: Every stem MUST be 60-120 words"

// Result: Questions enforced to exact tier range
```

---

## Summary

**`stemLength`** = Descriptive label for Gemini and documentation
- "How many sentences should this look like?"
- Human-readable
- Used in prompts and messages

**`stemWordRange`** = Numeric constraint for enforcement
- [min, max] word count
- Machine-validated
- Used in generation and validation logic

Together they ensure questions are **appropriately sized for their tier** while providing **clear guidance** to both Gemini (during generation) and validators (during verification).


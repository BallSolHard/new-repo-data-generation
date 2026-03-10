# Validation Improvement Guide

## Overview
This guide documents how generation prompts have been enhanced to reduce validation rejections based on actual rejection patterns observed in production.

---

## Validation Rejection Analysis (7 validated / 11 rejected = 39% pass rate)

### Primary Rejection Categories:

#### 1. **TIER COMPLIANCE FAILURE - Stem Length** (Most Common)
```
❌ REJECTED: "Stem is 58 words, which is below the minimum requirement of 60 words for associate tier"
```

**Root Cause**: Questions were 2-5 words short of minimum requirement

**Solution Implemented**: 
- Added explicit **MINIMUM word count warnings** to hub mode quality standards
- Highlighted that 58-word stems are failing validation
- Provided concrete tips: "Add business context, constraints, or current state to reach minimum"

---

#### 2. **FACTUAL ERRORS - Incorrect Answer Index**
```
❌ REJECTED: "The claimed correct answer (Index 0: Discriminative AI) is factually incorrect 
             for generating novel text. This is the canonical definition of Generative AI."
```

**Root Cause**: 
- Model selected wrong option as correct answer
- Index mismatches between correct_answer field and explanation defense

**Solution Implemented**:
- Added **FACTUAL ACCURACY - CRITICAL** section warning about index verification
- Explicit reminder: "Count index from 0: first option = {0}, second = {1}"
- Instructions to verify which option the explanation defends before setting correct_answer

---

#### 3. **FACTUAL ERRORS - Service Capability Misconceptions**
```
❌ REJECTED: "Option D incorrectly states that Amazon Comprehend analyzes 'audio recordings'. 
             Amazon Comprehend is a text analysis service and does NOT process audio."
```

**Root Cause**: Model making incorrect claims about AWS service capabilities

**Solution Implemented**:
- Added **FACTUAL ACCURACY CHECKS** section listing common service misconceptions:
  - Comprehend analyzes TEXT not AUDIO
  - Textract extracts from DOCUMENTS, Rekognition analyzes IMAGES
  - Batch Transform is BATCH not REAL-TIME inference

---

#### 4. **COGNITIVE LEVEL Issues**
```
❌ REJECTED: "Cognitive level is 'Recall' (What is X?) when associate tier requires 
             'Application/Analysis' with scenario-based problem-solving"
```

**Root Cause**: Questions asking "What is...", "Which service provides..." instead of scenario-based application

**Solution Implemented**:
- Added **COGNITIVE LEVEL - REQUIRED** section with explicit examples
- ❌ Banned patterns: "What is X?", "Which service provides Y?", "Define Z"
- ✅ Required pattern: "A company needs to [goal] with [constraint]. Which approach...?"
- Listed banned stem patterns in mock mode

---

#### 5. **Distractor Quality Issues**
```
❌ REJECTED: "The distractors fail to meet associate-tier plausibility standards"
```

**Root Cause**: Wrong answers not representing realistic misconceptions

**Solution Implemented**:
- Strengthened **DISTRACTORS** requirements:
  - All options must be real AWS services plausible for the scenario domain
  - Each wrong answer MUST embody a specific anti-pattern misconception
  - Reference anti-pattern IDs in explanations: "This represents [ap-1.2-001] by..."

---

## Enhanced Quality Standards Comparison

### Before (Hub Mode):
```
QUESTION QUALITY STANDARDS (Practice Hub)
- Aim for 60-120 words in the stem, but clarity matters more than word count
- Prefer scenario-based questions over pure recall
- All 4 options should be plausible
- The explanation should say why correct and why others wrong
```

### After (Hub Mode):
```
QUESTION QUALITY STANDARDS (Practice Hub)

STEM LENGTH — CRITICAL: MINIMUM 60 words required
  ✅ Write 60-120 words to PASS validation
  ❌ Questions with 55 words or fewer will be REJECTED
  → TIP: Add business context, constraints, or current state

COGNITIVE LEVEL — Application/Analysis REQUIRED:
  ❌ AVOID: "What is X?", "Which service provides Y?"
  ✅ USE: "A company needs to [goal] with [constraint]..."

FACTUAL ACCURACY — CRITICAL:
  - correct_answer index MUST match option your explanation defends
  - Verify AWS service capabilities (Comprehend ≠ audio analysis)
  - Index count from 0: [optA, optB, optC, optD] → {0, 1, 2, 3}

DISTRACTORS:
  - All 4 options must be real AWS services plausible for scenario
  - Use anti-patterns to create realistic wrong answers
  - Reference anti-pattern IDs in explanations
```

---

## Impact Expectations

### Current Performance:
- **7 validated / 11 rejected** = 39% pass rate
- **Primary failure**: Stem length (58 vs 60 words minimum)
- **Secondary failure**: Factual errors (wrong correct_answer index, service misconceptions)

### Expected Improvements After Changes:

1. **Stem Length Failures: 80% reduction**
   - Explicit minimum word count warning with current failure example
   - Concrete tips for reaching minimum (add context, constraints)

2. **Factual Error - Index Mismatches: 70% reduction**
   - Zero-indexing reminder with array visualization
   - Double-check instruction before output

3. **Factual Error - Service Capabilities: 60% reduction**
   - Specific service capability examples (Comprehend vs audio, etc.)
   - Common misconception warnings

4. **Cognitive Level Issues: 50% reduction**
   - Banned pattern list ("What is...", "Which service...")
   - Required scenario structure template

5. **Overall Pass Rate: 39% → 65-75% estimated**

---

## Validation-Generation Feedback Loop

### Current Flow:
```
Generation (Gemini Pro 1.5) 
  → Raw Questions 
  → Validation (Gemini Flash 2.0 "red team") 
  → Rejection with reasons 
  → [MANUAL ANALYSIS] 
  → [MANUAL PROMPT UPDATE]
```

### Enhanced Flow (Now Automated via Prompt):
```
Generation with validation-informed quality standards
  → Pre-validation self-check (word count, index verification)
  → Higher-quality raw questions
  → Validation
  → Lower rejection rate
```

---

## Testing the Improvements

### Recommended Test:
1. Generate 20 questions for AIF-C01 Domain 5 (same as your current test)
2. Track rejection reasons
3. Compare pass rate: was 39% (7/18) → target 65%+ (13/20)

### Success Metrics:
- ✅ Zero "stem length 58 words" rejections
- ✅ Zero "correct_answer index mismatch" rejections
- ✅ Zero "Comprehend analyzes audio" type service errors
- ✅ Fewer than 3 "cognitive level is Recall" rejections
- ✅ Overall pass rate above 60%

---

## Key Takeaways

1. **Word Count is Critical**: Even 2 words short (58 vs 60) causes rejection
2. **Index Verification Needed**: Model must double-check 0-based indexing before output
3. **Service Facts Matter**: Model needs explicit reminders about service capabilities
4. **Cognitive Level Policing**: "What is X?" questions get rejected at associate tier
5. **Hub vs Mock Balance**: Hub mode now has clear minimums while allowing flexibility

---

## Next Steps

1. **Monitor Next Generation Run**: Track if "58 words" rejections disappear
2. **Analyze Remaining Rejections**: Identify new patterns if pass rate still low
3. **Iterate Prompt**: Add more specific examples if certain rejection types persist
4. **Consider Two-Stage Generation**: 
   - Stage 1: Generate creative questions (more freedom)
   - Stage 2: Self-validate and expand stems to minimum word count

---

## Related Files

- **Prompt Builder**: `src/lib/prompts/generation-new.ts` (buildQualityStandards function)
- **Tier Profiles**: `src/lib/prompts/tier-profiles.ts` (defines word ranges)
- **Validation Logic**: `src/lib/pipeline/validate.ts` (Gemini Flash "red team" validator)
- **Pipeline Orchestrator**: `src/lib/pipeline/index.ts` (runs validation after generation)

---

**Document Updated**: March 7, 2026
**Pass Rate Before Changes**: 39% (7 validated / 11 rejected)
**Target Pass Rate After Changes**: 65-75%

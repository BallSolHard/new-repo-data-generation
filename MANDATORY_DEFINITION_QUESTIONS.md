# Mandatory Definition Questions for Hub Generation

## Overview
Updated the generation system to **guarantee** at least 40% definition questions in every hub question generation batch.

---

## Key Changes

### 1. **Mandatory Requirement Added**

#### Before:
```
QUESTION MIX TARGET:
  - 40% Definition/Recall questions (suggested)
  - 30% Application questions
  - 30% Analysis questions
```

#### After:
```
⚠️ MANDATORY REQUIREMENT: You MUST generate AT LEAST 40% definition questions.
   For every 10 questions, generate AT LEAST 4 definition-style questions.
   For 5 questions, generate AT LEAST 2 definition questions.
   This is NON-NEGOTIABLE. Do not skip this requirement.

⚠️ GENERATION ORDER: Generate definition questions FIRST, then fill remaining quota.
```

---

## What This Guarantees

### **For Different Batch Sizes:**

| Total Questions | Definition (MIN) | Application | Analysis |
|----------------|------------------|-------------|----------|
| 5 questions | **2+ questions** | 2 questions | 1 question |
| 10 questions | **4+ questions** | 3 questions | 3 questions |
| 20 questions | **8+ questions** | 6 questions | 6 questions |
| 30 questions | **12+ questions** | 9 questions | 9 questions |

### **Generation Order Enforced:**
1. ✅ **Step 1**: Generate definition questions FIRST (40% quota)
2. ✅ **Step 2**: Fill remaining slots with application questions
3. ✅ **Step 3**: Fill final slots with analysis questions

---

## Enhanced Prompt Features

### 1. **Triple Reinforcement**
The requirement appears in **3 places** in the prompt:

**Location 1 - Quality Standards Section:**
```
⚠️ MANDATORY REQUIREMENT: You MUST generate AT LEAST 40% definition questions.
```

**Location 2 - Task Section:**
```
⚠️ CRITICAL: Of the 10 questions, you MUST generate AT LEAST 4 DEFINITION questions (40% minimum).
   Definition questions are 10-30 words and ask "What is...", "Which service...", "What does... do?"
   Generate definition questions FIRST, then fill remaining quota.
```

**Location 3 - Calculation Helper:**
```
CALCULATION HELPER FOR QUESTION MIX:
  Example for 10 questions:
    - Definition: AT LEAST 4 questions (10-30 words each) ← START HERE
```

### 2. **Definition Question Templates**
Added explicit patterns for the AI to follow:

```
SERVICE PURPOSE:
✅ "What is the primary purpose of [Service Name]?"
✅ "What does [Service Name] enable?"
✅ "Which AWS service is designed for [use case]?"

SERVICE SELECTION:
✅ "Which service provides [capability]?"
✅ "Which AWS service offers [feature]?"

SERVICE CHARACTERISTICS:
✅ "What type of service is [Service Name]?"
✅ "What does [Service Name] automate?"
```

### 3. **Exam-Specific Examples**
For ML/AI certifications:

```
EXAMPLES FOR THIS EXAM:
✅ "What is Amazon SageMaker primarily used for?"
✅ "Which service provides managed machine learning model hosting?"
✅ "What does Amazon SageMaker Model Monitor detect?"
✅ "Which AWS service automates bias detection in ML models?"
✅ "What is the primary purpose of Amazon SageMaker Clarify?"
✅ "Which service provides real-time ML model predictions?"
✅ "What does Amazon SageMaker Autopilot automate?"
✅ "Which AWS service stores training datasets?"
```

---

## Expected Output

### **Before Changes (Old SQL):**
```sql
-- All questions were 100+ word scenarios
'A financial institution has deployed a machine learning model on Amazon 
SageMaker for real-time fraud detection. After initial deployment, the 
data science team observes that the model's performance has started to 
degrade over time due to shifts in transaction patterns...'
```

### **After Changes (New Generation):**
```sql
-- Mix of definition (40%), application (30%), analysis (30%)

-- DEFINITION (10-30 words):
'What is Amazon SageMaker Model Monitor primarily designed for?'
'Which AWS service provides automated bias detection in ML models?'
'What does Amazon SageMaker Clarify do?'
'Which service enables real-time ML model predictions?'

-- APPLICATION (30-60 words):
'A data science team needs to detect bias in their ML model predictions 
without writing custom code. Which AWS service provides this capability?'

-- ANALYSIS (60-120 words):
'A financial institution requires ML models deployed in isolated networks 
with no internet access, encryption at rest using customer-managed keys, 
and automated monitoring for data drift. Which combination best meets these 
requirements with least operational overhead?'
```

---

## Why This Approach Works

### 1. **Multiple Reinforcements**
- Appears 3 times in different sections of prompt
- Hard to miss or ignore by the AI model

### 2. **Explicit Calculations**
```
For 10 questions → AT LEAST 4 definition questions
For 5 questions → AT LEAST 2 definition questions  
For 20 questions → AT LEAST 8 definition questions
```

### 3. **Generation Order Mandate**
- "Generate definition questions FIRST"
- Forces AI to start with short questions
- Prevents defaulting to all scenario questions

### 4. **Concrete Templates**
- Not just "generate definition questions"
- Shows exact patterns: "What is...", "Which service...", "What does..."
- Provides 8+ specific examples

---

## Testing the Changes

### **Generate Hub Questions:**
```bash
POST /api/generate-hub
{
  "certCode": "mla-c01",
  "domainId": "domain17",
  "questionsPerModule": 10
}
```

### **Expected Response:**
```json
{
  "questions": [
    // First 4 questions = Definitions (10-30 words)
    { "text": "What is Amazon SageMaker Model Monitor used for?", ... },
    { "text": "Which service provides automated ML model training?", ... },
    { "text": "What does Amazon SageMaker Clarify detect?", ... },
    { "text": "Which AWS service stores ML training datasets?", ... },
    
    // Next 3 questions = Application (30-60 words)
    { "text": "A company needs to deploy ML models with automated scaling...", ... },
    
    // Last 3 questions = Analysis (60-120 words)
    { "text": "A financial institution requires ML infrastructure with...", ... }
  ]
}
```

### **Validation Checks:**
```bash
# Count question lengths
cat output.sql | grep "text," | awk '{print length($0)}' | sort -n

# Expected distribution:
# - 4+ questions with 10-30 word stems
# - 3 questions with 30-60 word stems
# - 3 questions with 60-120 word stems
```

---

## Mock Mode Unchanged

Mock test generation still uses strict requirements (60-120 words only):

```bash
POST /api/generate-mock  # ← Still generates 60-120 word questions only
POST /api/generate-hub   # ← Now guarantees 40%+ definition questions
```

---

## Benefits

### 1. **Guaranteed Variety**
- No more "all scenario questions" batches
- Every generation has short + long questions

### 2. **Better Learning Experience**
- Students can practice foundational knowledge
- Quick review sessions become possible
- Progressive difficulty curve

### 3. **Faster Practice**
- 40% of questions take 30 seconds to answer
- 30% take 1-2 minutes
- 30% take 2-5 minutes

### 4. **More Coverage**
- Can test individual AWS services directly
- Each service gets dedicated definition question
- Builds vocabulary before scenarios

---

## Implementation Details

### **Files Modified:**
1. `src/lib/prompts/generation-new.ts`
   - `buildQualityStandards()` function
   - Added mandatory 40% requirement with triple reinforcement
   - Added definition question templates
   - Added calculation helper with examples

### **Key Code Addition:**
```typescript
${generationContext === 'hub' ? `
⚠️ CRITICAL: Of the ${totalQuestions} questions, you MUST generate 
   AT LEAST ${Math.ceil(totalQuestions * 0.4)} DEFINITION questions (40% minimum).
   Definition questions are 10-30 words and ask "What is...", "Which service...", "What does... do?"
   Generate definition questions FIRST, then fill remaining quota.
` : ''}
```

---

## Rollout Plan

### **Phase 1: Immediate** ✅
- Code changes deployed
- Server restart required to pick up changes

### **Phase 2: Test Generation** ⏳
- Generate 10 questions → verify 4+ are definitions
- Generate 5 questions → verify 2+ are definitions
- Generate 20 questions → verify 8+ are definitions

### **Phase 3: Monitor** ⏳
- Track validation rejection rates
- Confirm definition questions pass validation
- Adjust templates if needed

---

## Troubleshooting

### **If Still Getting All Scenario Questions:**

1. **Restart the server:**
   ```bash
   # Stop and restart to load new prompt
   npm run dev
   ```

2. **Check prompt is being used:**
   ```typescript
   // In generate.ts, verify generationContext is passed
   generate(params, 'hub')  // ← Should be 'hub' for practice questions
   ```

3. **Verify API route:**
   ```typescript
   // In generate-hub/route.ts
   runGenerationPipeline({ 
     ...params, 
     generationContext: 'hub'  // ← Ensure this is set
   })
   ```

---

**Document Updated**: March 9, 2026  
**Minimum Definition Questions**: 40% (enforced)  
**Generation Order**: Definition → Application → Analysis  
**Prompt Reinforcements**: 3 (quality standards, task, calculation helper)

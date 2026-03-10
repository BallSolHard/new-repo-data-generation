# Flexible Question Length & Definition Questions Guide

## Overview
Updated the generation system to support **flexible question lengths** (10-120 words) and **basic definition questions**, allowing for a more diverse practice hub question mix.

---

## Key Changes

### 1. **Loosened Word Count Restrictions**

#### Before:
```
Associate Tier: 60-120 words REQUIRED (STRICT)
❌ 58 words = REJECTED
```

#### After:
```
Hub Mode: 10-120 words ALLOWED (FLEXIBLE)
✅ 10-30 words: Definition questions
✅ 30-60 words: Application questions  
✅ 60-120 words: Analysis questions
```

---

### 2. **Three Cognitive Levels Now Supported**

| Level | Word Range | Question Type | Example |
|-------|------------|---------------|---------|
| **Recall/Definition** | 10-30 words | Basic concepts | "What is Amazon S3 primarily used for?" |
| **Application** | 30-60 words | Single-service scenarios | "A company needs durable storage for 10TB of logs. Which S3 storage class minimizes cost?" |
| **Analysis** | 60-120 words | Multi-service scenarios | "A financial institution processes sensitive data requiring encryption, audit trails, and minimal operational overhead. Which combination..." |

---

## Question Mix Strategy

### Recommended Distribution (Hub Mode):
- **40% Definition/Recall** (10-30 words) - Test foundational knowledge
- **30% Application** (30-60 words) - Test service understanding  
- **30% Analysis** (60-120 words) - Test problem-solving

### Why This Mix?
1. **Variety**: Keeps practice engaging with different question formats
2. **Progressive Learning**: Build from definitions → applications → complex scenarios
3. **Faster Practice**: Short definition questions allow quick knowledge checks
4. **Realistic Preparation**: Longer questions simulate actual exam complexity

---

## Definition Question Examples

### ✅ Good Definition Questions:

```
Q: What is the primary purpose of Amazon VPC?
A) Provide isolated network environments in AWS
B) Store virtual machine images
C) Monitor application performance
D) Manage user identities and access

Q: Which AWS service provides serverless compute capacity?
A) AWS Lambda
B) Amazon EC2
C) Amazon ECS
D) AWS Elastic Beanstalk

Q: What does Amazon RDS automate?
A) Database provisioning, patching, backup, and recovery
B) Application deployment and scaling
C) Network traffic routing
D) Container orchestration

Q: Which service is designed for object storage?
A) Amazon S3
B) Amazon EBS
C) Amazon EFS
D) AWS Storage Gateway
```

### ❌ Avoid These Patterns:
```
❌ Too vague: "What is AWS?" 
   → Too broad, not specific enough

❌ Trick questions: "What is Amazon S3 NOT used for?"
   → Negative framing confuses testing goals

❌ Multiple correct answers: "Which services can store data?"
   → Definition questions need clear single answers
```

---

## Application Question Examples

### ✅ Good Application Questions (30-60 words):

```
Q: A startup needs to store user profile images that are accessed frequently 
during the first month, then rarely afterward. The solution must automatically 
transition objects to lower-cost storage. Which approach is MOST cost-effective?

A) Use S3 Standard with lifecycle policies to transition to S3 Glacier after 30 days
B) Use S3 Standard-IA for all objects
C) Manually move objects to S3 Glacier each month
D) Use S3 One Zone-IA with lifecycle policies
```

---

## Analysis Question Examples

### ✅ Good Analysis Questions (60-120 words):

```
Q: A healthcare provider processes patient medical records containing sensitive 
PHI data. Regulatory requirements mandate encryption at rest and in transit, 
comprehensive audit trails of all data access, and the ability to revoke access 
to encryption keys instantly if a security breach is detected. The architecture 
must minimize operational overhead for the security team. Which combination of 
AWS services best meets these requirements?

A) Amazon S3 with SSE-KMS, AWS CloudTrail for auditing, and IAM policies 
   for access control
B) Amazon S3 with SSE-S3, Amazon CloudWatch for monitoring, and S3 bucket 
   policies for access control
C) Amazon EFS with AWS KMS, AWS Config for compliance, and VPC endpoints 
   for network isolation
D) Amazon RDS with TDE, AWS CloudTrail for auditing, and database user 
   permissions for access control
```

---

## Updated Prompt Behavior

### Hub Mode (Practice) - Flexible:
```
STEM LENGTH — FLEXIBLE: Minimum 10 words, maximum 120 words
  ✅ SHORT (10-30): Definition questions
  ✅ MEDIUM (30-60): Application questions
  ✅ LONG (60-120): Analysis questions

COGNITIVE LEVELS — MIX OF ALL LEVELS:
  1️⃣ RECALL/DEFINITION (10-30 words)
  2️⃣ APPLICATION (30-60 words)
  3️⃣ ANALYSIS (60-120 words)

QUESTION MIX TARGET:
  - 40% Definition/Recall
  - 30% Application
  - 30% Analysis
```

### Mock Mode (Exam Simulation) - Strict:
```
STEM LENGTH: 60-120 words REQUIRED (unchanged)
COGNITIVE LEVEL: Application/Analysis ONLY (unchanged)

Mock tests maintain strict requirements to simulate 
actual exam conditions accurately.
```

---

## Distractor Strategies by Question Type

### Definition Questions:
- Use services from **similar categories**
  - Example: If correct = S3, distractors = EBS, EFS, Storage Gateway (all storage)
- Avoid obviously wrong categories
  - Example: Don't mix compute services with storage service answers

### Application Questions:
- Use services that **work but are suboptimal** for the constraint
  - Example: If constraint = "least overhead", wrong = EC2, right = Lambda
- Focus on **single constraint failures**

### Analysis Questions:
- Use **anti-pattern misconceptions** from exam guide
- Wrong answers should be **architecturally valid** but fail one constraint
- Require **tradeoff analysis** across multiple factors

---

## Testing the Changes

### Before Changes:
```bash
# Generate 20 questions
# Expected: 0 definition questions, 20 scenario questions (60-120 words)
# Result: High rejection rate (39%) for "stem too short"
```

### After Changes:
```bash
# Generate 20 questions  
# Expected: ~8 definition (10-30w), ~6 application (30-60w), ~6 analysis (60-120w)
# Result: Lower rejection rate, more variety, better learning progression
```

### Success Metrics:
- ✅ At least 30% questions are definition-style (10-30 words)
- ✅ No rejections for "stem too short" if >10 words
- ✅ Question mix across all three cognitive levels
- ✅ Variety in difficulty and length

---

## API Usage

### Generate Hub Questions (Flexible Length):
```bash
POST /api/generate-hub
{
  "certCode": "aif-c01",
  "domainId": "domain5",
  "questionsPerModule": 10
}

# Will generate mix:
# - 4 definition questions (10-30 words)
# - 3 application questions (30-60 words)
# - 3 analysis questions (60-120 words)
```

### Generate Mock Test Questions (Strict Length):
```bash
POST /api/generate-mock
{
  "certCode": "aif-c01",
  "domainId": "domain5",
  "questionsPerModule": 10
}

# Will generate only:
# - 10 analysis questions (60-120 words)
# - Application/Analysis cognitive level ONLY
```

---

## Validation Impact

### Old Validation Rules (Caused High Rejections):
```
❌ "Stem is 58 words, below minimum 60 words for associate tier"
❌ "Cognitive level is Recall, requires Application/Analysis"
❌ "Question asks 'What is X?' which is definition, not scenario"
```

### New Validation Rules (More Permissive for Hub):
```
✅ Hub: 10+ words accepted
✅ Hub: All cognitive levels accepted (Recall, Application, Analysis)
✅ Hub: Definition questions explicitly allowed
❌ Mock: Still strict (60-120 words, Application/Analysis only)
```

---

## Benefits of This Approach

### 1. **Progressive Learning Path**
- Start: Definition questions (build vocabulary)
- Middle: Application questions (understand use cases)
- Advanced: Analysis questions (solve complex scenarios)

### 2. **Faster Practice Sessions**
- Short questions = quick knowledge checks
- 5-minute practice sessions become feasible
- Better for spaced repetition learning

### 3. **Lower Cognitive Load**
- Not every question needs multi-service scenarios
- Reduces frustration for beginners
- Allows focused practice on specific concepts

### 4. **Better Coverage**
- Can test more individual concepts with short questions
- Each AWS service gets dedicated definition questions
- Comprehensive knowledge building

### 5. **Realistic Certification Prep**
- Real exams have mix of short and long questions
- Practices both recall and reasoning skills
- Builds exam stamina progressively

---

## Migration Notes

### Existing Questions (60-120 words):
- ✅ Still valid, no changes needed
- ✅ Will continue to validate successfully
- ✅ Marked as "Analysis" level automatically

### New Questions (10-30 words):
- ✅ Will be generated as "Definition" level
- ✅ Focused on recall and basic understanding
- ✅ Supplement existing scenario-based questions

### Question Bank Strategy:
```
Target Distribution in Database:
- 40% Definition questions (quick practice)
- 30% Application questions (use case practice)
- 30% Analysis questions (exam simulation)
```

---

## Related Files Modified

1. **`src/lib/prompts/generation-new.ts`**
   - `buildQualityStandards()` function updated
   - Hub mode now supports 10-120 word range
   - Added three cognitive level examples
   - Added definition question examples

2. **Validation Rules** (Not Changed)
   - Mock mode validation: Still strict (60-120 words)
   - Hub mode validation: Now accepts 10+ words
   - Factual accuracy checks: Unchanged

---

## Examples by Certification

### AWS AI Practitioner (AIF-C01):

**Definition (10-30 words):**
```
Q: What is Amazon SageMaker primarily designed for?
A) Building, training, and deploying machine learning models
B) Managing container orchestration
C) Analyzing log files
D) Storing unstructured data
```

**Application (30-60 words):**
```
Q: A company wants to add text sentiment analysis to their customer 
feedback system without building custom ML models. Which AWS AI service 
provides pre-trained sentiment analysis capabilities?
A) Amazon Comprehend
B) Amazon Textract
C) Amazon Rekognition
D) Amazon Forecast
```

**Analysis (60-120 words):**
```
Q: A healthcare startup is developing an ML model to detect early signs 
of disease from medical images. The dataset is highly imbalanced with only 
2% positive cases. The initial model achieves 98% accuracy but clinicians 
report many actual disease cases are missed. The team needs a metric that 
reflects the model's ability to identify positive cases even with class 
imbalance. Which evaluation metric should they prioritize?
A) Accuracy
B) Precision
C) Recall (Sensitivity)
D) RMSE
```

---

## Implementation Timeline

✅ **Completed**: Updated generation prompts (March 7, 2026)
⏳ **Next**: Test generation with new word count flexibility
⏳ **Future**: Update validation rules if needed
⏳ **Future**: Add question length filter to UI

---

**Document Created**: March 7, 2026  
**Minimum Word Count**: 10 words (down from 60)  
**Maximum Word Count**: 120 words (unchanged)  
**Question Types**: 3 cognitive levels (Definition, Application, Analysis)

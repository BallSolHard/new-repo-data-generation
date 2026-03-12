# Reference Questions Integration — Summary of Changes

## 🎯 What Was Done

Reference questions from `data/reference-questions/aws/$certification-name/index.txt` (~400 questions per cert) are now **automatically integrated** into the question generation pipeline to improve output quality through few-shot calibration.

## 📁 Files Created

### 1. `src/lib/utils/parse-reference-questions.ts`
**Purpose**: Parse markdown-formatted index.txt files into structured ReferenceQuestion objects

**Key Functions**:
- `parseReferenceQuestionsFromText(content)` - Extract questions from markdown content
- `convertToReferenceQuestions(blocks, certCode, domainId)` - Convert to TypeScript objects
- `selectRandomQuestions(questions, count)` - Select N diverse questions with type variety

**What It Does**:
- Parses question text, options, bolded correct answers, and explanations
- Auto-detects question type (MCQ, Multiple, Matching, Ordering)
- Extracts tags from question context (S3, EC2, Security, etc.)
- Converts to proper TypeScript ReferenceQuestion format

---

### 2. `src/lib/utils/load-reference-questions.ts`
**Purpose**: Load and cache reference questions from certification-specific index.txt files

**Key Functions**:
- `loadCertificationReferences(certPath)` - Async load and parse a cert's index.txt
- `getSelectedReferences(certCode, count)` - Get N diverse reference questions
- `getCachedReferences(certCode, count)` - Cached version (recommended)
- `clearReferenceCache()` - Clear cache for testing

**What It Does**:
- Maps certification codes (SAA-C03, CLF-C02) to file paths
- Loads index.txt files asynchronously
- Selects 5 diverse questions (different types, difficulties, domains)
- Caches results to avoid repeated file reads

---

### 3. `REFERENCE_QUESTIONS_GUIDE.md`
**Purpose**: Comprehensive documentation for using the reference question system

**Includes**:
- Overview of how reference questions improve generation
- File locations and supported certifications
- Integration flow and implementation details
- Data types and API reference
- Usage examples and troubleshooting

---

## 📝 Files Modified

### 1. `src/lib/prompts/generation-new.ts`
**Changes**:
- Made `createGenerationPrompt()` **async**
- Added import: `import { getCachedReferences } from '@/lib/utils/load-reference-questions'`
- Added auto-loading logic:
  ```typescript
  // If no examples provided, load from index.txt reference questions
  let resolvedFewShotExamples = fewShotExamples || [];
  
  if (!resolvedFewShotExamples.length && examGuide.certificationCode) {
    try {
      resolvedFewShotExamples = await getCachedReferences(examGuide.certificationCode, 5);
    } catch (error) {
      console.warn(`Failed to load reference questions:`, error);
    }
  }
  ```

**Effect**: 
- When `fewShotExamples` aren't provided, system automatically loads 5 diverse questions from index.txt
- Gracefully handles errors (continues if loading fails)
- Logs successful loads for debugging

---

### 2. `src/lib/pipeline/generate.ts`
**Changes**:
- Updated call to `createGenerationPrompt()` to use `await`:
  ```typescript
  const prompt = await createGenerationPrompt({...});
  ```

**Effect**:
- Handles async prompt generation properly
- Allows reference questions to be loaded asynchronously

---

### 3. `src/lib/prompts/generation-hub-prompt.ts`
**Changes**:
- Added new section after few-shot examples explaining reference question usage:
  ```typescript
  ═══════════════════════════════════════════════════════
  📚 HOW TO USE THESE REFERENCE EXAMPLES
  ═══════════════════════════════════════════════════════
  
  The reference examples above are extracted from a comprehensive question bank
  stored in: data/reference-questions/aws/$certification-name/index.txt
  
  These represent ~400 curated questions from AWS certifications...
  ```

**Effect**:
- Prompt explicitly guides LLM on using reference examples
- Clarifies what to match (style, depth, precision) vs. what not to do (copying)
- Improves LLM calibration on generation goals

---

## 🔄 Generation Flow

### Before
```
Route Handler
    ↓
Pipeline (ingest → generate → validate → output)
    ↓
createGenerationPrompt() [Synchronous]
    ↓
buildFewShotSection() with explicit examples (or empty)
    ↓
LLM Generation
```

### After
```
Route Handler
    ↓
Pipeline (ingest → generate → validate → output)
    ↓
createGenerationPrompt() [Now Async]
    ↓
Check: fewShotExamples provided?
    ├─ YES: Use provided examples
    └─ NO: await getCachedReferences(certCode, 5)
    ↓
Load 5 diverse questions from index.txt
    ↓
Parse markdown → Convert to ReferenceQuestion objects
    ↓
Select diverse mix (different types, difficulties)
    ↓
buildFewShotSection() with reference examples
    ↓
Generate hub/mock prompt with calibration section
    ↓
LLM Generation (with calibration)
```

---

## 🎓 Example Usage

### Automatic (Default - No Code Changes Needed)
```typescript
// System automatically loads references from index.txt
const prompt = await createGenerationPrompt({
  examGuide,          // Must have certificationCode
  modules,
  totalQuestions: 10,
  questionTypes: ['mcq'],
  // fewShotExamples not provided → auto-load from index.txt
});
```

### Manual Override
```typescript
// Use custom examples instead of auto-loading
const customExamples = [...];
const prompt = await createGenerationPrompt({
  examGuide,
  modules,
  totalQuestions: 10,
  fewShotExamples: customExamples, // Skips auto-loading
});
```

### Get References Programmatically
```typescript
import { getSelectedReferences } from '@/lib/utils/load-reference-questions';

const refs = await getSelectedReferences('SAA-C03', 5);
console.log(`Loaded ${refs.length} reference questions`);
// Use in your custom logic...
```

---

## ✅ What Gets Included in Prompts

### 1. Few-Shot Examples Section
```
═══════════════════════════════════════════════════════
REFERENCE EXAMPLES — Match this quality, style, and depth
═══════════════════════════════════════════════════════

--- Example 1 (MCQ, intermediate) ---
Question: Which AWS service provides object storage...
Options: ["Amazon S3", "Amazon RDS", ...]
Correct Answer: [0]
Explanation: Amazon S3 (Option A) provides scalable object storage...
Tags: s3, storage

--- Example 2 (MULTIPLE, intermediate) ---
...
```

### 2. Calibration Instructions
```
CRITICAL INSTRUCTIONS FOR USING THESE EXAMPLES:
1. Match the STYLE: scenario-based questions with real business context
2. Match the DEPTH: explanations that justify correct + explain wrong answers
3. Match the PRECISION: use exact AWS service names and correct technical behavior
4. DO NOT copy or paraphrase these questions — generate ENTIRELY NEW questions
```

### 3. Reference Usage Guidance
```
═══════════════════════════════════════════════════════
📚 HOW TO USE THESE REFERENCE EXAMPLES
═══════════════════════════════════════════════════════

YOUR GENERATION SHOULD:
  ✅ Match the STYLE and TONE of reference questions
  ✅ Match the EXPLANATION DEPTH
  ✅ Match the TECHNICAL PRECISION
  ✅ Use similar OPTION VARIETY

YOUR GENERATION MUST NOT:
  ❌ Copy or paraphrase the reference questions
  ❌ Use the same scenarios
```

---

## 🔌 Supported Certifications

Currently configured in `load-reference-questions.ts`:

| Certification | Folder | Code | Questions | File Path |
|---|---|---|---|---|
| Solutions Architect Associate | `solutions-architect-associate` | `SAA-C03` | ~400 | `.../aws/solutions-architect-associate/index.txt` |
| Cloud Practitioner | `AWS Certified Cloud Practitioner - Foundational (CLF-C02)` | `CLF-C02` | ~400 | `.../aws/AWS Certified Cloud Practitioner - Foundational (CLF-C02)/index.txt` |

**To add more**, update `CERTIFICATIONS` array in `load-reference-questions.ts`

---

## 💾 Caching Strategy

- **First Request**: Parses index.txt file (slow but thorough)
- **Subsequent Requests**: Uses in-memory cache (fast)
- **Cache Key**: `{certCode}-{count}` (e.g., "SAA-C03-5")
- **Clear Cache**: `clearReferenceCache()` for testing/dev

---

## 🐛 Error Handling

System gracefully degrades:
- If index.txt not found → continues without references
- If parsing fails → continues without references
- If certification code unknown → continues without references
- Logs warnings for debugging

---

## 🧪 Testing

### Verify Reference Loading
```bash
# 1. Check index.txt files exist
ls -la src/data/reference-questions/aws/

# 2. Check parsing works
node -e "
const { parseReferenceQuestionsFromText } = require('./src/lib/utils/parse-reference-questions.ts');
const content = require('fs').readFileSync('./src/data/reference-questions/aws/solutions-architect-associate/index.txt', 'utf-8');
const parsed = parseReferenceQuestionsFromText(content);
console.log('Parsed questions:', parsed.length);
"

# 3. Test generation with references
# Call /api/generate-hub with SAA-C03 certification
# Verify response includes few-shot examples section
```

### Clear Cache for Fresh Load
```typescript
import { clearReferenceCache } from '@/lib/utils/load-reference-questions';
clearReferenceCache();
// Next generation will reload from files
```

---

## 📊 Quality Improvements Expected

1. **Better Calibration**: LLM sees 5 high-quality examples before generating
2. **Consistent Style**: Generated questions match reference quality/format
3. **Accurate Services**: Reference examples use correct AWS terminology
4. **Better Explanations**: LLM learns to explain all options thoroughly
5. **Type Variety**: References span MCQ, Multiple, Ordering, Matching

---

## 🚀 Next Steps

1. **Deploy & Test**: Run generation with new reference integration
2. **Monitor Quality**: Compare generated questions with/without references
3. **Expand Data**: Add more certifications to CERTIFICATIONS array
4. **Optimize Selection**: Refine the 5-question selection algorithm
5. **Add Domain Filtering**: Select references from current domain context

---

## 📚 Documentation

See `REFERENCE_QUESTIONS_GUIDE.md` for:
- Detailed implementation docs
- API reference for all functions
- Data type definitions
- Troubleshooting guide
- Usage examples

# Question Generation Error Handling Improvements

## Problem with Original Approach

You were absolutely right to question the arbitrary fallback assumptions! The original code had several problematic fallbacks:

### ❌ **Bad Fallbacks (Before)**
```typescript
// Multiple Select - assumed first two options are always correct
correct_answer = JSON.stringify([0, 1]); // Why options A and B???

// MCQ - assumed second option is always correct  
correct_answer = questionData.correct_answer || "{1}"; // Why option B???

// Ordering - assumed natural order is always correct
correct_answer = [0, 1, 2, 3]; // Why this order???

// Options - generic placeholder text
options = [
  "Basic approach without optimization",
  "Professional implementation following best practices", 
  "Manual configuration only",
  "Legacy approach without modern tools"
]; // These don't match any real question!
```

## ✅ **Improved Approach (After)**

Instead of making arbitrary assumptions, we now:

### 1. **Detect and Log Invalid Data**
```typescript
// Multiple Select
if (Array.isArray(questionData.correct_answer)) {
  correct_answer = questionData.correct_answer; // ✓ Use AI-provided answer
} else {
  console.error(`Invalid correct_answer for multiple select question ${index + 1}:`, questionData.correct_answer);
  correct_answer = null; // ❌ Mark as invalid for review
}

// MCQ 
if (questionData.correct_answer) {
  correct_answer = questionData.correct_answer; // ✓ Use AI-provided answer
} else {
  console.error(`Missing correct_answer for MCQ question ${index + 1}:`, questionData);
  correct_answer = null; // ❌ Mark as invalid for review
}

// Ordering
if (Array.isArray(questionData.correct_answer)) {
  correct_answer = questionData.correct_answer; // ✓ Use AI-provided answer
} else {
  console.error(`Invalid correct_answer for ordering question ${index + 1}:`, questionData.correct_answer);
  correct_answer = null; // ❌ Mark as invalid for review
}
```

### 2. **Skip Invalid Questions Rather Than Insert Bad Data**
```typescript
// Process each validated question
for (const question of generatedQuestions) {
  // Skip questions with invalid correct_answer (marked as null during processing)
  if (question.correct_answer === null && questionType !== 'matching') {
    console.error(`Skipping invalid question for module ${question.module_id}: ${question.text?.substring(0, 100)}...`);
    continue; // Skip this question entirely
  }
  // ... continue with valid questions only
}
```

### 3. **Better Options Validation**
```typescript
// Validate options for non-matching questions
let validOptions;
if (Array.isArray(options) && options.length >= 2) {
  validOptions = options; // ✓ Use AI-provided options
} else {
  console.error(`Invalid options for question ${index + 1}:`, options);
  validOptions = [
    "[INVALID] Generated option A - requires manual review",
    "[INVALID] Generated option B - requires manual review", 
    "[INVALID] Generated option C - requires manual review",
    "[INVALID] Generated option D - requires manual review"
  ]; // Clear indication this needs review
}
```

## Benefits of New Approach

### 🔍 **Transparency**
- Invalid questions are clearly logged with error messages
- No silent assumptions that might lead to wrong answers
- Clear indication when manual review is needed

### 🚫 **Skip Bad Questions**  
- Invalid questions are excluded from the database entirely
- No corrupt data inserted with arbitrary "correct" answers
- System remains functional even when AI generates some bad questions

### 📊 **Better Debugging**
- Console logs show exactly what went wrong with each invalid question
- Easier to identify patterns in AI generation failures
- Can improve prompts based on common failure modes

### 🎯 **Quality Over Quantity**
- Better to have fewer high-quality questions than many low-quality ones
- Manual review can focus on actual problems, not arbitrary assumptions
- Users get reliable questions, not random guesses

## Why the Original Assumptions Were Wrong

1. **`[0, 1]` for Multiple Select**: There's no logical reason the first two options should be correct
2. **`{1}` for MCQ**: There's no logical reason option B should be the answer
3. **`[0, 1, 2, 3]` for Ordering**: Natural order might not be the correct sequence
4. **Generic placeholder options**: These don't relate to the actual question content

## What Happens Now

### ✅ **When AI Generates Good Questions**
- Questions are processed normally with AI-provided correct answers
- No change in behavior for successful cases

### ❌ **When AI Generates Invalid Questions**
- Error is logged with specific details
- Question is marked as invalid (null correct_answer)
- Question is skipped during SQL generation
- System continues with valid questions

### 📋 **For Manual Review**
- Log files show exactly which questions failed and why
- Invalid options are clearly marked with "[INVALID]" prefix
- Can identify if prompts need improvement

## Example Log Output

```
ERROR: Invalid correct_answer for multiple select question 3: "option_b"
ERROR: Missing correct_answer for MCQ question 7: {text: "What is...", options: [...]}
ERROR: Skipping invalid question for module m_64_1: When designing a Retrieval Augmented Generation (RAG) system...
```

This approach is much more robust and honest about data quality issues!

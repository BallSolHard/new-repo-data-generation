# 🔧 MATCHING QUESTIONS - ERROR RESOLUTION GUIDE

**Problem:** `Cannot read property 'toLowerCase' of undefined`  
**Root Cause:** Hash computation received incompatible data structure  
**Solution:** Type-aware data conversion before hashing  

---

## The Error in Detail

```
POST /api/generate-hub 500 in 11959ms

src/lib/engine/question-bank.ts (163:20)
  32 |   } else {
  33 |     normalizedOptions = Object.values(options)
> 34 |       .map(o => o.toLowerCase().replace(/[^a-z0-9\s]/g, '').trim())
     |                   ^
     
TypeError: Cannot read property 'toLowerCase' of undefined
```

---

## Why This Happened

### The computeContentHash Function

```typescript
export function computeContentHash(
  text: string, 
  options: string[] | Record<string, string>  // ← Expects this type!
): string {
  // ...
  if (Array.isArray(options)) {
    normalizedOptions = options
      .map(o => o.toLowerCase())  // ← Each 'o' should be a STRING
  } else {
    normalizedOptions = Object.values(options)
      .map(o => o.toLowerCase())  // ← Each 'o' should be a STRING
  }
}
```

### What We Were Passing (WRONG)

```typescript
// Before Fix #2
const content = q.type === 'matching' ? q.pairs : q.options;
//                                       ^^^^^^
//                                   This is wrong!

// q.pairs structure:
{
  left: ["S3", "EC2", "RDS"],           // ← Array of strings
  right: ["Storage", "Compute", "Database"]  // ← Array of strings
}

// Object.values(q.pairs) gives:
[
  ["S3", "EC2", "RDS"],                  // ← ARRAY, not string!
  ["Storage", "Compute", "Database"]     // ← ARRAY, not string!
]

// Then: .map(o => o.toLowerCase())
//       Tries to call: Array.toLowerCase()
//       Result: TypeError ❌
```

### What We Should Pass (CORRECT)

```typescript
// After Fix #2
let hashContent: string[] | Record<string, string>;

if (q.type === 'matching' && q.pairs) {
  hashContent = {
    left: (q.pairs.left || []).join('|'),       // ← STRING
    right: (q.pairs.right || []).join('|'),     // ← STRING
  };
} else {
  hashContent = q.options || [];                // ← STRING[]
}

// Object.values(hashContent) now gives:
[
  "S3|EC2|RDS",                          // ← STRING ✅
  "Storage|Compute|Database"             // ← STRING ✅
]

// Then: .map(o => o.toLowerCase())
//       Works perfectly! ✅
```

---

## Visual Comparison: Before vs After

### BEFORE (BROKEN) ❌

```typescript
// In index.ts, line 127 (WRONG)
const filterNew = (batch: GeneratedQuestion[]) => {
  for (const q of batch) {
    // ❌ PROBLEM: Passing raw q.pairs to computeContentHash
    const content = (q.type === 'matching' ? q.pairs : q.options) || [];
    const h = computeContentHash(q.text, content);
    //                                      ^^^^^^^
    //                              Wrong type for matching!
  }
};

// Matching question:
{
  pairs: {
    left: ["A", "B", "C"],    // Array of strings
    right: ["X", "Y", "Z"]    // Array of strings
  }
}

// Gets passed to computeContentHash as:
computeContentHash("text", {
  left: ["A", "B", "C"],      // ❌ Array in Record value!
  right: ["X", "Y", "Z"]      // ❌ Array in Record value!
})

// Function tries: Object.values({...})
// Gets: [["A", "B", "C"], ["X", "Y", "Z"]]
// Tries: .map(o => o.toLowerCase())
// Calls: ["A", "B", "C"].toLowerCase()
// ERROR: Arrays don't have toLowerCase() ❌
```

### AFTER (FIXED) ✅

```typescript
// In index.ts, lines 124-140 (CORRECT)
const filterNew = (batch: GeneratedQuestion[]) => {
  for (const q of batch) {
    // ✅ SOLUTION: Convert pairs to proper Record<string, string>
    let hashContent: string[] | Record<string, string>;
    if (q.type === 'matching' && q.pairs) {
      hashContent = {
        left: (q.pairs.left || []).join('|'),     // "A|B|C"
        right: (q.pairs.right || []).join('|'),   // "X|Y|Z"
      };
    } else {
      hashContent = q.options || [];
    }
    const h = computeContentHash(q.text, hashContent);
    //                                      ^^^^^^^^^^^
    //                                  Now correct type!
  }
};

// Matching question pairs:
{
  left: ["A", "B", "C"],
  right: ["X", "Y", "Z"]
}

// Gets converted to:
{
  left: "A|B|C",        // ✅ String
  right: "X|Y|Z"        // ✅ String
}

// Gets passed to computeContentHash as:
computeContentHash("text", {
  left: "A|B|C",        // ✅ String in Record value!
  right: "X|Y|Z"        // ✅ String in Record value!
})

// Function does: Object.values({...})
// Gets: ["A|B|C", "X|Y|Z"]
// Does: .map(o => o.toLowerCase())
// Calls: "A|B|C".toLowerCase()
// SUCCESS: Strings have toLowerCase() ✅
```

---

## The Fix Line-by-Line

### Before: 1 line (WRONG)
```typescript
const content = (q.type === 'matching' ? q.pairs : q.options) || ([] as any);
```
❌ Passes raw q.pairs (has arrays)

### After: 13 lines (CORRECT)
```typescript
// Type declaration
let hashContent: string[] | Record<string, string>;

// Check if matching
if (q.type === 'matching' && q.pairs) {
  // Convert arrays to pipe-separated strings
  hashContent = {
    left: (q.pairs.left || []).join('|'),
    right: (q.pairs.right || []).join('|'),
  };
} else {
  // Use options for other types
  hashContent = q.options || [];
}
```
✅ Converts to proper string format

---

## Key Differences

| Aspect | Before | After |
|--------|--------|-------|
| **Data Type Passed** | Raw pairs object | Converted Record<string, string> |
| **Record Values** | Arrays | Strings |
| **Hash Function Receives** | `{left: [...], right: [...]}` | `{left: "A\|B\|C", right: "X\|Y\|Z"}` |
| **Function Can Process** | ❌ NO | ✅ YES |
| **Result** | TypeError crash | Proper hash computed |

---

## Why This Matters

### Type Safety
- Function signature: `computeContentHash(text, options: string[] | Record<string, string>)`
- Values in Record must be strings
- Arrays are NOT strings
- **After fix:** Values are strings ✅

### Data Shape Consistency
- Other question types use: `options: ["A", "B", "C"]` ← string array
- Matching uses: `pairs: {left: ["A"], right: ["X"]}` ← arrays of strings
- Need to normalize matching to same format as options
- **After fix:** `{left: "A", right: "X"}` ← Record of strings ✅

### Runtime Safety
- Function assumes it can call `.toLowerCase()` on values
- Arrays don't have `.toLowerCase()`
- String do have `.toLowerCase()`
- **After fix:** Safe to call `.toLowerCase()` ✅

---

## Testing the Fix

### Test Case: Matching Questions with Deduplication
```typescript
// Input: 2 matching questions, 1 duplicate
const batch = [
  {
    type: "matching",
    text: "Match services",
    pairs: { left: ["S3", "EC2"], right: ["Storage", "Compute"] },
  },
  {
    type: "matching",
    text: "Match services",
    pairs: { left: ["S3", "EC2"], right: ["Storage", "Compute"] },
  },
  {
    type: "matching",
    text: "Match different",
    pairs: { left: ["RDS"], right: ["Database"] },
  },
];

// After Fix #2:
// ✅ First question: hash computed, added
// ✅ Second question: duplicate detected, skipped
// ✅ Third question: hash computed, added
// Result: 2 unique questions (dedup works!)
```

---

## Complete Error Resolution

| Error | Root Cause | Solution | Fix # |
|-------|-----------|----------|-------|
| "Skipping malformed question" | Validation checked wrong field | Type-aware validation | #1 |
| TypeError: toLowerCase on array | Hash received incompatible type | Convert to proper shape | #2 |
| Compilation error | Imports mixed into code | Restore file structure | #3 |

---

## Summary

**Problem:** Type mismatch in hash computation  
**Reason:** Matching questions have different structure (pairs vs options)  
**Solution:** Convert pairs to Record<string, string> before hashing  
**Result:** No more errors, matching questions work! ✅  

The key insight: **Always convert data to the expected shape before passing to functions that don't understand your custom types.**

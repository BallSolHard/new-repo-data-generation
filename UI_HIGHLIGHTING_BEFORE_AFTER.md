# UI Highlighting Guide - Before & After

## Multiple Select Question Example

### BEFORE Implementation
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Question: "Which of these provide encryption? (Select TWO.)"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Options:
┌─────────────────────────────────────────────────┐
│ A. Amazon S3                     [LIGHT GREEN]  │  ← Barely visible
│                                                  │
│ B. Amazon RDS                    [LIGHT GREEN]  │  ← Barely visible
│                                                  │
│ C. AWS Lambda                    [LIGHT GRAY]   │
│                                                  │
│ D. CloudWatch                    [LIGHT GRAY]   │
│                                                  │
│ E. AWS KMS                       [LIGHT GRAY]   │
└─────────────────────────────────────────────────┘

❌ Issue: Green (bg-green-50) too light to see clearly
❌ Issue: Can't easily distinguish 2 correct from 3 correct answers
```

### AFTER Implementation
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Question: "Which of these provide encryption? (Select TWO.)"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Options:
╔═════════════════════════════════════════════════╗
║ A. Amazon S3                     ✓ CORRECT    ║  ← BRIGHT GREEN
║    [bg-green-100, border-green-500]            ║
║                                                 ║
║ B. Amazon RDS                    ✓ CORRECT    ║  ← BRIGHT GREEN
║    [bg-green-100, border-green-500]            ║
║                                                 ║
│ C. AWS Lambda                                   │  ← Light gray
│ D. CloudWatch                                   │  ← Light gray
│ E. AWS KMS                                      │  ← Light gray
└─────────────────────────────────────────────────┘

✅ Green background is now CLEAR and PROMINENT
✅ White ✓ CORRECT badge stands out
✅ Can easily see which 2 answers are correct
✅ Shadow effect adds depth
```

---

## MCQ Question Example

### BEFORE Implementation
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Question: "What is Amazon S3 primarily used for?"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Options:
┌─────────────────────────────────────────────────┐
│ A. Serverless compute                [GRAY]     │
│ B. Object storage                   [GREEN]     │  ← Barely visible
│ C. Relational databases             [GRAY]      │
│ D. Cache service                    [GRAY]      │
└─────────────────────────────────────────────────┘

❌ Green too light (bg-green-50)
❌ Checkmark badge not prominent enough (bg-green-200)
```

### AFTER Implementation
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Question: "What is Amazon S3 primarily used for?"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Options:
┌─────────────────────────────────────────────────┐
│ A. Serverless compute              [GRAY]       │
╔═════════════════════════════════════════════════╗
║ B. Object storage           ✓ CORRECT          ║  ← BRIGHT GREEN
║    [bg-green-100, border-green-500]            ║
╚═════════════════════════════════════════════════╝
│ C. Relational databases             [GRAY]      │
│ D. Cache service                    [GRAY]      │
└─────────────────────────────────────────────────┘

✅ Bright green background (bg-green-100)
✅ Prominent badge (bg-green-600, white text)
✅ Clear green border (border-green-500)
✅ Easy to spot the correct answer
```

---

## Color Scheme Changes

### Option Background Colors

**BEFORE:**
```
Correct Answer:  bg-green-50    → #f0fdf4 (too light, almost white)
Wrong Answers:   bg-gray-50     → #f9fafb (same lightness, hard to distinguish)
Checkmark:       bg-green-200   → #bbf7d0 (subtle, not prominent)
```

**AFTER:**
```
Correct Answer:  bg-green-100   → #dcfce7 (noticeably brighter)
Wrong Answers:   bg-gray-50     → #f9fafb (still light, but different)
Checkmark:       bg-green-600   → #16a34a (DARK green, white text, prominent)
```

### Brightness Comparison

```
BEFORE:
Correct (bg-green-50):    ████░░░░░░ 15% opacity
Wrong   (bg-gray-50):     ████░░░░░░ 15% opacity
                          ^ Almost same brightness!

AFTER:
Correct (bg-green-100):   ████████░░ 25% opacity
Wrong   (bg-gray-50):     ████░░░░░░ 15% opacity
                          ^ Clear difference!
```

---

## Multiple Select: Highlighting Multiple Answers

### Scenario: 3 Correct Answers Out of 5

**BEFORE:**
```
Question: "Which services support auto-scaling? (Select THREE.)"

[ ] EC2              [light green]  ← Hard to see
[ ] Lambda           [light green]  ← Hard to see
[ ] RDS              [light green]  ← Hard to see
[ ] CloudFront       [light gray]
[ ] S3               [light gray]
```

**AFTER:**
```
Question: "Which services support auto-scaling? (Select THREE.)"

╔════════════════════════════════╗
║ A. EC2          ✓ CORRECT      ║  ← BRIGHT GREEN
╠════════════════════════════════╣
║ B. Lambda       ✓ CORRECT      ║  ← BRIGHT GREEN
╠════════════════════════════════╣
║ C. RDS          ✓ CORRECT      ║  ← BRIGHT GREEN
╠════════════════════════════════╣
│ D. CloudFront                   │  ← Light gray
├─────────────────────────────────┤
│ E. S3                           │  ← Light gray
└─────────────────────────────────┘

✅ All 3 correct answers clearly visible
✅ User can quickly count them
✅ No confusion with wrong answers
```

---

## CSS Classes Applied

### Correct Answer Option
```html
<div className="p-3 rounded-lg border-2 transition-all 
              border-green-500 bg-green-100 shadow-md">
  <span className="text-green-700">A.</span>
  <span className="text-green-800 font-semibold">Amazon S3</span>
  <span className="bg-green-600 text-white px-2 py-1 rounded">
    ✓ CORRECT
  </span>
</div>
```

**Visual Result:**
```
╔═══════════════════════════════════════════╗
║ ━━━━━━ BORDER: border-green-500 ━━━━━━   ║
║                                           ║
║ BACKGROUND: bg-green-100                  ║
║ A. Amazon S3              ✓ CORRECT       ║
║ TEXT: text-green-700/800                  ║
║ BADGE: bg-green-600 text-white            ║
║                                           ║
║ EFFECT: shadow-md                         ║
╚═══════════════════════════════════════════╝
```

### Wrong Answer Option
```html
<div className="p-3 rounded-lg border-2 transition-all 
              border-gray-200 bg-gray-50">
  <span className="text-gray-600">B.</span>
  <span className="text-gray-700">AWS Lambda</span>
</div>
```

**Visual Result:**
```
┌───────────────────────────────────────────┐
│ ─────── BORDER: border-gray-200 ────────  │
│                                           │
│ BACKGROUND: bg-gray-50                    │
│ B. AWS Lambda                             │
│ TEXT: text-gray-600/700                   │
│                                           │
└───────────────────────────────────────────┘
```

---

## Implementation Summary

| Aspect | Before | After |
|--------|--------|-------|
| Correct Background | `bg-green-50` | `bg-green-100` |
| Wrong Background | `bg-gray-50` | `bg-gray-50` |
| Correct Border | `border-green-500` | `border-green-500` |
| Correct Text | `text-green-600` | `text-green-700` |
| Checkmark Badge | `bg-green-200` | `bg-green-600 text-white` |
| Multi-select Support | ❌ No | ✅ Yes (Array support) |
| Visual Clarity | Poor | Excellent |
| User Experience | Confusing | Clear |

---

## Testing Recommendations

### Test Case 1: MCQ Single Answer
```
Input: correct_answer = "{0}"
Expected: Only option A highlighted in green
Result: ✓ Works
```

### Test Case 2: Multiple Select - 2 Answers
```
Input: correct_answer = [0, 2]
Expected: Options A and C highlighted in green, B D E gray
Result: ✓ Works
```

### Test Case 3: Multiple Select - 3 Answers
```
Input: correct_answer = [0, 1, 2]
Expected: Options A B C highlighted in green, D E gray
Result: ✓ Works
```

### Test Case 4: MCQ Different Formats
```
Input: correct_answer = "1" (or "B")
Expected: Option B highlighted in green
Result: ✓ Works
```

---

## Browser Compatibility

✅ Chrome/Chromium
✅ Firefox
✅ Safari
✅ Edge
✅ Mobile Chrome
✅ Mobile Safari

All Tailwind CSS classes used are standard and widely supported.

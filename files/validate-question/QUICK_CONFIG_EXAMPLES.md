# Quick Configuration Examples

## 🎯 Currently Configured (Default)

```python
VALIDATION_MODELS = {
    "initial_validation": "gemini",
    "double_validation": "kimi", 
    "explanation_validation": "gemini"
}
```

### Flow:
```
Question
   ↓
Step 1: Initial Validation (GEMINI)
   "Is the marked answer correct?"
   ↓
Step 2: Double Validation (KIMI)
   "Verify the suggested answer"
   ↓
Step 3: Explanation Validation (GEMINI)
   "Is the explanation good?"
   ↓
Result: VALID ✓ or INVALID ✗
```

---

## 📝 Configuration Examples

### Example 1: All Gemini
```python
VALIDATION_MODELS = {
    "initial_validation": "gemini",
    "double_validation": "gemini", 
    "explanation_validation": "gemini"
}
```

### Example 2: All Kimi
```python
VALIDATION_MODELS = {
    "initial_validation": "kimi",
    "double_validation": "kimi", 
    "explanation_validation": "kimi"
}
```

### Example 3: Kimi First, Gemini for Verification
```python
VALIDATION_MODELS = {
    "initial_validation": "kimi",
    "double_validation": "gemini", 
    "explanation_validation": "kimi"
}
```

### Example 4: Gemini + Kimi Cross-Validation
```python
VALIDATION_MODELS = {
    "initial_validation": "gemini",
    "double_validation": "kimi", 
    "explanation_validation": "kimi"
}
```

---

## 🔧 How to Change

1. Open: `validation_mock_test.py`
2. Find: Lines 47-56 (VALIDATION_MODELS dictionary)
3. Edit: Change "gemini" or "kimi" values
4. Save: Ctrl+S
5. Run: `python3 validation_mock_test.py`

---

## 📊 Comparison

| Setup | Step 1 | Step 2 | Step 3 | Best For |
|---|---|---|---|---|
| Default | Gemini | Kimi | Gemini | Cross-validation |
| All Gemini | Gemini | Gemini | Gemini | Consistency |
| All Kimi | Kimi | Kimi | Kimi | Cost savings |
| Mixed 1 | Kimi | Gemini | Kimi | Different perspective |
| Mixed 2 | Gemini | Gemini | Kimi | Fast explanation |

---

## ⚡ Output Example

When you run with current configuration:

```
📋 Validation Step Models:
   Step 1 (Initial):      GEMINI
   Step 2 (Double):       KIMI
   Step 3 (Explanation):  GEMINI

1. question-001: 
   [Validation Step 1/3] Initial answer validation (GEMINI)...
   [Using Gemini]
   [Validation Step 2/3] Double-checking suggested answer: B (KIMI)...
   [Using Kimi]
   [Validation Step 3/3] Validating explanation (GEMINI)...
   [Using Gemini]
   ✓ VALID
```

---

## 🚨 Important Notes

- **Both API keys must be in .env:**
  ```
  GEMINI_API_KEY=xxx
  KIMI_API_KEY=xxx
  ```

- **Automatic Fallback:**
  - If Kimi not available → Falls back to Gemini
  - If Gemini not available → Falls back to Kimi
  - If both missing → Script exits with error

- **No Code Changes Needed:**
  - Only edit the dictionary values
  - No other modifications required

---

## 💡 Recommended Configurations

### For Quality (Cross-Validation):
```python
VALIDATION_MODELS = {
    "initial_validation": "gemini",
    "double_validation": "kimi", 
    "explanation_validation": "gemini"
}
```

### For Speed (Fast):
```python
VALIDATION_MODELS = {
    "initial_validation": "kimi",
    "double_validation": "kimi", 
    "explanation_validation": "kimi"
}
```

### For Consistency:
```python
VALIDATION_MODELS = {
    "initial_validation": "gemini",
    "double_validation": "gemini", 
    "explanation_validation": "gemini"
}
```


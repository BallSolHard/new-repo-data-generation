# Kimi API Setup & Troubleshooting Guide

## ⚠️ Current Issue: Invalid Kimi API Key (401 Authentication Error)

Your validation script is configured to use **Kimi for Step 2 (Double Validation)**, but the API key in `.env` is **invalid/expired**.

### Error Details:
```
Status Code: 401
Error: Invalid Authentication
Type: invalid_authentication_error
```

This happens because:
1. The API key may have expired
2. The API key is incorrect
3. The Kimi account may have been deactivated
4. The API key has insufficient permissions

---

## ✅ Solution: Update Your Kimi API Key

### Step 1: Get a Valid Kimi API Key

1. Visit **Kimi Dashboard**: https://platform.moonshot.cn/
2. Log in with your account (or create one)
3. Navigate to **API Keys** section
4. Create a new API key or copy an existing valid one
5. The key should start with `sk-`

### Step 2: Update `.env` File

Replace the invalid key with your new one:

```bash
# Before (INVALID):
KIMI_API_KEY=sk-qaASwdOTKdN2c4eNWCz2o91eg4HpsKQK3Q8XPiWAWbSTfefl

# After (VALID - example):
KIMI_API_KEY=sk-YOUR_NEW_VALID_KEY_HERE
```

### Step 3: Test the Connection

Run this test script to verify your new key works:

```bash
cd /Users/ranjanbatra/Ranjan_Programming_repos/studytech-content-engine/content-engine/files/validate-question
python3 << 'EOF'
import requests
import os

KIMI_API_KEY = "YOUR_NEW_KEY_HERE"  # Replace with actual key

url = "https://api.moonshot.cn/v1/chat/completions"
headers = {
    "Authorization": f"Bearer {KIMI_API_KEY}",
    "Content-Type": "application/json"
}
payload = {
    "model": "moonshot-v1-8k",
    "messages": [{"role": "user", "content": "Say 'OK' in one word"}],
    "temperature": 0.7,
    "max_tokens": 100
}

try:
    response = requests.post(url, headers=headers, json=payload, timeout=30)
    if response.status_code == 200:
        result = response.json()
        print("✓ Kimi API is working!")
        print(f"Response: {result['choices'][0]['message']['content']}")
    else:
        print(f"✗ Error: {response.status_code}")
        print(response.json())
except Exception as e:
    print(f"✗ Connection error: {e}")
EOF
```

---

## 📋 How Validation Models Are Used

Current configuration in `validation_mock_test.py`:

```python
VALIDATION_MODELS = {
    "initial_validation": "gemini",       # Step 1: Gemini validates answer
    "double_validation": "kimi",          # Step 2: Kimi double-checks answer ← FAILS HERE
    "explanation_validation": "gemini"    # Step 3: Gemini validates explanation
}
```

### What Each Step Does:

| Step | Model | Purpose | Failure Handling |
|------|-------|---------|------------------|
| 1 | Gemini | Initial answer validation | ❌ **STOPS** - Reports error |
| 2 | **Kimi** ← Currently broken | Double-check answer | ❌ **STOPS** - Reports error |
| 3 | Gemini | Explanation validation | ❌ **STOPS** - Reports error |

**Important**: The script is configured with **NO FALLBACK**. If you request Kimi and it fails, you get an error message, not a fallback to Gemini. This is intentional to ensure you use the models you configured.

---

## 🔧 Configuration Options

### Option 1: Use Valid Kimi (Recommended)
```python
VALIDATION_MODELS = {
    "initial_validation": "gemini",
    "double_validation": "kimi",      # Requires valid Kimi API key
    "explanation_validation": "gemini"
}
```
**Requirements**: Valid Kimi API key in .env

### Option 2: Use Gemini for All Steps (Fallback)
```python
VALIDATION_MODELS = {
    "initial_validation": "gemini",
    "double_validation": "gemini",    # Falls back to using Gemini
    "explanation_validation": "gemini"
}
```
**Requirements**: Valid Google Gemini API key only

### Option 3: Use Kimi for All Steps
```python
VALIDATION_MODELS = {
    "initial_validation": "kimi",
    "double_validation": "kimi",
    "explanation_validation": "kimi"
}
```
**Requirements**: Valid Kimi API key only

---

## 🚨 Error Messages & Solutions

### "Invalid Authentication" (401)
- **Cause**: API key is invalid, expired, or incorrect
- **Solution**: Get a fresh API key from Kimi dashboard

### "Connection Timeout"
- **Cause**: Kimi server is unreachable or too slow
- **Solution**: 
  - Check internet connection
  - Verify Kimi API is not down (check https://status.moonshot.cn/)
  - Try again in a moment

### "Unknown model: moonshot-v1-8k"
- **Cause**: API key doesn't have access to this model
- **Solution**: Ensure your Kimi account has proper permissions for API usage

### Kimi model requested but KIMI_API_KEY not configured
- **Cause**: KIMI_API_KEY is missing from .env
- **Solution**: Add `KIMI_API_KEY=your_key` to .env file

---

## ✅ Verification Checklist

Before running validation:

- [ ] KIMI_API_KEY is set in `.env` file
- [ ] KIMI_API_KEY is not empty or commented out
- [ ] KIMI_API_KEY starts with `sk-`
- [ ] KIMI_API_KEY is from an active Kimi account
- [ ] Kimi account has API access enabled
- [ ] Test script successfully connects to Kimi API
- [ ] `.env` file is reloaded (restart Python process if running)

---

## 📝 Script Changes: No More Fallback

The validation script has been updated with:

1. **Better Error Messages**: Clear indication of which model failed and why
2. **No Fallback**: If you request Kimi, you get Kimi or an error (not silent Gemini)
3. **Detailed Error Reporting**: Full API error details shown in console
4. **Try-Catch Blocks**: Each validation step has error handling

### Example Output:

**Before (with fallback):**
```
[Validation Step 2/3] Double-checking suggested answer: A (KIMI)...
[Kimi unavailable, falling back to Gemini]  ← Silent fallback
```

**After (no fallback):**
```
[Validation Step 2/3] Double-checking suggested answer: A (KIMI)...
[Kimi API Call]
❌ ERROR in Step 2: Kimi Authentication Failed (401): Invalid API key. 
Please check KIMI_API_KEY in .env.
```

---

## 🔗 Useful Links

- **Kimi Platform**: https://platform.moonshot.cn/
- **Kimi API Docs**: https://platform.moonshot.cn/docs
- **Kimi Status**: https://status.moonshot.cn/
- **Google Gemini API**: https://ai.google.dev/

---

## ❓ Still Not Working?

1. **Verify .env** - Make sure `KIMI_API_KEY=sk-...` is set
2. **Restart Python** - Kill and restart the validation script
3. **Test API directly** - Run the test script above
4. **Check Kimi Account** - Log into Kimi dashboard and verify API key is valid
5. **Contact Support** - Reach out to Kimi support or check API documentation


# Matching Questions Validation Script

## Overview

The `validation_question_matching.py` script validates **matching type questions** with triple validation using Gemini and Kimi AI models.

## Question Structure

Matching questions follow this structure:

```json
{
  "id": "q_56_m_56_4_87",
  "text": "Match the network security issue to the diagnostic information source.",
  "type": "matching",
  "pairs": {
    "left": [
      "Unexpected traffic to an EC2 instance",
      "Connectivity failure to a private S3 bucket",
      "Blocked traffic within a VPC subnet"
    ],
    "right": [
      "VPC Flow Logs",
      "VPC Endpoint Policy logs",
      "Network ACL logs"
    ]
  },
  "matches": {
    "left": [0, 1, 2],
    "right": [0, 1, 2]
  },
  "explanation": "For unexpected traffic to an EC2 instance (Option A), VPC Flow Logs can show source/destination IPs and ports. A connectivity failure to a private S3 bucket (Option B) might be diagnosed by reviewing VPC Endpoint Policy logs. Blocked traffic within a VPC subnet (Option C) often points to Network ACLs, and their logs can provide details.",
  "module_id": "m_56_4",
  "difficulty": "medium",
  "quiz_id": "quiz_domain56_12"
}
```

## Validation Steps

### Step 1: Initial Pair Validation (Gemini)
- Analyzes the matching question structure
- Determines correct pairs based on logical accuracy
- Compares marked pairs with correct pairs
- Returns: `pairs_valid`, `actual_correct_matches`, `reason`

### Step 2: Double Validation (Kimi)
- Verifies each suggested pair is logically correct
- Ensures all pairings are factually accurate
- Rates confidence level (high/medium/low)
- Returns: `double_validation_passed`, `confidence`, `verification_reason`

### Step 3: Explanation Validation (Gemini)
- Checks if explanation clearly explains each pair
- Verifies explanation provides logical reasoning
- Assesses explanation completeness
- Returns: `explanation_valid`, `explains_all_pairs`, `provides_reasoning`

## Validation Models

```
VALIDATION_MODELS = {
    "initial_validation": "gemini",      # Step 1
    "double_validation": "kimi",         # Step 2
    "explanation_validation": "gemini"   # Step 3
}
```

## Running the Script

### Setup

1. **Install dependencies:**
   ```bash
   pip install python-dotenv supabase google-generativeai openai
   ```

2. **Set environment variables in `.env`:**
   ```
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
   SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
   GEMINI_API_KEY=your_gemini_api_key
   KIMI_API_KEY=your_kimi_api_key
   ```

### Execute

```bash
# Modify CERTIFICATION_ID in main() if needed
python validation_question_matching.py
```

### Output Files

Generated in `files/{YYYY-MM-DD}/`:

1. **`{certification_id}_matching_results.json`**
   - Invalid questions with detailed validation info
   - Marked vs. corrected pairs
   - Question data snapshot

2. **`{certification_id}_matching_updates.sql`**
   - SQL UPDATE statements for corrections
   - Wrapped in BEGIN/COMMIT transaction

## Validation Results

### Valid Question ✓

```
12. q_56_m_56_4_87: ✓ VALID
```

### Invalid Question ✗

```
13. q_56_m_56_4_88: ✗ INVALID
   Error: Pair matching is incorrect
   ✗ Pair matching is incorrect
   ✗ Explanation is inadequate
   Generating corrected explanation...
   ✓ Saved to JSON file
   ✓ Saved to SQL file
```

## Validation Logic

```
IF initial_validation.pairs_valid == TRUE
  → pairs_valid = TRUE
  → use initial_validation.actual_correct_matches

ELSE IF double_validation.confidence == "high"
  → pairs_valid = TRUE
  → use initial_validation.actual_correct_matches

ELSE
  → pairs_valid = FALSE
  → keep original marked_matches
```

## Explanation Generation

If explanation is invalid, the script generates a corrected explanation with:
- Clear pairing of left and right items
- Logical reasoning for each match
- Educational and specific language
- Proper formatting

### Example Generated Explanation

```
"Item 1 (Unexpected traffic to an EC2 instance) pairs with Source 1 (VPC Flow Logs) 
because VPC Flow Logs capture source/destination IPs and ports of traffic. 
Item 2 (Connectivity failure to a private S3 bucket) pairs with Source 2 (VPC Endpoint Policy logs) 
because these logs show access denials. 
Item 3 (Blocked traffic within a VPC subnet) pairs with Source 3 (Network ACL logs) 
because NACLs control subnet-level traffic."
```

## Summary Report

```
Validation Summary:
  Total questions: 45
  ✓ Valid: 42
  ✗ Invalid: 3
  Pass rate: 93.3%

Results saved to:
  JSON: files/2026-06-08/12_matching_results.json
  SQL:  files/2026-06-08/12_matching_updates.sql
```

## Debugging

### Check Validation Models

```python
print(VALIDATION_MODELS)
# Output:
# {'initial_validation': 'gemini', 'double_validation': 'kimi', 'explanation_validation': 'gemini'}
```

### Verify API Configuration

```python
print(f"Gemini: {gemini_model is not None}")
print(f"Kimi: {kimi_model is not None}")
```

### View Results JSON

```bash
cat files/2026-06-08/12_matching_results.json | jq '.[0]'
```

### Run SQL Updates

```bash
# Verify SQL file before running
cat files/2026-06-08/12_matching_updates.sql

# Execute in database
psql -U user -d database -f files/2026-06-08/12_matching_updates.sql
```

## Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| `KIMI_API_KEY not configured` | Missing .env variable | Add `KIMI_API_KEY=...` to .env |
| `GOOGLE_API_KEY not found` | Missing Gemini key | Add `GEMINI_API_KEY=...` to .env |
| `SyntaxError in JSON parse` | Model returned invalid JSON | Check model API response |
| `Incomplete pairs structure` | Missing left/right items | Verify question data in database |
| `Mismatch between matches count` | Unequal left/right indices | Fix matches array in database |

## Performance Notes

- **Fetch**: ~1-2 seconds per 100 questions
- **Validation**: ~30-60 seconds per question (3 API calls)
- **Total time**: ~10-15 minutes for 100 questions with all API calls

## Troubleshooting

### No questions found
```
Check:
1. Certification ID exists
2. Quizzes linked to certification
3. Questions linked to quizzes
4. Questions have type = "matching"
```

### Validation always fails
```
Check:
1. GEMINI_API_KEY is valid
2. KIMI_API_KEY is valid
3. API rate limits not exceeded
4. Network connectivity
```

### SQL file empty
```
Likely all questions are valid.
Check JSON results file instead.
```

---

**Version**: 1.0  
**Last Updated**: June 8, 2026  
**Question Type**: Matching  
**Validation Models**: Gemini + Kimi (Triple Validation)


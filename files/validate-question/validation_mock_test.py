#!/usr/bin/env python3
"""
Simple validation script for Mock Test MCQ questions and their explanations.
Validates that:
1. Correct answer is indeed valid
2. Explanation makes sense
3. Records results in $date/$certification_id_mock_test_results.json
"""

import json
import os
from typing import List, Dict, Any
from dotenv import load_dotenv
from supabase import create_client, Client
import google.generativeai as genai
import requests
from datetime import datetime
from pathlib import Path

# Load environment variables
load_dotenv()

SUPABASE_URL = os.getenv("NEXT_PUBLIC_SUPABASE_URL_PROD")
SUPABASE_SERVICE_ROLE_KEY = os.getenv("NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD")
GOOGLE_API_KEY = os.getenv("GEMINI_API_KEY")
KIMI_API_KEY = "sk-nmtiCVe0iifBCwjflNLJONLzRjRI0Fjz3eQ67C5NDTBDR1ZY"
import pdb
pdb.set_trace()
# Initialize Supabase client
supabase: Client = create_client(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

# Initialize Google Gemini client
gemini_model = None
if GOOGLE_API_KEY:
    genai.configure(api_key=GOOGLE_API_KEY)
    gemini_model = genai.GenerativeModel("gemini-2.5-flash")
    print("✓ Gemini API configured")
else:
    print("⚠️ Warning: GOOGLE_API_KEY not found")

# Initialize Kimi client
kimi_model = None
if KIMI_API_KEY:
    kimi_model = "kimi"  # Marker to use Kimi API
    print("✓ Kimi API configured")
else:
    print("⚠️ Warning: KIMI_API_KEY not found")

# Select primary model
SELECTED_MODEL = "gemini"  # Options: "gemini" or "kimi"
print(f"\nℹ️  Primary model selected: {SELECTED_MODEL.upper()}")

# Configuration for different validation steps
VALIDATION_MODELS = {
    "initial_validation": "gemini",      # Step 1: Use Gemini for initial validation
    "double_validation": "kimi",         # Step 2: Use Kimi for double validation
    "explanation_validation": "gemini"   # Step 3: Use Gemini for explanation validation
}

print(f"\n📋 Validation Step Models:")
print(f"   Step 1 (Initial):      {VALIDATION_MODELS['initial_validation'].upper()}")
print(f"   Step 2 (Double):       {VALIDATION_MODELS['double_validation'].upper()}")
print(f"   Step 3 (Explanation):  {VALIDATION_MODELS['explanation_validation'].upper()}")

if not gemini_model and not kimi_model:
    print("❌ ERROR: No AI model API keys configured!")
    exit(1)


def call_kimi_api(prompt: str) -> str:
    """
    Call Kimi API with the given prompt.
    Raises exceptions on failure - does NOT fall back to other models.
    
    Args:
        prompt: The prompt to send to Kimi
        
    Returns:
        Response text from Kimi API
        
    Raises:
        Exception: If API call fails or authentication is invalid
    """
    url = "https://api.moonshot.cn/v1/chat/completions"
    headers = {
        "Authorization": f"Bearer {KIMI_API_KEY}",
        "Content-Type": "application/json"
    }
    payload = {
        "model": "moonshot-v1-8k",
        "messages": [
            {
                "role": "user",
                "content": prompt
            }
        ],
        "temperature": 0.7,
        "max_tokens": 2000
    }
    
    print(f"   [Kimi API Call]", end="")
    
    try:
        response = requests.post(url, headers=headers, json=payload, timeout=30)
        
        # Handle authentication errors specifically
        if response.status_code == 401:
            raise Exception(f"Kimi Authentication Failed (401): Invalid API key. Please check KIMI_API_KEY in .env. Response: {response.json()}")
        
        # Handle other HTTP errors
        if response.status_code >= 400:
            try:
                error_detail = response.json()
                raise Exception(f"Kimi API Error ({response.status_code}): {error_detail}")
            except ValueError:
                raise Exception(f"Kimi API Error ({response.status_code}): {response.text}")
        
        result = response.json()
        
        if "choices" in result and len(result["choices"]) > 0:
            return result["choices"][0]["message"]["content"]
        else:
            raise Exception(f"Unexpected Kimi response format (no choices): {result}")
            
    except requests.exceptions.Timeout:
        raise Exception("Kimi API Request Timeout (30s exceeded)")
    except requests.exceptions.ConnectionError as e:
        raise Exception(f"Kimi API Connection Error: {str(e)}")
    except requests.exceptions.RequestException as e:
        raise Exception(f"Kimi API Request Error: {str(e)}")
    except Exception as e:
        if "Kimi" in str(e):
            raise  # Re-raise Kimi-specific errors
        raise Exception(f"Kimi API Error: {str(e)}")


def generate_content(prompt: str, use_model: str = SELECTED_MODEL) -> str:
    """
    Generate content using the selected AI model (Gemini or Kimi).
    Uses the specified model or raises exception - NO FALLBACK.
    
    Args:
        prompt: The prompt to send
        use_model: Which model to use ("gemini" or "kimi")
        
    Returns:
        Response text from the model
        
    Raises:
        Exception: If model is unavailable or API call fails
    """
    if use_model == "kimi":
        if not kimi_model:
            raise Exception("Kimi model requested but KIMI_API_KEY not configured in .env")
        print(f"   [Using Kimi]", end="")
        return call_kimi_api(prompt)
    
    elif use_model == "gemini":
        if not gemini_model:
            raise Exception("Gemini model requested but GOOGLE_API_KEY not configured in .env")
        print(f"   [Using Gemini]", end="")
        return gemini_model.generate_content(prompt).text
    
    else:
        raise Exception(f"Unknown model: {use_model}. Use 'gemini' or 'kimi'")


def get_mock_tests_by_certification(certification_id: int) -> List[Dict[str, Any]]:
    """
    Fetch all mock tests for a given certification ID.
    
    Args:
        certification_id: The certification ID to filter mock tests
        
    Returns:
        List of mock test dictionaries
    """
    try:
        response = supabase.table("mock_tests").select("*").eq(
            "certification_id", certification_id
        ).execute()
        
        mock_tests = response.data
        print(f"Found {len(mock_tests)} mock tests for certification ID: {certification_id}")
        return mock_tests
        
    except Exception as e:
        print(f"Error fetching mock tests: {str(e)}")
        return []


def get_mock_test_questions(mock_test_id: str, question_type: str = "mcq") -> List[Dict[str, Any]]:
    """
    Fetch all MCQ type questions for a given mock test ID directly from mock_test_questions table.
    
    Args:
        mock_test_id: The mock test ID
        question_type: Type of question (default: "mcq")
        
    Returns:
        List of question dictionaries with full data
    """
    try:
        # Get all questions directly from mock_test_questions table with full question data
        mock_test_questions_response = supabase.table("mock_test_questions").select(
            "*"
        ).eq("mock_test_id", mock_test_id).execute()
        
        all_questions = mock_test_questions_response.data
        
        if not all_questions:
            print(f"  No questions found for mock test: {mock_test_id}")
            return []
        
        # Filter by question_type if needed
        if question_type:
            all_questions = [q for q in all_questions if q.get("question_type") == question_type]
        
        print(f"  Fetched {len(all_questions)} {question_type} questions")
        return all_questions
        
    except Exception as e:
        print(f"Error fetching mock test questions: {str(e)}")
        return []


def validate_with_gemini(question: Dict[str, Any]) -> Dict[str, Any]:
    """
    Use AI model (Gemini or Kimi) to validate MCQ questions with DOUBLE VALIDATION:
    1. Initial validation: If marked answer is correct or incorrect
    2. Double validation: If answer is incorrect, validate the suggested correction
    3. Explanation validation
    
    Args:
        question: Question dictionary
        
    Returns:
        Validation result with:
        - correct_answer_valid: bool (is the marked answer actually correct?)
        - actual_correct_index: int (which answer should be correct?)
        - actual_correct_letter: str (letter representation)
        - answer_validation_confidence: str (high/medium/low - after double validation)
        - explanation_valid: bool
    """
    if not gemini_model and not kimi_model:
        return {
            "is_valid": False,
            "correct_answer_valid": False,
            "actual_correct_index": None,
            "actual_correct_letter": None,
            "reason": "No model available",
            "error": "Neither Gemini nor Kimi API is configured"
        }
    
    try:
        question_text = question.get("question_text", "")
        options = question.get("options", [])
        marked_correct_index = question.get("correct_answer")
        explanation = question.get("explanation", "")
        
        if not explanation or len(explanation.strip()) == 0:
            return {
                "is_valid": False,
                "correct_answer_valid": False,
                "actual_correct_index": None,
                "actual_correct_letter": None,
                "reason": "No explanation provided",
                "error": "Empty explanation"
            }
        
        # For MCQ, correct_answer is a list with single element [0], [1], etc.
        if isinstance(marked_correct_index, list):
            if not marked_correct_index or not isinstance(marked_correct_index[0], int):
                return {
                    "is_valid": False,
                    "correct_answer_valid": False,
                    "actual_correct_index": None,
                    "actual_correct_letter": None,
                    "reason": "Invalid correct answer format",
                    "error": "correct_answer must be a list with single integer for MCQ"
                }
            marked_correct_index = marked_correct_index[0]
        elif isinstance(marked_correct_index, int):
            # Handle both formats: [0] or 0
            pass
        else:
            return {
                "is_valid": False,
                "correct_answer_valid": False,
                "actual_correct_index": None,
                "actual_correct_letter": None,
                "reason": "Invalid correct answer format",
                "error": "correct_answer must be list [n] or integer n for MCQ"
            }
        
        # Validate index is within range
        if marked_correct_index >= len(options) or marked_correct_index < 0:
            return {
                "is_valid": False,
                "correct_answer_valid": False,
                "actual_correct_index": None,
                "actual_correct_letter": None,
                "reason": "Invalid correct answer index",
                "error": f"Index {marked_correct_index} out of range (0-{len(options)-1})"
            }
        
        # Format options for Gemini
        options_text = "\n".join([f"{chr(65 + i)}) {opt}" for i, opt in enumerate(options)])
        marked_letter = chr(65 + marked_correct_index)
        
        # STEP 1: Initial validation
        print(f"   [Validation Step 1/3] Initial answer validation ({VALIDATION_MODELS['initial_validation'].upper()})...")
        initial_validation_prompt = f"""
You are an expert exam validator. Analyze this MCQ question.

QUESTION:
{question_text}

OPTIONS:
{options_text}

MARKED CORRECT ANSWER IN DATABASE: {marked_letter} (index: {marked_correct_index})

Your task:
1. Determine the ACTUAL correct answer for this question based on factual accuracy
2. Check if the MARKED answer is correct or incorrect
3. If incorrect, specify which answer SHOULD be correct

Respond ONLY in this JSON format (no markdown, no extra text):
{{
    "marked_answer_index": {marked_correct_index},
    "marked_answer_letter": "{marked_letter}",
    "actual_correct_index": 2,
    "actual_correct_letter": "C",
    "correct_answer_valid": true/false,
    "reason": "brief reason why this is the correct answer"
}}
"""
        
        try:
            response = generate_content(initial_validation_prompt, VALIDATION_MODELS['initial_validation'])
        except Exception as e:
            print(f"\n❌ ERROR in Step 1: {str(e)}")
            return {
                "is_valid": False,
                "error": f"Validation failed: {str(e)}",
                "correct_answer_valid": False,
                "explanation_valid": False
            }
        
        response_text = response.strip()
        
        # Extract JSON from initial validation
        try:
            import re
            json_match = re.search(r'\{.*\}', response_text, re.DOTALL)
            if json_match:
                initial_result = json.loads(json_match.group())
            else:
                initial_result = json.loads(response_text)
        except json.JSONDecodeError:
            return {
                "is_valid": False,
                "correct_answer_valid": False,
                "actual_correct_index": None,
                "actual_correct_letter": None,
                "reason": "Could not parse initial validation response",
                "error": response_text[:200]
            }
        
        # STEP 2: Double validation - verify the suggested answer is correct
        actual_answer_index = initial_result.get("actual_correct_index")
        actual_answer_letter = chr(65 + actual_answer_index) if actual_answer_index is not None else "?"
        
        print(f"   [Validation Step 2/3] Double-checking suggested answer: {actual_answer_letter} ({VALIDATION_MODELS['double_validation'].upper()})...")
        double_validation_prompt = f"""
You are an expert exam validator. Double-check this answer.

QUESTION:
{question_text}

OPTIONS:
{options_text}

SUGGESTED CORRECT ANSWER: {actual_answer_letter} (index: {actual_answer_index})

Your task:
1. Verify that {actual_answer_letter} is definitively the correct answer
2. Confirm it's factually accurate
3. Rate your confidence level

IMPORTANT: Be ABSOLUTELY CERTAIN this is correct. If you have ANY doubt, respond with low confidence.

Respond ONLY in this JSON format (no markdown, no extra text):
{{
    "is_definitively_correct": true/false,
    "confidence": "high|medium|low",
    "verification_reason": "brief explanation of why you verified this is correct",
    "double_validation_passed": true/false
}}
"""
        
        try:
            response = generate_content(double_validation_prompt, VALIDATION_MODELS['double_validation'])
        except Exception as e:
            print(f"\n❌ ERROR in Step 2: {str(e)}")
            return {
                "is_valid": False,
                "error": f"Validation failed: {str(e)}",
                "correct_answer_valid": False,
                "explanation_valid": False
            }
        
        response_text = response.strip()
        
        # Extract JSON from double validation
        try:
            json_match = re.search(r'\{.*\}', response_text, re.DOTALL)
            if json_match:
                double_validation = json.loads(json_match.group())
            else:
                double_validation = json.loads(response_text)
        except json.JSONDecodeError:
            double_validation = {
                "is_definitively_correct": False,
                "confidence": "low",
                "double_validation_passed": False
            }
        
        # Combine results
        is_initial_correct = initial_result.get("correct_answer_valid", False)
        double_validation_passed = double_validation.get("double_validation_passed", double_validation.get("is_definitively_correct", False))
        confidence = double_validation.get("confidence", "low")
        
        # Only accept the corrected answer if double validation passed AND high confidence
        if not is_initial_correct and double_validation_passed and confidence == "high":
            answer_is_valid = True
        elif is_initial_correct:
            answer_is_valid = True
        else:
            answer_is_valid = False
            # If double validation failed, revert to marked answer
            if not is_initial_correct and not double_validation_passed:
                actual_answer_index = None
                actual_answer_letter = None
        
        # STEP 3: Validate explanation
        print(f"   [Validation Step 3/3] Validating explanation ({VALIDATION_MODELS['explanation_validation'].upper()})...")
        explanation_validation_prompt = f"""
You are an expert exam validator. Validate the explanation quality.

QUESTION:
{question_text}

OPTIONS:
{options_text}

CORRECT ANSWER: {chr(65 + (actual_answer_index if actual_answer_index is not None else marked_correct_index))}

PROVIDED EXPLANATION:
{explanation}

Your task:
1. Check if explanation clearly explains WHY the correct option is right
2. Check if explanation clearly explains WHY EACH incorrect option is wrong
3. Assess explanation quality

Respond ONLY in this JSON format (no markdown, no extra text):
{{
    "explanation_valid": true/false,
    "explains_correct_option": true/false,
    "explains_incorrect_options": true/false,
    "explanation_issues": "list issues if any"
}}
"""
        
        try:
            response = generate_content(explanation_validation_prompt, VALIDATION_MODELS['explanation_validation'])
        except Exception as e:
            print(f"\n❌ ERROR in Step 3: {str(e)}")
            return {
                "is_valid": False,
                "error": f"Validation failed: {str(e)}",
                "correct_answer_valid": False,
                "explanation_valid": False
            }
        
        response_text = response.strip()
        
        try:
            json_match = re.search(r'\{.*\}', response_text, re.DOTALL)
            if json_match:
                explanation_result = json.loads(json_match.group())
            else:
                explanation_result = json.loads(response_text)
        except json.JSONDecodeError:
            explanation_result = {
                "explanation_valid": False,
                "explanation_issues": "Could not parse response"
            }
        
        # Final result
        final_result = {
            "marked_answer_index": marked_correct_index,
            "marked_answer_letter": marked_letter,
            "actual_correct_index": actual_answer_index if answer_is_valid else marked_correct_index,
            "actual_correct_letter": actual_answer_letter if answer_is_valid else marked_letter,
            "correct_answer_valid": answer_is_valid,
            "answer_validation_confidence": confidence,
            "double_validation_passed": double_validation_passed,
            "reason_for_correct_answer": initial_result.get("reason", ""),
            "verification_reason": double_validation.get("verification_reason", ""),
            "explanation_valid": explanation_result.get("explanation_valid", False),
            "explains_correct_option": explanation_result.get("explains_correct_option", False),
            "explains_incorrect_options": explanation_result.get("explains_incorrect_options", False),
            "explanation_issues": explanation_result.get("explanation_issues", ""),
            "is_valid": answer_is_valid and explanation_result.get("explanation_valid", False)
        }
        
        return final_result
        
    except Exception as e:
        return {
            "is_valid": False,
            "correct_answer_valid": False,
            "actual_correct_index": None,
            "actual_correct_letter": None,
            "reason": "Gemini validation error",
            "error": str(e)
        }


def find_correct_answer(question: Dict[str, Any]) -> Dict[str, Any]:
    """
    Use Gemini to find the correct answer for a question.
    
    Args:
        question: Question dictionary
        
    Returns:
        Dictionary with correct_answer indices and validation status
    """
    if not model:
        return {"correct_indices": [], "is_valid": False, "reasoning": "Model not available"}
    
    try:
        question_text = question.get("text", "")
        options = question.get("options", [])
        
        # Format options for Gemini
        options_text = "\n".join([f"{chr(65 + i)}) {opt}" for i, opt in enumerate(options)])
        
        answer_prompt = f"""
You are an expert exam validator. Analyze this MCQ question and determine the CORRECT answer.

QUESTION:
{question_text}

OPTIONS:
{options_text}

Your task:
1. Identify which option(s) is/are factually correct
2. Explain why this is the correct answer
3. Explain why each other option is incorrect
4. Rate your confidence level (high/medium/low)

IMPORTANT RULES:
- If multiple options are correct, list ALL correct options
- Be absolutely certain the answer is factually accurate
- Provide clear reasoning for each decision

Respond ONLY in this JSON format (no markdown, no extra text):
{{
    "correct_indices": [0, 1],
    "correct_letters": ["A", "B"],
    "reasoning": "Brief explanation of why these are correct and others are wrong",
    "confidence": "high|medium|low",
    "is_definitive": true/false
}}
"""
        
        response = model.generate_content(answer_prompt)
        response_text = response.text.strip()
        
        # Extract JSON from response
        try:
            import re
            json_match = re.search(r'\{.*\}', response_text, re.DOTALL)
            if json_match:
                result = json.loads(json_match.group())
            else:
                result = json.loads(response_text)
            
            # Mark as valid only if high confidence and definitive
            result["is_valid"] = result.get("confidence") == "high" and result.get("is_definitive", False)
            return result
            
        except json.JSONDecodeError:
            return {"correct_indices": [], "is_valid": False, "reasoning": f"Error parsing response: {response_text[:200]}"}
        
    except Exception as e:
        return {"correct_indices": [], "is_valid": False, "reasoning": f"Error: {str(e)}"}


def generate_corrected_explanation(question: Dict[str, Any], correct_answer_index: int = None) -> str:
    """
    Generate a corrected explanation using AI model (Gemini or Kimi).
    
    Args:
        question: Question dictionary
        correct_answer_index: Override correct answer index (optional, single integer for MCQ)
        
    Returns:
        Corrected explanation string
    """
    if not gemini_model and not kimi_model:
        return ""
    
    try:
        question_text = question.get("question_text", "")
        options = question.get("options", [])
        
        # For MCQ, use provided correct answer index or from question
        if correct_answer_index is not None:
            correct_idx = correct_answer_index
        else:
            correct_idx = question.get("correct_answer")
        
        # Handle list format [0] or integer 0
        if isinstance(correct_idx, list):
            if not correct_idx or not isinstance(correct_idx[0], int):
                return "Error: Invalid correct answer index - must be list [n] or integer n for MCQ"
            correct_idx = correct_idx[0]
        elif isinstance(correct_idx, int):
            pass
        else:
            return "Error: Invalid correct answer index format"
        
        if correct_idx < 0 or correct_idx >= len(options):
            return f"Error: Correct answer index {correct_idx} out of range"
        
        # Format options for Gemini
        options_text = "\n".join([f"{chr(65 + i)}) {opt}" for i, opt in enumerate(options)])
        correct_letter = chr(65 + correct_idx)
        
        correction_prompt = f"""
You are an expert exam question writer. Generate a comprehensive explanation for this MCQ question.

QUESTION:
{question_text}

OPTIONS:
{options_text}

CORRECT ANSWER: {correct_letter}

Generate an explanation that MUST follow this EXACT structure:
1. Start with "Option [LETTER] (correct) is [OPTION_TEXT]. " followed by clear explanation of WHY it's correct
2. For EACH incorrect option, explain "Option [LETTER] (incorrect) is [OPTION_TEXT], which is..." or "Option [LETTER] is incorrect because..."
3. Each option should be clearly identified by its letter and marked as (correct) or (incorrect)
4. Provide factual reasoning for rejecting each incorrect option
5. Be educational and specific, not vague

Example format:
"Option C (correct) is the `-backend-config` flag, which allows passing backend configuration values during initialization. Option A (incorrect) is wrong because terraform uses TF_VAR_ for variables, not backend config. Option B (incorrect) is wrong because .tfvars files are for input variables. Option D (incorrect) is wrong because local variables are internal configuration."

Respond with ONLY the explanation text (no JSON, no markdown, no extra formatting):
"""
        
        response = generate_content(correction_prompt, VALIDATION_MODELS['explanation_validation'])
        corrected_explanation = response.strip()
        return corrected_explanation
        
    except Exception as e:
        return f"Error generating explanation: {str(e)}"


def validate_explanation(question: Dict[str, Any]) -> Dict[str, Any]:
    """
    Validate using Gemini if correct answer is valid and explanation makes sense.
    
    Args:
        question: Question dictionary
        
    Returns:
        Validation result dictionary
    """
    # Try to get question_id from different possible field names
    question_id = question.get("id") or question.get("question_id") or question.get("q_id")
    
    result = {
        "question_id": question_id,
        "is_valid": True,
    }
    
    try:
        options = question.get("options", [])
        correct_answer = question.get("correct_answer")
        
        # Check if options list is valid
        if not options or not isinstance(options, list):
            result["is_valid"] = False
            result["error"] = "Options must be a non-empty list"
            return result
        
        # Check if correct_answer is None
        if correct_answer is None:
            result["is_valid"] = False
            result["error"] = "Correct answer is missing (None)"
            return result
        
        # For MCQ, correct_answer is a list with single element [0], [1], etc.
        if isinstance(correct_answer, list):
            if not correct_answer or not isinstance(correct_answer[0], int):
                result["is_valid"] = False
                result["error"] = "Correct answer must be a list with single integer for MCQ"
                return result
            correct_answer = correct_answer[0]
        elif isinstance(correct_answer, int):
            # Handle both formats: [0] or 0
            pass
        else:
            result["is_valid"] = False
            result["error"] = "Correct answer must be list [n] or integer n for MCQ"
            return result
        
        # Validate index is within range
        if correct_answer < 0 or correct_answer >= len(options):
            result["is_valid"] = False
            result["error"] = f"Correct answer index {correct_answer} out of range (0-{len(options)-1})"
            return result
        
        # Use Gemini for validation
        gemini_result = validate_with_gemini(question)
        result.update(gemini_result)
        
        # Ensure is_valid reflects both format AND content validation
        if not result.get("correct_answer_valid") or not result.get("explanation_valid"):
            result["is_valid"] = False
        
    except Exception as e:
        result["is_valid"] = False
        result["error"] = str(e)
    
    return result


def validate_all_mock_test_questions(certification_id: int) -> Dict[str, Any]:
    """
    Validate all MCQ questions across all mock tests for a certification.
    Save invalid questions to results file and SQL file.
    
    Args:
        certification_id: The certification ID to validate
        
    Returns:
        Validation summary dictionary
    """
    # Get all mock tests for this certification
    mock_tests = get_mock_tests_by_certification(certification_id)
    
    if not mock_tests:
        print("No mock tests found for this certification")
        return {"total": 0, "valid": 0, "invalid": 0, "results_file": None, "sql_file": None}
    
    # Collect all questions across all mock tests
    all_questions = []
    for mock_test in mock_tests:
        questions = get_mock_test_questions(mock_test["id"], "mcq")
        all_questions.extend(questions)
    
    if not all_questions:
        print("No MCQ questions found in mock tests")
        return {"total": 0, "valid": 0, "invalid": 0, "results_file": None, "sql_file": None}
    
    # Create results directory with date
    today = datetime.now().strftime("%Y-%m-%d")
    results_dir = Path(f"../{today}")
    results_dir.mkdir(parents=True, exist_ok=True)
    
    # Results file paths
    results_file = results_dir / f"{certification_id}_mock_test_results.json"
    sql_file = results_dir / f"{certification_id}_mock_test_updates.sql"
    sql_generic_file = results_dir / f"{certification_id}_mock_test_generic_updates.sql"
    
    # Load existing results if file exists
    invalid_questions = []
    if results_file.exists():
        try:
            with open(results_file, "r") as f:
                content = f.read().strip()
                if content:
                    invalid_questions = json.loads(content)
        except (json.JSONDecodeError, IOError) as e:
            print(f"⚠️  Warning: Could not load existing results file ({str(e)}). Starting fresh.")
            invalid_questions = []
    
    summary = {
        "total": len(all_questions),
        "valid": 0,
        "invalid": 0,
        "results_file": str(results_file),
        "sql_file": str(sql_file),
        "sql_generic_file": str(sql_generic_file),
    }
    
    print(f"\nValidating {len(all_questions)} questions from mock tests...")
    print("=" * 80)
    
    all_sql_updates = []
    all_generic_sql_updates = []
    sql_file_initialized = False
    sql_generic_file_initialized = False
    
    for idx, question in enumerate(all_questions, 1):
        validation_result = validate_explanation(question)
        
        # Debug: Print available fields on first question
        if idx == 1:
            print(f"\nDEBUG - First question fields: {list(question.keys())}")
            print(f"DEBUG - Question data: {question}\n")
        
        if validation_result["is_valid"]:
            summary["valid"] += 1
            status = "✓ VALID"
            print(f"{idx}. {validation_result['question_id']}: {status}")
        else:
            summary["invalid"] += 1
            status = "✗ INVALID"
            print(f"{idx}. {validation_result['question_id']}: {status}")
            
            if validation_result.get("error"):
                print(f"   Error: {validation_result['error']}")
            if validation_result.get("reason"):
                print(f"   Reason: {validation_result['reason']}")
            
            # Show specific issues
            if not validation_result.get("correct_answer_valid"):
                print(f"   ✗ Correct answer is factually incorrect")
            if not validation_result.get("explanation_valid"):
                print(f"   ✗ Explanation is invalid or incomplete")
            
            # Generate SQL update statement for invalid questions
            question_id = validation_result["question_id"]
            question_text = question.get("question_text", "")
            sql_updates = []
            generic_sql_updates = []
            corrected_answer_index = None
            
            # If correct_answer is invalid, get the actual correct answer from validation
            if not validation_result.get("correct_answer_valid"):
                print(f"   Correcting answer...")
                
                # Use the actual_correct_index from validation result
                corrected_answer_index = validation_result.get("actual_correct_index")
                
                print(f"   Should be corrected to index: {corrected_answer_index}")
                
                if corrected_answer_index is not None:
                    # For MCQ, format as '{index}' (single digit in curly braces)
                    corrected_answer = f"{{{corrected_answer_index}}}"
                    marked_answer = question.get("correct_answer")
                    
                    # Build comment
                    comment = f"CORRECTED ANSWER (was {marked_answer}, should be {corrected_answer_index})"
                    
                    # SQL update by ID (environment-specific)
                    sql_stmt = f"UPDATE public.mock_test_questions SET correct_answer = '{corrected_answer}' WHERE id = '{question_id}'; -- {comment}"
                    sql_updates.append(sql_stmt)
                    all_sql_updates.append(sql_stmt)
                    
                    # SQL update by question_text (portable across environments)
                    question_text_escaped = question_text.replace("'", "''")
                    generic_sql_stmt = f"UPDATE public.mock_test_questions SET correct_answer = '{corrected_answer}' WHERE question_text = E'{question_text_escaped}'; -- {comment}"
                    generic_sql_updates.append(generic_sql_stmt)
                    all_generic_sql_updates.append(generic_sql_stmt)
                else:
                    print(f"   ⚠️ Could not determine corrected answer")
            
            # If explanation is invalid, generate corrected explanation
            if not validation_result.get("explanation_valid"):
                print(f"   Correcting explanation...")
                
                # Use corrected answer index if we just corrected it, otherwise use current answer
                answer_index_for_explanation = corrected_answer_index if corrected_answer_index is not None else question.get("correct_answer")
                
                # Handle list format [0] or integer 0 - extract single value
                if isinstance(answer_index_for_explanation, list):
                    answer_index_for_explanation = answer_index_for_explanation[0] if answer_index_for_explanation else None
                
                # Only generate explanation if we have a valid answer index
                if answer_index_for_explanation is not None and isinstance(answer_index_for_explanation, int):
                    corrected_explanation = generate_corrected_explanation(question, answer_index_for_explanation)
                    corrected_explanation_escaped = corrected_explanation.replace("'", "''")
                    
                    # Build comment
                    comment = "CORRECTED EXPLANATION"
                    
                    # SQL update by ID (environment-specific)
                    sql_stmt = f"UPDATE public.mock_test_questions SET explanation = E'{corrected_explanation_escaped}' WHERE id = '{question_id}'; -- {comment}"
                    sql_updates.append(sql_stmt)
                    all_sql_updates.append(sql_stmt)
                    
                    # SQL update by question_text (portable across environments)
                    question_text_escaped = question_text.replace("'", "''")
                    generic_sql_stmt = f"UPDATE public.mock_test_questions SET explanation = E'{corrected_explanation_escaped}' WHERE question_text = E'{question_text_escaped}'; -- {comment}"
                    generic_sql_updates.append(generic_sql_stmt)
                    all_generic_sql_updates.append(generic_sql_stmt)
                else:
                    print(f"   ⚠️ Could not generate explanation - invalid answer index")
            
            # Add to invalid questions list
            invalid_record = {
                "question_id": question_id,
                "mock_test_id": question.get("mock_test_id"),
                "error": validation_result.get("error"),
                "reason": validation_result.get("reason"),
                "original_answer": question.get("correct_answer"),
                "corrected_answer": corrected_answer_index,
                "correct_answer_valid": validation_result.get("correct_answer_valid"),
                "actual_correct_index": validation_result.get("actual_correct_index"),
                "explanation_valid": validation_result.get("explanation_valid"),
                "explanation_issues": validation_result.get("explanation_issues"),
                "question_data": {
                    "question_text": question.get("question_text", "")[:200],
                    "options": question.get("options", []),
                    "correct_answer": question.get("correct_answer"),
                    "explanation": question.get("explanation", "")[:200],
                },
                "sql_updates": sql_updates
            }
            
            invalid_questions.append(invalid_record)
            
            # Save JSON file incrementally
            with open(results_file, "w") as f:
                json.dump(invalid_questions, f, indent=2)
            print(f"   ✓ Saved to JSON file")
            
            # Initialize SQL file with BEGIN if not already done
            if not sql_file_initialized:
                with open(sql_file, "w") as f:
                    f.write("BEGIN;\n\n")
                sql_file_initialized = True
            
            # Append SQL statements to file
            with open(sql_file, "a") as f:
                for sql_stmt in sql_updates:
                    f.write(sql_stmt + "\n")
            print(f"   ✓ Saved to SQL file")
            
            # Initialize generic SQL file with BEGIN if not already done
            if not sql_generic_file_initialized:
                with open(sql_generic_file, "w") as f:
                    f.write("BEGIN;\n\n")
                sql_generic_file_initialized = True
            
            # Append generic SQL statements to file
            with open(sql_generic_file, "a") as f:
                for sql_stmt in generic_sql_updates:
                    f.write(sql_stmt + "\n")
            print(f"   ✓ Saved to generic SQL file")
    
    # Close SQL file with COMMIT
    if sql_file_initialized:
        with open(sql_file, "a") as f:
            f.write("\nCOMMIT;\n")
    else:
        with open(sql_file, "w") as f:
            f.write("BEGIN;\n-- No updates required - all questions are valid\nCOMMIT;\n")
    
    # Close generic SQL file with COMMIT
    if sql_generic_file_initialized:
        with open(sql_generic_file, "a") as f:
            f.write("\nCOMMIT;\n")
    else:
        with open(sql_generic_file, "w") as f:
            f.write("BEGIN;\n-- No updates required - all questions are valid\nCOMMIT;\n")
    
    print("=" * 80)
    print("\nValidation Summary:")
    print(f"  Total questions: {summary['total']}")
    print(f"  ✓ Valid: {summary['valid']}")
    print(f"  ✗ Invalid: {summary['invalid']}")
    if summary['total'] > 0:
        print(f"  Pass rate: {(summary['valid'] / summary['total'] * 100):.1f}%")
    print(f"\nResults saved to:")
    print(f"  JSON:          {results_file}")
    print(f"  SQL (by ID):   {sql_file}")
    print(f"  SQL (by Text): {sql_generic_file}")
    
    return summary


def main():
    """Main execution function."""
    # Change this to the certification ID you want to validate
    CERTIFICATION_ID = 4  # Example: Solutions Architect
    
    print(f"\n{'='*80}")
    print(f"Starting mock test validation for Certification ID: {CERTIFICATION_ID}")
    print(f"Supabase URL: {SUPABASE_URL}")
    print(f"Primary Model: {SELECTED_MODEL.upper()}")
    print(f"{'='*80}\n")
    
    validate_all_mock_test_questions(CERTIFICATION_ID)


if __name__ == "__main__":
    main()

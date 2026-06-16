#!/usr/bin/env python3
"""
Simple validation script for MCQ questions and their explanations.
Validates that:
1. Correct answer is indeed valid
2. Explanation makes sense
"""

import json
import os
import re
from typing import List, Dict, Any
from dotenv import load_dotenv
from supabase import create_client, Client
import google.generativeai as genai
from datetime import datetime
from pathlib import Path

# Load environment variables
load_dotenv()

SUPABASE_URL = os.getenv("NEXT_PUBLIC_SUPABASE_URL")
SUPABASE_SERVICE_ROLE_KEY = os.getenv("SUPABASE_SERVICE_ROLE_KEY")
GOOGLE_API_KEY = os.getenv("GEMINI_API_KEY")
KIMI_API_KEY = os.getenv("KIMI_API_KEY")

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

# Validation step models
VALIDATION_MODELS = {
    "initial_validation": "gemini",      # Step 1: Use Gemini for initial validation
    "double_validation": "kimi",         # Step 2: Use Kimi for double validation
    "explanation_validation": "gemini"   # Step 3: Use Gemini for explanation validation
}

print(f"\n📋 Validation Step Models:")
print(f"   Step 1 (Initial):      {VALIDATION_MODELS['initial_validation'].upper()}")
print(f"   Step 2 (Double):       {VALIDATION_MODELS['double_validation'].upper()}")
print(f"   Step 3 (Explanation):  {VALIDATION_MODELS['explanation_validation'].upper()}")

# For backward compatibility
model = gemini_model


def get_questions_by_certification(certification_id: int) -> List[Dict[str, Any]]:
    """
    Fetch all MCQ type questions for a given certification ID with pagination.
    
    Args:
        certification_id: The certification ID to filter questions
        
    Returns:
        List of question dictionaries
    """
    try:
        # Get all quizzes for the certification
        quizzes_response = supabase.table("quiz").select("id").eq(
            "certification_id", certification_id
        ).execute()
        
        quiz_ids = [quiz["id"] for quiz in quizzes_response.data]
        
        if not quiz_ids:
            print(f"No quizzes found for certification ID: {certification_id}")
            return []
        
        print(f"Found {len(quiz_ids)} quizzes for certification ID: {certification_id}")
        
        # Get all question IDs from quiz_question junction table for these quizzes
        # Using pagination to handle large datasets
        all_question_ids = []
        page_size = 1000
        offset = 0
        
        while True:
            quiz_questions_response = supabase.table("quiz_question").select(
                "question_id"
            ).in_("quiz_id", quiz_ids).range(offset, offset + page_size - 1).execute()
            
            batch = quiz_questions_response.data
            if not batch:
                break
            
            all_question_ids.extend([qq["question_id"] for qq in batch])
            print(f"Fetched {len(all_question_ids)} question IDs so far...")
            
            if len(batch) < page_size:
                break
            
            offset += page_size
        
        if not all_question_ids:
            print(f"No questions found for the quizzes")
            return []
        
        print(f"Found {len(all_question_ids)} questions linked to quizzes")
        
        # Get all MCQ questions with these IDs using pagination
        # Batch the question IDs to avoid "JSON could not be generated" error
        all_questions = []
        batch_size = 100  # Process question IDs in batches of 100
        
        for batch_start in range(0, len(all_question_ids), batch_size):
            batch_end = min(batch_start + batch_size, len(all_question_ids))
            id_batch = all_question_ids[batch_start:batch_end]
            
            print(f"Processing question batch {batch_start}-{batch_end}/{len(all_question_ids)}...")
            
            # Get all MCQ questions with these IDs using pagination
            offset = 0
            page_size = 1000
            
            while True:
                questions_response = supabase.table("question").select(
                    "*"
                ).eq("type", "mcq").in_("id", id_batch).range(offset, offset + page_size - 1).execute()
                
                batch = questions_response.data
                if not batch:
                    break
                
                all_questions.extend(batch)
                print(f"  Fetched {len(all_questions)} MCQ questions so far...")
                
                if len(batch) < page_size:
                    break
                
                offset += page_size
        
        print(f"Found {len(all_questions)} total MCQ questions")
        
        return all_questions
        
    except Exception as e:
        print(f"Error fetching questions: {str(e)}")
        return []


def call_kimi_api(prompt: str) -> str:
    """
    Call Kimi API using OpenAI SDK (Kimi is OpenAI-compatible).
    Raises exceptions on failure - does NOT fall back to other models.
    
    Args:
        prompt: The prompt to send to Kimi
        
    Returns:
        Response text from Kimi API
        
    Raises:
        Exception: If API call fails or authentication is invalid
    """
    try:
        from openai import OpenAI
        
        # Initialize Kimi client using OpenAI SDK
        kimi_client = OpenAI(
            api_key=KIMI_API_KEY,
            base_url="https://api.moonshot.ai/v1"
        )
        
        # Make API call using OpenAI SDK
        completion = kimi_client.chat.completions.create(
            model="kimi-k2.6",  # Latest Kimi model
            messages=[
                {
                    "role": "user",
                    "content": prompt
                }
            ],
            temperature=1,  # Kimi K2.6 requires temperature=1 (fixed value)
            max_tokens=2000
        )
        
        # Extract response
        if completion.choices and len(completion.choices) > 0:
            return completion.choices[0].message.content
        else:
            raise Exception(f"Unexpected Kimi response format (no choices)")
            
    except ImportError:
        raise Exception("OpenAI SDK not installed. Run: pip install openai")
    except Exception as e:
        error_msg = str(e)
        
        # Handle authentication errors specifically
        if "401" in error_msg or "authentication" in error_msg.lower() or "invalid" in error_msg.lower():
            raise Exception(f"Kimi Authentication Failed: Invalid API key or insufficient permissions. Please verify KIMI_API_KEY in .env. Error: {error_msg}")
        
        # Handle rate limiting
        if "429" in error_msg:
            raise Exception(f"Kimi Rate Limited: Too many requests. Please try again later.")
        
        # Handle timeout
        if "timeout" in error_msg.lower():
            raise Exception(f"Kimi API Request Timeout (30s exceeded)")
        
        # Handle connection errors
        if "connection" in error_msg.lower():
            raise Exception(f"Kimi API Connection Error: {error_msg}")
        
        # Generic error
        raise Exception(f"Kimi API Error: {error_msg}")


def generate_content(prompt: str, use_model: str = "gemini") -> str:
    """
    Generate content using the selected AI model (Gemini or Kimi).
    
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
        return call_kimi_api(prompt)
    
    elif use_model == "gemini":
        if not gemini_model:
            raise Exception("Gemini model requested but GOOGLE_API_KEY not configured in .env")
        return gemini_model.generate_content(prompt).text
    
    else:
        raise Exception(f"Unknown model: {use_model}. Use 'gemini' or 'kimi'")


def validate_with_gemini(question: Dict[str, Any]) -> Dict[str, Any]:
    """
    Use AI models to validate MCQ questions with DOUBLE VALIDATION:
    1. Initial validation (Gemini): If marked answer is correct or incorrect
    2. Double validation (Kimi): If answer is incorrect, validate the suggested correction
    3. Explanation validation (Gemini)
    
    Args:
        question: Question dictionary
        
    Returns:
        Validation result with answer validity and confidence
    """
    if not gemini_model and not kimi_model:
        return {
            "is_valid": False,
            "correct_answer_valid": False,
            "actual_correct_indices": [],
            "reason": "No model available",
            "error": "Neither Gemini nor Kimi API is configured"
        }
    
    try:
        question_text = question.get("text", "")
        options = question.get("options", [])
        correct_answers = question.get("correct_answer", [])
        explanation = question.get("explanation", "")
        
        if not explanation or len(explanation.strip()) == 0:
            return {
                "is_valid": False,
                "correct_answer_valid": False,
                "actual_correct_indices": [],
                "reason": "No explanation provided",
                "error": "Empty explanation"
            }
        
        # Handle both list and single values
        if not isinstance(correct_answers, list):
            correct_answers = [correct_answers] if correct_answers else []
        
        if not correct_answers:
            return {
                "is_valid": False,
                "correct_answer_valid": False,
                "actual_correct_indices": [],
                "reason": "No correct answer specified",
                "error": "Empty correct_answer"
            }
        
        # Format options for AI models
        options_text = "\n".join([f"{chr(65 + i)}) {opt}" for i, opt in enumerate(options)])
        marked_letters = [chr(65 + idx) for idx in correct_answers]
        marked_letters_str = ", ".join(marked_letters)
        
        # STEP 1: Initial validation (Gemini)
        print(f"   [Validation Step 1/3] Initial answer validation (GEMINI)...")
        initial_validation_prompt = f"""
You are an expert exam validator. Analyze this MCQ question.

QUESTION:
{question_text}

OPTIONS:
{options_text}

MARKED CORRECT ANSWER(S) IN DATABASE: {marked_letters_str} (indices: {correct_answers})

Your task:
1. Determine the ACTUAL correct answer(s) for this question based on factual accuracy
2. Check if the MARKED answer(s) match the ACTUAL answer(s)
3. If incorrect, specify which answer(s) SHOULD be correct

Respond ONLY in this JSON format (no markdown, no extra text):
{{
    "marked_answer_indices": {correct_answers},
    "marked_answer_letters": {marked_letters},
    "actual_correct_indices": [0, 2],
    "actual_correct_letters": ["A", "C"],
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
                "explanation_valid": False,
                "actual_correct_indices": []
            }
        
        response_text = response.strip()
        
        # Extract JSON from initial validation
        try:
            json_match = re.search(r'\{.*\}', response_text, re.DOTALL)
            if json_match:
                initial_result = json.loads(json_match.group())
            else:
                initial_result = json.loads(response_text)
        except json.JSONDecodeError:
            return {
                "is_valid": False,
                "correct_answer_valid": False,
                "actual_correct_indices": [],
                "reason": "Could not parse initial validation response",
                "error": response_text[:200]
            }
        
        # STEP 2: Double validation (Kimi) - verify the suggested answer(s) are correct
        actual_answer_indices = initial_result.get("actual_correct_indices", correct_answers)
        actual_answer_letters = [chr(65 + idx) for idx in actual_answer_indices]
        actual_answer_letters_str = ", ".join(actual_answer_letters)
        
        print(f"   [Validation Step 2/3] Double-checking suggested answer(s): {actual_answer_letters_str} (KIMI)...")
        double_validation_prompt = f"""
You are an expert exam validator. Double-check this/these answer(s).

QUESTION:
{question_text}

OPTIONS:
{options_text}

SUGGESTED CORRECT ANSWER(S): {actual_answer_letters_str} (indices: {actual_answer_indices})

Your task:
1. Verify that {actual_answer_letters_str} is/are definitively the correct answer(s)
2. Confirm it's/they're factually accurate
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
                "explanation_valid": False,
                "actual_correct_indices": []
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
        
        # STEP 3: Validate explanation (Gemini)
        print(f"   [Validation Step 3/3] Validating explanation (GEMINI)...")
        explanation_validation_prompt = f"""
You are an expert exam validator. Validate the explanation quality.

QUESTION:
{question_text}

OPTIONS:
{options_text}

CORRECT ANSWER(S): {actual_answer_letters_str}

PROVIDED EXPLANATION:
{explanation}

Your task:
1. Check if explanation clearly explains WHY the correct option(s) is/are right
2. Check if explanation clearly explains WHY EACH incorrect option is wrong
3. Assess explanation quality and completeness

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
            explanation_result = {
                "explanation_valid": False,
                "explanation_issues": f"Error: {str(e)}"
            }
        else:
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
        
        # Determine if answer is valid based on double validation
        is_initial_correct = initial_result.get("correct_answer_valid", False)
        double_validation_passed = double_validation.get("double_validation_passed", double_validation.get("is_definitively_correct", False))
        confidence = double_validation.get("confidence", "low")
        
        # Only accept the corrected answer if double validation passed AND high confidence
        if not is_initial_correct and double_validation_passed and confidence == "high":
            answer_is_valid = True
            final_answer_indices = actual_answer_indices
        elif is_initial_correct:
            answer_is_valid = True
            final_answer_indices = actual_answer_indices
        else:
            answer_is_valid = False
            # If double validation failed, revert to marked answer
            if not is_initial_correct and not double_validation_passed:
                final_answer_indices = correct_answers
        
        # Final result
        final_result = {
            "marked_answer_indices": correct_answers,
            "marked_answer_letters": marked_letters,
            "actual_correct_indices": final_answer_indices,
            "actual_correct_letters": [chr(65 + idx) for idx in final_answer_indices],
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
            "actual_correct_indices": [],
            "reason": "Validation error",
            "error": str(e)
        }


def generate_corrected_explanation(question: Dict[str, Any]) -> str:
    """
    Generate a corrected explanation using model selected in VALIDATION_MODELS['explanation_validation'].
    
    Args:
        question: Question dictionary
        
    Returns:
        Corrected explanation string
    """
    if not gemini_model and not kimi_model:
        return ""
    
    try:
        question_text = question.get("text", "")
        options = question.get("options", [])
        correct_answers = question.get("correct_answer", [])
        
        # Format options for model
        options_text = "\n".join([f"{chr(65 + i)}) {opt}" for i, opt in enumerate(options)])
        correct_letters = [chr(65 + idx) for idx in correct_answers]
        correct_letters_str = ", ".join(correct_letters)
        
        correction_prompt = f"""
You are an expert exam question writer. Generate a comprehensive explanation for this MCQ question.

QUESTION:
{question_text}

OPTIONS:
{options_text}

CORRECT ANSWER(S): {correct_letters_str}

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
        
        try:
            response = generate_content(correction_prompt, VALIDATION_MODELS['explanation_validation'])
            corrected_explanation = response.strip()
        except Exception as e:
            print(f"\n❌ ERROR in generate_corrected_explanation: {str(e)}")
            return f"Error generating explanation: {str(e)}"
        
        return corrected_explanation
        
    except Exception as e:
        return f"Error generating explanation: {str(e)}"


def generate_corrected_answer(question: Dict[str, Any], correct_answer_indices: List[int] = None) -> str:
    """
    Get the correct answer indices. If provided, use those (from validation), otherwise generate via model.
    
    Args:
        question: Question dictionary
        correct_answer_indices: Pre-validated correct answer indices (optional)
        
    Returns:
        Corrected answer as JSON array string (e.g., "[0]" or "[0, 2]")
    """
    # If we have pre-validated indices, use them
    if correct_answer_indices is not None:
        return json.dumps(correct_answer_indices)
    
    if not gemini_model and not kimi_model:
        return json.dumps(question.get("correct_answer", [0]))
    
    try:
        question_text = question.get("text", "")
        options = question.get("options", [])
        
        # Format options for model
        options_text = "\n".join([f"{chr(65 + i)}) {opt}" for i, opt in enumerate(options)])
        
        answer_prompt = f"""
You are an expert exam validator. Identify the correct answer for this MCQ.

QUESTION:
{question_text}

OPTIONS:
{options_text}

Respond with ONLY a JSON array with the index/indices of the correct answer(s). Examples:
- For option A (first): [0]
- For option C (third): [2]
- For multiple answers: [0, 2]

Do not include any other text.
"""
        
        try:
            response = generate_content(answer_prompt, VALIDATION_MODELS['initial_validation'])
            response_text = response.strip()
        except Exception as e:
            print(f"\n❌ ERROR in generate_corrected_answer: {str(e)}")
            return json.dumps(question.get("correct_answer", [0]))
        
        # Extract JSON array
        json_match = re.search(r'\[\d+(?:,\s*\d+)*\]', response_text)
        if json_match:
            return json_match.group()
        return json.dumps(question.get("correct_answer", [0]))  # Fallback
        
    except Exception as e:
        return json.dumps(question.get("correct_answer", [0]))


def validate_explanation(question: Dict[str, Any]) -> Dict[str, Any]:
    """
    Validate using Gemini if correct answer is valid and explanation makes sense.
    
    Args:
        question: Question dictionary
        
    Returns:
        Validation result dictionary
    """
    result = {
        "question_id": question.get("id"),
        "is_valid": True,
    }
    
    try:
        options = question.get("options", [])
        correct_answers = question.get("correct_answer", [])
        
        # Check if correct answer index is valid
        if not correct_answers:
            result["is_valid"] = False
            result["error"] = "No correct answer specified"
            return result
        
        for correct_idx in correct_answers:
            if correct_idx >= len(options):
                result["is_valid"] = False
                result["error"] = f"Correct answer index {correct_idx} out of range"
                return result
        
        # Use Gemini for validation
        gemini_result = validate_with_gemini(question)
        result.update(gemini_result)
        
    except Exception as e:
        result["is_valid"] = False
        result["error"] = str(e)
    
    return result


def validate_all_questions(certification_id: int) -> Dict[str, Any]:
    """
    Validate all MCQ questions for a certification.
    Save invalid questions to results file and SQL file.
    
    Args:
        certification_id: The certification ID to validate
        
    Returns:
        Validation summary dictionary
    """
    questions = get_questions_by_certification(certification_id)
    
    if not questions:
        print("No questions found to validate")
        return {"total": 0, "valid": 0, "invalid": 0, "results_file": None, "sql_file": None}
    
    # Create results directory with date
    today = datetime.now().strftime("%Y-%m-%d")
    results_dir = Path(f"files/{today}")
    results_dir.mkdir(parents=True, exist_ok=True)
    
    # Results file paths
    results_file = results_dir / f"{certification_id}_results.json"
    sql_file = results_dir / f"{certification_id}_updates.sql"
    
    # Load existing results if file exists
    invalid_questions = []
    if results_file.exists():
        try:
            with open(results_file, "r") as f:
                content = f.read().strip()
                if content:  # Only load if file is not empty
                    invalid_questions = json.loads(content)
        except (json.JSONDecodeError, IOError) as e:
            print(f"⚠️  Warning: Could not load existing results file ({str(e)}). Starting fresh.")
            invalid_questions = []
    
    # Load existing SQL statements if file exists
    existing_sql_statements = []
    if sql_file.exists():
        try:
            with open(sql_file, "r") as f:
                content = f.read().strip()
                # Extract UPDATE statements from between BEGIN and COMMIT
                if content and "BEGIN;" in content and "COMMIT;" in content:
                    lines = content.split("\n")
                    for line in lines:
                        line = line.strip()
                        if line.startswith("UPDATE ") and line.endswith(";"):
                            existing_sql_statements.append(line)
        except IOError:
            existing_sql_statements = []
    
    summary = {
        "total": len(questions),
        "valid": 0,
        "invalid": 0,
        "results_file": str(results_file),
        "sql_file": str(sql_file),
    }
    
    print(f"\nValidating {len(questions)} questions...")
    print("=" * 80)
    
    all_sql_updates = []  # Collect all SQL statements
    sql_file_initialized = False  # Track if we've written BEGIN
    
    for idx, question in enumerate(questions, 1):
        validation_result = validate_explanation(question)
        
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
            
            # Show specific explanation issues
            if not validation_result.get("correct_answer_valid"):
                print(f"   ✗ Correct answer is factually incorrect")
            if not validation_result.get("explains_correct_option"):
                print(f"   ✗ Explanation does not clearly explain why correct option is right")
            if not validation_result.get("explains_incorrect_options"):
                print(f"   ✗ Explanation does not clearly explain why incorrect options are wrong")
            
            # Generate SQL update statement for invalid questions
            question_id = validation_result["question_id"]
            sql_updates = []
            
            # If correct answer is invalid, use the double-validated answer
            if not validation_result.get("correct_answer_valid"):
                print(f"   Correcting answer (double-validated)...")
                actual_answer_indices = validation_result.get("actual_correct_indices", question.get("correct_answer", []))
                confidence = validation_result.get("answer_validation_confidence", "unknown")
                corrected_answer = json.dumps(actual_answer_indices)
                
                print(f"   Corrected to: {corrected_answer} (confidence: {confidence})")
                
                sql_stmt = f"UPDATE public.question SET correct_answer = '{corrected_answer}' WHERE id = '{question_id}'; -- CORRECTED ANSWER (confidence: {confidence})"
                sql_updates.append(sql_stmt)
                all_sql_updates.append(sql_stmt)
            
            # If explanation is invalid, generate corrected explanation
            if not validation_result.get("explanation_valid"):
                print(f"   Generating corrected explanation...")
                corrected_explanation = generate_corrected_explanation(question)
                corrected_explanation_escaped = corrected_explanation.replace("'", "''")  # Escape single quotes
                sql_stmt = f"UPDATE public.question SET explanation = E'{corrected_explanation_escaped}' WHERE id = '{question_id}'; -- CORRECTED EXPLANATION"
                sql_updates.append(sql_stmt)
                all_sql_updates.append(sql_stmt)
            
            # Add to invalid questions list
            invalid_record = {
                "question_id": question_id,
                "error": validation_result.get("error"),
                "reason": validation_result.get("reason"),
                "correct_answer_valid": validation_result.get("correct_answer_valid"),
                "answer_validation_confidence": validation_result.get("answer_validation_confidence"),
                "double_validation_passed": validation_result.get("double_validation_passed"),
                "explanation_valid": validation_result.get("explanation_valid"),
                "explains_correct_option": validation_result.get("explains_correct_option"),
                "explains_incorrect_options": validation_result.get("explains_incorrect_options"),
                "marked_answer": validation_result.get("marked_answer_indices"),
                "corrected_answer": validation_result.get("actual_correct_indices"),
                "question_data": {
                    "text": question.get("text", "")[:200],
                    "options": question.get("options", []),
                    "correct_answer": question.get("correct_answer", []),
                    "explanation": question.get("explanation", "")[:200],
                    "module": question.get("module"),
                    "topic": question.get("topic"),
                },
                "sql_updates": sql_updates
            }
            
            invalid_questions.append(invalid_record)
            
            # Save JSON file incrementally after each invalid question
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
    
    # Close SQL file with COMMIT (only if we have invalid questions)
    if sql_file_initialized:
        with open(sql_file, "a") as f:
            f.write("\nCOMMIT;\n")
    else:
        # Create empty transaction block if no invalid questions
        with open(sql_file, "w") as f:
            f.write("BEGIN;\n-- No updates required - all questions are valid\nCOMMIT;\n")
    
    print("=" * 80)
    print("\nValidation Summary:")
    print(f"  Total questions: {summary['total']}")
    print(f"  ✓ Valid: {summary['valid']}")
    print(f"  ✗ Invalid: {summary['invalid']}")
    if summary['total'] > 0:
        print(f"  Pass rate: {(summary['valid'] / summary['total'] * 100):.1f}%")
    print(f"\nResults saved to:")
    print(f"  JSON: {results_file}")
    print(f"  SQL:  {sql_file}")
    
    return summary


def main():
    """Main execution function."""
    # Change this to the certification ID you want to validate
    CERTIFICATION_ID = 12
    
    print(f"Starting validation for Certification ID: {CERTIFICATION_ID}")
    print(f"Supabase URL: {SUPABASE_URL}")
    print()
    
    validate_all_questions(CERTIFICATION_ID)


if __name__ == "__main__":
    main()

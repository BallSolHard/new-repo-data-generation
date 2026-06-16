#!/usr/bin/env python3
"""
Validation script for MATCHING type questions.
Validates that:
1. Left and right items are correctly paired
2. Explanation clearly explains each match
3. Pairs are logically sound
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

# Validation step models for matching questions
VALIDATION_MODELS = {
    "initial_validation": "gemini",      # Step 1: Use Gemini for initial validation
    "double_validation": "kimi",         # Step 2: Use Kimi for double validation
    "explanation_validation": "gemini"   # Step 3: Use Gemini for explanation validation
}

print(f"\n📋 Validation Step Models (Matching Questions):")
print(f"   Step 1 (Initial):      {VALIDATION_MODELS['initial_validation'].upper()}")
print(f"   Step 2 (Double):       {VALIDATION_MODELS['double_validation'].upper()}")
print(f"   Step 3 (Explanation):  {VALIDATION_MODELS['explanation_validation'].upper()}")

# For backward compatibility
model = gemini_model


def get_questions_by_certification(certification_id: int) -> List[Dict[str, Any]]:
    """
    Fetch all MATCHING type questions for a given certification ID with pagination.
    
    Args:
        certification_id: The certification ID to filter questions
        
    Returns:
        List of matching question dictionaries
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
        
        # Get all MATCHING questions with these IDs using pagination
        all_questions = []
        batch_size = 100  # Process question IDs in batches of 100
        
        for batch_start in range(0, len(all_question_ids), batch_size):
            batch_end = min(batch_start + batch_size, len(all_question_ids))
            id_batch = all_question_ids[batch_start:batch_end]
            
            print(f"Processing question batch {batch_start}-{batch_end}/{len(all_question_ids)}...")
            
            offset = 0
            page_size = 1000
            
            while True:
                questions_response = supabase.table("question").select(
                    "*"
                ).eq("type", "matching").in_("id", id_batch).range(offset, offset + page_size - 1).execute()
                
                batch = questions_response.data
                if not batch:
                    break
                
                all_questions.extend(batch)
                print(f"  Fetched {len(all_questions)} matching questions so far...")
                
                if len(batch) < page_size:
                    break
                
                offset += page_size
        
        print(f"Found {len(all_questions)} total matching questions")
        
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
    Validate matching type questions with TRIPLE VALIDATION:
    1. Initial validation (Gemini): Check if pairs are correctly matched
    2. Double validation (Kimi): Verify each pair makes logical sense
    3. Explanation validation (Gemini): Check explanation quality
    
    Args:
        question: Matching question dictionary
        
    Returns:
        Validation result with pair validity and confidence
    """
    if not gemini_model and not kimi_model:
        return {
            "is_valid": False,
            "pairs_valid": False,
            "reason": "No model available",
            "error": "Neither Gemini nor Kimi API is configured"
        }
    
    try:
        question_text = question.get("text", "")
        pairs = question.get("pairs", {})
        matches = question.get("matches", {})
        explanation = question.get("explanation", "")
        
        left_items = pairs.get("left", [])
        right_items = pairs.get("right", [])
        left_matches = matches.get("left", [])
        right_matches = matches.get("right", [])
        
        # Validate structure
        if not left_items or not right_items:
            return {
                "is_valid": False,
                "pairs_valid": False,
                "reason": "Missing left or right items",
                "error": "Incomplete pairs structure"
            }
        
        if len(left_matches) != len(right_matches):
            return {
                "is_valid": False,
                "pairs_valid": False,
                "reason": "Mismatch between left and right matches count",
                "error": f"Left matches: {len(left_matches)}, Right matches: {len(right_matches)}"
            }
        
        if not explanation or len(explanation.strip()) == 0:
            return {
                "is_valid": False,
                "pairs_valid": False,
                "reason": "No explanation provided",
                "error": "Empty explanation"
            }
        
        # Format for validation
        left_items_text = "\n".join([f"{i}. {item}" for i, item in enumerate(left_items)])
        right_items_text = "\n".join([f"{i}. {item}" for i, item in enumerate(right_items)])
        
        # Build current matches text
        current_matches_text = "\n".join([
            f"Left[{l}] → Right[{r}]" 
            for l, r in zip(left_matches, right_matches)
        ])
        
        # STEP 1: Initial validation (Gemini)
        print(f"   [Validation Step 1/3] Initial pair validation (GEMINI)...")
        initial_validation_prompt = f"""
You are an expert matching question validator. Analyze this matching question.

QUESTION:
{question_text}

LEFT ITEMS:
{left_items_text}

RIGHT ITEMS:
{right_items_text}

MARKED MATCHES (DATABASE):
{current_matches_text}

Your task:
1. Determine the CORRECT pairs based on logical accuracy
2. Check if MARKED matches are correct
3. If incorrect, specify CORRECT pairs

Respond ONLY in this JSON format (no markdown, no extra text):
{{
    "marked_matches": {{"left": {left_matches}, "right": {right_matches}}},
    "actual_correct_matches": {{"left": [0, 1, 2], "right": [0, 1, 2]}},
    "pairs_valid": true/false,
    "reason": "brief explanation of the correct pairings"
}}
"""
        
        try:
            response = generate_content(initial_validation_prompt, VALIDATION_MODELS['initial_validation'])
        except Exception as e:
            print(f"\n❌ ERROR in Step 1: {str(e)}")
            return {
                "is_valid": False,
                "error": f"Validation failed: {str(e)}",
                "pairs_valid": False
            }
        
        response_text = response.strip()
        
        try:
            json_match = re.search(r'\{.*\}', response_text, re.DOTALL)
            if json_match:
                initial_result = json.loads(json_match.group())
            else:
                initial_result = json.loads(response_text)
        except json.JSONDecodeError:
            return {
                "is_valid": False,
                "pairs_valid": False,
                "reason": "Could not parse initial validation response",
                "error": response_text[:200]
            }
        
        # STEP 2: Double validation (Kimi)
        actual_matches = initial_result.get("actual_correct_matches", {"left": left_matches, "right": right_matches})
        actual_left = actual_matches.get("left", [])
        actual_right = actual_matches.get("right", [])
        
        actual_matches_text = "\n".join([
            f"Left[{l}] → Right[{r}]" 
            for l, r in zip(actual_left, actual_right)
        ])
        
        print(f"   [Validation Step 2/3] Double-checking pairs (KIMI)...")
        double_validation_prompt = f"""
You are an expert matching question validator. Double-check these pairings.

QUESTION:
{question_text}

LEFT ITEMS:
{left_items_text}

RIGHT ITEMS:
{right_items_text}

SUGGESTED MATCHES:
{actual_matches_text}

Your task:
1. Verify each pair is logically correct
2. Ensure all pairings are factually accurate
3. Rate your confidence level

Be ABSOLUTELY CERTAIN. If you have ANY doubt, respond with low confidence.

Respond ONLY in this JSON format (no markdown, no extra text):
{{
    "pairs_definitively_correct": true/false,
    "confidence": "high|medium|low",
    "verification_reason": "brief explanation of why you verified these pairs",
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
                "pairs_valid": False
            }
        
        response_text = response.strip()
        
        try:
            json_match = re.search(r'\{.*\}', response_text, re.DOTALL)
            if json_match:
                double_validation = json.loads(json_match.group())
            else:
                double_validation = json.loads(response_text)
        except json.JSONDecodeError:
            double_validation = {
                "pairs_definitively_correct": False,
                "confidence": "low",
                "double_validation_passed": False
            }
        
        # STEP 3: Validate explanation (Gemini)
        print(f"   [Validation Step 3/3] Validating explanation (GEMINI)...")
        explanation_validation_prompt = f"""
You are an expert matching question validator. Validate the explanation quality.

QUESTION:
{question_text}

LEFT ITEMS:
{left_items_text}

RIGHT ITEMS:
{right_items_text}

CORRECT MATCHES:
{actual_matches_text}

PROVIDED EXPLANATION:
{explanation}

Your task:
1. Check if explanation clearly explains each pair
2. Check if explanation provides logical reasoning
3. Assess explanation completeness

Respond ONLY in this JSON format (no markdown, no extra text):
{{
    "explanation_valid": true/false,
    "explains_all_pairs": true/false,
    "provides_reasoning": true/false,
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
        
        # Determine overall validity
        is_initial_correct = initial_result.get("pairs_valid", False)
        double_validation_passed = double_validation.get("double_validation_passed", False)
        confidence = double_validation.get("confidence", "low")
        
        if not is_initial_correct and double_validation_passed and confidence == "high":
            pairs_valid = True
            final_matches = actual_matches
        elif is_initial_correct:
            pairs_valid = True
            final_matches = actual_matches
        else:
            pairs_valid = False
            final_matches = {"left": left_matches, "right": right_matches}
        
        # Final result
        final_result = {
            "question_id": question.get("id"),
            "marked_matches": {"left": left_matches, "right": right_matches},
            "actual_correct_matches": final_matches,
            "pairs_valid": pairs_valid,
            "pair_validation_confidence": confidence,
            "double_validation_passed": double_validation_passed,
            "reason_for_pairs": initial_result.get("reason", ""),
            "verification_reason": double_validation.get("verification_reason", ""),
            "explanation_valid": explanation_result.get("explanation_valid", False),
            "explains_all_pairs": explanation_result.get("explains_all_pairs", False),
            "provides_reasoning": explanation_result.get("provides_reasoning", False),
            "explanation_issues": explanation_result.get("explanation_issues", ""),
            "is_valid": pairs_valid and explanation_result.get("explanation_valid", False)
        }
        
        return final_result
        
    except Exception as e:
        return {
            "is_valid": False,
            "pairs_valid": False,
            "reason": "Validation error",
            "error": str(e)
        }


def generate_corrected_explanation(question: Dict[str, Any]) -> str:
    """
    Generate a corrected explanation for matching questions.
    
    Args:
        question: Question dictionary
        
    Returns:
        Corrected explanation string
    """
    if not gemini_model and not kimi_model:
        return ""
    
    try:
        question_text = question.get("text", "")
        pairs = question.get("pairs", {})
        matches = question.get("matches", {})
        
        left_items = pairs.get("left", [])
        right_items = pairs.get("right", [])
        left_matches = matches.get("left", [])
        right_matches = matches.get("right", [])
        
        left_items_text = "\n".join([f"{i}. {item}" for i, item in enumerate(left_items)])
        right_items_text = "\n".join([f"{i}. {item}" for i, item in enumerate(right_items)])
        
        matches_text = "\n".join([
            f"Left[{l}] → Right[{r}]" 
            for l, r in zip(left_matches, right_matches)
        ])
        
        correction_prompt = f"""
You are an expert matching question writer. Generate a comprehensive explanation for this matching question.

QUESTION:
{question_text}

LEFT ITEMS:
{left_items_text}

RIGHT ITEMS:
{right_items_text}

CORRECT MATCHES:
{matches_text}

Generate an explanation that:
1. Explains each pairing clearly
2. Provides logical reasoning for why each left item matches its right item
3. Be educational and specific

Example format:
"Item 1 (Unexpected traffic to an EC2 instance) pairs with Source 1 (VPC Flow Logs) because VPC Flow Logs capture source/destination IPs and ports of traffic. Item 2 (Connectivity failure to a private S3 bucket) pairs with Source 2 (VPC Endpoint Policy logs) because these logs show access denials. Item 3 (Blocked traffic within a VPC subnet) pairs with Source 3 (Network ACL logs) because NACLs control subnet-level traffic."

Respond with ONLY the explanation text (no JSON, no markdown):
"""
        
        try:
            response = generate_content(correction_prompt, VALIDATION_MODELS['explanation_validation'])
            return response.strip()
        except Exception as e:
            print(f"\n❌ ERROR: {str(e)}")
            return f"Error generating explanation: {str(e)}"
        
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
    Validate using Gemini if correct pairs are valid and explanation makes sense.
    
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
        pairs = question.get("pairs", {})
        matches = question.get("matches", {})
        
        # Check if structure is valid
        if not pairs or not matches:
            result["is_valid"] = False
            result["error"] = "Missing pairs or matches structure"
            return result
        
        left_items = pairs.get("left", [])
        right_items = pairs.get("right", [])
        
        if not left_items or not right_items:
            result["is_valid"] = False
            result["error"] = "Missing left or right items"
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
    Validate all matching type questions for a certification.
    
    Args:
        certification_id: The certification ID to validate
        
    Returns:
        Validation summary dictionary
    """
    questions = get_questions_by_certification(certification_id)
    
    if not questions:
        print("No matching questions found to validate")
        return {"total": 0, "valid": 0, "invalid": 0, "results_file": None, "sql_file": None}
    
    # Create results directory with date
    today = datetime.now().strftime("%Y-%m-%d")
    results_dir = Path(f"files/{today}")
    results_dir.mkdir(parents=True, exist_ok=True)
    
    results_file = results_dir / f"{certification_id}_matching_results.json"
    sql_file = results_dir / f"{certification_id}_matching_updates.sql"
    
    # Load existing results
    invalid_questions = []
    if results_file.exists():
        try:
            with open(results_file, "r") as f:
                content = f.read().strip()
                if content:
                    invalid_questions = json.loads(content)
        except (json.JSONDecodeError, IOError) as e:
            print(f"⚠️ Warning: Could not load existing results ({str(e)})")
            invalid_questions = []
    
    summary = {
        "total": len(questions),
        "valid": 0,
        "invalid": 0,
        "results_file": str(results_file),
        "sql_file": str(sql_file),
    }
    
    print(f"\nValidating {len(questions)} matching questions...")
    print("=" * 80)
    
    all_sql_updates = []
    
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
            if validation_result.get("reason_for_pairs"):
                print(f"   Reason: {validation_result['reason_for_pairs']}")
            
            if not validation_result.get("pairs_valid"):
                print(f"   ✗ Pair matching is incorrect")
            if not validation_result.get("explanation_valid"):
                print(f"   ✗ Explanation is inadequate")
            
            question_id = validation_result["question_id"]
            sql_updates = []
            
            # Generate corrected explanation if needed
            if not validation_result.get("explanation_valid"):
                print(f"   Generating corrected explanation...")
                corrected_explanation = generate_corrected_explanation(question)
                corrected_explanation_escaped = corrected_explanation.replace("'", "''")
                sql_stmt = f"UPDATE public.question SET explanation = E'{corrected_explanation_escaped}' WHERE id = '{question_id}'; -- CORRECTED EXPLANATION"
                sql_updates.append(sql_stmt)
                all_sql_updates.append(sql_stmt)
            
            # Add to invalid list
            invalid_record = {
                "question_id": question_id,
                "error": validation_result.get("error"),
                "pairs_valid": validation_result.get("pairs_valid"),
                "explanation_valid": validation_result.get("explanation_valid"),
                "confidence": validation_result.get("pair_validation_confidence"),
                "marked_matches": validation_result.get("marked_matches"),
                "corrected_matches": validation_result.get("actual_correct_matches"),
                "question_data": {
                    "text": question.get("text", "")[:200],
                    "pairs": question.get("pairs", {}),
                    "matches": question.get("matches", {}),
                    "explanation": question.get("explanation", "")[:200],
                },
                "sql_updates": sql_updates
            }
            
            invalid_questions.append(invalid_record)
            
            # Save JSON incrementally
            with open(results_file, "w") as f:
                json.dump(invalid_questions, f, indent=2)
            print(f"   ✓ Saved to JSON file")
            
            # Save SQL incrementally
            if sql_updates:
                with open(sql_file, "a") as f:
                    if idx == 1:
                        f.write("BEGIN;\n\n")
                    for sql_stmt in sql_updates:
                        f.write(sql_stmt + "\n")
                print(f"   ✓ Saved to SQL file")
    
    # Close SQL transaction
    with open(sql_file, "a") as f:
        if summary["invalid"] > 0:
            f.write("\nCOMMIT;\n")
        else:
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

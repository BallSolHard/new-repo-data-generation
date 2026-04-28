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
from datetime import datetime
from pathlib import Path

# Load environment variables
load_dotenv()

SUPABASE_URL = os.getenv("NEXT_PUBLIC_SUPABASE_URL_PROD")
SUPABASE_SERVICE_ROLE_KEY = os.getenv("NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD")
GOOGLE_API_KEY = os.getenv("GEMINI_API_KEY")

# Initialize Supabase client
supabase: Client = create_client(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

# Initialize Google Gemini client
if GOOGLE_API_KEY:
    genai.configure(api_key=GOOGLE_API_KEY)
    model = genai.GenerativeModel("gemini-2.5-flash")
else:
    model = None
    print("⚠️ Warning: GOOGLE_API_KEY not found. Gemini validation will be skipped.")


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
    Use Google Gemini to validate MCQ questions:
    1. If the marked correct answer is actually correct or incorrect
    2. If incorrect, identify which answer should be correct
    3. If the explanation makes sense and explains all options
    
    Args:
        question: Question dictionary
        
    Returns:
        Gemini validation result with:
        - correct_answer_valid: bool (is the marked answer actually correct?)
        - actual_correct_index: int (which answer should be correct?)
        - actual_correct_letter: str (letter representation)
        - explanation_valid: bool
        - reason_for_correct_answer: explanation of findings
    """
    if not model:
        return {
            "is_valid": False,
            "correct_answer_valid": False,
            "actual_correct_index": None,
            "actual_correct_letter": None,
            "reason": "Gemini not available",
            "error": "GOOGLE_API_KEY not configured"
        }
    
    try:
        question_text = question.get("text", "")
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
        
        # Handle both single int and list format
        if isinstance(marked_correct_index, list):
            marked_correct_index = marked_correct_index[0] if marked_correct_index else None
        
        if marked_correct_index is None:
            return {
                "is_valid": False,
                "correct_answer_valid": False,
                "actual_correct_index": None,
                "actual_correct_letter": None,
                "reason": "No marked correct answer",
                "error": "correct_answer field is empty"
            }
        
        # Format options for Gemini
        options_text = "\n".join([f"{chr(65 + i)}) {opt}" for i, opt in enumerate(options)])
        marked_letter = chr(65 + marked_correct_index)
        
        # Create comprehensive validation prompt
        validation_prompt = f"""
You are an expert exam validator. Analyze this MCQ question in detail.

QUESTION:
{question_text}

OPTIONS:
{options_text}

MARKED CORRECT ANSWER IN DATABASE: {marked_letter} (index: {marked_correct_index})

PROVIDED EXPLANATION:
{explanation}

Your task:
1. Determine the ACTUAL correct answer for this question based on factual accuracy (single option)
2. Check if the MARKED answer matches the ACTUAL answer
3. If MARKED answer is INCORRECT, specify which answer SHOULD be correct
4. Validate the explanation quality

Respond ONLY in this JSON format (no markdown, no extra text):
{{
    "marked_answer_index": {marked_correct_index},
    "marked_answer_letter": "{marked_letter}",
    "actual_correct_index": 2,
    "actual_correct_letter": "C",
    "correct_answer_valid": true/false,
    "reason_for_correct_answer": "explanation of why this answer is correct",
    "explanation_valid": true/false,
    "explanation_issues": "list any issues with explanation quality",
    "is_valid": true/false
}}
"""
        
        response = model.generate_content(validation_prompt)
        response_text = response.text.strip()
        
        # Extract JSON from response
        try:
            import re
            json_match = re.search(r'\{.*\}', response_text, re.DOTALL)
            if json_match:
                gemini_result = json.loads(json_match.group())
            else:
                gemini_result = json.loads(response_text)
            
            # Ensure required fields exist and are single values
            if "actual_correct_index" not in gemini_result:
                gemini_result["actual_correct_index"] = marked_correct_index if gemini_result.get("correct_answer_valid") else None
            if "actual_correct_letter" not in gemini_result:
                idx = gemini_result.get("actual_correct_index")
                gemini_result["actual_correct_letter"] = chr(65 + idx) if idx is not None else None
            
            return gemini_result
            
        except json.JSONDecodeError:
            return {
                "is_valid": False,
                "correct_answer_valid": False,
                "actual_correct_index": None,
                "actual_correct_letter": None,
                "reason": "Could not parse Gemini response",
                "error": response_text[:200]
            }
        
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


def generate_corrected_explanation(question: Dict[str, Any], correct_answer_indices: List[int] = None) -> str:
    """
    Generate a corrected explanation using Gemini.
    
    Args:
        question: Question dictionary
        correct_answer_indices: Override correct answer indices (optional)
        
    Returns:
        Corrected explanation string
    """
    if not model:
        return ""
    
    try:
        question_text = question.get("text", "")
        options = question.get("options", [])
        
        # Use provided correct answer or from question
        if correct_answer_indices is not None:
            correct_answers = correct_answer_indices
        else:
            correct_answers = question.get("correct_answer", [])
        
        # Format options for Gemini
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
        
        response = model.generate_content(correction_prompt)
        corrected_explanation = response.text.strip()
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
            
            # Show specific explanation issues
            if not validation_result.get("correct_answer_valid"):
                print(f"   ✗ Correct answer is factually incorrect")
            if not validation_result.get("explains_correct_option"):
                print(f"   ✗ Explanation does not clearly explain why correct option is right")
            if not validation_result.get("explains_incorrect_options"):
                print(f"   ✗ Explanation does not clearly explain why incorrect options are wrong")
            
            # Generate SQL update statement for invalid questions
            question_id = validation_result["question_id"]
            question_text = question.get("text", "")
            sql_updates = []
            generic_sql_updates = []
            corrected_answer_indices = None
            corrected_answer_valid = True
            
            # If correct_answer is invalid, find the correct answer
            if not validation_result.get("correct_answer_valid"):
                print(f"   Finding correct answer...")
                answer_result = find_correct_answer(question)
                corrected_answer_indices = answer_result.get("correct_indices", [])
                corrected_answer_valid = answer_result.get("is_valid", False)
                confidence = answer_result.get("confidence", "unknown")
                reasoning = answer_result.get("reasoning", "")
                
                print(f"   Corrected answer indices: {corrected_answer_indices}")
                print(f"   Confidence: {confidence} | Valid: {corrected_answer_valid}")
                
                if corrected_answer_indices:
                    corrected_answer = json.dumps(corrected_answer_indices)
                    
                    # Build comment based on validation
                    if corrected_answer_valid:
                        comment = f"CORRECTED ANSWER (was {question.get('correct_answer', [])}, confidence: {confidence})"
                    else:
                        comment = f"⚠️ CORRECTED ANSWER - UNCONFIRMED (was {question.get('correct_answer', [])}), confidence: {confidence}"
                    
                    # SQL update by ID
                    sql_stmt = f"UPDATE public.question SET correct_answer = '{corrected_answer}' WHERE id = '{question_id}'; -- {comment}"
                    sql_updates.append(sql_stmt)
                    all_sql_updates.append(sql_stmt)
                    
                    # SQL update by text
                    question_text_escaped = question_text.replace("'", "''")
                    generic_sql_stmt = f"UPDATE public.question SET correct_answer = '{corrected_answer}' WHERE text = E'{question_text_escaped}'; -- {comment}"
                    generic_sql_updates.append(generic_sql_stmt)
                    all_generic_sql_updates.append(generic_sql_stmt)
                else:
                    print(f"   ⚠️ Could not determine corrected answer")
            
            # If explanation is invalid, generate corrected explanation
            if not validation_result.get("explanation_valid"):
                print(f"   Generating corrected explanation...")
                corrected_explanation = generate_corrected_explanation(question, corrected_answer_indices)
                corrected_explanation_escaped = corrected_explanation.replace("'", "''")
                
                # Build comment based on corrected answer validity
                if corrected_answer_valid or corrected_answer_indices is None:
                    comment = "CORRECTED EXPLANATION"
                else:
                    comment = "⚠️ CORRECTED EXPLANATION (based on unconfirmed answer)"
                
                # SQL update by ID (environment-specific)
                sql_stmt = f"UPDATE public.question SET explanation = E'{corrected_explanation_escaped}' WHERE id = '{question_id}'; -- {comment}"
                sql_updates.append(sql_stmt)
                all_sql_updates.append(sql_stmt)
                
                # SQL update by question text (portable across environments)
                question_text_escaped = question_text.replace("'", "''")
                generic_sql_stmt = f"UPDATE public.question SET explanation = E'{corrected_explanation_escaped}' WHERE text = E'{question_text_escaped}'; -- {comment}"
                generic_sql_updates.append(generic_sql_stmt)
                all_generic_sql_updates.append(generic_sql_stmt)
            
            # Add to invalid questions list
            invalid_record = {
                "question_id": question_id,
                "mock_test_id": question.get("mock_test_id"),
                "error": validation_result.get("error"),
                "reason": validation_result.get("reason"),
                "original_answer": question.get("correct_answer", []),
                "corrected_answer": corrected_answer_indices,
                "corrected_answer_valid": corrected_answer_valid,
                "correct_answer_valid": validation_result.get("correct_answer_valid"),
                "explanation_valid": validation_result.get("explanation_valid"),
                "explains_correct_option": validation_result.get("explains_correct_option"),
                "explains_incorrect_options": validation_result.get("explains_incorrect_options"),
                "question_data": {
                    "text": question.get("text", "")[:200],
                    "options": question.get("options", []),
                    "correct_answer": question.get("correct_answer", []),
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
    
    print(f"Starting mock test validation for Certification ID: {CERTIFICATION_ID}")
    print(f"Supabase URL: {SUPABASE_URL}")
    print()
    
    validate_all_mock_test_questions(CERTIFICATION_ID)


if __name__ == "__main__":
    main()

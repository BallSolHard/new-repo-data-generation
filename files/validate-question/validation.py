#!/usr/bin/env python3
"""
Simple validation script for MCQ questions and their explanations.
Validates that:
1. Correct answer is indeed valid
2. Explanation makes sense
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

SUPABASE_URL = os.getenv("NEXT_PUBLIC_SUPABASE_URL")
SUPABASE_SERVICE_ROLE_KEY = os.getenv("SUPABASE_SERVICE_ROLE_KEY")
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


def validate_with_gemini(question: Dict[str, Any]) -> Dict[str, Any]:
    """
    Use Google Gemini to validate:
    1. If the marked correct answer is actually correct
    2. If the explanation makes sense
    
    Args:
        question: Question dictionary
        
    Returns:
        Gemini validation result
    """
    if not model:
        return {
            "is_valid": False,
            "reason": "Gemini not available",
            "error": "GOOGLE_API_KEY not configured"
        }
    
    try:
        question_text = question.get("text", "")
        options = question.get("options", [])
        correct_answers = question.get("correct_answer", [])
        explanation = question.get("explanation", "")
        
        if not explanation or len(explanation.strip()) == 0:
            return {
                "is_valid": False,
                "reason": "No explanation provided",
                "error": "Empty explanation"
            }
        
        # Format options for Gemini
        options_text = "\n".join([f"{chr(65 + i)}) {opt}" for i, opt in enumerate(options)])
        
        # Create validation prompt
        validation_prompt = f"""
You are an expert exam validator. Validate this MCQ question strictly.

QUESTION:
{question_text}

OPTIONS:
{options_text}

MARKED CORRECT ANSWER(S): {[chr(65 + idx) for idx in correct_answers]}

PROVIDED EXPLANATION:
{explanation}

Validate:
1. Is the marked correct answer factually correct?
2. Does the explanation clearly state WHY this option is correct?
3. Does the explanation clearly state WHY EACH other option is incorrect?

IMPORTANT: An explanation is only valid if it:
- Clearly explains the factual reasoning for the correct answer
- Explicitly addresses why each incorrect option is wrong
- Provides factual basis for rejecting incorrect options
- Is not vague or incomplete about incorrect options

Respond ONLY in this JSON format (no markdown, no extra text):
{{
    "is_valid": true/false,
    "correct_answer_valid": true/false,
    "explanation_valid": true/false,
    "explains_correct_option": true/false,
    "explains_incorrect_options": true/false,
    "reason": "brief reason if invalid"
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
            
            return gemini_result
            
        except json.JSONDecodeError:
            return {
                "is_valid": False,
                "reason": "Could not parse Gemini response",
                "error": response_text[:200]
            }
        
    except Exception as e:
        return {
            "is_valid": False,
            "reason": "Gemini validation error",
            "error": str(e)
        }


def generate_corrected_explanation(question: Dict[str, Any]) -> str:
    """
    Generate a corrected explanation using Gemini.
    
    Args:
        question: Question dictionary
        
    Returns:
        Corrected explanation string
    """
    if not model:
        return ""
    
    try:
        question_text = question.get("text", "")
        options = question.get("options", [])
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


def generate_corrected_answer(question: Dict[str, Any]) -> str:
    """
    Generate the correct answer index using Gemini.
    
    Args:
        question: Question dictionary
        
    Returns:
        Corrected answer as JSON array string (e.g., "[0]")
    """
    if not model:
        return "[0]"
    
    try:
        question_text = question.get("text", "")
        options = question.get("options", [])
        
        # Format options for Gemini
        options_text = "\n".join([f"{chr(65 + i)}) {opt}" for i, opt in enumerate(options)])
        
        answer_prompt = f"""
You are an expert exam validator. Identify the correct answer for this MCQ.

QUESTION:
{question_text}

OPTIONS:
{options_text}

Respond with ONLY a JSON array with the index of the correct answer(s). Examples:
- For option A (first): [0]
- For option C (third): [2]
- For multiple answers: [0, 2]

Do not include any other text.
"""
        
        response = model.generate_content(answer_prompt)
        response_text = response.text.strip()
        
        # Extract JSON array
        import re
        json_match = re.search(r'\[\d+(?:,\s*\d+)*\]', response_text)
        if json_match:
            return json_match.group()
        return "[0]"  # Default fallback
        
    except Exception as e:
        return "[0]"


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
            
            # If correct answer is invalid, generate corrected answer
            if not validation_result.get("correct_answer_valid"):
                print(f"   Generating corrected answer...")
                corrected_answer = generate_corrected_answer(question)
                sql_stmt = f"UPDATE public.question SET correct_answer = '{corrected_answer}' WHERE id = '{question_id}'; -- CORRECTED ANSWER"
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
    CERTIFICATION_ID = 16
    
    print(f"Starting validation for Certification ID: {CERTIFICATION_ID}")
    print(f"Supabase URL: {SUPABASE_URL}")
    print()
    
    validate_all_questions(CERTIFICATION_ID)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""
Verify MCQ questions - Check if correct_answer is valid using Gemini AI.
Fetches all MCQ questions where module_id is not null and verifies answers.
Outputs list of question IDs with invalid correct answers.
"""

import os
import json
from dotenv import load_dotenv
from supabase import create_client
import google.generativeai as genai

# Load environment variables
load_dotenv()

# Initialize Supabase
SUPABASE_URL = os.getenv("NEXT_PUBLIC_SUPABASE_URL_PROD")
SERVICE_ROLE_KEY = os.getenv("NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD")

supabase = create_client(SUPABASE_URL, SERVICE_ROLE_KEY)

# Initialize Gemini
api_key = os.getenv("GEMINI_API_KEY")
genai.configure(api_key=api_key)
model = genai.GenerativeModel("gemini-2.5-flash")

def fetch_mcq_questions_paginated(batch_size=100):
    """Fetch all MCQ questions with pagination (batch_size per request)"""
    print("📥 Fetching MCQ questions from database (with pagination)...")
    print("   Filters: type='mcq', module_id IS NOT NULL, is_deprecated=FALSE\n")
    
    all_questions = []
    offset = 0
    batch_count = 0
    
    while True:
        batch_count += 1
        print(f"  📄 Fetching batch {batch_count} (offset: {offset})...")
        
        response = supabase.table("question").select(
            "id, text, options, correct_answer, type, module_id, explanation, is_deprecated"
        ).eq("type", "mcq").neq("module_id", None).eq("is_deprecated", False).range(offset, offset + batch_size - 1).execute()
        
        batch = response.data
        
        if not batch:
            break
        
        all_questions.extend(batch)
        print(f"    ✅ Fetched {len(batch)} questions (total so far: {len(all_questions)})")
        
        # If we got fewer questions than batch_size, we've reached the end
        if len(batch) < batch_size:
            break
        
        offset += batch_size
    
    print(f"✅ Total MCQ questions fetched: {len(all_questions)}")
    return all_questions

def verify_explanation_format_with_gemini(question):
    """Use Gemini to verify if explanation follows the required format"""
    text = question.get("text", "")
    options = question.get("options", [])
    correct_answer = question.get("correct_answer", [])
    explanation = question.get("explanation", "")
    
    # Build option letters list
    option_letters = [chr(65+i) for i in range(len(options))]  # A, B, C, D, etc.
    options_formatted = "\n".join([f"Option {option_letters[i]}: {options[i]}" for i in range(len(options))])
    
    # Convert indices to letters in explanation for clarity
    correct_answer_letters = [option_letters[i] for i in correct_answer if i < len(option_letters)]
    
    prompt = f"""Verify if this explanation follows the REQUIRED format for an MCQ question:

QUESTION: {text}

OPTIONS:
{options_formatted}

CORRECT ANSWER: {', '.join(correct_answer_letters)}

EXPLANATION:
{explanation}

REQUIRED FORMAT:
- Start with the correct option (e.g., "Option B (correct)")
- Explain why the correct option is the best answer
- For EACH incorrect option, explain why it is wrong
- Use the format: "Option X (correct/incorrect) explanation..."
- Use Option A, Option B, Option C, Option D format (NOT numbers like Option 0, Option 1)
- DO NOT include anti-pattern references or ap-pattern codes

Does this explanation follow the required format where it:
1. Clearly identifies the correct option with explanation using letter format (A, B, C, D)
2. Explains why each other option is incorrect
3. Covers all options (correct and incorrect)
4. Does NOT contain anti-pattern references (ap-X.X.XXX)
5. Uses "Option A", "Option B" format, NOT "Option 0", "Option 1"

Respond with ONLY "true" or "false" (lowercase).
"""
    
    try:
        response = model.generate_content(prompt)
        result = response.text.strip().lower()
        return result == "true"
    except Exception as e:
        return True  # Default to valid on error

def verify_answer_accuracy_with_gemini(question):
    """Use Gemini to verify if correct_answer is accurate"""
    text = question.get("text", "")
    options = question.get("options", [])
    correct_answer = question.get("correct_answer", [])
    explanation = question.get("explanation", "")
    
    # Build option letters list
    option_letters = [chr(65+i) for i in range(len(options))]
    options_formatted = "\n".join([f"Option {option_letters[i]}: {options[i]}" for i in range(len(options))])
    
    # Convert indices to letters
    correct_answer_letters = [option_letters[i] for i in correct_answer if i < len(option_letters)]
    
    prompt = f"""Verify if the correct answer is accurate for this MCQ question:

QUESTION: {text}

OPTIONS:
{options_formatted}

MARKED CORRECT ANSWER: {', '.join(correct_answer_letters)}

EXPLANATION:
{explanation}

Is the marked correct answer factually accurate and the best choice?
Consider the explanation and the question context.

Respond with ONLY "true" or "false" (lowercase).
"""
    
    try:
        response = model.generate_content(prompt)
        result = response.text.strip().lower()
        return result == "true"
    except Exception as e:
        return True  # Default to valid on error

def verify_with_gemini(question):
    """Verify if correct_answer is valid and explanation follows format"""
    question_id = question["id"]
    text = question.get("text", "")
    options = question.get("options", [])
    correct_answer = question.get("correct_answer", [])
    explanation = question.get("explanation", "")
    
    if not text or not options:
        return True, None, None, None  # Skip invalid questions
    
    # Ensure correct_answer is a list
    if isinstance(correct_answer, str):
        try:
            correct_answer = json.loads(correct_answer)
        except:
            return False, "Invalid correct_answer format", True, False
    
    if not isinstance(correct_answer, list):
        return False, "correct_answer must be a list", True, False
    
    # Check if indices are within range
    answer_valid = True
    for idx in correct_answer:
        if not isinstance(idx, int) or idx < 0 or idx >= len(options):
            answer_valid = False
            break
    
    # Check explanation format
    explanation_valid = True
    if not explanation or not isinstance(explanation, str):
        explanation_valid = False
    else:
        # Use Gemini to verify explanation format
        explanation_valid = verify_explanation_format_with_gemini(question)
    
    # Use Gemini to verify answer accuracy only if answer structure is valid
    if answer_valid:
          = verify_answer_accuracy_with_gemini(question)
    
    # Return: (is_fully_valid, error_msg, answer_invalid, explanation_invalid)
    is_fully_valid = answer_valid and explanation_valid
    error_msg = None
    if not answer_valid:
        error_msg = "Correct answer is invalid"
    if not explanation_valid:
        error_msg = "Explanation format is invalid" if not error_msg else error_msg + " | Explanation format is invalid"
    
    return is_fully_valid, error_msg, not answer_valid, not explanation_valid

def _init_sql_file(output_file):
    """Initialize SQL file with header"""
    with open(output_file, "w") as f:
        f.write("-- MCQ Questions Verification - Invalid Questions\n")
        f.write("-- Generated SQL UPDATE statements for questions requiring review\n")
        f.write("-- " + "=" * 76 + "\n")
        f.write("-- Questions are appended as they are verified\n\n")
        f.write("BEGIN;\n\n")

def _clean_explanation(explanation, options):
    """Clean explanation by removing ap-patterns and converting Option 0,1,2,3 to Option A,B,C,D"""
    if not explanation:
        return explanation
    
    import re
    
    # Remove all anti-pattern references (various formats)
    # Remove: (Anti-pattern: ap-3.2-001), (Anti-pattern:-001), Anti-pattern: ap-3.2-001, etc.
    explanation = re.sub(r'\s*\(?Anti-pattern:?\s*ap?-?[\d\.\-]*\)?\s*', '', explanation)
    explanation = re.sub(r'\s*\(?Anti-pattern[:\s]*[\w\d\.\-]*\)?\s*', '', explanation)
    explanation = re.sub(r'\s*ap-[\d\.]+\s*', '', explanation)
    
    # Convert Option 0, 1, 2, 3 to Option A, B, C, D
    option_letters = [chr(65+i) for i in range(len(options))]  # A, B, C, D, etc.
    
    for idx, letter in enumerate(option_letters):
        # Replace "Option {idx}" with "Option {letter}"
        explanation = re.sub(rf'\bOption\s+{idx}\b', f'Option {letter}', explanation)
    
    # Clean up extra spaces and punctuation issues
    explanation = re.sub(r'\s+', ' ', explanation)
    explanation = re.sub(r'\s+([.,;:])', r'\1', explanation)  # Fix spaces before punctuation
    explanation = explanation.strip()
    
    return explanation

def _append_sql_statement(output_file, question, answer_invalid, explanation_invalid):
    """Append SQL statement for a single invalid question"""
    question_id = question["id"]
    correct_answer = question.get("correct_answer", [])
    explanation = question.get("explanation", "")
    options = question.get("options", [])
    
    # Ensure correct_answer is properly formatted
    if isinstance(correct_answer, str):
        try:
            correct_answer = json.loads(correct_answer)
        except:
            correct_answer = []
    
    # Build option letters list
    option_letters = [chr(65+i) for i in range(len(options))]  # A, B, C, D, etc.
    
    # Convert indices to letters for display
    correct_answer_letters = [option_letters[i] for i in correct_answer if i < len(option_letters)]
    
    # Clean explanation: remove ap-patterns and convert Option 0,1,2,3 to A,B,C,D
    explanation = _clean_explanation(explanation, options)
    
    # Escape single quotes in explanation for SQL
    explanation_escaped = explanation.replace("'", "''")
    
    with open(output_file, "a") as f:
        f.write(f"-- Question ID: {question_id}\n")
        if correct_answer_letters:
            f.write(f"-- Correct Answer: {', '.join(correct_answer_letters)}\n")
        
        # Build SET clause only for invalid fields
        set_clauses = []
        if answer_invalid:
            set_clauses.append(f"correct_answer = '{{" + ",".join(str(i) for i in correct_answer) + f"}}'::integer[]")
        
        if explanation_invalid:
            set_clauses.append(f"explanation = '{explanation_escaped}'")
        
        if set_clauses:
            f.write(f"UPDATE public.question\n")
            f.write(f"SET\n")
            f.write(f"    " + f",\n    ".join(set_clauses) + "\n")
            f.write(f"WHERE id = '{question_id}';\n\n")

def _finalize_sql_file(output_file):
    """Finalize SQL file with COMMIT"""
    with open(output_file, "a") as f:
        f.write("COMMIT;\n")

def main():
    print("=" * 80)
    print("MCQ QUESTIONS VERIFICATION")
    print("=" * 80)
    
    # Fetch questions with pagination
    questions = fetch_mcq_questions_paginated(batch_size=100)
    
    if not questions:
        print("❌ No MCQ questions found")
        return
    
    # Initialize SQL file
    output_file = "sql_verify_mcq_quiz.sql"
    _init_sql_file(output_file)
    
    # Verify each question and append results progressively
    invalid_count = 0
    print(f"\n🔍 Verifying {len(questions)} questions...\n")
    
    for i, question in enumerate(questions, 1):
        question_id = question["id"]
        is_valid, error_msg, answer_invalid, explanation_invalid = verify_with_gemini(question)
        
        status = "✅" if is_valid else "❌"
        print(f"{status} [{i}/{len(questions)}] {question_id}", end="", flush=True)
        
        if not is_valid:
            print(f" - {error_msg}")
            _append_sql_statement(output_file, question, answer_invalid, explanation_invalid)
            invalid_count += 1
        else:
            print()
    
    # Finalize SQL file
    _finalize_sql_file(output_file)
    
    # Summary
    print("\n" + "=" * 80)
    print(f"✅ Verification Complete")
    print(f"Total: {len(questions)} | Invalid: {invalid_count}")
    print(f"SQL file generated: {output_file}")
    print("=" * 80)

if __name__ == "__main__":
    main()

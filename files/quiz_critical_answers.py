#!/usr/bin/env python3
"""
Quiz Critical Answers Validator
Reads critical question IDs from CSV, validates correct_answer via Supabase
Appends invalid answers to txt file in real-time
"""

import os
import csv
import json
from pathlib import Path
from dotenv import load_dotenv
from supabase import create_client, Client
import google.generativeai as genai

# Load environment variables
env_path = Path(__file__).parent / "content-engine" / ".env"
load_dotenv(dotenv_path=env_path)

# Initialize Supabase
SUPABASE_URL = os.getenv("NEXT_PUBLIC_SUPABASE_URL_PROD")
SUPABASE_KEY = os.getenv("NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD")
supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

# Initialize Gemini
api_key = os.getenv("GEMINI_API_KEY")
genai.configure(api_key=api_key)
model = genai.GenerativeModel("gemini-2.5-flash")

OUTPUT_FILE = "quiz_critical_invalid_answers.txt"


def init_output_file():
    """Initialize output file with header"""
    with open(OUTPUT_FILE, 'w') as f:
        f.write("=" * 100 + "\n")
        f.write("QUIZ CRITICAL QUESTIONS - INVALID ANSWERS REPORT\n")
        f.write("=" * 100 + "\n")
        f.write(f"Questions with invalid correct_answer are appended in real-time\n")
        f.write("=" * 100 + "\n\n")


def append_invalid_question(question_id, question_data, reason):
    """Append invalid question to output file"""
    with open(OUTPUT_FILE, 'a') as f:
        f.write(f"[✗ INVALID] Question ID: {question_id}\n")
        f.write(f"Reason: {reason}\n")
        
        text = question_data.get('text', 'N/A')
        if text and len(text) > 100:
            text = text[:100] + "..."
        f.write(f"Text: {text}\n")
        
        f.write(f"Options: {question_data.get('options', [])}\n")
        f.write(f"Correct Answer: {question_data.get('correct_answer', [])}\n")
        f.write(f"Type: {question_data.get('type', 'N/A')}\n")
        f.write("-" * 100 + "\n\n")
    print(f"  ❌ Appended to {OUTPUT_FILE}")


def validate_answer_with_gemini(question):
    """Validate if correct_answer is actually correct using Gemini"""
    text = question.get('text', '')
    options = question.get('options', [])
    correct_answer = question.get('correct_answer', [])
    question_type = question.get('type', '')
    explanation = question.get('explanation', '')
    
    if not text or not options or not correct_answer:
        return False, "Missing required fields"
    
    # Build option letters list
    option_letters = [chr(65+i) for i in range(len(options))]
    options_formatted = "\n".join([f"Option {option_letters[i]}: {options[i]}" for i in range(len(options))])
    correct_answer_letters = [option_letters[i] for i in correct_answer if i < len(option_letters)]
    
    prompt = f"""Verify if the marked correct answer is factually accurate for this {question_type} question:

QUESTION: {text}

OPTIONS:
{options_formatted}

MARKED CORRECT ANSWER: {', '.join(correct_answer_letters)}

EXPLANATION:
{explanation}

Is this the correct answer? Consider:
1. Factual accuracy
2. Best/most complete answer
3. Alignment with question intent

Respond with ONLY "true" or "false" (lowercase).
"""
    
    try:
        response = model.generate_content(prompt)
        result = response.text.strip().lower()
        is_correct = result == "true"
        reason = "Answer verified as correct" if is_correct else "Answer is factually incorrect or not the best choice"
        return is_correct, reason
    except Exception as e:
        return False, f"Gemini error: {str(e)}"


def validate_answer_structure(question):
    """Check basic structure of correct_answer"""
    text = question.get('text', '')
    options = question.get('options', [])
    correct_answer = question.get('correct_answer', [])
    question_type = question.get('type', '')
    
    # Check if required fields exist
    if not text or not options or correct_answer is None:
        return False, "Missing question text, options, or correct_answer"
    
    # Ensure correct_answer is a list
    if isinstance(correct_answer, str):
        try:
            correct_answer = json.loads(correct_answer)
        except:
            return False, f"correct_answer is not valid JSON: {correct_answer}"
    
    # Check if correct_answer is a list
    if not isinstance(correct_answer, list):
        return False, f"correct_answer is not a list: {type(correct_answer)}"
    
    # Check if indices are valid
    for idx in correct_answer:
        if not isinstance(idx, int):
            return False, f"correct_answer contains non-integer index: {idx}"
        if idx < 0 or idx >= len(options):
            return False, f"correct_answer index {idx} out of range (0-{len(options)-1})"
    
    # Check type-specific requirements
    if question_type == "mcq" and len(correct_answer) != 1:
        return False, f"MCQ should have exactly 1 correct answer, has {len(correct_answer)}"
    
    if question_type == "multiple" and len(correct_answer) < 2:
        return False, f"MULTIPLE type should have at least 2 correct answers, has {len(correct_answer)}"
    
    return True, "Structure is valid"


def fetch_and_validate_questions():
    """Fetch questions from CSV and validate each one"""
    csv_file = Path("quiz_critical_questions.csv")
    
    if not csv_file.exists():
        print(f"❌ File not found: {csv_file}")
        return
    
    # Read CSV
    with open(csv_file, 'r') as f:
        reader = csv.DictReader(f)
        question_ids = [row['question_id'] for row in reader]
    
    print(f"\n📋 Loaded {len(question_ids)} critical question IDs from CSV\n")
    print("=" * 100)
    print("VALIDATING CRITICAL QUESTION ANSWERS")
    print("=" * 100)
    print()
    
    invalid_count = 0
    valid_count = 0
    not_found_count = 0
    
    for idx, q_id in enumerate(question_ids, 1):
        print(f"[{idx}/{len(question_ids)}] Validating {q_id}...", end=' ', flush=True)
        
        try:
            # Fetch from Supabase
            response = supabase.table('question').select('*').eq('id', q_id).execute()
            
            if not response.data:
                print("⚠️  Not found in database")
                append_invalid_question(q_id, {}, "Question not found in database")
                not_found_count += 1
                continue
            
            question = response.data[0]
            
            # Check structure first
            is_valid_structure, structure_reason = validate_answer_structure(question)
            if not is_valid_structure:
                print(f"❌ Structure invalid")
                append_invalid_question(q_id, question, structure_reason)
                invalid_count += 1
                continue
            
            # Check accuracy with Gemini
            is_accurate, accuracy_reason = validate_answer_with_gemini(question)
            if not is_accurate:
                print(f"❌ Answer inaccurate")
                append_invalid_question(q_id, question, accuracy_reason)
                invalid_count += 1
                continue
            
            print("✓")
            valid_count += 1
        
        except Exception as e:
            print(f"❌ Error: {str(e)}")
            append_invalid_question(q_id, {}, f"Validation error: {str(e)}")
            invalid_count += 1
    
    print("\n" + "=" * 100)
    print("VALIDATION COMPLETE")
    print("=" * 100)
    print(f"  Total questions: {len(question_ids)}")
    print(f"  Valid answers: {valid_count}")
    print(f"  Invalid answers: {invalid_count}")
    print(f"  Not found: {not_found_count}")
    print(f"\n  Results saved to: {OUTPUT_FILE}")
    print("=" * 100 + "\n")


if __name__ == "__main__":
    init_output_file()
    fetch_and_validate_questions()

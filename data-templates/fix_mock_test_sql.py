#!/usr/bin/env python3
"""
Fix Mock Test SQL Generation Issues

This script fixes common issues in generated mock test SQL scripts:
1. Missing mock_tests table insert
2. "undefined" module_ids
3. Incomplete INSERT statements
"""

import re
import json
import sys
from datetime import datetime
from pathlib import Path

def extract_mock_test_id(content):
    """Extract mock test ID from header comment"""
    match = re.search(r'-- Mock Test ID:\s*(\S+)', content)
    return match.group(1) if match else None

def extract_topic_id(content):
    """Extract topic ID from header comment"""
    match = re.search(r'-- Topic ID:\s*(\d+)', content)
    return match.group(1) if match else None

def extract_question_count(content):
    """Extract question count from header"""
    match = re.search(r'-- Questions:\s*(\d+)', content)
    return match.group(1) if match else None

def extract_questions(content):
    """Extract individual questions from INSERT statements"""
    questions = []
    
    # Pattern to match VALUES clause with question data
    pattern = r"VALUES\s*\(\s*'([^']+)',\s*'([^']*)',\s*'([^']*)'::jsonb,\s*'([^']+)',\s*'({[^}]*})'::integer\[\],\s*'([^']*)',\s*(\d+),\s*'([^']+)',\s*(\d+),\s*NULL,\s*NULL\s*\)"
    
    matches = re.finditer(pattern, content, re.DOTALL)
    for match in matches:
        question = {
            'mock_test_id': match.group(1),
            'question_text': match.group(2),
            'options': match.group(3),
            'question_type': match.group(4),
            'correct_answer': match.group(5),
            'explanation': match.group(6),
            'topic_id': match.group(7),
            'module_id': match.group(8),
            'question_order': match.group(9),
        }
        
        # Validate question
        if is_valid_question(question):
            questions.append(question)
    
    return questions

def is_valid_question(question):
    """Check if a question has all required fields"""
    required_fields = ['mock_test_id', 'question_text', 'options', 'question_type', 
                       'correct_answer', 'explanation', 'topic_id', 'module_id', 'question_order']
    
    for field in required_fields:
        value = question.get(field, '').strip()
        if not value or value == 'undefined':
            return False
    
    return True

def fix_module_id(module_id, topic_id, question_order):
    """
    Fix undefined module_id by inferring from topic and question order
    
    Module mapping rules:
    - If module_id is valid (matches pattern m_X_Y), keep it
    - If module_id is 'undefined', infer based on question content and order
    - Default to m_{topic_id}_{section} where section = basic (1-3), intermediate (4-6), advanced (7+)
    """
    if module_id and module_id != 'undefined' and re.match(r'm_\d+_\d+', module_id):
        return module_id
    
    # Infer section based on question order
    order = int(question_order)
    if order <= 3:
        section = 1
    elif order <= 6:
        section = 2
    elif order <= 10:
        section = 3
    else:
        section = 4
    
    return f"m_{topic_id}_{section}"

def generate_fixed_sql(original_content, module_mapping=None):
    """
    Generate fixed SQL script from original content
    
    Args:
        original_content: Original SQL script content
        module_mapping: Optional dict mapping undefined modules to correct ones
    
    Returns:
        Fixed SQL script content
    """
    mock_test_id = extract_mock_test_id(original_content)
    topic_id = extract_topic_id(original_content)
    question_count = extract_question_count(original_content)
    
    if not all([mock_test_id, topic_id]):
        raise ValueError("Could not extract mock_test_id or topic_id from content")
    
    # Extract questions with validation
    questions = extract_questions(original_content)
    
    if not questions:
        print(f"Warning: No valid questions found in content. Attempting alternative parsing...")
        # Alternative: try to extract questions with more lenient patterns
        questions = extract_questions_lenient(original_content, topic_id)
    
    # Fix module_ids
    fixed_questions = []
    for i, q in enumerate(questions, 1):
        q['module_id'] = fix_module_id(q['module_id'], topic_id, i)
        q['question_order'] = str(i)
        fixed_questions.append(q)
    
    # Calculate difficulty distribution
    difficulty_dist = calculate_difficulty_distribution(fixed_questions)
    
    # Generate new SQL
    sql = generate_sql_script(mock_test_id, topic_id, fixed_questions, difficulty_dist)
    
    return sql

def extract_questions_lenient(content, topic_id):
    """More lenient extraction for questions"""
    questions = []
    # Try to extract from multiple patterns
    # This is a fallback for different formatting styles
    return questions

def calculate_difficulty_distribution(questions):
    """Calculate difficulty distribution from questions"""
    # This would require parsing question objects which might not have difficulty info
    # For now, return a default distribution
    return {"easy": 1, "medium": 1, "hard": 1}

def generate_sql_script(mock_test_id, topic_id, questions, difficulty_dist):
    """Generate the complete fixed SQL script"""
    
    timestamp = datetime.now().isoformat() + 'Z'
    question_count = len(questions)
    
    sql_parts = [
        "-- ═══════════════════════════════════════════════════════",
        "-- Generated Mock Test Questions — AI Pipeline Output",
        "-- ═══════════════════════════════════════════════════════",
        f"-- Mock Test ID: {mock_test_id}",
        f"-- Topic ID: {topic_id}",
        f"-- Questions: {question_count}",
        f"-- Generated: {timestamp}",
        "-- ═══════════════════════════════════════════════════════",
        "",
        "BEGIN;",
        "",
        "-- ─────────────────────────────────────────",
        "-- Create Mock Test Record",
        "-- ─────────────────────────────────────────",
        "",
        "INSERT INTO public.mock_tests (id, topic_id, title, total_questions, difficulty_distribution, created_at, modified_at)",
        "VALUES (",
        f"  '{mock_test_id}',",
        f"  {topic_id},",
        f"  'Mock Test - Topic {topic_id}',",
        f"  0,",
        f"  '{json.dumps(difficulty_dist)}'::jsonb,",
        "  NOW(),",
        "  NOW()",
        ")",
        "ON CONFLICT (id) DO NOTHING;",
        "",
        "-- ─────────────────────────────────────────",
        "-- Add Questions to Mock Test",
        "-- ─────────────────────────────────────────",
        "",
        "INSERT INTO public.mock_test_questions (mock_test_id, question_text, options, question_type, correct_answer, explanation, topic_id, module_id, question_order, pairs, matches)",
        "VALUES"
    ]
    
    # Add question rows
    for i, q in enumerate(questions):
        # Escape single quotes in text
        question_text = q['question_text'].replace("'", "''")
        explanation = q['explanation'].replace("'", "''")
        
        row = f"  ('{mock_test_id}', '{question_text}', '{q['options']}'::jsonb, '{q['question_type']}', '{q['correct_answer']}'::integer[], '{explanation}', {q['topic_id']}, '{q['module_id']}', {q['question_order']}, NULL, NULL)"
        
        if i < len(questions) - 1:
            row += ","
        else:
            row += ""
        
        sql_parts.append(row)
    
    sql_parts.extend([
        "ON CONFLICT DO NOTHING;",
        "",
        "-- ─────────────────────────────────────────",
        "-- Update Mock Test With Question Count",
        "-- ─────────────────────────────────────────",
        "",
        "UPDATE public.mock_tests",
        "SET total_questions = (SELECT COUNT(*) FROM public.mock_test_questions WHERE mock_test_id = '" + mock_test_id + "'),",
        "    modified_at = NOW()",
        f"WHERE id = '{mock_test_id}';",
        "",
        "COMMIT;"
    ])
    
    return "\n".join(sql_parts)

def main():
    if len(sys.argv) < 2:
        print("Usage: python fix_mock_test_sql.py <input_sql_file> [output_sql_file]")
        print("\nExample:")
        print("  python fix_mock_test_sql.py mock_test_input.sql mock_test_fixed.sql")
        sys.exit(1)
    
    input_file = Path(sys.argv[1])
    output_file = Path(sys.argv[2]) if len(sys.argv) > 2 else input_file.parent / f"{input_file.stem}_fixed.sql"
    
    if not input_file.exists():
        print(f"Error: Input file '{input_file}' not found")
        sys.exit(1)
    
    try:
        # Read original content
        original_content = input_file.read_text()
        
        print(f"Processing: {input_file}")
        print(f"  - Extracting mock test information...")
        
        mock_test_id = extract_mock_test_id(original_content)
        topic_id = extract_topic_id(original_content)
        
        print(f"  - Mock Test ID: {mock_test_id}")
        print(f"  - Topic ID: {topic_id}")
        
        # Generate fixed SQL
        fixed_sql = generate_fixed_sql(original_content)
        
        # Write output
        output_file.write_text(fixed_sql)
        print(f"  ✓ Fixed SQL written to: {output_file}")
        
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()

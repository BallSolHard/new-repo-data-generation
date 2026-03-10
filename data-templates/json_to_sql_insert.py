#!/usr/bin/env python3
"""
Convert JSON question data to PostgreSQL INSERT statements
Usage:
  python3 json_to_sql_insert.py input.json output.sql
  python3 json_to_sql_insert.py < input.json > output.sql
"""

import json
import sys
import argparse
from datetime import datetime
from pathlib import Path

def escape_sql_string(value):
    """Escape single quotes in SQL strings"""
    if value is None:
        return "NULL"
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, (int, float)):
        return str(value)
    # Escape single quotes by doubling them
    escaped = str(value).replace("'", "''")
    return f"'{escaped}'"

def convert_options_to_jsonb(options):
    """Convert options array to JSONB format"""
    if not options:
        return "NULL"
    json_str = json.dumps(options)
    escaped = json_str.replace("'", "''")
    return f"'{escaped}'::jsonb"

def convert_array_to_postgres(arr):
    """Convert array to PostgreSQL array format"""
    if not arr or len(arr) == 0:
        return "'{}'::integer[]"
    # Handle array of integers
    if all(isinstance(x, int) for x in arr):
        return "'{" + ",".join(str(x) for x in arr) + "}'::integer[]"
    # Handle array of text
    escaped_items = [str(x).replace("'", "''") for x in arr]
    return "'{" + ",".join(f'"{item}"' for item in escaped_items) + "}'::text[]"

def questions_to_insert_statements(questions, table_name="public.question_bank"):
    """Convert questions JSON to INSERT statements"""
    
    if not questions:
        return ""
    
    statements = []
    timestamp = datetime.now().isoformat()
    
    # Start transaction
    statements.append("BEGIN;")
    statements.append("")
    statements.append("-- Generated SQL INSERT statements from JSON")
    statements.append(f"-- Generated at: {timestamp}")
    statements.append(f"-- Total questions: {len(questions)}")
    statements.append("")
    
    # Determine which columns to use
    first_q = questions[0]
    available_columns = [col for col in first_q.keys() if col not in ['pairs', 'matches']]
    
    # Map JSON fields to database columns
    column_mapping = {
        'id': 'id',
        'text': 'text',
        'type': 'type',
        'options': 'options',
        'correct_answer': 'correct_answer',
        'explanation': 'explanation',
        'difficulty': 'difficulty',
        'module_id': 'module_id',
        'quiz_id': 'quiz_id',
        'index': 'index',
        'created_at': 'created_at',
        'modified_at': 'modified_at',
        'is_deprecated': 'is_deprecated',
    }
    
    # Generate INSERT statements
    for idx, q in enumerate(questions, 1):
        columns = []
        values = []
        
        for json_key, db_col in column_mapping.items():
            if json_key in q:
                columns.append(db_col)
                value = q[json_key]
                
                # Handle special column types
                if json_key == 'options':
                    values.append(convert_options_to_jsonb(value))
                elif json_key == 'correct_answer':
                    values.append(convert_array_to_postgres(value))
                elif json_key in ['created_at', 'modified_at']:
                    # Convert to PostgreSQL timestamp format
                    if value:
                        values.append(f"'{value}'::timestamp")
                    else:
                        values.append("NOW()")
                elif json_key == 'is_deprecated':
                    values.append("true" if value else "false")
                else:
                    values.append(escape_sql_string(value))
        
        # Build INSERT statement
        columns_str = ",\n  ".join(columns)
        values_str = ",\n  ".join(values)
        
        insert_stmt = f"""INSERT INTO {table_name} (
  {columns_str}
) VALUES (
  {values_str}
) ON CONFLICT (id) DO NOTHING;"""
        
        statements.append(insert_stmt)
        if idx < len(questions):
            statements.append("")
    
    statements.append("")
    statements.append("-- Verification Query")
    statements.append("SELECT COUNT(*) as inserted_count FROM " + table_name + ";")
    statements.append("")
    statements.append("COMMIT;")
    
    return "\n".join(statements)

def main():
    parser = argparse.ArgumentParser(
        description="Convert JSON question data to PostgreSQL INSERT statements"
    )
    parser.add_argument(
        "input",
        nargs="?",
        type=argparse.FileType('r'),
        default=sys.stdin,
        help="Input JSON file (default: stdin)"
    )
    parser.add_argument(
        "-o", "--output",
        type=argparse.FileType('w'),
        default=sys.stdout,
        help="Output SQL file (default: stdout)"
    )
    parser.add_argument(
        "-t", "--table",
        default="public.question_bank",
        help="Target table name (default: public.question_bank)"
    )
    
    args = parser.parse_args()
    
    try:
        # Read JSON
        data = json.load(args.input)
        
        # Handle both single object and array of objects
        if isinstance(data, dict):
            data = [data]
        elif not isinstance(data, list):
            raise ValueError("JSON must be an array of objects or a single object")
        
        # Convert to SQL
        sql = questions_to_insert_statements(data, table_name=args.table)
        
        # Write output
        args.output.write(sql)
        
        print(f"\n✅ Successfully converted {len(data)} questions to SQL INSERT statements", file=sys.stderr)
        
    except json.JSONDecodeError as e:
        print(f"❌ Invalid JSON: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"❌ Error: {e}", file=sys.stderr)
        sys.exit(1)
    finally:
        if args.input != sys.stdin:
            args.input.close()
        if args.output != sys.stdout:
            args.output.close()

if __name__ == "__main__":
    main()

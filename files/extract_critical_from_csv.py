#!/usr/bin/env python3
"""
Extract critical quiz questions from a specific CSV validation results file.
Reads a CSV file and extracts all CRITICAL and WARNING flagged questions.
"""

import re
import csv
import sys
import json
from pathlib import Path
from collections import defaultdict
from datetime import datetime

def extract_critical_from_results_txt(filepath):
    """Extract critical/warning questions from a validation results .txt file."""
    critical_questions = []
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Pattern: [✗ CRITICAL] or [✗ WARNING] Question ID: <id>
    pattern = r'\[✗ (?:CRITICAL|WARNING)\]\s+Question ID:\s+([^\n]+)'
    matches = re.findall(pattern, content)
    
    for question_id in matches:
        question_id = question_id.strip()
        if question_id and question_id != 'row_1':  # Skip placeholder rows
            critical_questions.append(question_id)
    
    return critical_questions

def extract_critical_from_csv(filepath):
    """
    Extract critical quiz questions from a CSV file.
    Assumes CSV has columns: id, text, options, correct_answer, explanation, etc.
    """
    critical_questions = []
    question_data = []
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            # Read as text first to detect format
            content = f.read()
        
        # Try to detect if this is already a validation results file
        if '[✗ CRITICAL]' in content or '[✗ WARNING]' in content:
            print(f"Detected validation results format in {filepath}")
            critical_ids = extract_critical_from_results_txt(filepath)
            return critical_ids, []
        
        # Otherwise treat as standard CSV
        with open(filepath, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                question_id = row.get('id') or row.get('question_id') or row.get('ID') or row.get('QUESTION_ID')
                
                if question_id and question_id.strip():
                    critical_questions.append(question_id.strip())
                    question_data.append({
                        'id': question_id.strip(),
                        'text': row.get('text', row.get('TEXT', '')),
                        'type': row.get('type', row.get('TYPE', 'unknown')),
                    })
    
    except Exception as e:
        print(f"Error reading CSV: {e}")
        return [], []
    
    return critical_questions, question_data

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 extract_critical_from_csv.py <csv_file> [--output <output_prefix>]")
        print("\nExample:")
        print("  python3 extract_critical_from_csv.py content-engine/verification-csv/11_networking_speciality.csv")
        print("  python3 extract_critical_from_csv.py content-engine/verification-csv/11_networking_speciality_results.txt")
        sys.exit(1)
    
    csv_file = Path(sys.argv[1])
    
    if not csv_file.exists():
        print(f"❌ File not found: {csv_file}")
        sys.exit(1)
    
    # Determine output prefix
    output_prefix = None
    if '--output' in sys.argv:
        idx = sys.argv.index('--output')
        if idx + 1 < len(sys.argv):
            output_prefix = sys.argv[idx + 1]
    
    if output_prefix is None:
        output_prefix = csv_file.stem  # Use filename without extension
    
    output_dir = Path("/Users/ranjanbatra/Ranjan_Programming_repos/studytech-content-engine")
    
    print(f"📖 Processing: {csv_file}")
    print(f"📊 Output prefix: {output_prefix}\n")
    
    # Extract critical questions
    critical_ids, question_data = extract_critical_from_csv(csv_file)
    
    if not critical_ids:
        print("⚠️  No critical or warning questions found in file")
        return
    
    # Write question IDs
    ids_file = output_dir / f"{output_prefix}_critical_ids.txt"
    with open(ids_file, 'w') as f:
        for qid in critical_ids:
            f.write(f"{qid}\n")
    print(f"✅ Wrote {len(critical_ids)} critical question IDs to: {ids_file.name}")
    
    # Write CSV with extracted data (if available)
    if question_data:
        csv_file_out = output_dir / f"{output_prefix}_critical_questions.csv"
        with open(csv_file_out, 'w', newline='') as f:
            writer = csv.DictWriter(f, fieldnames=['id', 'text', 'type'])
            writer.writeheader()
            writer.writerows(question_data)
        print(f"✅ Wrote question data to: {csv_file_out.name}")
    
    # Write summary
    summary_file = output_dir / f"{output_prefix}_summary.txt"
    with open(summary_file, 'w') as f:
        f.write("=" * 80 + "\n")
        f.write(f"CRITICAL & WARNING QUESTIONS EXTRACTION\n")
        f.write("=" * 80 + "\n\n")
        f.write(f"Source File: {csv_file.name}\n")
        f.write(f"Extracted At: {datetime.now().isoformat()}\n\n")
        f.write(f"Total CRITICAL/WARNING Questions Found: {len(critical_ids)}\n\n")
        f.write("Question IDs:\n")
        f.write("-" * 80 + "\n")
        for i, qid in enumerate(critical_ids, 1):
            f.write(f"{i:4d}. {qid}\n")
        f.write("\n" + "=" * 80 + "\n")
    print(f"✅ Wrote summary to: {summary_file.name}")
    
    print("\n" + "=" * 80)
    print("EXTRACTION COMPLETE")
    print("=" * 80)
    print(f"Total critical questions: {len(critical_ids)}")
    print(f"\nOutput files:")
    print(f"  • {ids_file.name}")
    if question_data:
        print(f"  • {csv_file_out.name}")
    print(f"  • {summary_file.name}")

if __name__ == "__main__":
    main()

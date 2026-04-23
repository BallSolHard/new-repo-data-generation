#!/usr/bin/env python3
"""
Extract critical quiz questions from validation result files.
Mirrors the mock test extraction logic but for quiz questions in content-engine/verification-csv/
"""

import re
import os
import json
from pathlib import Path
from collections import defaultdict

RESULTS_DIR = Path("/Users/ranjanbatra/Ranjan_Programming_repos/studytech-content-engine/content-engine/verification-csv")
OUTPUT_DIR = Path("/Users/ranjanbatra/Ranjan_Programming_repos/studytech-content-engine")

def extract_critical_from_file(filepath):
    """Extract all CRITICAL and WARNING questions from a single validation results file."""
    critical_questions = []
    
    with open(filepath, 'r') as f:
        content = f.read()
    
    # Pattern: [✗ CRITICAL] or [✗ WARNING] Question ID: <id>
    pattern = r'\[✗ (?:CRITICAL|WARNING)\]\s+Question ID:\s+([^\n]+)'
    matches = re.findall(pattern, content)
    
    for question_id in matches:
        question_id = question_id.strip()
        critical_questions.append(question_id)
    
    return critical_questions

def process_all_quiz_results():
    """Process all *_results.txt files in content-engine/verification-csv/"""
    
    # Find all quiz results files (skip mocktest files)
    results_files = sorted([f for f in RESULTS_DIR.glob('*_results.txt') 
                           if 'mocktest' not in f.name.lower()])
    
    print(f"Found {len(results_files)} quiz results files")
    
    all_critical_ids = []
    summary_by_file = {}
    all_questions = []
    
    for results_file in results_files:
        print(f"Processing {results_file.name}...", end=" ")
        
        critical_ids = extract_critical_from_file(results_file)
        
        # Get base filename for reference
        base_name = results_file.name.replace('_results.txt', '')
        summary_by_file[base_name] = len(critical_ids)
        
        print(f"Found {len(critical_ids)} CRITICAL questions")
        
        # Extract corresponding CSV for additional data
        csv_file = RESULTS_DIR / f"{base_name}.csv"
        if csv_file.exists():
            try:
                # Try to read CSV and extract data for critical questions
                with open(csv_file, 'r') as f:
                    csv_content = f.read()
                
                # For each critical ID, try to find it in CSV
                for question_id in critical_ids:
                    all_critical_ids.append(question_id)
                    
                    # Add to consolidated list
                    all_questions.append({
                        'question_id': question_id,
                        'certification': base_name,
                        'source_file': results_file.name
                    })
            except Exception as e:
                print(f"  Warning: Could not process {csv_file}: {e}")
        else:
            # Just record the IDs
            for question_id in critical_ids:
                all_critical_ids.append(question_id)
                all_questions.append({
                    'question_id': question_id,
                    'certification': base_name,
                    'source_file': results_file.name
                })
    
    return all_critical_ids, summary_by_file, all_questions

def write_critical_ids(critical_ids, output_file):
    """Write critical question IDs to file."""
    with open(output_file, 'w') as f:
        for qid in critical_ids:
            f.write(f"{qid}\n")
    print(f"\n✓ Wrote {len(critical_ids)} critical question IDs to {output_file.name}")

def write_summary(summary_by_file, output_file):
    """Write summary by certification file."""
    with open(output_file, 'w') as f:
        f.write("CRITICAL & WARNING QUIZ QUESTIONS SUMMARY\n")
        f.write("=" * 80 + "\n\n")
        
        total = 0
        for cert, count in sorted(summary_by_file.items(), key=lambda x: -x[1]):
            f.write(f"{cert}: {count} CRITICAL/WARNING questions\n")
            total += count
        
        f.write("\n" + "=" * 80 + "\n")
        f.write(f"TOTAL: {total} CRITICAL/WARNING questions across {len(summary_by_file)} certifications\n")
    
    print(f"✓ Wrote summary to {output_file.name}")

def write_csv(all_questions, output_file):
    """Write critical questions to CSV format."""
    with open(output_file, 'w') as f:
        f.write("question_id,certification,source_file\n")
        for q in all_questions:
            f.write(f'{q["question_id"]},{q["certification"]},{q["source_file"]}\n')
    
    print(f"✓ Wrote {len(all_questions)} questions to {output_file.name}")

def main():
    print("Extracting critical quiz questions...\n")
    
    # Process all quiz results files
    critical_ids, summary, all_questions = process_all_quiz_results()
    
    # Write output files
    output_ids = OUTPUT_DIR / "quiz_critical_question_ids.txt"
    output_summary = OUTPUT_DIR / "quiz_critical_questions_summary.txt"
    output_csv = OUTPUT_DIR / "quiz_critical_questions.csv"
    
    write_critical_ids(critical_ids, output_ids)
    write_summary(summary, output_summary)
    write_csv(all_questions, output_csv)
    
    print("\n" + "=" * 80)
    print(f"EXTRACTION COMPLETE")
    print("=" * 80)
    print(f"Total critical questions found: {len(critical_ids)}")
    print(f"Output files:")
    print(f"  - {output_ids.name}")
    print(f"  - {output_summary.name}")
    print(f"  - {output_csv.name}")

if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""
Extract Critical Question IDs from Mock Test Validation Results

This script processes all validation result text files in src/verification-csv/invalid-mocktest/
and extracts all question IDs that have CRITICAL status, generating a comprehensive report.
"""

import re
from pathlib import Path
from typing import List, Dict, Set
from datetime import datetime
from collections import defaultdict


@staticmethod
def extract_critical_questions(txt_file: Path) -> Dict[str, List[str]]:
    """
    Extract all questions with CRITICAL status from a validation results file.
    
    Returns a dict with:
    - 'critical_ids': list of question IDs with CRITICAL status
    - 'file_name': source file name
    - 'total_critical': count of critical questions
    """
    critical_ids = []
    
    try:
        with open(txt_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Pattern to find [✗ CRITICAL] Question ID: <id>
        pattern = r'\[✗ CRITICAL\]\s+Question ID:\s+([\w\-]+)'
        matches = re.finditer(pattern, content)
        
        for match in matches:
            question_id = match.group(1)
            critical_ids.append(question_id)
        
        return {
            'critical_ids': critical_ids,
            'file_name': txt_file.name,
            'total_critical': len(critical_ids)
        }
    except Exception as e:
        print(f"Error reading file {txt_file}: {e}")
        return {
            'critical_ids': [],
            'file_name': txt_file.name,
            'total_critical': 0
        }


def generate_critical_report(input_dir: str = "src/verification-csv/invalid-mocktest", 
                            output_dir: str = "src/verification-csv/invalid-mocktest") -> None:
    """
    Process all validation result files and generate a critical questions report.
    
    Args:
        input_dir: Directory containing validation result .txt files
        output_dir: Directory to save output files
    """
    input_path = Path(input_dir)
    output_path = Path(output_dir)
    
    # Validate input directory exists
    if not input_path.exists():
        print(f"Error: Input directory not found: {input_dir}")
        return
    
    # Create output directory if needed
    output_path.mkdir(parents=True, exist_ok=True)
    
    print(f"Scanning for validation results in: {input_dir}")
    print("-" * 80)
    
    # Find all .txt files (excluding report files)
    txt_files = sorted([f for f in input_path.glob("*_validation_results.txt")])
    
    if not txt_files:
        print("No validation result files found!")
        return
    
    print(f"Found {len(txt_files)} validation result file(s)")
    print("-" * 80 + "\n")
    
    # Process all files
    all_critical_ids = []
    file_results = []
    by_file_stats = defaultdict(lambda: {"critical": 0, "warning": 0, "total": 0})
    
    for txt_file in txt_files:
        print(f"Processing: {txt_file.name}...", end=" ")
        result = extract_critical_questions(txt_file)
        file_results.append(result)
        all_critical_ids.extend(result['critical_ids'])
        
        # Extract filename base for stats
        file_base = txt_file.stem.replace('_validation_results', '')
        
        # Count statistics from file
        with open(txt_file, 'r', encoding='utf-8') as f:
            content = f.read()
            critical_count = len(re.findall(r'\[✗ CRITICAL\]', content))
            warning_count = len(re.findall(r'\[✗ WARNING\]', content))
            total_count = len(re.findall(r'\[✓ VALID\]|\[✗ (CRITICAL|WARNING)\]', content))
            
            by_file_stats[file_base] = {
                "critical": critical_count,
                "warning": warning_count,
                "total": total_count
            }
        
        print(f"✓ Found {result['total_critical']} critical question(s)")
    
    print("\n" + "=" * 80)
    print("CRITICAL QUESTIONS EXTRACTION COMPLETE")
    print("=" * 80 + "\n")
    
    # Generate summary file
    summary_file = output_path / "critical_questions_summary.txt"
    with open(summary_file, 'w', encoding='utf-8') as f:
        f.write("=" * 80 + "\n")
        f.write("CRITICAL QUESTIONS SUMMARY REPORT\n")
        f.write("=" * 80 + "\n\n")
        f.write(f"Timestamp: {datetime.now().isoformat()}\n")
        f.write(f"Scan Directory: {input_dir}\n")
        f.write(f"Files Processed: {len(txt_files)}\n\n")
        
        # Overall statistics
        total_critical = len(all_critical_ids)
        f.write(f"OVERALL STATISTICS\n")
        f.write("-" * 80 + "\n")
        f.write(f"Total Critical Questions Found: {total_critical}\n\n")
        
        # Statistics by file
        f.write(f"BREAKDOWN BY FILE\n")
        f.write("-" * 80 + "\n")
        for file_result in file_results:
            file_base = file_result['file_name'].replace('_validation_results.txt', '')
            stats = by_file_stats.get(file_base, {})
            f.write(f"\n{file_result['file_name']}:\n")
            f.write(f"  Critical: {file_result['total_critical']}\n")
            f.write(f"  Warning: {stats.get('warning', 0)}\n")
            f.write(f"  Total Issues: {stats.get('critical', 0) + stats.get('warning', 0)}\n")
            f.write(f"  Total Questions: {stats.get('total', 0)}\n")
        
        # All critical question IDs
        f.write(f"\n\nALL CRITICAL QUESTION IDs ({total_critical})\n")
        f.write("-" * 80 + "\n")
        for qid in sorted(all_critical_ids):
            f.write(f"  {qid}\n")
    
    # Generate CSV file for import
    csv_file = output_path / "critical_questions.csv"
    with open(csv_file, 'w', encoding='utf-8') as f:
        f.write("question_id,source_file,severity\n")
        for file_result in file_results:
            for qid in file_result['critical_ids']:
                file_base = file_result['file_name'].replace('_validation_results.txt', '')
                f.write(f"{qid},{file_base},CRITICAL\n")
    
    # Generate plain text list (one ID per line)
    ids_file = output_path / "critical_question_ids.txt"
    with open(ids_file, 'w', encoding='utf-8') as f:
        f.write("CRITICAL QUESTION IDs\n")
        f.write("=" * 80 + "\n\n")
        for qid in sorted(all_critical_ids):
            f.write(f"{qid}\n")
    
    # Print summary to console
    print(f"\nTotal Critical Questions Found: {total_critical}\n")
    
    if by_file_stats:
        print("BREAKDOWN BY FILE:")
        print("-" * 80)
        for file_name, stats in sorted(by_file_stats.items()):
            print(f"{file_name}:")
            print(f"  Critical: {stats['critical']}")
            print(f"  Warning: {stats['warning']}")
            print(f"  Valid: {stats['total'] - stats['critical'] - stats['warning']}")
            print(f"  Total: {stats['total']}\n")
    
    print("=" * 80)
    print(f"Summary saved to: {summary_file}")
    print(f"CSV export saved to: {csv_file}")
    print(f"Question IDs saved to: {ids_file}")
    print("=" * 80)


def main():
    """Main entry point"""
    import argparse
    
    parser = argparse.ArgumentParser(
        description="Extract all CRITICAL questions from mock test validation results"
    )
    parser.add_argument(
        "--input-dir",
        "-i",
        default="src/verification-csv/invalid-mocktest",
        help="Input directory containing validation result files (default: src/verification-csv/invalid-mocktest)"
    )
    parser.add_argument(
        "--output-dir",
        "-o",
        default="src/verification-csv/invalid-mocktest",
        help="Output directory for results (default: src/verification-csv/invalid-mocktest)"
    )
    
    args = parser.parse_args()
    
    generate_critical_report(args.input_dir, args.output_dir)


if __name__ == "__main__":
    main()

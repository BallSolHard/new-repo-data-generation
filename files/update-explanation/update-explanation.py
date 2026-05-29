#!/usr/bin/env python3
"""
Anti-pattern Explanation Remover
Processes anti-pattern records from JSON, removes anti-pattern references from explanations
using Gemini AI, and generates SQL UPDATE statements based on question_text.
"""

import json
import os
import re
from typing import List, Dict, Any, Optional
from pathlib import Path
from datetime import datetime
from dotenv import load_dotenv
import google.generativeai as genai

# Load environment variables
load_dotenv()

GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")

# Initialize Gemini
gemini_model = None
if GEMINI_API_KEY:
    genai.configure(api_key=GEMINI_API_KEY)
    gemini_model = genai.GenerativeModel("gemini-2.5-flash")
    print("✓ Gemini API configured")
else:
    print("❌ ERROR: GEMINI_API_KEY not found in .env")
    exit(1)


class AntiPatternExplanationRemover:
    """Class to handle anti-pattern explanation removal and SQL generation."""

    def __init__(self, records_file: str = "anti-pattern-records.json"):
        """
        Initialize the remover with path to anti-pattern records.

        Args:
            records_file: Path to the anti-pattern records JSON file
        """
        self.records_file = Path(records_file)
        self.records = []
        self.cleaned_records = []
        self.sql_statements = []
        
        # Create output directory
        today = datetime.now().strftime("%Y-%m-%d")
        self.output_dir = Path(__file__).parent / today
        self.output_dir.mkdir(parents=True, exist_ok=True)
        
        print(f"✓ Output directory: {self.output_dir}")

    def load_records(self) -> bool:
        """
        Load anti-pattern records from JSON file.

        Returns:
            True if records loaded successfully, False otherwise
        """
        try:
            if not self.records_file.exists():
                print(f"❌ ERROR: Records file not found: {self.records_file}")
                return False

            with open(self.records_file, "r") as f:
                self.records = json.load(f)

            print(f"✓ Loaded {len(self.records)} records from {self.records_file}")
            return True

        except json.JSONDecodeError as e:
            print(f"❌ ERROR: Failed to parse JSON: {e}")
            return False
        except Exception as e:
            print(f"❌ ERROR: Failed to load records: {e}")
            return False

    def remove_antipattern_from_explanation(self, explanation: str) -> str:
        """
        Use Gemini to remove anti-pattern references from explanation.
        Removes text like "(Anti-pattern: ap-3.2-001)", "(Anti-pattern: ap-X.X-XXX)" etc.

        Args:
            explanation: Original explanation with anti-pattern markers

        Returns:
            Cleaned explanation without anti-pattern references
        """
        try:
            # First, try simple regex removal for common patterns
            # This handles: (Anti-pattern: ap-X.X-XXX)
            cleaned = re.sub(r'\s*\(Anti-pattern:\s*ap-[\d\.\-]+\)', '', explanation)
            
            # Also handle variations like: Anti-pattern: ap-3.2-001
            cleaned = re.sub(r'\s*Anti-pattern:\s*ap-[\d\.\-]+', '', cleaned)
            
            # Remove any extra whitespace
            cleaned = re.sub(r'\s+', ' ', cleaned).strip()

            # If the explanation still contains "anti-pattern" or "Anti-pattern", use Gemini
            if "anti-pattern" in cleaned.lower():
                print(f"   [Using Gemini to clean complex anti-pattern references]", end="")
                
                prompt = f"""Remove all references to anti-patterns from the following explanation. 
Anti-pattern references look like "(Anti-pattern: ap-3.2-001)" or similar.
Keep all other content intact.
Return ONLY the cleaned explanation text without any additional commentary.

ORIGINAL EXPLANATION:
{explanation}

CLEANED EXPLANATION:
"""
                
                response = gemini_model.generate_content(prompt)
                cleaned = response.text.strip()
                print(" ✓")

            return cleaned

        except Exception as e:
            print(f"   [Error cleaning explanation: {e}]")
            return explanation

    def process_records(self) -> bool:
        """
        Process all records: remove anti-pattern references from explanations.

        Returns:
            True if all records processed successfully
        """
        if not self.records:
            print("❌ No records to process")
            return False

        print(f"\n{'='*80}")
        print(f"Processing {len(self.records)} records...")
        print(f"{'='*80}\n")

        success_count = 0

        for idx, record in enumerate(self.records, 1):
            try:
                print(f"[{idx}/{len(self.records)}] Processing record: {record.get('id', 'Unknown')}")
                
                # Get original explanation
                original_explanation = record.get("explanation", "")
                
                if not original_explanation:
                    print(f"  ⚠️  No explanation found, skipping")
                    continue

                # Remove anti-pattern references
                print(f"  - Removing anti-pattern references...", end="")
                cleaned_explanation = self.remove_antipattern_from_explanation(original_explanation)
                print(" ✓")

                # Store cleaned record
                cleaned_record = record.copy()
                cleaned_record["original_explanation"] = original_explanation
                cleaned_record["cleaned_explanation"] = cleaned_explanation
                cleaned_record["text"] = record.get("text", "")
                
                self.cleaned_records.append(cleaned_record)
                success_count += 1

                print(f"  - Original: {original_explanation[:80]}...")
                print(f"  - Cleaned:  {cleaned_explanation[:80]}...")
                print()

            except Exception as e:
                print(f"  ❌ Error processing record: {e}")
                continue

        print(f"{'='*80}")
        print(f"✓ Successfully processed {success_count}/{len(self.records)} records")
        print(f"{'='*80}\n")

        return success_count > 0

    def generate_sql_statements(self) -> bool:
        """
        Generate SQL UPDATE statements based on cleaned explanations.
        Updates are based on question_text matching, not question_id.

        Returns:
            True if SQL statements generated successfully
        """
        if not self.cleaned_records:
            print("❌ No cleaned records available for SQL generation")
            return False

        print(f"\n{'='*80}")
        print(f"Generating SQL statements based on question_text...")
        print(f"{'='*80}\n")

        self.sql_statements = []
        success_count = 0

        # Start transaction
        self.sql_statements.append("BEGIN;")
        self.sql_statements.append("")

        for idx, record in enumerate(self.cleaned_records, 1):
            try:
                question_text = record.get("text", "")
                cleaned_explanation = record.get("cleaned_explanation", "")
                record_id = record.get("id", "")

                if not question_text or not cleaned_explanation:
                    print(f"[{idx}/{len(self.cleaned_records)}] Skipping - missing text or explanation")
                    continue

                # Escape single quotes for SQL
                question_text_escaped = question_text.replace("'", "''")
                explanation_escaped = cleaned_explanation.replace("'", "''")

                # Generate SQL UPDATE statement
                # Matches on question_text to find the record
                sql_statement = f"""-- Record ID: {record_id}
UPDATE public.mock_test_questions
SET explanation = '{explanation_escaped}'
WHERE question_text = '{question_text_escaped}';
"""
                
                self.sql_statements.append(sql_statement)
                success_count += 1

                print(f"[{idx}/{len(self.cleaned_records)}] Generated SQL for: {record_id}")
                print(f"  - Question: {question_text[:60]}...")
                print()

            except Exception as e:
                print(f"[{idx}/{len(self.cleaned_records)}] ❌ Error generating SQL: {e}")
                continue

        # End transaction
        self.sql_statements.append("")
        self.sql_statements.append("COMMIT;")

        print(f"{'='*80}")
        print(f"✓ Generated SQL for {success_count}/{len(self.cleaned_records)} records")
        print(f"{'='*80}\n")

        return success_count > 0

    def save_results(self) -> Dict[str, str]:
        """
        Save cleaned records and SQL statements to files.

        Returns:
            Dictionary with file paths
        """
        output_files = {}

        try:
            # Save cleaned records as JSON
            cleaned_json_file = self.output_dir / "cleaned_records.json"
            with open(cleaned_json_file, "w") as f:
                json.dump(self.cleaned_records, f, indent=2)
            output_files["cleaned_json"] = str(cleaned_json_file)
            print(f"✓ Cleaned records saved: {cleaned_json_file}")

        except Exception as e:
            print(f"❌ Error saving cleaned records: {e}")

        try:
            # Save SQL statements
            sql_file = self.output_dir / "update_explanations.sql"
            with open(sql_file, "w") as f:
                f.write("\n".join(self.sql_statements))
            output_files["sql"] = str(sql_file)
            print(f"✓ SQL statements saved: {sql_file}")

        except Exception as e:
            print(f"❌ Error saving SQL statements: {e}")

        try:
            # Save summary report
            summary = {
                "total_records": len(self.records),
                "processed_records": len(self.cleaned_records),
                "sql_statements_generated": len(self.sql_statements),
                "timestamp": datetime.now().isoformat(),
                "output_directory": str(self.output_dir),
                "files": output_files
            }
            
            summary_file = self.output_dir / "summary.json"
            with open(summary_file, "w") as f:
                json.dump(summary, f, indent=2)
            output_files["summary"] = str(summary_file)
            print(f"✓ Summary saved: {summary_file}")

        except Exception as e:
            print(f"❌ Error saving summary: {e}")

        return output_files

    def apply_sql_to_database(self, dry_run: bool = True) -> bool:
        """
        Display SQL statements (no database execution).

        Args:
            dry_run: If True, only print the SQL without executing

        Returns:
            True if display successful
        """
        if not self.sql_statements:
            print("❌ No SQL statements to display")
            return False

        print(f"\n{'='*80}")
        print("SQL Statements Generated (Ready for execution)")
        print(f"{'='*80}\n")
        print("\n".join(self.sql_statements[:20]))  # Show first 20 lines
        if len(self.sql_statements) > 20:
            print(f"\n... and {len(self.sql_statements) - 20} more lines")
        print(f"\n{'='*80}\n")
        return True

    def run_full_pipeline(self, apply_to_db: bool = False, dry_run: bool = True) -> bool:
        """
        Run the complete pipeline: load → process → generate SQL → save.

        Args:
            apply_to_db: Ignored (kept for backward compatibility)
            dry_run: Ignored (kept for backward compatibility)

        Returns:
            True if pipeline completed successfully
        """
        print(f"\n{'='*80}")
        print("Anti-Pattern Explanation Remover - Full Pipeline")
        print(f"{'='*80}\n")

        # Step 1: Load records
        if not self.load_records():
            return False

        # Step 2: Process records
        if not self.process_records():
            return False

        # Step 3: Generate SQL
        if not self.generate_sql_statements():
            return False

        # Step 4: Save results
        self.save_results()

        # Step 5: Display SQL statements
        self.apply_sql_to_database()

        print(f"\n{'='*80}")
        print("✓ Pipeline completed successfully")
        print(f"Results saved to: {self.output_dir}")
        print(f"{'='*80}\n")

        return True


def main():
    """Main execution function."""
    # Get the directory of this script
    script_dir = Path(__file__).parent
    records_file = script_dir / "anti-pattern-records.json"
    
    # Initialize remover
    remover = AntiPatternExplanationRemover(
        records_file=str(records_file)
    )

    # Run full pipeline (only creates SQL files, no database execution)
    remover.run_full_pipeline()

    # Print sample SQL for verification
    if remover.sql_statements:
        print("\n" + "="*80)
        print("SAMPLE SQL STATEMENTS (first 5):")
        print("="*80 + "\n")
        for statement in remover.sql_statements[:5]:
            if statement.strip():
                print(statement)


if __name__ == "__main__":
    main()

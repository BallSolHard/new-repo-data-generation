#!/usr/bin/env python3
"""
Update On Review - Fix Critical Questions (PROD ONLY)
Reads critical question IDs → Fetches from Supabase PROD → Analyzes with Gemini → Generates SQL fixes
"""

import os
import json
import re
from pathlib import Path
from dotenv import load_dotenv
import google.generativeai as genai
from supabase import create_client, Client

# Load environment variables
env_path = Path(__file__).parent / "content-engine" / ".env"
load_dotenv(dotenv_path=env_path)

class UpdateOnReview:
    def __init__(self):
        """Initialize for PROD environment"""
        self.gemini_api_key = os.getenv('GEMINI_API_KEY')
        if not self.gemini_api_key:
            raise ValueError("GEMINI_API_KEY not set")
        
        genai.configure(api_key=self.gemini_api_key)
        self.model = genai.GenerativeModel('gemini-2.5-flash')
        
        self.supabase_url = os.getenv('NEXT_PUBLIC_SUPABASE_URL_PROD')
        self.supabase_key = os.getenv('NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD')
        
        if not self.supabase_url or not self.supabase_key:
            raise ValueError("SUPABASE_URL_PROD or SERVICE_ROLE_KEY_PROD not set")
        
        self.supabase = create_client(self.supabase_url, self.supabase_key)
        print(f"🔌 Connected to PROD Supabase (Service Role Key)\n")
        
        self.sql_file = 'sql_updates_from_review.sql'
        self.analysis_results = []
        self.total_sql_statements = 0
        
        # Initialize SQL file with header
        self._init_sql_file()
        
    def _init_sql_file(self):
        """Initialize SQL file with header"""
        with open(self.sql_file, 'w') as f:
            f.write("-- Update Critical Mock Test Questions (PROD)\n")
            f.write("-- Generated from updateonreview.py\n")
            f.write("-- Appended on each record processing\n\n")
            f.write("BEGIN;\n\n")
    
    def _append_sql_statement(self, sql):
        """Append SQL statement to file immediately"""
        if not sql:
            return
        
        with open(self.sql_file, 'a') as f:
            f.write(sql + "\n\n")
        
        self.total_sql_statements += 1
        
    def load_critical_question_ids(self):
        """Load critical question IDs from file"""
        critical_ids_file = Path(__file__).parent / "src" / "verification-csv" / "invalid-mocktest" / "critical_question_ids.txt"
        
        if not critical_ids_file.exists():
            print(f"❌ File not found: {critical_ids_file}")
            return []
        
        try:
            with open(critical_ids_file, 'r') as f:
                lines = f.readlines()
            
            # Skip header lines and extract UUIDs
            ids = [line.strip() for line in lines if line.strip() and '-' in line and len(line.strip()) == 36]
            print(f"📋 Loaded {len(ids)} critical question IDs from file\n")
            return ids
        except Exception as e:
            print(f"❌ Error loading critical IDs: {str(e)}\n")
            return []
        
    def get_questions(self, question_ids, limit=None):
        """Fetch specific questions from PROD database by question_ids"""
        if not question_ids:
            print("❌ No question IDs provided")
            return []
        
        # Limit the IDs if specified
        ids_to_fetch = question_ids[:limit] if limit else question_ids
        
        try:
            print(f"📥 Fetching {len(ids_to_fetch)} questions from PROD...")
            questions = []
            for q_id in ids_to_fetch:
                response = self.supabase.table('mock_test_questions').select('*').eq('question_id', q_id).execute()
                if response.data and len(response.data) > 0:
                    questions.append(response.data[0])
            
            print(f"✅ Got {len(questions)} questions\n")
            return questions
        except Exception as e:
            print(f"❌ Error: {str(e)}\n")
            return []
    
    def analyze_with_gemini(self, question):
        """Step 1 - Verify if the correct_answer index is actually correct"""
        try:
            options = question.get('options', [])
            options_formatted = "\n".join([f"  [{i}] {opt}" for i, opt in enumerate(options)])

            prompt = f"""You are an AWS certification expert. Evaluate this mock test question strictly.

QUESTION: {question.get('question_text')}
OPTIONS:
{options_formatted}
CURRENT CORRECT ANSWER INDICES: {question.get('correct_answer')}

Task: Verify whether the marked correct answer index/indices are factually accurate based on AWS documentation and best practices.

Return ONLY this JSON (no markdown, no extra text):
{{
    "answer_is_correct": true or false,
    "correct_answer_indices": [list of correct 0-based indices],
    "confidence": 0.0 to 1.0,
    "reasoning": "brief explanation of why these indices are correct"
}}"""

            response = self.model.generate_content(prompt, request_options={"timeout": 30})
            json_match = re.search(r'\{[\s\S]*\}', response.text.strip())
            if json_match:
                return json.loads(json_match.group())
            return {"answer_is_correct": True, "correct_answer_indices": question.get('correct_answer', [])}
        except Exception as e:
            print(f"❌ Gemini error (answer check): {str(e)}")
            return {"answer_is_correct": True, "correct_answer_indices": question.get('correct_answer', [])}

    def generate_explanation(self, question, correct_answer_indices):
        """Step 2 - Generate a detailed per-option explanation"""
        try:
            options = question.get('options', [])
            options_formatted = "\n".join([f"  [{i}] {opt}" for i, opt in enumerate(options)])
            correct_labels = [chr(65 + i) for i in correct_answer_indices]  # e.g. [0,2] → ['A','C']

            prompt = f"""You are an AWS certification expert. Write a detailed explanation for this mock test question.

QUESTION: {question.get('question_text')}
OPTIONS:
{options_formatted}
CORRECT ANSWER(S): {', '.join([f'Option {l} (index {i})' for l, i in zip(correct_labels, correct_answer_indices)])}

Write an explanation that covers EVERY option in order. For each option state:
- Whether it is correct or incorrect
- A specific technical reason referencing AWS services, features, or best practices

Use this exact format for each option (one sentence per option, no bullet points, plain text):
Option A (correct/incorrect) <reason>. Option B (correct/incorrect) <reason>. ... and so on.

Return only the explanation text, no JSON, no markdown."""

            response = self.model.generate_content(prompt, request_options={"timeout": 45})
            return response.text.strip()
        except Exception as e:
            print(f"    ⚠️  Failed to generate explanation: {str(e)}")
            return None

    def generate_sql_update(self, question, answer_analysis):
        """Generate SQL UPDATE for correct_answer and/or explanation"""
        question_id = question.get('question_id')
        current_answer = question.get('correct_answer', [])
        answer_is_correct = answer_analysis.get('answer_is_correct', True)
        verified_indices = answer_analysis.get('correct_answer_indices', current_answer)

        set_clauses = []

        # 1. Fix correct_answer if wrong - use integer[] format
        if not answer_is_correct:
            # Convert list to PostgreSQL integer[] format: {0,1}
            indices_str = '{' + ','.join(str(i) for i in verified_indices) + '}'
            set_clauses.append(f"correct_answer = '{indices_str}'::integer[]")

        # 2. Always regenerate explanation (per-option detail check)
        print(f"    ✍️  Generating per-option explanation...", end=' ', flush=True)
        new_explanation = self.generate_explanation(question, verified_indices)
        print("✓")

        if new_explanation:
            cleaned = new_explanation.replace("'", "''").replace('\n', ' ').replace('\r', '').strip()
            set_clauses.append(f"explanation = '{cleaned}'")

        if not set_clauses:
            return None

        sets = ',\n    '.join(set_clauses)
        return (
            f"-- question_id: {question_id}\n"
            f"-- answer_correct: {answer_is_correct} | verified_indices: {verified_indices} | confidence: {answer_analysis.get('confidence', 0):.0%}\n"
            f"UPDATE public.mock_test_questions\n"
            f"SET\n    {sets}\n"
            f"WHERE question_id = '{question_id}';"
        )

    def run(self, limit=None):
        """Run analysis on critical questions"""
        print("="*80)
        print("   🔍 UPDATE ON REVIEW - PROD ONLY")
        print("="*80 + "\n")
        
        # Load critical question IDs from file
        critical_ids = self.load_critical_question_ids()
        if not critical_ids:
            print("❌ No critical question IDs found")
            return False
        
        # Fetch only critical questions
        questions = self.get_questions(critical_ids, limit=limit)
        if not questions:
            print("❌ No questions found in database")
            return False
        
        print(f"🔄 Processing {len(questions)} question(s)...\n")
        
        for idx, q in enumerate(questions, 1):
            q_text = q.get('question_text', '')[:60] + "..."
            print(f"[{idx}] {q_text}")
            print(f"    🔍 Step 1: Verifying correct answer...", end=' ', flush=True)
            
            answer_analysis = self.analyze_with_gemini(q)
            answer_is_correct = answer_analysis.get('answer_is_correct', True)
            verified_indices = answer_analysis.get('correct_answer_indices', q.get('correct_answer'))
            print("✓")

            if not answer_is_correct:
                print(f"    ⚠️  Answer wrong → should be {verified_indices} ({answer_analysis.get('confidence', 0):.0%})")
            else:
                print(f"    ✓ Answer correct: {verified_indices}")

            self.analysis_results.append({
                'question_id': q.get('question_id'),
                'question_text': q.get('question_text'),
                'answer_analysis': answer_analysis
            })

            print(f"    📝 Step 2: Generating per-option explanation...", end=' ', flush=True)
            sql = self.generate_sql_update(q, answer_analysis)

            if sql:
                self._append_sql_statement(sql)
                print(f"    ✅ SQL update appended\n")
            else:
                print(f"    ⚠️  No SQL generated\n")
        
        # Finalize SQL file
        self._finalize_sql_file()
        self._write_json_report()
        print(self._summary())
        
        return True
    
    def _finalize_sql_file(self):
        """Finalize SQL file with COMMIT"""
        with open(self.sql_file, 'a') as f:
            f.write("COMMIT;\n")
        print(f"✅ sql_updates_from_review.sql finalized ({self.total_sql_statements} updates)")
    
    def _write_json_report(self):
        """Write JSON report"""
        with open('analysis_report.json', 'w') as f:
            json.dump({
                'total_analyzed': len(self.analysis_results),
                'issues_found': self.total_sql_statements,
                'analyses': self.analysis_results
            }, f, indent=2)
        print("✅ analysis_report.json")
    
    def _summary(self):
        """Print summary"""
        answer_fixed = sum(1 for r in self.analysis_results if not r.get('answer_analysis', {}).get('answer_is_correct', True))
        
        summary = f"\n📊 RESULTS:\n  • Analyzed: {len(self.analysis_results)}\n  • SQL Updates: {self.total_sql_statements}\n  • Answers Corrected: {answer_fixed}\n  • Explanations Regenerated: {self.total_sql_statements}\n"
        return summary


if __name__ == "__main__":
    import sys
    limit = None
    if len(sys.argv) > 1:
        try:
            limit = int(sys.argv[1])
            print(f"⚙️  Processing first {limit} critical questions\n")
        except ValueError:
            pass
    
    try:
        UpdateOnReview().run(limit=limit)
    except Exception as e:
        print(f"❌ Error: {e}")

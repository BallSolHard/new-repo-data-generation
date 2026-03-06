# JSON to SQL INSERT Script Generator

Convert JSON question data to PostgreSQL INSERT statements with ON CONFLICT handling.

## Overview

Two implementations are provided:
- **Node.js version** (`json_to_sql_insert.js`) — use this in your Next.js project
- **Python version** (`json_to_sql_insert.py`) — alternative for standalone usage

## Quick Start

### Using Node.js (Recommended for Next.js)

```bash
# Make executable
chmod +x json_to_sql_insert.js

# From file to file
node json_to_sql_insert.js questions.json output.sql

# From stdin to stdout
cat questions.json | node json_to_sql_insert.js > output.sql

# From file to stdout
node json_to_sql_insert.js questions.json

# Specify custom table name
node json_to_sql_insert.js questions.json -o output.sql -t public.questions
```

### Using Python

```bash
# Make executable
chmod +x json_to_sql_insert.py

# From file to file
python3 json_to_sql_insert.py questions.json output.sql

# From stdin
cat questions.json | python3 json_to_sql_insert.py > output.sql

# Specify custom table name
python3 json_to_sql_insert.py questions.json -o output.sql -t public.questions
```

## Input Format

### Single Question
```json
{
  "id": "q_60_m_60_3_71",
  "text": "Which migration strategy allows you to keep some applications on-premises?",
  "options": ["Rehost", "Refactor", "Retain", "Repurchase"],
  "correct_answer": [2],
  "explanation": "Retain keeps selected workloads on-prem.",
  "created_at": "2025-08-28 01:52:30.286694",
  "quiz_id": "quiz_domain60_13",
  "modified_at": "2025-08-28 01:52:30.286694",
  "type": "mcq",
  "index": 21,
  "module_id": "m_60_3",
  "difficulty": "medium",
  "is_deprecated": true
}
```

### Multiple Questions (Array)
```json
[
  {
    "id": "q_60_m_60_3_71",
    "text": "...",
    ...
  },
  {
    "id": "q_60_m_60_3_74",
    "text": "...",
    ...
  }
]
```

## Output Format

Generates SQL with:
- ✅ `BEGIN` transaction for atomicity
- ✅ `INSERT INTO` statements for each question
- ✅ `ON CONFLICT (id) DO NOTHING` for safe idempotent execution
- ✅ Proper escaping of single quotes
- ✅ JSONB format for options
- ✅ PostgreSQL array format for correct_answer
- ✅ Timestamp conversion
- ✅ Boolean conversion for is_deprecated
- ✅ `COMMIT` at the end
- ✅ Verification query with COUNT

### Example Output

```sql
BEGIN;

-- Generated SQL INSERT statements from JSON
-- Generated at: 2025-03-05T14:32:10.123Z
-- Total questions: 2

INSERT INTO public.question_bank (
  id,
  text,
  options,
  correct_answer,
  explanation,
  created_at,
  quiz_id,
  modified_at,
  type,
  index,
  module_id,
  difficulty,
  is_deprecated
) VALUES (
  'q_60_m_60_3_71',
  'Which migration strategy allows you to keep some applications on-premises?',
  '["Rehost","Refactor","Retain","Repurchase"]'::jsonb,
  '{2}'::integer[],
  'Retain keeps selected workloads on-prem.',
  '2025-08-28 01:52:30.286694'::timestamp,
  'quiz_domain60_13',
  '2025-08-28 01:52:30.286694'::timestamp,
  'mcq',
  21,
  'm_60_3',
  'medium',
  true
) ON CONFLICT (id) DO NOTHING;

...

-- Verification Query
SELECT COUNT(*) as inserted_count FROM public.question_bank;

COMMIT;
```

## Advanced Usage

### From API Endpoint

In your Next.js app, export questions as JSON and convert:

```bash
# Assuming you have an /api/export-questions endpoint
curl http://localhost:3000/api/export-questions > export.json
node json_to_sql_insert.js export.json output.sql
psql -d your_database -f output.sql
```

### In a Pipeline Script

```bash
#!/bin/bash

# Example: Export, convert, and execute in one command

echo "📥 Exporting questions..."
curl -s http://localhost:3000/api/export-questions > /tmp/export.json

echo "🔄 Converting JSON to SQL..."
node json_to_sql_insert.js /tmp/export.json -o /tmp/insert.sql

echo "📤 Executing against database..."
psql "postgresql://user:pass@host:5432/db" -f /tmp/insert.sql

echo "✅ Complete!"
```

### Batch Process Multiple Files

```bash
#!/bin/bash

for json_file in questions/*.json; do
  sql_file="${json_file%.json}.sql"
  node json_to_sql_insert.js "$json_file" -o "$sql_file"
  echo "✅ Converted: $json_file → $sql_file"
done

# Execute all
for sql_file in questions/*.sql; do
  echo "Running: $sql_file"
  psql -d your_database -f "$sql_file"
done
```

## Supported Columns

The converter maps these JSON fields to database columns:

| JSON Field | DB Column | Type | Notes |
|-----------|-----------|------|-------|
| id | id | TEXT | Question ID (primary key) |
| text | text | TEXT | Question stem |
| type | type | TEXT | mcq, matching, etc. |
| options | options | JSONB | Array of options converted to JSONB |
| correct_answer | correct_answer | integer[] | Array of correct option indices |
| explanation | explanation | TEXT | Explanation text |
| difficulty | difficulty | TEXT | easy, medium, hard |
| module_id | module_id | TEXT | Module reference |
| quiz_id | quiz_id | TEXT | Quiz reference |
| index | index | INTEGER | Question index in quiz |
| created_at | created_at | TIMESTAMP | Creation timestamp |
| modified_at | modified_at | TIMESTAMP | Last modification timestamp |
| is_deprecated | is_deprecated | BOOLEAN | Deprecation flag |

## Data Type Conversions

### Options Array → JSONB
```json
["Option A", "Option B", "Option C"]
```
↓
```sql
'["Option A","Option B","Option C"]'::jsonb
```

### Correct Answer Array → INTEGER[]
```json
[1, 2]
```
↓
```sql
'{1,2}'::integer[]
```

### Timestamps
```json
"2025-08-28 01:52:30.286694"
```
↓
```sql
'2025-08-28 01:52:30.286694'::timestamp
```

### Boolean
```json
true
```
↓
```sql
true
```

## Error Handling

### Invalid JSON
```bash
$ node json_to_sql_insert.js bad.json
❌ Invalid JSON: Unexpected token } in JSON at position 42
```

### File Not Found
```bash
$ node json_to_sql_insert.js missing.json
❌ File not found: missing.json
```

## Integration with Your Pipeline

### Option 1: Direct Integration in API Route

Create `/api/export-questions-as-sql`:
```typescript
import { NextRequest, NextResponse } from 'next/server';
import { spawn } from 'child_process';

export async function POST(request: NextRequest) {
  const questions = await request.json();
  
  // Run Node.js converter
  const result = await convertToSQL(questions);
  
  return NextResponse.json({ sql: result });
}

function convertToSQL(questions: any[]): Promise<string> {
  return new Promise((resolve, reject) => {
    const child = spawn('node', ['json_to_sql_insert.js']);
    let output = '';
    
    child.stdout.on('data', (data) => {
      output += data.toString();
    });
    
    child.on('close', (code) => {
      if (code === 0) resolve(output);
      else reject(new Error('Conversion failed'));
    });
    
    child.stdin.write(JSON.stringify(questions));
    child.stdin.end();
  });
}
```

### Option 2: CLI Tool Wrapper

```bash
#!/bin/bash
# scripts/export-and-insert.sh

set -e

CERT_ID=${1:-13}
ENV=${2:-development}
DB_CONN=${3:-local}

echo "Step 1: Export questions..."
QUESTIONS=$(curl -s "http://localhost:3000/api/export-questions?cert_id=${CERT_ID}")

echo "Step 2: Convert to SQL..."
SQL=$(echo "$QUESTIONS" | node json_to_sql_insert.js)

echo "Step 3: Execute in ${ENV}..."
echo "$SQL" | psql $(get_db_connection "$DB_CONN")

echo "✅ Complete!"
```

Usage:
```bash
chmod +x scripts/export-and-insert.sh
./scripts/export-and-insert.sh 13 development
```

## Troubleshooting

### Problem: "command not found: node"
**Solution**: Ensure Node.js is installed
```bash
which node
node --version
```

### Problem: Duplicate key errors despite ON CONFLICT
**Solution**: Check if questions already exist in database
```bash
SELECT id, COUNT(*) FROM question_bank GROUP BY id HAVING COUNT(*) > 1;
```

### Problem: JSONB parsing errors
**Solution**: Verify options are valid JSON arrays
```bash
node -e "console.log(JSON.parse('[\"A\",\"B\"]'))"
```

## Performance Tips

- For large batches (1000+ questions), split into smaller files
- Use `ON CONFLICT DO NOTHING` for idempotent operations
- Index on `id` for faster conflict detection
- Wrap in transactions for consistency

---

## Examples

### Example 1: Export AWS Certification Questions

```bash
# Save JSON to file
cat > aws_questions.json << 'EOF'
[
  {
    "id": "q_aws_001",
    "text": "Which service...",
    "options": ["A", "B", "C", "D"],
    "correct_answer": [1],
    "explanation": "...",
    "type": "mcq",
    "difficulty": "medium",
    "is_deprecated": false,
    "created_at": "2025-03-05 10:00:00",
    "modified_at": "2025-03-05 10:00:00"
  }
]
EOF

# Convert to SQL
node json_to_sql_insert.js aws_questions.json aws_questions.sql

# Execute
psql -d mydb -f aws_questions.sql
```

### Example 2: Pipe from API to Database

```bash
curl -s http://api.example.com/export | \
  node json_to_sql_insert.js | \
  psql -d production_db
```

### Example 3: Generate Multiple Certification SQLs

```bash
for cert_id in 13 14 15 16; do
  curl -s "http://localhost:3000/api/export?cert=$cert_id" > cert_$cert_id.json
  node json_to_sql_insert.js cert_$cert_id.json -o cert_$cert_id.sql
done

# Review before executing
cat cert_*.sql | wc -l

# Execute all
for sql in cert_*.sql; do psql -d mydb -f "$sql"; done
```

---

**Last Updated**: 2025-03-05
**Versions**: Node.js v18+, Python 3.7+

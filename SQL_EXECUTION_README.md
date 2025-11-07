# SQL Execution Setup for Supabase

## Overview
This setup enables direct SQL script execution from the StudyTech Content Engine to your Supabase database.

## Setup Instructions

### 1. Create SQL Functions in Supabase

1. Open your Supabase Dashboard
2. Go to the SQL Editor
3. Run the contents of `supabase-sql-functions.sql` to create the necessary functions

### 2. Environment Variables

Make sure you have the following environment variables set:

```bash
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
```

**Important:** You need the SERVICE ROLE key (not the anon key) to execute administrative operations.

### 3. Security Considerations

The SQL functions are designed with security in mind:

- **`execute_question_script`** (Recommended) - Only allows INSERT/UPDATE on question-related tables
- **`execute_sql_script`** (General) - Allows broader SQL operations

### 4. Testing

Test the setup by:

1. Generate questions in the Content Engine
2. Click "Execute SQL" button
3. Check the success message

## API Endpoints

### `/api/execute-sql-v2`

Executes SQL scripts using Supabase RPC functions.

**Request:**
```json
{
  "sql": "INSERT INTO public.question ...",
  "operation": "insert_questions"
}
```

**Response (Success):**
```json
{
  "success": true,
  "message": "Successfully executed SQL script",
  "data": {
    "statements_executed": 5,
    "statements_processed": 5
  }
}
```

**Response (Error):**
```json
{
  "error": "Failed to execute SQL script via RPC",
  "details": "function execute_question_script(text) does not exist",
  "suggestion": "Make sure the execute_question_script function exists in your Supabase database"
}
```

## Troubleshooting

### Function Not Found Error
If you get "function does not exist" error:
1. Make sure you ran the SQL functions in Supabase SQL Editor
2. Check that the functions were created successfully
3. Verify you're using the correct Supabase project

### Permission Denied Error
1. Ensure you're using the SERVICE ROLE key, not the anon key
2. Check that the functions have proper permissions granted

### SQL Syntax Errors
1. The functions will return detailed error messages for SQL syntax issues
2. Check the generated SQL script for any formatting problems

## Function Details

### `execute_question_script(script TEXT)`

**Security Features:**
- Only allows INSERT and UPDATE operations
- Restricts operations to `question`, `quiz_question`, and `quiz` tables
- Prevents dangerous operations like DROP, DELETE, etc.

**Usage:**
```sql
SELECT execute_question_script('INSERT INTO public.question ...');
```

### `execute_sql_script(script TEXT)`

**Less Restrictive:**
- Allows broader SQL operations
- Still prevents most dangerous operations
- Use only if you need more flexibility

**Usage:**
```sql
SELECT execute_sql_script('INSERT INTO public.question ...');
```

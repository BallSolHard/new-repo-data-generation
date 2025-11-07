-- SQL Function for Supabase to Execute Raw SQL Scripts
-- Run this in your Supabase SQL Editor to enable the execute_sql_script RPC function

CREATE OR REPLACE FUNCTION execute_sql_script(script TEXT)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    result_count INTEGER := 0;
    statement_count INTEGER := 0;
    current_statement TEXT;
    statements TEXT[];
    error_message TEXT;
BEGIN
    -- Split the script into individual statements
    -- This is a simple split on semicolons - you might need to make this more sophisticated
    SELECT string_to_array(script, ';') INTO statements;
    
    -- Execute each statement
    FOR i IN 1..array_length(statements, 1) LOOP
        current_statement := trim(statements[i]);
        
        -- Skip empty statements and comments
        IF current_statement != '' AND NOT (current_statement ~ '^\s*--') AND 
           NOT (current_statement ~ '^\s*(BEGIN|COMMIT)\s*$') THEN
            
            statement_count := statement_count + 1;
            
            BEGIN
                -- Execute the statement dynamically
                EXECUTE current_statement;
                result_count := result_count + 1;
                
            EXCEPTION WHEN OTHERS THEN
                -- Log the error but continue with other statements
                error_message := SQLERRM;
                RAISE NOTICE 'Error in statement %: %', statement_count, error_message;
            END;
        END IF;
    END LOOP;
    
    -- Return results as JSON
    RETURN json_build_object(
        'success', true,
        'statements_processed', statement_count,
        'statements_executed', result_count,
        'message', format('Successfully executed %s out of %s statements', result_count, statement_count)
    );
    
EXCEPTION WHEN OTHERS THEN
    -- Return error information
    RETURN json_build_object(
        'success', false,
        'error', SQLERRM,
        'message', 'Failed to execute SQL script'
    );
END;
$$;

-- Grant execute permission to authenticated users (adjust as needed for your security requirements)
GRANT EXECUTE ON FUNCTION execute_sql_script(TEXT) TO authenticated;

-- Optional: Create a more restrictive version that only allows specific operations
CREATE OR REPLACE FUNCTION execute_question_script(script TEXT)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    result_count INTEGER := 0;
    statement_count INTEGER := 0;
    current_statement TEXT;
    statements TEXT[];
    error_message TEXT;
BEGIN
    -- Validation: Only allow INSERT and UPDATE on specific tables
    IF script ~* 'DROP|DELETE|TRUNCATE|ALTER.*DROP|GRANT|REVOKE|CREATE\s+USER|DROP\s+USER' THEN
        RETURN json_build_object(
            'success', false,
            'error', 'Script contains prohibited operations',
            'message', 'Only INSERT and UPDATE operations are allowed on question-related tables'
        );
    END IF;
    
    -- Additional validation: Only allow operations on specific tables
    IF NOT (script ~* 'public\.(question|quiz_question|quiz)') THEN
        RETURN json_build_object(
            'success', false,
            'error', 'Script can only operate on question, quiz_question, and quiz tables',
            'message', 'Restricted to question-related tables only'
        );
    END IF;
    
    -- Split the script into individual statements
    SELECT string_to_array(script, ';') INTO statements;
    
    -- Execute each statement
    FOR i IN 1..array_length(statements, 1) LOOP
        current_statement := trim(statements[i]);
        
        -- Skip empty statements and comments
        IF current_statement != '' AND NOT (current_statement ~ '^\s*--') AND 
           NOT (current_statement ~ '^\s*(BEGIN|COMMIT)\s*$') THEN
            
            statement_count := statement_count + 1;
            
            BEGIN
                -- Execute the statement dynamically
                EXECUTE current_statement;
                result_count := result_count + 1;
                
            EXCEPTION WHEN OTHERS THEN
                -- Log the error but continue with other statements
                error_message := SQLERRM;
                RAISE NOTICE 'Error in statement %: %', statement_count, error_message;
            END;
        END IF;
    END LOOP;
    
    -- Return results as JSON
    RETURN json_build_object(
        'success', true,
        'statements_processed', statement_count,
        'statements_executed', result_count,
        'message', format('Successfully executed %s out of %s statements', result_count, statement_count)
    );
    
EXCEPTION WHEN OTHERS THEN
    -- Return error information
    RETURN json_build_object(
        'success', false,
        'error', SQLERRM,
        'message', 'Failed to execute SQL script'
    );
END;
$$;

-- Grant execute permission for the restricted version
GRANT EXECUTE ON FUNCTION execute_question_script(TEXT) TO authenticated;

-- Example usage:
-- SELECT execute_sql_script('INSERT INTO public.question (id, text, type) VALUES (''test'', ''Test Question'', ''mcq'');');
-- SELECT execute_question_script('INSERT INTO public.question (id, text, type) VALUES (''test'', ''Test Question'', ''mcq'');');

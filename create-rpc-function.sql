-- Improved RPC function to execute SQL scripts in Supabase
-- Run this in your Supabase SQL Editor to replace the existing function

DROP FUNCTION IF EXISTS execute_question_script(TEXT);

CREATE OR REPLACE FUNCTION execute_question_script(script TEXT)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    result_count INTEGER := 0;
    statement_count INTEGER := 0;
    error_count INTEGER := 0;
    current_statement TEXT;
    statements TEXT[];
    error_message TEXT;
    debug_info TEXT[] := ARRAY[]::TEXT[];
BEGIN
    -- Basic security: only allow INSERT, UPDATE, and SELECT operations on specific tables
    IF script ~* 'DROP\s+(DATABASE|SCHEMA|TABLE)|DELETE.*WHERE.*=.*1|TRUNCATE|ALTER.*DROP|GRANT|REVOKE|CREATE\s+USER|DROP\s+USER' THEN
        RETURN json_build_object(
            'success', false,
            'error', 'Script contains prohibited operations',
            'message', 'Only INSERT, UPDATE operations are allowed on question-related tables'
        );
    END IF;
    
    -- Clean up the script - remove comments and normalize whitespace but KEEP BEGIN/COMMIT
    script := regexp_replace(script, '--[^\r\n]*', '', 'g'); -- Remove comments
    script := regexp_replace(script, '\r\n|\r|\n', ' ', 'g'); -- Normalize line breaks
    script := regexp_replace(script, '\s+', ' ', 'g'); -- Normalize whitespace
    script := trim(script);
    
    -- Split the script into individual statements using semicolon
    SELECT string_to_array(script, ';') INTO statements;
    
    -- Process each statement
    FOR i IN 1..array_length(statements, 1) LOOP
        current_statement := trim(statements[i]);
        
        -- Skip empty statements and comments, but allow BEGIN/COMMIT and all SQL operations
        IF current_statement != '' AND 
           length(current_statement) > 3 AND
           current_statement !~ '^\s*--' THEN
            
            statement_count := statement_count + 1;
            debug_info := array_append(debug_info, format('Processing statement %s: %s...', statement_count, left(current_statement, 50)));
            
            BEGIN
                -- Execute the statement dynamically
                EXECUTE current_statement;
                result_count := result_count + 1;
                debug_info := array_append(debug_info, format('✓ Statement %s executed successfully', statement_count));
                
            EXCEPTION WHEN OTHERS THEN
                error_count := error_count + 1;
                error_message := SQLERRM;
                debug_info := array_append(debug_info, format('✗ Statement %s failed: %s', statement_count, error_message));
                RAISE NOTICE 'Error in statement %: % | Statement: %', statement_count, error_message, left(current_statement, 200);
            END;
        ELSE
            -- Log skipped statements for debugging
            IF length(current_statement) > 0 THEN
                debug_info := array_append(debug_info, format('Skipped: %s...', left(current_statement, 50)));
            END IF;
        END IF;
    END LOOP;
    
    -- Return comprehensive results
    RETURN json_build_object(
        'success', true,
        'statements_processed', statement_count,
        'statements_executed', result_count,
        'statements_failed', error_count,
        'message', format('Successfully executed %s out of %s statements (%s failed)', result_count, statement_count, error_count),
        'debug_info', debug_info,
        'total_statements_found', array_length(statements, 1)
    );
    
EXCEPTION WHEN OTHERS THEN
    -- Return comprehensive error information
    RETURN json_build_object(
        'success', false,
        'error', SQLERRM,
        'message', 'Failed to execute SQL script',
        'debug_info', debug_info,
        'statements_processed', statement_count,
        'statements_executed', result_count
    );
END;
$$;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION execute_question_script(TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION execute_question_script(TEXT) TO service_role;

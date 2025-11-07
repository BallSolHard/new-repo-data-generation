import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

// Initialize Supabase client with service role key for admin operations
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL || '',
  process.env.SUPABASE_SERVICE_ROLE_KEY || ''
);

const supabase_preprod = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL_PREPROD || '',
    process.env.SUPABASE_SERVICE_ROLE_KEY_PREPROD || ''
);

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { sql, environment } = body; // Add optional environment parameter

    // Validate required parameters
    if (!sql || typeof sql !== 'string') {
      return NextResponse.json(
        { error: 'SQL script is required and must be a string' },
        { status: 400 }
      );
    }

    // Validate Supabase configuration
    if (!process.env.NEXT_PUBLIC_SUPABASE_URL || !process.env.SUPABASE_SERVICE_ROLE_KEY) {
      return NextResponse.json(
        { error: 'Supabase configuration missing. Please check environment variables.' },
        { status: 500 }
      );
    }

    // Basic security validation - prevent dangerous operations
    const dangerousPatterns = [
      /DROP\s+DATABASE/i,
      /DROP\s+SCHEMA/i,
      /DROP\s+TABLE/i,
      /TRUNCATE\s+TABLE/i,
      /DELETE\s+FROM.*WHERE.*1\s*=\s*1/i,
      /ALTER\s+TABLE.*DROP/i,
      /GRANT/i,
      /REVOKE/i,
      /CREATE\s+USER/i,
      /DROP\s+USER/i
    ];

    const isDangerous = dangerousPatterns.some(pattern => pattern.test(sql));
    if (isDangerous) {
      return NextResponse.json(
        { error: 'SQL script contains potentially dangerous operations' },
        { status: 400 }
      );
    }

    
    try {
      // Execute on production environment
      const { data: prodData, error: prodError } = await supabase.rpc('execute_question_script', {
        script: sql
      });

      // Execute on pre-production environment
      const { data: preprodData, error: preprodError } = await supabase_preprod.rpc('execute_question_script', {
        script: sql
      });

      // Check for errors in either environment
      if (prodError) {
        console.error('Production Supabase RPC error:', prodError);
        
        // Check if the function doesn't exist
        if (prodError.message?.includes('function execute_question_script') || prodError.code === 'PGRST202') {
          return NextResponse.json(
            { 
              error: 'RPC Function Not Found in Production',
              details: prodError.message
            },
            { status: 400 }
          );
        }
      }

      if (preprodError) {
        console.error('Pre-production Supabase RPC error:', preprodError);
        
        // Check if the function doesn't exist
        if (preprodError.message?.includes('function execute_question_script') || preprodError.code === 'PGRST202') {
          return NextResponse.json(
            { 
              error: 'RPC Function Not Found in Pre-production',
              details: preprodError.message
            },
            { status: 400 }
          );
        }
      }

      // If there are errors in either environment, return error details
      if (prodError || preprodError) {
        return NextResponse.json(
          { 
            error: 'Failed to execute SQL script via RPC',
            production: prodError ? { error: prodError.message, code: prodError.code } : { success: true },
            preprod: preprodError ? { error: preprodError.message, code: preprodError.code } : { success: true }
          },
          { status: 500 }
        );
      }

      // Check if the execution was successful in both environments
      const prodSuccess = prodData && typeof prodData === 'object' && prodData.success !== false;
      const preprodSuccess = preprodData && typeof preprodData === 'object' && preprodData.success !== false;

      if (!prodSuccess || !preprodSuccess) {
        return NextResponse.json(
          { 
            error: 'SQL Execution Failed in one or both environments',
            production: prodSuccess ? 'Success' : (prodData?.error || 'Unknown error'),
            preprod: preprodSuccess ? 'Success' : (preprodData?.error || 'Unknown error')
          },
          { status: 400 }
        );
      }

      return NextResponse.json({
        success: true,
        message: 'Successfully executed SQL script in both environments',
        production: {
          message: prodData.message || 'Successfully executed SQL script',
          statements_processed: prodData.statements_processed,
          statements_executed: prodData.statements_executed
        },
        preprod: {
          message: preprodData.message || 'Successfully executed SQL script',
          statements_processed: preprodData.statements_processed,
          statements_executed: preprodData.statements_executed
        }
      });

    } catch (execError) {
      console.error('Error executing SQL script:', execError);
        return NextResponse.json(
        { error: `Failed to execute SQL script: ${execError instanceof Error ? execError.message : 'Unknown error'}` },
        { status: 500 }
      );
    }
  } catch (error) {
    console.error('Error in SQL execution endpoint:', error);
    return NextResponse.json(
      { error: `Failed to process request: ${error instanceof Error ? error.message : 'Unknown error'}` },
      { status: 500 }
    );
  }
}

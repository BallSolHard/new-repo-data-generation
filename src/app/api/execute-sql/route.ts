import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

const DANGEROUS_PATTERNS = [
  /DROP\s+DATABASE/i,
  /DROP\s+TABLE/i,
  /DROP\s+SCHEMA/i,
  /TRUNCATE/i,
  /GRANT\s/i,
  /REVOKE\s/i,
  /ALTER\s+ROLE/i,
  /CREATE\s+ROLE/i,
  /CREATE\s+USER/i,
  /DROP\s+ROLE/i,
  /DROP\s+USER/i,
];

/** POST /api/execute-sql — execute a generated SQL script via Supabase RPC */
export async function POST(request: NextRequest) {
  try {
    const { script } = await request.json();

    if (!script || typeof script !== 'string') {
      return NextResponse.json(
        { error: 'Missing required field: script (string)' },
        { status: 400 }
      );
    }

    // Safety check — block dangerous SQL
    for (const pattern of DANGEROUS_PATTERNS) {
      if (pattern.test(script)) {
        return NextResponse.json(
          { error: `Blocked: script contains dangerous SQL pattern: ${pattern.source}` },
          { status: 403 }
        );
      }
    }

    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

    if (!supabaseUrl || !supabaseKey) {
      return NextResponse.json(
        { error: 'Supabase credentials not configured' },
        { status: 500 }
      );
    }

    const supabase = createClient(supabaseUrl, supabaseKey);

    const { data, error } = await supabase.rpc('execute_question_script', {
      script,
    });

    if (error) {
      console.error('[execute-sql] RPC error:', error);
      return NextResponse.json(
        { error: `SQL execution failed: ${error.message}`, details: error },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      result: data,
    });
  } catch (error) {
    console.error('[execute-sql] Error:', error);
    const message = error instanceof Error ? error.message : 'Failed to execute SQL';
    return NextResponse.json(
      { error: message },
      { status: 500 }
    );
  }
}

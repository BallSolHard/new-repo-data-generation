import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

// Initialize Supabase client
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL || '',
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || ''
);

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const certificationId = searchParams.get('certification_id');

    if (!certificationId) {
      return NextResponse.json(
        { error: 'certification_id parameter is required' },
        { status: 400 }
      );
    }

    // Fetch mock tests for the specific certification
    const { data: mockTests, error } = await supabase
      .from('mock_tests')
      .select(`
        id,
        title,
        created_at,
        certification_id,
        duration,
        total_questions,
        description,
        validity_months,
        passing_score,
        recommended_experience_text,
        exam_format
      `)
      .eq('certification_id', certificationId)
      .order('created_at', { ascending: false });

    if (error) {
      console.error('Supabase error:', error);
      return NextResponse.json(
        { error: 'Failed to fetch mock tests from database' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      mockTests: mockTests || [],
      count: mockTests?.length || 0
    });

  } catch (error) {
    console.error('API error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

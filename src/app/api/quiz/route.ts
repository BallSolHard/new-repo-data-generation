import { NextRequest, NextResponse } from 'next/server';
import { getSupabaseClient } from "../config";

export async function GET(request: NextRequest) {
  try {
    
    const { searchParams } = new URL(request.url);
    const categoryId = searchParams.get('category_id'); // This is topic_id
    const certificationId = searchParams.get('certification_id');

    const supabase = await getSupabaseClient();
    // Validate required parameters
    if (!categoryId || !certificationId) {
      return NextResponse.json(
        { error: 'Both category_id and certification_id parameters are required' },
        { status: 400 }
      );
    }

    // Build the query
    let query = supabase
      .from('quiz')
      .select(`
        id,
        title,
        created_at,
        difficulty,
        questions,
        duration,
        modified_at,
        popularity,
        category_id,
        certification_id,
        question_type,
        is_completed
      `)
      .eq('category_id', categoryId)
      .eq('certification_id', certificationId)
      .is('clerk_user_id', null) // Only fetch quizzes where clerk_user_id is null
      .order('popularity', { ascending: false }) // Order by popularity (highest first)
      .order('created_at', { ascending: false }); // Then by newest first

    const { data: quizzes, error } = await query;

    if (error) {
      console.error('Supabase error:', error);
      return NextResponse.json(
        { error: 'Failed to fetch quizzes from database' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      quizzes: quizzes || [],
      count: quizzes?.length || 0,
      filters: {
        category_id: categoryId,
        certification_id: certificationId,
        clerk_user_id: 'null'
      }
    });

  } catch (error) {
    console.error('API error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// Optional: POST endpoint to create new quizzes
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const {
      title,
      difficulty,
      questions,
      duration,
      category_id,
      certification_id,
      question_type,
      clerk_user_id = null
    } = body;

    // Validate required fields
    if (!title || !difficulty || !category_id || !certification_id) {
      return NextResponse.json(
        { error: 'Missing required fields: title, difficulty, category_id, certification_id' },
        { status: 400 }
      );
    }

    // Generate unique ID
    const id = `quiz_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;

    const { data: quiz, error } = await supabase
      .from('quiz')
      .insert({
        id,
        title,
        difficulty,
        questions: questions || 0,
        duration: duration || 0,
        category_id,
        certification_id,
        question_type: question_type || 'multiple-choice',
        clerk_user_id
      })
      .select()
      .single();

    if (error) {
      console.error('Supabase error:', error);
      return NextResponse.json(
        { error: 'Failed to create quiz' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      quiz,
      message: 'Quiz created successfully'
    }, { status: 201 });

  } catch (error) {
    console.error('API error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

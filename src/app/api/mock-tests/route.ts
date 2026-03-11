import { NextRequest, NextResponse } from 'next/server';
import { getSupabaseClient } from "../config";

type MockTest = {
  id: string;
  mock_test_id?: string;
  title: string;
  created_at: string;
  difficulty?: string;
  questions?: number;
  duration: number;
  total_questions?: number;
  modified_at?: string;
  popularity?: number;
  category_id?: string;
  certification_id: number;
  question_type?: string;
  is_completed?: boolean;
  description?: string;
  validity_months?: number;
  passing_score?: number;
  recommended_experience_text?: string;
  exam_format?: string[];
};

/**
 * GET endpoint to fetch existing mock tests for a specific certification/domain
 * Query parameters:
 * - category_id: The category/domain ID (optional, for backward compatibility)
 * - certification_id: The certification ID
 * - domain_name: Optional, filter by domain name in title
 */
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const certificationId = searchParams.get('certification_id');
  
    if (!certificationId) {
      return NextResponse.json(
        { error: 'Missing required parameter: certification_id' },
        { status: 400 }
      );
    }

    const supabase = await getSupabaseClient();

    // Build query for existing mock tests from mock_tests table
    let query = supabase
      .from('mock_tests')
      .select(`
        id,
        title
      `)
      .eq('certification_id', certificationId);


    query = query
      .order('created_at', { ascending: false })
      .limit(10);

    const { data: mockTests, error } = await query;

    if (error) {
      console.error('Supabase error fetching mock tests:', error);
      return NextResponse.json(
        { error: 'Failed to fetch mock tests from database', details: error.message },
        { status: 500 }
      );
    }

    const formattedMockTests = (mockTests || []).map(test => ({
      id: test.id,
      title: test.title,
    }));

    return NextResponse.json({
      success: true,
      mockTests: formattedMockTests,
      count: formattedMockTests.length,
    });
  } catch (error) {
    console.error('Error fetching mock tests:', error);
    return NextResponse.json(
      { error: 'Failed to fetch mock tests', details: String(error) },
      { status: 500 }
    );
  }
}

/**
 * POST endpoint for mock test generation with data storage
 * Handles both:
 * 1. Adding questions to an existing mock test
 * 2. Creating a new mock test with questions
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();

    const {
      certification_id,
      certification_name,
      topic_id,
      topic_name,
      quiz_id,
      mock_test_id,
      mock_test_action, // "existing" or "new"
      existing_mock_test, // The mock test object if action is "existing"
      questions,
    } = body;

    if (!quiz_id || !certification_id) {
      return NextResponse.json(
        { error: 'Missing required fields: quiz_id, certification_id' },
        { status: 400 }
      );
    }

    const supabase = await getSupabaseClient();

    try {
      if (mock_test_action === 'new') {
        // Create a new mock test in mock_tests table
        const mockTestTitle = `${topic_name} - Mock Test`;
        const newMockTestId = mock_test_id || `mock_${certification_id}_${Date.now()}`;
        
        const { error: insertError } = await supabase
          .from('mock_tests')
          .insert([
            {
              id: newMockTestId,
              title: mockTestTitle,
              certification_id: certification_id,
              duration: 60, // Default duration
              total_questions: questions?.length || 0,
              created_at: new Date().toISOString(),
              description: `Mock test for ${topic_name}`,
              validity_months: 12,
              passing_score: 70,
            }
          ]);

        if (insertError) {
          console.error('Error creating mock test:', insertError);
          return NextResponse.json(
            { error: 'Failed to create mock test', details: insertError.message },
            { status: 500 }
          );
        }

        console.log(`[mock-tests] Created new mock test: ${mockTestTitle}`);
      } else if (mock_test_action === 'existing' && existing_mock_test) {
        // Update existing mock test's total_questions
        const { error: updateError } = await supabase
          .from('mock_tests')
          .update({
            total_questions: (existing_mock_test.total_questions || existing_mock_test.questions || 0) + (questions?.length || 0),
          })
          .eq('id', quiz_id);

        if (updateError) {
          console.error('Error updating mock test:', updateError);
          return NextResponse.json(
            { error: 'Failed to update mock test', details: updateError.message },
            { status: 500 }
          );
        }

        console.log(`[mock-tests] Updated existing mock test: ${quiz_id}`);
      }

      // Insert the questions if provided (in quiz_questions or mock_test_questions table)
      if (questions && Array.isArray(questions) && questions.length > 0) {
        const questionRecords = questions.map((question: any) => ({
          mock_test_id: quiz_id,
          question_text: question.text,
          question_type: question.type,
          options: JSON.stringify(question.options || question.pairs || []),
          correct_answer: JSON.stringify(question.correct_answer),
          difficulty: question.difficulty,
          created_at: new Date().toISOString(),
        }));

        const { error: questionsError } = await supabase
          .from('mock_test_questions')
          .insert(questionRecords);

        if (questionsError) {
          console.error('Error inserting questions:', questionsError);
          return NextResponse.json(
            { error: 'Failed to insert questions', details: questionsError.message },
            { status: 500 }
          );
        }

        console.log(`[mock-tests] Inserted ${questions.length} questions into mock test`);
      }

      return NextResponse.json({
        success: true,
        message: `Mock test ${mock_test_action === 'new' ? 'created' : 'updated'} successfully`,
        quiz_id: quiz_id,
        questions_added: questions?.length || 0,
      });
    } catch (error) {
      console.error('Error processing mock test:', error);
      return NextResponse.json(
        { error: 'Failed to process mock test', details: String(error) },
        { status: 500 }
      );
    }
  } catch (error) {
    console.error('Error in mock test endpoint:', error);
    return NextResponse.json(
      { error: 'Failed to process mock test request', details: String(error) },
      { status: 500 }
    );
  }
}

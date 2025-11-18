import { NextRequest, NextResponse } from 'next/server';
import { getSupabaseClient } from "../config";

export async function GET(request: NextRequest) {
  try {
    
    const supabase = await getSupabaseClient();
    
    const { searchParams } = new URL(request.url);
    const topicId = searchParams.get('topic_id');

    if (!topicId) {
      return NextResponse.json(
        { error: 'topic_id parameter is required' },
        { status: 400 }
      );
    }

    // Fetch modules for the specific topic
    const { data: modules, error } = await supabase
      .from('modules')
      .select(`
        module_id,
        module_name,
        module_description,
        topic_id,
        ideal_completion_time
      `)
      .eq('topic_id', topicId)
      .order('module_name');

    if (error) {
      console.error('Supabase error:', error);
      return NextResponse.json(
        { error: 'Failed to fetch modules from database' },
        { status: 500 }
      );
    }

    return NextResponse.json({
      modules: modules || [],
      count: modules?.length || 0
    });

  } catch (error) {
    console.error('API error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

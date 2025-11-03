import { NextRequest, NextResponse } from "next/server";
import { getSupabaseClient } from "../config";

export async function GET(request: NextRequest) {
    try {
        const supabase = await getSupabaseClient();
        
        // Get certification_id from query parameters if provided
        const { searchParams } = new URL(request.url);
        const certificationId = searchParams.get('certification_id');
        
        let query = supabase
            .from("topics")
            .select(`
                topic_id,
                topic_name,
                topic_description,
                ideal_completion_time,
                certification_id
            `)
            .order("topic_id", { ascending: true });
        
        // Filter by certification_id if provided
        if (certificationId) {
            query = query.eq("certification_id", certificationId);
        }
        
        const { data: domains, error } = await query;

        if (error) throw error;

        return NextResponse.json({ domains });
    } catch (error) {
        console.error("Error fetching domains:", error);
        return NextResponse.json(
            { error: "Internal server error" },
            { status: 500 },
        );
    }
}
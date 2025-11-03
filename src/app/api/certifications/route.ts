import { NextResponse } from "next/server";
import { getSupabaseClient } from "../config";

export async function GET() {
    try {
        const supabase = await getSupabaseClient();
        const { data: certifications, error } = await supabase
            .from("certifications")
            .select(`
                *,
                topics!topics_certification_id_fkey(
                    topic_id,
                    topic_name,
                    topic_description,
                    ideal_completion_time,
                    certification_id
                )
            `)
            .eq("active", true)
            .order("id", { ascending: true });

        if (error) throw error;

        // Transform the data to match our expected structure
        const transformedCertifications = certifications?.map(cert => ({
            ...cert,
            domains: cert.topics || []
        })) || [];

        return NextResponse.json({ certifications: transformedCertifications });
    } catch (error) {
        console.error("Error fetching certifications:", error);
        return NextResponse.json(
            { error: "Internal server error" },
            { status: 500 },
        );
    }
}

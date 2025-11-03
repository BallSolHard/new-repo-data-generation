import { createClient } from "@supabase/supabase-js";

// RLS-aware client factory function
export async function getSupabaseClient() {

  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
  );

  return supabase;
}

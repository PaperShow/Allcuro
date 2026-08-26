import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://your-project.supabase.co';
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY || 'your-anon-key';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export interface ProfileRecord {
  id: string;
  role: 'customer' | 'nurse' | 'centre' | 'admin';
  full_name: string;
  phone?: string;
  email?: string;
  city?: string;
  kyc_status: 'incomplete' | 'under_review' | 'site_visit_scheduled' | 'verified' | 'flagged';
  created_at: string;
}

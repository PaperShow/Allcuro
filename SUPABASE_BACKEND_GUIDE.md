# ALLCURO Healthcare — Supabase Backend Integration Guide

This guide details how Supabase powers **Auth**, **PostgreSQL Database**, **Row-Level Security (RLS) Roles & Permissions**, and **Storage** for the entire ALLCURO ecosystem.

---

## 1. Quick Setup in Supabase Dashboard

1. Create a new project at [supabase.com](https://supabase.com).
2. Go to **SQL Editor** $\rightarrow$ Click **New Query** $\rightarrow$ Paste the entire contents of [`supabase/schema.sql`](file:///Users/abhishek/Desktop/allcuro_total/supabase/schema.sql) $\rightarrow$ Click **Run**.
3. Go to **Project Settings** $\rightarrow$ **API** to retrieve:
   - `Project URL`
   - `anon public key`
   - `service_role secret` (for backend/admin operations)

---

## 2. User Roles & Permission Matrix

| Role | Permissions | Auth Claims / Metadata |
|---|---|---|
| **`customer`** | Can search verified nurses, centres & equipment; book shifts & stays; view own bookings & invoice history; manage emergency family SOS contact. | `raw_user_meta_data: { "role": "customer" }` |
| **`nurse`** | Can manage availability, view assigned patient shifts, GPS check-in/out, upload qualification/police clearances into private vault, and track payout ledger. | `raw_user_meta_data: { "role": "nurse" }` |
| **`centre`** | Can manage bed & room inventory, accept elder placement requests, upload CEA/Fire NOC certificates, and track Razorpay split payouts. | `raw_user_meta_data: { "role": "centre" }` |
| **`admin`** | Full access across all tables, KYC verification queue approval/rejection, live SOS alert dispatch, and compliance tracking. | `raw_user_meta_data: { "role": "admin" }` |

---

## 3. Storage Buckets

1. **`kyc-documents` (Private)**
   - Uploads for Aadhaar, Nursing Council Registrations, Fire Safety NOC, Biomedical Waste PCB certificates.
   - Access via time-limited Supabase signed URLs (`createSignedUrl`).
2. **`avatars` (Public)**
   - Profile photos for patients, nurses, and care centre managers.
3. **`centre-photos` (Public)**
   - 360 tour images, room photos, and amenities for care facilities.
4. **`equipment-images` (Public)**
   - Oxygen concentrators, hospital beds, wheelchairs, and ICU monitoring equipment catalog photos.

---

## 4. Environment Variables Setup

### In `allcuro_admin/.env`:
```env
VITE_SUPABASE_URL=https://<your-project-id>.supabase.co
VITE_SUPABASE_ANON_KEY=<your-anon-key>
```

### In `allcuro/` and `allcuro_partner/` (`pubspec.yaml`):
```yaml
dependencies:
  supabase_flutter: ^2.8.0
```
Initialize in `main()`:
```dart
await Supabase.initialize(
  url: 'https://<your-project-id>.supabase.co',
  anonKey: '<your-anon-key>',
);
```

# ALLCURO Healthcare Ecosystem — Master Architecture & Blueprint

> **Tagline:** *"Healthcare, Made Simple."*  
> **Mission:** Transform home healthcare in India through a trusted, verified 3-sided marketplace for elderly care, professional home nursing, and medical equipment rental.

---

## 1. Ecosystem Overview

ALLCURO operates as a coordinated 3-sided marketplace:

```
                  ┌───────────────────────────────┐
                  │          ALLCURO ADMIN        │
                  │   Internal Control & Ops HQ   │
                  │  (KYC Queue, SOS, Settlements)│
                  └───────────────┬───────────────┘
                                  │
          ┌───────────────────────┴───────────────────────┐
          ▼                                               ▼
┌──────────────────┐                            ┌──────────────────┐
│  ALLCURO CUSTOMER│                            │  ALLCURO PARTNER │
│   (Patient/Fam)  │ ◄────── Services ───────── │ (Nurses/Centres) │
│  Bookings & Care │ ─────── Payments ────────► │  Shifts & Beds   │
└──────────────────┘                            └──────────────────┘
```

| Application | Audience | Core Technologies | Primary Responsibilities |
|---|---|---|---|
| **`allcuro`** | Patients & Families | Flutter (iOS/Android), Riverpod, GoRouter | Hyperlocal discovery, nurse shift booking, centre bed booking, equipment rental, light KYC, and Razorpay checkout. |
| **`allcuro_partner`** | Nurses, Care Attendants & Care Centres | Flutter (iOS/Android), Riverpod, GoRouter | Dual-role app (Nurse vs Centre): shift acceptance, GPS check-in/out, bed occupancy management, compliance uploads, and earnings. |
| **`allcuro_admin`** | Internal Ops, City Managers, Finance | React 19, Vite, TypeScript, Lucide | Unified KYC verification inbox, real-time booking/SOS monitor, Razorpay Route split ledger, bed occupancy matrix, and compliance tracker. |

---

## 2. Shared Marketplace Data Models

### A. Provider Roles & Tiers
- **Nurses:**
  - `GNM` (General Nursing & Midwifery) — Basic post-op, elderly monitoring
  - `ANM` (Auxiliary Nurse Midwife) — Injections, wound dressing, vitals
  - `B.Sc Nursing` — Critical care, post-surgical rehabilitation
  - `Critical Care Certified` — ICU, ventilator, tracheostomy, dialysis assistance
  - `Care Attendant` — Non-medical elderly assistance, mobility, hygiene
- **Home Care Centres:**
  - Types: Elderly Care Homes, Rehabilitation Facilities, Physiotherapy Recovery, Palliative Care, Day-Care.
  - Trust Signals: Staff-to-patient ratio (e.g. 1:3, 1:4), Clinical Establishment Act license, Fire NOC, Biomedical waste clearance, and physical field audit.
- **Medical Equipment Rental:**
  - Categories: Mobility (wheelchairs, walkers), Respiratory (oxygen concentrators, BiPAP/CPAP), Hospital Beds, ICU Monitoring.
  - Deposit model: Refundable security deposit held in escrow until return inspection.

---

## 3. Payments & Financial Architecture (Razorpay Route)

1. **Customer Checkout:**
   - Base Price + Optional Add-ons + Platform Fee + GST (18%).
   - Supported Rails: UPI, Netbanking, Debit/Credit Cards, EMI / Pay Later.
2. **Automatic Split Settlement (Razorpay Route):**
   - Customer payment arrives in ALLCURO Master Account.
   - Platform commission retained (10%–15%).
   - Balance transfers automatically to Partner sub-account (`acc_rzp_...`).
3. **Escrow & Refund Protection:**
   - Equipment deposit held in auth-and-capture escrow.
   - Instant-refund-to-wallet or bank transfer upon booking cancellation.

---

## 4. Trust, Safety & Legitimacy Hierarchy

```
[Level 1: Unverified] ──► [Level 2: ALLCURO Verified] ──► [Level 3: Field Audited] ──► [Level 4: Elite / Top Rated]
• Basic Mobile + OTP       • Govt ID (Aadhaar match)      • Physical inspection audit   • 50+ completed bookings
• Profile submitted         • Nursing Council License      • Fire & bio-waste cleared    • 4.8+ sustained rating
                            • Police background check
```

---

## 5. Development Guidelines
- **Customer App:** Keep design calm, accessible for elderly families, with high contrast typography and zero layout overflow.
- **Partner App:** Preserve `Surface` and `Tappable` wrappers to maintain tactile ripple responsiveness on all devices.
- **Admin App:** Use the modern soft-card neumorphic design tokens for fast data density and operator efficiency.

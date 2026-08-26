# ALLCURO Partner App — Developer Context & Architecture

> **Directory:** `/allcuro_partner`  
> **Target Audience:** Home Care Nurses, Attendants, Care Givers, and Home Care Centre Operators.  
> **Stack:** Flutter 3, Riverpod 2.6, GoRouter 14.8, Google Fonts (Plus Jakarta Sans).

---

## 1. Core Architecture: Dual Role Shell

The partner app is a unified codebase serving two distinct provider roles:

```
                  ┌───────────────────────────────┐
                  │      Auth / Role Selection    │
                  │   (Nurse vs Home Care Centre) │
                  └───────────────┬───────────────┘
                                  │
          ┌───────────────────────┴───────────────────────┐
          ▼                                               ▼
┌──────────────────┐                            ┌──────────────────┐
│   NURSE SHELL    │                            │   CENTRE SHELL   │
│ • Home Dashboard │                            │ • Centre Home    │
│ • Shift Requests │                            │ • Placement Reqs │
│ • Shift Schedule │                            │ • Room Inventory │
│ • Earnings & SOS │                            │ • Compliance Hub │
└──────────────────┘                            └──────────────────┘
```

- **`ProviderRole`**: Enum `nurse` vs `centre`, stored in `SharedPreferences`.
- **`ProviderShell`**: Role-aware header gradient with status indicators and role-specific bottom navigation tabs.

---

## 2. Nurse Features & Lifecycle

1. **Onboarding & KYC (Blueprint Section 04):**
   - Government ID (Aadhaar with face match), Nursing Council registration, Medical fitness certificate, Police clearance, and 2 previous supervisor reference contacts.
2. **Dashboard & Shift Management:**
   - Real-time shift requests (Morning / Evening / Night / 24-hr).
   - GPS check-in / check-out with geofenced visit verification.
   - Panic / SOS button with direct line to ALLCURO Operations.
   - Payout ledger with Razorpay Route split breakdowns.

---

## 3. Centre Features & Lifecycle

1. **Onboarding & Legitimacy Filter (Blueprint Section 05):**
   - Shop & Establishment Act / Clinical Establishment Act license.
   - Fire safety NOC & Biomedical Waste Management clearance (PCB).
   - Mandatory on-site field agent physical inspection audit (photos + 360 video).
2. **Dashboard & Inventory:**
   - Real-time room/bed occupancy management.
   - Admission requests acceptance/waitlisting.
   - Staff roster with staff-to-patient ratio tracking.
   - Compliance center with automated license expiration warnings.

---

## 4. Design Guidelines & Flutter Pitfalls
- **`Surface` & `Tappable`:** Always wrap interactive cards in `Surface` and buttons/links in `Tappable` from `lib/core/ui/` so that Flutter's `InkWell` ripples paint on top of gradient headers and opaque backgrounds.
- **Theme Tokens:** Primary `#26593B`, Primary Soft `#DDF4E4`, Accent `#3A8357`, Ink `#111512`.

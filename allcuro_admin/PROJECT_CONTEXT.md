# ALLCURO Admin Panel — Developer Context & UI Guide

> **Directory:** `/allcuro_admin`  
> **Target Audience:** ALLCURO Operations Team, City Managers, Compliance Officers, and Finance Leads.  
> **Stack:** React 19, Vite, TypeScript, Lucide React, Custom CSS Design System.

---

## 1. Visual Design Architecture (Reference Visual)

The admin panel is built with an ultra-modern, frosted glass and soft-card aesthetic:
- **Left Navigation:**
  - **Dark Icon Dock (Far Left):** Brand quick-launch icon, fast nav switches, alert dots, settings, and support helpdesk.
  - **Sub-Sidebar (Secondary):** Starred/Recent items, Dashboards, Reports, and folder management with real-time numeric badges.
- **Top Header:**
  - Global intelligent search (`⌘K`) for nurses, centres, and compliance items.
  - Active admin team avatars with live status dots (e.g. `AA`, `EY`, `MA`).
  - Timeframe switcher pill (`Sep 1 – Nov 30, 2026`).
  - Quick action controls (Filters, Export, Share, + New Action).

---

## 2. Core Functional Modules

### 1. Executive Overview (`OverviewView.tsx`)
- Hero KPI card showing Gross Marketplace Value (GMV: `₹5,289,760` +14.2%), Top active shifts (`842`), Best care deal (`₹68,000`), and SLA rate (`99.4%`).
- Horizontal provider revenue distribution bar.
- Channel breakdown (Care Centres 43%, In-house Nurses 27%, Equipment 17%, Specialised 7%).
- Monthly timeline bars and performance leaderboards with praise tags ("Top compliance ⭐", "100% Shift Fill 🔥").

### 2. Unified Verification Queue (`VerificationQueueView.tsx`)
- Inbox for pending nurse KYC, centre registrations, and vendor onboardings.
- Document inspection modal/drawer (Nursing Council, Aadhaar Face Match, Police Clearance, Fire NOC, Biomedical Waste Auth, Field Visit Photos).
- One-tap actions: **Approve & Go-Live**, **Schedule Field Audit**, **Request Info**, **Reject**.

### 3. Live Operations & Shift Dispatch (`LiveOperationsView.tsx`)
- Live GPS geofenced check-in tracking for active nursing shifts.
- Emergency SOS Alert protocol with 1-tap ops direct contact and auto-reassignment triggers for emergency cancellations.

### 4. Care Centres & Bed Occupancy Matrix (`BedOccupancyView.tsx`)
- Visual occupancy progress bars per facility (Vacant vs Occupied).
- Verified staff-to-patient ratio and physical field audit certificate status.

### 5. Razorpay Route Split-Payouts Ledger (`PayoutsLedgerView.tsx`)
- Automated split settlements: Customer gross $\rightarrow$ ALLCURO commission (10–15%) $\rightarrow$ Partner sub-account payout.
- Security deposit holding & refund releases for medical equipment rentals.

### 6. Compliance Tracker (`ComplianceView.tsx`)
- 12-Month re-verification countdown & auto-flagging for expiring licenses or police clearances.

### 7. City Demand Heatmap (`AnalyticsView.tsx`)
- Hyperlocal cluster metrics across Bengaluru, Delhi-NCR, Mumbai, and Hyderabad.

---

## 3. Running & Building the Admin App

```bash
# Start Vite development server
npm run dev

# Compile TypeScript & build production bundle
npm run build

# Preview production build
npm run preview
```

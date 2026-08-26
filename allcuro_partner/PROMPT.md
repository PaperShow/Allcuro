# Prompt for Claude Code in the ALLCURO Partner app repo

Paste everything below this line into Claude Code in the partner-app repository.

---

I'm building **ALLCURO Partner** — the companion app to our ALLCURO customer app (a
home-healthcare marketplace: elderly care, nursing, and medical equipment rental in
India). The customer app lets families book nurses and homecare-centre beds; this
partner app is for the two kinds of providers who fulfil those bookings:

- **Nurses** — accept/decline shift requests, see job details, manage their schedule.
- **Homecare centres** — manage bed/room availability, accept/decline placement requests.

It's **one combined app**. Whoever signs in picks a role once (nurse vs. centre) and
from then on sees that role's version of the shell (same header/branding, different
bottom-tab set and home screen).

## What I'm giving you

I already have Flutter UI screens built and visually verified (screenshotted on an iOS
simulator) for the first slice of this app. They're plain `StatelessWidget`s with mock
data and callback props — **no routing, no state management, no API calls wired up
yet**. That's the next step, and it's what I want your help with.

Files, already dropped into this repo at matching paths:

```
lib/core/provider_role.dart                                        # ProviderRole enum (nurse/centre)
lib/core/theme/app_theme.dart                                       # design tokens + ThemeData
lib/core/ui/app_shell.dart                                          # ProviderShell: gradient header + role-aware bottom nav
lib/core/ui/screen_header.dart                                      # in-page white title header (title/subtitle/back)
lib/core/ui/surface.dart                                            # card surface, Material-backed so onTap ripples show correctly
lib/core/ui/tappable.dart                                           # wraps any tap target so ripple feedback always shows
lib/features/auth/presentation/role_select_screen.dart              # "I'm a Nurse" / "I run a Homecare Centre" picker
lib/features/nurse/presentation/home/nurse_home_screen.dart         # nurse dashboard
lib/features/nurse/presentation/requests/job_requests_screen.dart   # nurse: pending shift requests, accept/decline
lib/features/nurse/presentation/requests/job_detail_screen.dart     # nurse: full request detail + accept/decline
lib/features/nurse/presentation/schedule/nurse_schedule_screen.dart # nurse: upcoming/ongoing/completed shifts
lib/features/centre/presentation/home/centre_home_screen.dart       # centre dashboard (occupancy, stats, requests preview)
lib/features/centre/presentation/requests/centre_requests_screen.dart # centre: pending placement requests, accept/decline
lib/features/centre/presentation/rooms/room_inventory_screen.dart   # centre: rooms/beds grouped by ward, occupied/vacant
```

## Design system — keep this consistent with the customer app

This is a companion app to an existing product, not a fresh brand. Reuse these tokens
exactly (they're already in `app_theme.dart`, but repeating here so you don't drift if
you touch it):

- **Colors**: primary `#26593B`, primary-soft `#DDF4E4`, accent `#3A8357`, ink
  `#111512`, muted-foreground `#646B66`, border `#E3E7E4`, card `#FFFFFF`, background
  `#FEFDFC`, destructive `#DA2B29`, warning `#B8791E` / warning-soft `#FBECD8`.
- **Header gradient** (`AppColors.gradientPrimary`): vertical, `#4A8F63 → #2F6B48 →
  #1B4A30`. Used behind every screen's header via `ProviderShell` — don't hardcode
  gradients per-screen, change the one definition if it ever needs to move.
- **Radius scale** (`AppRadius`): sm 12, md 14, lg 16, xl 20, xxl 24, xxxl 28, pill 999.
  Cards are `xxxl`, buttons/chips are `pill`.
- **Font**: Plus Jakarta Sans via `google_fonts` (`GoogleFonts.plusJakartaSansTextTheme`
  in `buildAppTheme()`). Add `google_fonts` to `pubspec.yaml` if it's not already there.
- **Bottom nav**: profile is reached only through the header avatar, never as its own
  bottom tab — that's a deliberate convention carried over from the customer app.

### A Flutter pitfall already fixed here — don't reintroduce it

Flutter's `InkWell`/`InkResponse` paint their ripple on the nearest ancestor `Material`.
If there's an opaque `Container`/`ColoredBox`/`DecoratedBox` sitting between that
`Material` and the tap target (which is the normal situation once you have a gradient
header, a rounded white card body, etc.), the ripple gets **painted but visually
hidden** underneath it — buttons end up feeling unresponsive even though they work.

`Surface` (card backgrounds) and `Tappable` (icon/text links) in `core/ui` both solve
this by wrapping tap targets in their own **local** `Material` right at the point of
interaction, rather than relying on some Material higher up the tree. When you add new
tappable UI, use `Surface(onTap: ...)` for cards and `Tappable(onTap: ...)` for
icons/text links instead of a bare `GestureDetector` — a `GestureDetector` gives zero
visual feedback on tap, which reads as broken/unresponsive to users.

## What's stubbed and needs wiring

1. **Routing** — screens take plain callbacks (`onOpenRequest`, `onAccept`, etc.)
   instead of navigating themselves, so wire them into whatever router this repo uses
   (go_router is what the customer app uses, for consistency I'd lean that way unless
   you have a reason not to).
2. **State management** — no Riverpod/provider wiring yet. The customer app's pattern
   is: `data/<thing>_service.dart` (data source) → `data/<thing>_repository.dart` →
   `presentation/<screen>_view_model.dart` (a `Riverpod` `AsyncNotifier` or similar) →
   the screen watches it. Mirror that structure here per feature
   (`features/nurse/data/...`, `features/centre/data/...`).
3. **Models** — mock data is inline in each screen file right now (`JobRequestSummary`,
   `PlacementRequestSummary`, `Room`/`BedSlot`, the private `_Shift` class in
   `nurse_schedule_screen.dart`). Promote these to real model classes in each feature's
   `data/models/` folder. The customer app uses `freezed` for its models — adopt that
   here too if you want consistency, but it's not required to get something working.
4. **Auth / role persistence** — `RoleSelectScreen` assumes it's shown once and the
   choice should be remembered (tied to the account), not asked every launch. There's
   no login screen at all yet — add one ahead of role selection.
5. **API integration** — obviously all requests/rooms/shifts are hardcoded mock lists
   right now; replace with real repository calls once there's a backend to hit.

## Deliberately deferred (out of scope for this first slice)

- Nurse: availability toggle (mark yourself available/unavailable for new shifts),
  earnings/payout dashboard, KYC/verification status screen.
- Centre: patient admission records, staff/nurse roster, centre profile & verification
  document management (the "VERIFIED" badge families see in the customer app implies
  this exists somewhere — it should live here once built).

Don't build these yet — flag them as follow-up rather than trying to squeeze them in.

## What I want from you right now

Please:
1. Read through the pasted screens so you understand the shape of things.
2. Set up routing (go_router, matching the customer app) covering: login →
   role-select → the right shell for that role, plus the request-detail push route.
3. Set up the MVVM plumbing per feature (nurse, centre) with mock repositories for now
   (same mock data that's already inline, just moved into proper data classes) so the
   app runs end-to-end on fake data through a real architecture, ready to swap in a
   real API later.
4. Confirm it actually runs — launch it and click/tap through both role paths.

Ask me if anything about scope or the API shape is unclear rather than guessing.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/bookings/data/models/booking.dart';
import '../../features/bookings/presentation/bookings_view_model.dart';
import '../theme/app_theme.dart';
import 'tappable.dart';

class _TabItem {
  final String path;
  final String label;
  final IconData icon;
  final bool exact;
  final bool isSpecial;

  const _TabItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.exact,
    this.isSpecial = false,
  });
}

const _tabs = [
  _TabItem(
    path: '/',
    label: 'Home',
    icon: Icons.grid_view_rounded,
    exact: true,
  ),
  _TabItem(
    path: '/centres',
    label: 'Care Centres',
    icon: Icons.apartment_rounded,
    exact: false,
  ),
  _TabItem(
    path: '/nurse-quick-booking',
    label: '45 Mins',
    icon: Icons.bolt_rounded,
    exact: false,
    isSpecial: true,
  ),
  _TabItem(
    path: '/equipment',
    label: 'Equipments',
    icon: Icons.medical_services_outlined,
    exact: false,
  ),
  _TabItem(
    path: '/bookings',
    label: 'Bookings',
    icon: Icons.event_available_outlined,
    exact: false,
  ),
];

/// Streamlined, Ultra-Compact Header AppShell:
/// - Shorter green gradient header with no bulky icons or top title.
/// - Top row: Location & Time (left), Notification & Profile (right).
/// - Below top row: Integrated search bar.
/// - Quick-commerce live nurse visit docked popup just above bottom nav.
/// - 5-tab flow: Home, Care Centres, 45 Mins (Quick Booking), Equipments, Bookings.
class AppShell extends ConsumerWidget {
  final Widget child;
  final Widget? bottomBar;
  final String currentPath;
  final String address;
  final String timeStatus;
  final VoidCallback? onAddressTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onProfileTap;
  final ValueChanged<String>? onSearchChanged;
  final TextEditingController? searchController;
  final String initials;
  final int notificationCount;
  final bool showSearch;
  final bool showQuickActions;

  const AppShell({
    super.key,
    required this.child,
    this.bottomBar,
    required this.currentPath,
    this.address = 'Indiranagar, Bengaluru',
    this.timeStatus = 'Instant Care Active · 45m',
    this.onAddressTap,
    this.onNotificationsTap,
    this.onProfileTap,
    this.onSearchChanged,
    this.searchController,
    this.initials = 'AK',
    this.notificationCount = 2,
    this.showSearch = false,
    this.showQuickActions = false,
  });

  bool _isActive(_TabItem tab) {
    if (tab.exact) return currentPath == tab.path;
    return currentPath == tab.path || currentPath.startsWith('${tab.path}/');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPadding = MediaQuery.paddingOf(context).top;

    final bookingsAsync = ref.watch(bookingsViewModelProvider);
    Booking? activeNurseBooking;
    final bookings = bookingsAsync.valueOrNull ?? [];
    for (final b in bookings) {
      if (b.type == BookingType.nurse &&
          (b.status == 'In Progress' || b.status == 'Active' || b.status == 'Confirmed')) {
        activeNurseBooking = b;
        break;
      }
    }
    final showVisitPopup = activeNurseBooking != null && currentPath == '/';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.gradientPrimary,
        ),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                pinned: true,
                delegate: _CompactHeaderDelegate(
                  topPadding: topPadding,
                  currentPath: currentPath,
                  address: address,
                  timeStatus: timeStatus,
                  onAddressTap: onAddressTap,
                  onNotificationsTap: onNotificationsTap,
                  onProfileTap: onProfileTap,
                  initials: initials,
                  notificationCount: notificationCount,
                ),
              ),
            ];
          },
          body: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppRadius.xxxl),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.xxxl),
              ),
              child: child,
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: ColoredBox(
          color: AppColors.card,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showVisitPopup)
                _MinimalActiveNurseVisitPopup(booking: activeNurseBooking!),
              ?bottomBar,
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 6, 8),
                  child: Row(
                    children: _tabs.map((tab) {
                      final active = _isActive(tab);
                      return Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkResponse(
                            onTap: () {
                              if (currentPath != tab.path) context.go(tab.path);
                            },
                            radius: 40,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (tab.isSpecial)
                                  Container(
                                    width: 36,
                                    height: 36,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: active
                                          ? const LinearGradient(
                                              colors: [Color(0xFF0F766E), Color(0xFF059669)],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )
                                          : const LinearGradient(
                                              colors: [Color(0xFFCCFBF1), Color(0xFFA7F3D0)],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF0F766E).withValues(alpha: active ? 0.35 : 0.15),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      tab.icon,
                                      size: 20,
                                      color: active ? const Color(0xFFFDE047) : const Color(0xFF0F766E),
                                    ),
                                  )
                                else
                                  Container(
                                    width: 36,
                                    height: 36,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: active
                                          ? AppColors.primarySoft
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      tab.icon,
                                      size: 20,
                                      color: active
                                          ? AppColors.primary
                                          : AppColors.mutedForeground,
                                    ),
                                  ),
                                const SizedBox(height: 2),
                                Text(
                                  tab.label,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                                    color: active
                                        ? AppColors.primary
                                        : AppColors.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompactHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double topPadding;
  final String currentPath;
  final String address;
  final String timeStatus;
  final VoidCallback? onAddressTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onProfileTap;
  final String initials;
  final int notificationCount;

  _CompactHeaderDelegate({
    required this.topPadding,
    required this.currentPath,
    required this.address,
    required this.timeStatus,
    this.onAddressTap,
    this.onNotificationsTap,
    this.onProfileTap,
    this.initials = 'AK',
    this.notificationCount = 2,
  });

  @override
  double get minExtent => topPadding + 52.0;

  @override
  double get maxExtent => topPadding + 62.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final delta = maxExtent - minExtent;
    final progress = delta > 0 ? (shrinkOffset / delta).clamp(0.0, 1.0) : 0.0;
    final subOpacity = (1.0 - progress * 2.0).clamp(0.0, 1.0);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.gradientPrimary,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(18, topPadding + 6, 18, 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. LEFT: Location & Time Status
              Expanded(
                child: Tappable(
                  onTap: onAddressTap ??
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('📍 Current Area: $address (Serving South Delhi, Bengaluru & Mumbai)'),
                            backgroundColor: AppColors.primary,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 15,
                            color: AppColors.primaryForeground,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                                color: AppColors.primaryForeground,
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 16,
                            color: AppColors.primaryForeground,
                          ),
                        ],
                      ),
                      if (subOpacity > 0) ...[
                        const SizedBox(height: 1),
                        Opacity(
                          opacity: subOpacity,
                          child: Row(
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4ADE80),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                timeStatus,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryForeground.withValues(alpha: 0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // 2. RIGHT: Notification Bell & Profile Avatar
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Notifications Icon
                  Tappable(
                    onTap: onNotificationsTap ??
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('🔔 No new clinical alerts. All bookings normal.'),
                              backgroundColor: AppColors.primary,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primaryForeground.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryForeground.withValues(alpha: 0.2),
                            ),
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            size: 18,
                            color: AppColors.primaryForeground,
                          ),
                        ),
                        if (notificationCount > 0)
                          Positioned(
                            right: -1,
                            top: -1,
                            child: Container(
                              width: 15,
                              height: 15,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppColors.destructive,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$notificationCount',
                                style: const TextStyle(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.destructiveForeground,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Profile / Avatar Icon
                  Tappable(
                    onTap: onProfileTap ?? () => context.go('/profile'),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryForeground.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryForeground.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Text(
                        initials,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryForeground,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _CompactHeaderDelegate oldDelegate) {
    return oldDelegate.address != address ||
        oldDelegate.currentPath != currentPath ||
        oldDelegate.notificationCount != notificationCount ||
        oldDelegate.topPadding != topPadding ||
        oldDelegate.timeStatus != timeStatus;
  }
}

/// Minimal Quick-Commerce style Active Nurse Visit Popup pinned right above bottom navigation.
class _MinimalActiveNurseVisitPopup extends StatelessWidget {
  final Booking booking;

  const _MinimalActiveNurseVisitPopup({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: () {
            context.push('/nurse-tracker/${booking.id}');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                // Clean static nurse icon with online indicator
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primarySoft,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.medical_services_rounded,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    Positioned(
                      right: 1,
                      top: 1,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),

                // Nurse Name & Quick visit status
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              booking.providerName.isNotEmpty ? booking.providerName : 'Sister Priya Sharma',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.verified_rounded, size: 13, color: AppColors.primary),
                        ],
                      ),
                      const SizedBox(height: 1),
                      Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Color(0xFF16A34A),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              'Live Nurse Visit · In Progress',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary.withValues(alpha: 0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 6),

                // OTP badge
                if (booking.otp.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      'OTP: ${booking.otp}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                  ),

                const SizedBox(width: 6),

                // Minimal Track Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(Icons.arrow_forward_ios_rounded, size: 8.5, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


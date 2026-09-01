import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';
import 'tappable.dart';

class _TabItem {
  final String path;
  final String label;
  final IconData icon;
  final bool exact;

  const _TabItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.exact,
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
    path: '/nurses',
    label: 'Nurses',
    icon: Icons.medical_services_outlined,
    exact: false,
  ),
  _TabItem(
    path: '/equipment',
    label: 'Equipment',
    icon: Icons.local_shipping_outlined,
    exact: false,
  ),
  _TabItem(
    path: '/bookings',
    label: 'Bookings',
    icon: Icons.event_available_outlined,
    exact: false,
  ),
];

/// Premium Collapsible App Shell for ALLCURO Customer App:
/// Features a dynamic sliding gradient header that collapses on scroll.
/// - Background: Seamless full-bleed green gradient behind header & rounded corners.
/// - Expanded state: ALLCURO brand title, small logo, Notifications bell with
///   badge, Profile Avatar, and clean Address with Quick Actions.
/// - Scrolled/Collapsed state: ALLCURO name and right-side icons smoothly fade
///   out, leaving only the small ALLCURO logo and the Address neatly pinned
///   while the content card slides up smoothly together.
class AppShell extends StatelessWidget {
  final Widget child;
  final Widget? bottomBar;
  final String currentPath;
  final String address;
  final VoidCallback? onAddressTap;
  final VoidCallback? onQuickBookTap;
  final VoidCallback? onSosTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onProfileTap;
  final String initials;
  final int notificationCount;
  final bool showQuickActions;

  const AppShell({
    super.key,
    required this.child,
    this.bottomBar,
    required this.currentPath,
    this.address = 'Indiranagar, Bengaluru',
    this.onAddressTap,
    this.onQuickBookTap,
    this.onSosTap,
    this.onNotificationsTap,
    this.onProfileTap,
    this.initials = 'AK',
    this.notificationCount = 3,
    this.showQuickActions = true,
  });

  bool _isActive(_TabItem tab) {
    if (tab.exact) return currentPath == tab.path;
    return currentPath == tab.path || currentPath.startsWith('${tab.path}/');
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

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
                delegate: _CollapsibleHeaderDelegate(
                  topPadding: topPadding,
                  currentPath: currentPath,
                  address: address,
                  onAddressTap: onAddressTap,
                  onQuickBookTap: onQuickBookTap,
                  onSosTap: onSosTap,
                  onNotificationsTap: onNotificationsTap,
                  onProfileTap: onProfileTap,
                  initials: initials,
                  notificationCount: notificationCount,
                  showQuickActions: showQuickActions,
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
              ?bottomBar,
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 12),
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
                                const SizedBox(height: 3),
                                Text(
                                  tab.label,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
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

class _CollapsibleHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double topPadding;
  final String currentPath;
  final String address;
  final VoidCallback? onAddressTap;
  final VoidCallback? onQuickBookTap;
  final VoidCallback? onSosTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onProfileTap;
  final String initials;
  final int notificationCount;
  final bool showQuickActions;

  _CollapsibleHeaderDelegate({
    required this.topPadding,
    required this.currentPath,
    required this.address,
    this.onAddressTap,
    this.onQuickBookTap,
    this.onSosTap,
    this.onNotificationsTap,
    this.onProfileTap,
    this.initials = 'AK',
    this.notificationCount = 3,
    this.showQuickActions = true,
  });

  @override
  double get minExtent => topPadding + 58.0;

  @override
  double get maxExtent => showQuickActions ? topPadding + 114.0 : topPadding + 68.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final delta = maxExtent - minExtent;
    final progress = delta > 0 ? (shrinkOffset / delta).clamp(0.0, 1.0) : 0.0;

    // Opacities for elements that disappear as the user scrolls
    final titleAndIconsOpacity = (1.0 - progress * 2.5).clamp(0.0, 1.0);
    final quickActionsOpacity = (1.0 - progress * 2.2).clamp(0.0, 1.0);

    // Interpolated values for small logo
    final logoSize = lerpDouble(36.0, 30.0, progress)!;
    final logoTop = lerpDouble(topPadding + 12.0, topPadding + 14.0, progress)!;
    const logoLeft = 20.0;

    // Interpolated values for Address (no box/border, simple clean layout)
    final addressExpandedTop = topPadding + 65.0;
    final addressCollapsedTop = topPadding + 18.0;
    final addressTop = lerpDouble(addressExpandedTop, addressCollapsedTop, progress)!;
    final addressLeft = lerpDouble(20.0, 58.0, progress)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.gradientPrimary,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 1. ALLCURO Brand Text (Fades away smoothly as user scrolls)
            if (titleAndIconsOpacity > 0)
              Positioned(
                left: 64,
                top: topPadding + 18,
                child: Opacity(
                  opacity: titleAndIconsOpacity,
                  child: const Text(
                    'ALLCURO',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.2,
                      color: AppColors.primaryForeground,
                    ),
                  ),
                ),
              ),

            // 2. Right Action Icons: Notifications & Profile (Fade away smoothly)
            if (titleAndIconsOpacity > 0)
              Positioned(
                right: 20,
                top: topPadding + 12,
                child: Opacity(
                  opacity: titleAndIconsOpacity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Notifications Bell
                      Tappable(
                        onTap: onNotificationsTap ?? () {},
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
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
                                size: 19,
                                color: AppColors.primaryForeground,
                              ),
                            ),
                            if (notificationCount > 0)
                              Positioned(
                                right: -2,
                                top: -2,
                                child: Container(
                                  width: 17,
                                  height: 17,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: AppColors.destructive,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '$notificationCount',
                                    style: const TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.destructiveForeground,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Profile Avatar
                      Tappable(
                        onTap: onProfileTap ?? () => context.go('/profile'),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 36,
                          height: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primaryForeground.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryForeground.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            initials,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryForeground,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // 3. Small Logo (ALWAYS VISIBLE, smooth scaling on scroll)
            Positioned(
              left: logoLeft,
              top: logoTop,
              child: Tappable(
                onTap: () => context.go('/'),
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: Container(
                  width: logoSize,
                  height: logoSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryForeground.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: AppColors.primaryForeground.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Icon(
                    Icons.monitor_heart_rounded,
                    size: logoSize * 0.55,
                    color: AppColors.primaryForeground,
                  ),
                ),
              ),
            ),

            // 4. Simple Clean Address (No border box, clean icon + text + chevron)
            Positioned(
              left: addressLeft,
              top: addressTop,
              child: Tappable(
                onTap: onAddressTap ?? () {},
                borderRadius: BorderRadius.circular(AppRadius.sm),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: AppColors.primaryForeground,
                      ),
                      const SizedBox(width: 4),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: lerpDouble(180.0, 250.0, progress)!,
                        ),
                        child: Text(
                          address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                            color: AppColors.primaryForeground,
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 15,
                        color: AppColors.primaryForeground,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 5. Quick Action Mini Pills in Header (⚡ Quick Book & 🚨 SOS)
            if (showQuickActions && quickActionsOpacity > 0)
              Positioned(
                right: 20,
                top: topPadding + 62.0,
                child: Opacity(
                  opacity: quickActionsOpacity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Quick Book Mini Pill (< 45m)
                      Tappable(
                        onTap: onQuickBookTap ?? () => context.push('/nurse-quick-booking'),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            border: Border.all(color: const Color(0xFFFECACA)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.bolt_rounded, size: 13, color: Color(0xFFE11D48)),
                              SizedBox(width: 3),
                              Text(
                                'Quick Book',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFE11D48),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // SOS Mini Pill
                      Tappable(
                        onTap: onSosTap ?? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('🚨 Connecting to 24/7 ALLCURO Emergency HQ...'),
                              backgroundColor: Color(0xFFDC2626),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.emergency_rounded, size: 12, color: Colors.white),
                              SizedBox(width: 3),
                              Text(
                                'SOS',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _CollapsibleHeaderDelegate oldDelegate) {
    return oldDelegate.address != address ||
        oldDelegate.currentPath != currentPath ||
        oldDelegate.notificationCount != notificationCount ||
        oldDelegate.showQuickActions != showQuickActions ||
        oldDelegate.topPadding != topPadding;
  }
}

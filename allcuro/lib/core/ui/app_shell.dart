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

/// Streamlined, Ultra-Compact Header AppShell:
/// - Shorter green gradient header with no bulky icons or top title.
/// - Top row: Location & Time (left), Notification & Profile (right).
/// - Below top row: Integrated search bar.
/// - Seamless sliding collapse on scroll.
class AppShell extends StatelessWidget {
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
              ?bottomBar,
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
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
                                const SizedBox(height: 2),
                                Text(
                                  tab.label,
                                  style: TextStyle(
                                    fontSize: 10.5,
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

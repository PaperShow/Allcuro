import 'package:flutter/material.dart';
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

/// Ports `<AppShell>` from `src/components/app/AppShell.tsx`: a gradient
/// header (logo, notifications, profile), the page content on a rounded
/// card surface, an optional sticky CTA bar, and a persistent bottom
/// navigation bar that stays visible on every screen (list, detail and
/// checkout alike) — exactly like the web version. Profile lives only in
/// the header avatar, not as a bottom tab.
class AppShell extends StatelessWidget {
  final Widget child;
  final Widget? bottomBar;
  final String currentPath;

  const AppShell({
    super.key,
    required this.child,
    this.bottomBar,
    required this.currentPath,
  });

  bool _isActive(_TabItem tab) {
    if (tab.exact) return currentPath == tab.path;
    return currentPath == tab.path || currentPath.startsWith('${tab.path}/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDeep,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.gradientPrimary),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _Header(),
              Expanded(
                child: DecoratedBox(
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
            ],
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

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        children: [
          Tappable(
            onTap: () => context.go('/'),
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryForeground.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: AppColors.primaryForeground.withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Icon(
                    Icons.monitor_heart_rounded,
                    size: 20,
                    color: AppColors.primaryForeground,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'ALLCURO',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.5,
                    color: AppColors.primaryForeground,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40,
                height: 40,
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
                  size: 20,
                  color: AppColors.primaryForeground,
                ),
              ),
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.destructive,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.destructiveForeground,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Tappable(
            onTap: () => context.go('/profile'),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryForeground.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryForeground.withValues(alpha: 0.2),
                ),
              ),
              child: const Text(
                'AK',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryForeground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

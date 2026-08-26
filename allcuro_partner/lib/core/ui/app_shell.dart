import 'package:flutter/material.dart';

import '../provider_role.dart';
import '../theme/app_theme.dart';
import 'tappable.dart';

class _TabItem {
  final String label;
  final IconData icon;

  const _TabItem({required this.label, required this.icon});
}

const _nurseTabs = [
  _TabItem(label: 'Home', icon: Icons.grid_view_rounded),
  _TabItem(label: 'Requests', icon: Icons.assignment_outlined),
  _TabItem(label: 'Schedule', icon: Icons.event_available_outlined),
];

const _centreTabs = [
  _TabItem(label: 'Home', icon: Icons.grid_view_rounded),
  _TabItem(label: 'Requests', icon: Icons.assignment_outlined),
  _TabItem(label: 'Rooms', icon: Icons.bed_outlined),
];

/// Partner-app counterpart to the customer app's `AppShell`: same gradient
/// header + rounded card body + bottom tab bar, but the tab set switches on
/// [role] (nurse vs homecare centre) instead of being fixed.
///
/// This is deliberately routing-agnostic — [currentIndex] and
/// [onTabSelected] are plain callbacks so it can be wired to go_router,
/// Navigator 2.0, or anything else the host app already uses. Profile lives
/// only in the header avatar, not as a bottom tab (matching the customer
/// app's convention).
class ProviderShell extends StatelessWidget {
  final Widget child;
  final ProviderRole role;
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationsTap;
  final String initials;
  final Widget? bottomBar;

  const ProviderShell({
    super.key,
    required this.child,
    required this.role,
    required this.currentIndex,
    required this.onTabSelected,
    this.onProfileTap,
    this.onNotificationsTap,
    this.initials = '—',
    this.bottomBar,
  });

  List<_TabItem> get _tabs =>
      role == ProviderRole.nurse ? _nurseTabs : _centreTabs;

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
              _Header(
                initials: initials,
                onProfileTap: onProfileTap,
                onNotificationsTap: onNotificationsTap,
              ),
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
                    children: _tabs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final tab = entry.value;
                      final active = index == currentIndex;
                      return Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkResponse(
                            onTap: () {
                              if (index != currentIndex) onTabSelected(index);
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
  final String initials;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationsTap;

  const _Header({
    required this.initials,
    this.onProfileTap,
    this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        children: [
          Row(
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
                'ALLCURO PARTNER',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.6,
                  color: AppColors.primaryForeground,
                ),
              ),
            ],
          ),
          const Spacer(),
          Tappable(
            onTap: onNotificationsTap ?? () {},
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
              child: const Icon(
                Icons.notifications_outlined,
                size: 20,
                color: AppColors.primaryForeground,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Tappable(
            onTap: onProfileTap ?? () {},
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
              child: Text(
                initials,
                style: const TextStyle(
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

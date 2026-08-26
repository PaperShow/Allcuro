import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Shown for the brief moment `AuthViewModel` is reading the persisted
/// session from disk, before `app_router.dart`'s redirect can decide
/// whether to send the user to login, role-select, or straight into a
/// shell.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDeep,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.gradientPrimary),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryForeground.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: AppColors.primaryForeground.withValues(alpha: 0.2),
                  ),
                ),
                child: const Icon(
                  Icons.monitor_heart_rounded,
                  size: 28,
                  color: AppColors.primaryForeground,
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primaryForeground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

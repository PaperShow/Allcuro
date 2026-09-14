import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// First screen a signed-out customer sees. Branded intro with primary CTA to start
/// and option to explore as a guest without signing up immediately.
class WelcomeScreen extends StatelessWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onExploreGuest;

  const WelcomeScreen({
    super.key,
    required this.onGetStarted,
    required this.onExploreGuest,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.gradientPrimary),
        child: Stack(
          children: [
            Positioned(
              top: -60,
              right: -70,
              child: _Blob(size: 220, opacity: 0.10),
            ),
            Positioned(
              top: 160,
              left: -90,
              child: _Blob(size: 180, opacity: 0.08),
            ),
            Positioned(
              bottom: 200,
              right: -60,
              child: _Blob(size: 150, opacity: 0.07),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 32, 28, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryForeground.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                        border: Border.all(
                          color: AppColors.primaryForeground.withValues(alpha: 0.2),
                        ),
                      ),
                      child: const Icon(
                        Icons.monitor_heart_rounded,
                        size: 34,
                        color: AppColors.primaryForeground,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'ALLCURO',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.5,
                        color: AppColors.primaryForeground,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Healthcare,\nMade Simple.',
                      style: appHeadingStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        height: 1.12,
                        letterSpacing: -0.8,
                        color: AppColors.primaryForeground,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Book verified nurses, top-rated home care centre beds, and rent ICU-grade medical equipment — all in one tap.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        color: AppColors.primaryForeground.withValues(alpha: 0.82),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Primary CTA: Get Started / Log In
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onGetStarted,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.accentForeground,
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign In / Register',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Secondary CTA: Explore as Guest
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: onExploreGuest,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryForeground,
                          side: BorderSide(
                            color: AppColors.primaryForeground.withValues(alpha: 0.35),
                            width: 1.2,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.explore_outlined, size: 19, color: AppColors.primaryForeground),
                            SizedBox(width: 8),
                            Text(
                              'Explore as Guest',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'By continuing, you agree to ALLCURO\'s Terms of Service and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: AppColors.primaryForeground.withValues(alpha: 0.55),
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
}

class _Blob extends StatelessWidget {
  final double size;
  final double opacity;

  const _Blob({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryForeground.withValues(alpha: opacity),
        ),
      ),
    );
  }
}

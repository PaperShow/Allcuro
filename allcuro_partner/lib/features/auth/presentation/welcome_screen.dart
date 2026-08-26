import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// First screen a signed-out user sees. Purely a branded intro — it never
/// navigates itself; the caller decides what "Get started" does (push the
/// phone-auth screen).
class WelcomeScreen extends StatelessWidget {
  final VoidCallback onGetStarted;

  const WelcomeScreen({super.key, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDeep,
      body: DecoratedBox(
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
                padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
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
                      'ALLCURO PARTNER',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.5,
                        color: AppColors.primaryForeground,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Care work,\ncoordinated better.',
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
                      'Shift requests, bed availability, and your schedule — '
                      'all in one place built for ALLCURO care partners.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        color: AppColors.primaryForeground.withValues(alpha: 0.78),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onGetStarted,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.accentForeground,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Get started',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'By continuing, you agree to our Terms of Service and Privacy Policy.',
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

/// Soft translucent decorative circle — purely visual texture behind the
/// content, never intercepts taps.
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

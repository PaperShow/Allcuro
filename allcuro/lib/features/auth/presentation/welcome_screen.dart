import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_theme.dart';

/// Minimalist, premium Welcome Screen for the ALLCURO Customer App.
/// Stripped of clutter, marketing paragraphs, and busy shapes — focusing purely
/// on clean brand presence, calm aesthetic, and the essential actions.
class WelcomeScreen extends StatefulWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onExploreGuest;

  const WelcomeScreen({
    super.key,
    required this.onGetStarted,
    required this.onExploreGuest,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.03),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1F13),
      body: Stack(
        children: [
          // Subtle, calm atmospheric gradient (no noisy blobs)
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0F2E1B),
                    Color(0xFF0B2415),
                    Color(0xFF07180E),
                  ],
                ),
              ),
            ),
          ),

          // Soft ambient radial glow centered behind brand mark
          Positioned(
            top: screenHeight * 0.22,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF26593B).withValues(alpha: 0.32),
                      const Color(0xFF26593B).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    children: [
                      // Top Row with discrete Skip button
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: TextButton(
                      //     onPressed: widget.onExploreGuest,
                      //     style: TextButton.styleFrom(
                      //       foregroundColor: Colors.white,
                      //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      //       side: BorderSide(
                      //         color: Colors.white.withValues(alpha: 0.28),
                      //       ),
                      //       shape: const StadiumBorder(),
                      //     ),
                      //     child: Text(
                      //       'Skip ➔',
                      //       style: GoogleFonts.plusJakartaSans(
                      //         fontSize: 12.5,
                      //         fontWeight: FontWeight.w700,
                      //         color: Colors.white.withValues(alpha: 0.9),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Logo Container (ready to swap with Image.asset('assets/images/logo.png') once generated)
                      const SizedBox(height: 25),

                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Container(
                          width: 76,
                          height: 76,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.14),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.22),
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.monitor_heart_rounded,
                            size: 36,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(flex: 5),

                      // Brand Emblem + Name + Tagline
                      const _BrandIdentity(),

                      // const Spacer(flex: 1),
                      const SizedBox(height: 25),

                      // Minimal Action Buttons & Essential Fine Print
                      _ActionSection(
                        onGetStarted: widget.onGetStarted,
                        onExploreGuest: widget.onExploreGuest,
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Minimal brand mark with wordmark and single tagline
class _BrandIdentity extends StatelessWidget {
  const _BrandIdentity();

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        // Brand Name
        Text(
          'ALLCURO',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 4.5,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 10),

        // Minimal Required Tagline
        Text(
          'Healthcare, made simple.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.5,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
            color: Colors.white.withValues(alpha: 0.72),
          ),
        ),

        const SizedBox(height: 10),

        // Minimal Required Tagline
        Text(
          'Complete home healthcare: Nurses, beds & equipment',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

/// Minimalist action area: Primary CTA, Guest Option, and Legal Notice
class _ActionSection extends StatelessWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onExploreGuest;

  const _ActionSection({
    required this.onGetStarted,
    required this.onExploreGuest,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Primary CTA Button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: onGetStarted,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0B2415),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
            child: Text(
              'Get Started',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Secondary / Guest CTA Button
        SizedBox(
          width: double.infinity,
          height: 44,
          child: TextButton(
            onPressed: onExploreGuest,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white.withValues(alpha: 0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
            child: Text(
              'Explore as guest',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
        ),

        const SizedBox(height: 18),

        // Discrete Legal Note
        Text(
          'By continuing, you agree to our Terms & Privacy Policy',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.42),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

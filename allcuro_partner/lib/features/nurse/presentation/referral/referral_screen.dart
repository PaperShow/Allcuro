import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/screen_header.dart';
import '../../../../core/ui/surface.dart';

class _Referral {
  final String name;
  final String status;
  final Color color;
  final Color background;

  const _Referral({
    required this.name,
    required this.status,
    required this.color,
    required this.background,
  });
}

const _referrals = <_Referral>[
  _Referral(
    name: 'Anjali Nair',
    status: 'Bonus paid',
    color: AppColors.success,
    background: AppColors.successSoft,
  ),
  _Referral(
    name: 'Deepak Rao',
    status: 'Joined',
    color: AppColors.primary,
    background: AppColors.primarySoft,
  ),
  _Referral(
    name: 'Meera Pillai',
    status: 'Pending',
    color: AppColors.warning,
    background: AppColors.warningSoft,
  ),
];

/// Nurse's referral screen — a demo-only referral code + status list,
/// pushed from the "More tools" grid. Copy-to-clipboard is real; sharing
/// is a stubbed SnackBar since no share package is wired up.
class ReferralScreen extends StatelessWidget {
  final VoidCallback onBack;

  static const _referralCode = 'PRIYA250';

  const ReferralScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(
              title: 'Refer a nurse',
              subtitle: 'Earn ₹500 when they complete their first 5 shifts',
              onBack: onBack,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                children: [
                  Surface(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Your referral code',
                          style: TextStyle(fontSize: 13, color: AppColors.mutedForeground),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          _referralCode,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 4,
                            fontFamily: 'monospace',
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () async {
                                  await Clipboard.setData(
                                    const ClipboardData(text: _referralCode),
                                  );
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Copied to clipboard')),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: const BorderSide(color: AppColors.primary),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppRadius.pill),
                                  ),
                                ),
                                child: const Text(
                                  'Copy code',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Share sheet coming soon — demo'),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accent,
                                  foregroundColor: AppColors.accentForeground,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppRadius.pill),
                                  ),
                                ),
                                child: const Text(
                                  'Share',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Your referrals',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final r in _referrals)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Surface(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                r.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.ink,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: r.background,
                                borderRadius: BorderRadius.circular(AppRadius.pill),
                              ),
                              child: Text(
                                r.status,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: r.color,
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
          ],
        ),
      ),
    );
  }
}

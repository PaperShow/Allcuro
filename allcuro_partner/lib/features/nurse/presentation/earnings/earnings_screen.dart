import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/screen_header.dart';
import '../../../../core/ui/surface.dart';

class _ShiftPayout {
  final String date;
  final String description;
  final String amount;

  const _ShiftPayout({
    required this.date,
    required this.description,
    required this.amount,
  });
}

const _payouts = <_ShiftPayout>[
  _ShiftPayout(date: '10 Aug', description: 'Post-op care · Ramesh Iyer', amount: '₹1,400'),
  _ShiftPayout(date: '08 Aug', description: 'Elderly care · Lakshmi Menon', amount: '₹1,200'),
  _ShiftPayout(date: '05 Aug', description: 'Wound dressing · Anand Pillai', amount: '₹900'),
  _ShiftPayout(date: '03 Aug', description: 'Night care · Fathima Beevi', amount: '₹1,600'),
  _ShiftPayout(date: '01 Aug', description: 'Post-op care · Suresh Kumar', amount: '₹1,400'),
];

/// Nurse's earnings screen — a demo-only summary of this month's payouts
/// plus a mock monthly statement, pushed from the "More tools" grid.
/// There is no payments backend here; "Download payslip" just confirms
/// the action via a SnackBar.
class EarningsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const EarningsScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(title: 'Earnings', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: _StatCard(
                          label: 'This month',
                          value: '₹34,200',
                          color: AppColors.primary,
                          bg: AppColors.primarySoft,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          label: 'Incentives',
                          value: '₹2,000',
                          color: AppColors.success,
                          bg: AppColors.successSoft,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Per-shift breakdown',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final payout in _payouts)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Surface(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    payout.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.ink,
                                    ),
                                  ),
                                  Text(
                                    payout.date,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.mutedForeground,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              payout.amount,
                              style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Surface(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Monthly statement',
                          style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'July 2026',
                          style: TextStyle(fontSize: 13, color: AppColors.mutedForeground),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'TDS deducted: ₹1,200',
                          style: TextStyle(fontSize: 13, color: AppColors.mutedForeground),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Payslip downloaded (demo)')),
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
                              'Download payslip',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ],
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

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Color bg;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: color),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}

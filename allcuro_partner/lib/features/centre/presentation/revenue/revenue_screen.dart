import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/screen_header.dart';
import '../../../../core/ui/surface.dart';

/// One settled booking, shown in the "Recent settlements" list.
class _Settlement {
  final String date;
  final String bookingRef;
  final String gross;
  final String net;

  const _Settlement({
    required this.date,
    required this.bookingRef,
    required this.gross,
    required this.net,
  });
}

const _settlements = <_Settlement>[
  _Settlement(date: '10 Aug', bookingRef: '#BK-1042', gross: '₹15,000', net: '₹13,500'),
  _Settlement(date: '07 Aug', bookingRef: '#BK-1038', gross: '₹22,000', net: '₹19,800'),
  _Settlement(date: '03 Aug', bookingRef: '#BK-1029', gross: '₹9,600', net: '₹8,640'),
  _Settlement(date: '29 Jul', bookingRef: '#BK-1017', gross: '₹18,400', net: '₹16,560'),
  _Settlement(date: '24 Jul', bookingRef: '#BK-1004', gross: '₹12,000', net: '₹10,800'),
];

/// Revenue overview for a homecare centre — a self-contained demo screen
/// with mock stats and a mock settlement history. Pushed from the centre
/// home screen's "More tools" grid.
class RevenueScreen extends StatelessWidget {
  final VoidCallback onBack;

  const RevenueScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(title: 'Revenue', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: _StatCard(
                          label: 'Total bookings this month',
                          value: '12',
                          color: AppColors.ink,
                          bg: AppColors.secondary,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          label: 'Gross revenue',
                          value: '₹1,84,000',
                          color: AppColors.primary,
                          bg: AppColors.primarySoft,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Expanded(
                        child: _StatCard(
                          label: 'Commission deducted',
                          value: '₹18,400',
                          color: AppColors.warning,
                          bg: AppColors.warningSoft,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          label: 'Pending settlement',
                          value: '₹42,000',
                          color: AppColors.primary,
                          bg: AppColors.primarySoft,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Recent settlements',
                    style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink),
                  ),
                  const SizedBox(height: 12),
                  for (final s in _settlements)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _SettlementRow(settlement: s),
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color),
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

class _SettlementRow extends StatelessWidget {
  final _Settlement settlement;

  const _SettlementRow({required this.settlement});

  @override
  Widget build(BuildContext context) {
    return Surface(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${settlement.date} · ${settlement.bookingRef}',
              style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Gross ${settlement.gross}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mutedForeground,
                ),
              ),
              Text(
                'Net ${settlement.net}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

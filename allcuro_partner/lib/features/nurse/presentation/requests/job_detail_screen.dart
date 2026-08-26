import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/screen_header.dart';
import '../../../../core/ui/surface.dart';
import '../../data/models/job_request_detail.dart';
import 'job_detail_view_model.dart';
import 'job_requests_view_model.dart';

/// Full detail for a single shift request, opened from either the
/// dashboard preview or the requests list. Accept/decline go through the
/// same `JobRequestsViewModel` the list screen uses, then pop back.
class JobDetailScreen extends ConsumerWidget {
  final String requestId;
  final VoidCallback onBack;

  const JobDetailScreen({
    super.key,
    required this.requestId,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(jobRequestDetailProvider(requestId));

    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: detailAsync.when(
          data: (detail) => _JobDetailContent(
            detail: detail,
            onBack: onBack,
            onAccept: () async {
              await ref.read(jobRequestsViewModelProvider.notifier).accept(requestId);
              onBack();
            },
            onDecline: () async {
              await ref
                  .read(jobRequestsViewModelProvider.notifier)
                  .decline(requestId);
              onBack();
            },
          ),
          loading: () => Column(
            children: [
              ScreenHeader(
                title: 'Request details',
                subtitle: 'Ref. $requestId',
                onBack: onBack,
              ),
              const Expanded(child: Center(child: CircularProgressIndicator())),
            ],
          ),
          error: (error, _) => Column(
            children: [
              ScreenHeader(
                title: 'Request details',
                subtitle: 'Ref. $requestId',
                onBack: onBack,
              ),
              Expanded(
                child: Center(child: Text('Could not load this request: $error')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobDetailContent extends StatelessWidget {
  final JobRequestDetail detail;
  final VoidCallback onBack;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const _JobDetailContent({
    required this.detail,
    required this.onBack,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final d = detail;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ScreenHeader(
                title: 'Request details',
                subtitle: 'Ref. ${d.id}',
                onBack: onBack,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.primarySoft,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            d.patientInitials,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d.patientName,
                                style: appHeadingStyle(fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                d.serviceSummary,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _DetailRow(
                      icon: Icons.location_on_outlined,
                      label: 'Address',
                      value: d.address,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      icon: Icons.schedule_outlined,
                      label: 'Timing',
                      value: d.timingDetail,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      icon: Icons.favorite_outline_rounded,
                      label: 'Condition',
                      value: d.condition,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      icon: Icons.family_restroom_outlined,
                      label: 'Family contact',
                      value: d.familyContactNote,
                    ),
                    const SizedBox(height: 24),
                    _Section(
                      title: 'Care requirements',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: d.careRequirements
                            .map(
                              (t) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(AppRadius.pill),
                                ),
                                child: Text(
                                  t,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryForeground,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    _Section(
                      title: 'Pay breakdown',
                      child: Surface(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _PayRow(label: 'Per shift', value: d.payPerShift),
                            const SizedBox(height: 8),
                            _PayRow(label: d.payEstimateLabel, value: d.payEstimateValue),
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
        Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onDecline,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                  ),
                  child: const Text(
                    'Decline',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.accentForeground,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Accept request',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: AppColors.mutedForeground,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
              color: AppColors.mutedForeground,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _PayRow extends StatelessWidget {
  final String label;
  final String value;

  const _PayRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppColors.mutedForeground),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/allcuro_chip.dart';
import '../../../../core/ui/app_shell.dart';
import '../../../../core/ui/surface.dart';
import '../../../../core/ui/tappable.dart';
import '../../../../core/utils/currency.dart';
import '../../../auth/presentation/auth_view_model.dart';
import '../../../auth/presentation/quick_login_sheet.dart';
import '../../data/models/nurse.dart';
import 'nurse_detail_view_model.dart';

const _checks = [
  (label: 'Police verified', icon: Icons.verified_user_outlined),
  (label: 'Medically fit', icon: Icons.monitor_heart_outlined),
  (label: 'Reference checked', icon: Icons.how_to_reg_outlined),
];

/// Ports `src/routes/nurses.$nurseId.tsx`.
class NurseDetailScreen extends ConsumerWidget {
  final String nurseId;

  const NurseDetailScreen({super.key, required this.nurseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nurseAsync = ref.watch(nurseDetailViewModelProvider(nurseId));
    final path = '/nurses/$nurseId';

    return nurseAsync.when(
      loading: () => AppShell(
        currentPath: path,
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
      error: (error, _) => _NotFound(path: path),
      data: (nurse) => nurse == null
          ? _NotFound(path: path)
          : _NurseDetail(nurse: nurse, path: path),
    );
  }
}

class _NotFound extends StatelessWidget {
  final String path;

  const _NotFound({required this.path});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      currentPath: path,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Nurse unavailable',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go('/nurses'),
              child: const Text('Back to nurses'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NurseDetail extends ConsumerWidget {
  final Nurse nurse;
  final String path;

  const _NurseDetail({required this.nurse, required this.path});

  void _handleBookingGuard(BuildContext context, WidgetRef ref) {
    final authState = ref.read(authViewModelProvider);
    final isAuthenticated =
        authState.status == AuthStatus.onboarded || authState.status == AuthStatus.authenticated;

    void proceed() => context.push('/nurse-quick-booking');

    if (isAuthenticated) {
      proceed();
    } else {
      QuickLoginSheet.show(
        context,
        title: 'Quick Login to Book',
        subtitle: 'Enter your phone number to book ${nurse.name}',
        onSuccess: proceed,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppShell(
      currentPath: path,
      bottomBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'FROM',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: AppColors.mutedForeground,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: inr(nurse.shifts.first.price),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                      children: const [
                        TextSpan(
                          text: ' / shift',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _handleBookingGuard(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.primaryForeground,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Book this nurse',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tappable(
                  onTap: () => context.pop(),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      '← Back',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                        color: AppColors.mutedForeground,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.xxl),
                      child: Image.asset(
                        nurse.photo,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nurse.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.ink,
                            ),
                          ),
                          Text(
                            '${nurse.level} · ${nurse.experience} yrs',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.mutedForeground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ID ${nurse.allcuroId}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${nurse.rating}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${nurse.reviews} reviews)',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(AppRadius.xxxl),
                  ),
                  child: Row(
                    children: _checks
                        .map(
                          (c) => Expanded(
                            child: Column(
                              children: [
                                Surface(
                                  radius: AppRadius.lg,
                                  padding: const EdgeInsets.all(9),
                                  child: Icon(
                                    c.icon,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  c.label,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                _Section(
                  title: 'Specialisations',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: nurse.tags.map(AllcuroChip.new).toList(),
                  ),
                ),
                _Section(
                  title: 'Languages',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: nurse.languages.map(AllcuroChip.new).toList(),
                  ),
                ),
                _Section(
                  title: 'Shift availability',
                  child: Surface(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        for (int i = 0; i < nurse.shifts.length; i++) ...[
                          if (i > 0)
                            const Divider(height: 1, color: AppColors.border),
                          Opacity(
                            opacity: nurse.shifts[i].available ? 1 : 0.5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: nurse.shifts[i].available
                                              ? AppColors.success
                                              : AppColors.border,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        nurse.shifts[i].label,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.ink,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    nurse.shifts[i].available
                                        ? inr(nurse.shifts[i].price)
                                        : 'Booked',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.ink,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                _Section(
                  title: 'What families say',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: nurse.highlights
                        .map(
                          (h) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primarySoft,
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                            ),
                            child: Text(
                              h,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
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

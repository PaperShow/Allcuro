import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/allcuro_chip.dart';
import '../../../../core/ui/app_shell.dart';
import '../../../../core/ui/screen_header.dart';
import '../../../../core/ui/surface.dart';
import '../../../../core/utils/currency.dart';
import '../../data/models/nurse.dart';
import 'nurses_list_view_model.dart';

const _filters = [
  'All Nurses',
  'Elderly Care',
  'Post-Op Recovery',
  'ICU / Critical Care',
  'Palliative',
  'Pediatric',
];

class NursesListScreen extends ConsumerWidget {
  const NursesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nursesAsync = ref.watch(nursesListViewModelProvider);

    return AppShell(
      currentPath: '/nurses',
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          ScreenHeader(
            title: 'Nurses & Attendants',
            subtitle: '100% police-verified & background checked care professionals',
            onBack: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, i) => AllcuroChip(_filters[i]),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: nursesAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
              error: (error, _) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    'Could not load nurses',
                    style: TextStyle(color: AppColors.mutedForeground),
                  ),
                ),
              ),
              data: (nurses) => Column(
                children: nurses.map((n) => _NurseCard(nurse: n)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NurseCard extends StatelessWidget {
  final Nurse nurse;

  const _NurseCard({required this.nurse});

  @override
  Widget build(BuildContext context) {
    final n = nurse;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Surface(
        onTap: () => context.push('/nurses/${n.id}'),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  child: Image.asset(
                    n.photo,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              n.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.verified_rounded,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            'VERIFIED',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${n.level} · ${n.experience} yrs experience · ${n.employment.label}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: n.tags.take(3).map((t) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primarySoft,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              t,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryForeground,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: Color(0xFFFFB800),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${n.rating}',
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${n.reviews} reviews)',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: AppColors.mutedForeground,
                      ),
                    ),
                  ],
                ),
                Text.rich(
                  TextSpan(
                    text: inr(n.shifts.first.price),
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w900,
                      color: AppColors.ink,
                    ),
                    children: const [
                      TextSpan(
                        text: ' / shift',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/screen_header.dart';
import '../../../../core/ui/surface.dart';
import '../../data/models/staff_member.dart';
import '../../../auth/presentation/onboarding_view_model.dart';
import 'add_edit_staff_dialog.dart';

class StaffManagementScreen extends ConsumerWidget {
  final VoidCallback onBack;

  const StaffManagementScreen({super.key, required this.onBack});

  void _showAddStaffDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddEditStaffDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(partnerOnboardingProvider);
    final staff = state.staffMembers;

    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(
              title: 'Staff & In-House Care Roster',
              subtitle: 'Duty nurses, caregivers & staff-to-patient trust metrics',
              onBack: onBack,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                children: [
                  Surface(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.primarySoft,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.people_alt_outlined, size: 22, color: AppColors.primary),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${staff.length} Active Care Staff Members',
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.ink),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Your staff roster and qualifications feed the trust badges families review.',
                                style: TextStyle(fontSize: 12, color: AppColors.mutedForeground),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Caregivers & Nurses',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _showAddStaffDialog(context),
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Add Staff', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.accentForeground,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.pill)),
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (staff.isEmpty)
                    Surface(
                      padding: const EdgeInsets.all(28),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(Icons.group_outlined, size: 40, color: AppColors.mutedForeground),
                            const SizedBox(height: 10),
                            const Text('No care staff configured yet', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
                            const SizedBox(height: 4),
                            const Text('Add your GNM nurses, B.Sc specialists or care attendants.', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => _showAddStaffDialog(context),
                              child: const Text('Add Staff Member'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...staff.map(
                      (member) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _StaffRow(
                          member: member,
                          onDelete: () {
                            ref.read(partnerOnboardingProvider.notifier).removeStaffMember(member.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Removed ${member.name}')),
                            );
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Material(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      onTap: () => _showAddStaffDialog(context),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Center(
                          child: Text(
                            '+ Add another staff member / duty nurse',
                            style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: AppColors.primary),
                          ),
                        ),
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

class _StaffRow extends StatelessWidget {
  final StaffMember member;
  final VoidCallback onDelete;

  const _StaffRow({required this.member, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Surface(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: Text(
              member.initials,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.ink),
                ),
                Text(
                  '${member.qualification} · Ratio ${member.ratio}',
                  style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground),
                ),
                Text(
                  '₹${member.shiftRate.toInt()} / shift',
                  style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: member.certificateExpiring ? AppColors.warningSoft : AppColors.successSoft,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              member.certificateExpiring ? 'Renewal Due' : 'Certified',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: member.certificateExpiring ? AppColors.warning : AppColors.success,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.mutedForeground),
            onPressed: onDelete,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

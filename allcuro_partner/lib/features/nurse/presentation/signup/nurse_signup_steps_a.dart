import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/wizard_scaffold.dart';
import 'nurse_signup_view_model.dart';

const qualificationOptions = [
  'ANM',
  'GNM',
  'B.Sc Nursing',
  'M.Sc Nursing',
  'Certified Attendant',
  'Physio-assistant',
];

const documentLabels = {
  'govt_id': 'Government-issued ID (Aadhaar / Passport)',
  'council_reg': 'State Nursing Council registration',
  'hpr_reg': 'Healthcare Professionals Registry (HPR / ABHA)',
  'edu_certs': 'Educational certificates',
  'pay_slip': 'Latest pay slip',
  'address_proof': 'Address proof',
  'selfie': 'Live selfie-match photo',
};

const medicalDocumentLabels = {
  'self_certificate': 'Medical fitness certificate',
  'tb_report': 'TB / health screening report',
};

/// Step 1: name, DOB, gender, city, address.
class BasicDetailsStep extends ConsumerStatefulWidget {
  const BasicDetailsStep({super.key});

  @override
  ConsumerState<BasicDetailsStep> createState() => _BasicDetailsStepState();
}

class _BasicDetailsStepState extends ConsumerState<BasicDetailsStep> {
  late final _name = TextEditingController(text: _data.fullName);
  late final _city = TextEditingController(text: _data.city);
  late final _address = TextEditingController(text: _data.address);

  NurseSignupData get _data => ref.read(nurseSignupViewModelProvider).data;

  @override
  void dispose() {
    _name.dispose();
    _city.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(nurseSignupViewModelProvider).data;
    final notifier = ref.read(nurseSignupViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WizardStepHeader(
          title: 'Tell us about yourself',
          subtitle: 'These details go on your public profile once verified.',
        ),
        WizardTextField(controller: _name, label: 'Full name', hint: 'As per your govt ID', onChanged: (v) {
          data.fullName = v;
          notifier.touch();
        }),
        const SizedBox(height: 16),
        const WizardSectionLabel('Date of birth'),
        Material(
          color: AppColors.primaryForeground.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: data.dob ?? DateTime(1995, 1, 1),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                data.dob = picked;
                notifier.touch();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryForeground.withValues(alpha: 0.25)),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: AppColors.primaryForeground.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    data.dob == null
                        ? 'Select date of birth'
                        : '${data.dob!.day}/${data.dob!.month}/${data.dob!.year}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: data.dob == null
                          ? AppColors.primaryForeground.withValues(alpha: 0.5)
                          : AppColors.primaryForeground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const WizardSectionLabel('Gender'),
        Wrap(
          spacing: 8,
          children: ['Female', 'Male', 'Other'].map((g) {
            return WizardChoiceChip(
              label: g,
              selected: data.gender == g,
              onTap: () {
                data.gender = g;
                notifier.touch();
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        WizardTextField(controller: _city, label: 'City', hint: 'Bengaluru', onChanged: (v) {
          data.city = v;
          notifier.touch();
        }),
        const SizedBox(height: 16),
        WizardTextField(
          controller: _address,
          label: 'Address',
          hint: 'House / street / area',
          maxLines: 2,
          onChanged: (v) {
            data.address = v;
            notifier.touch();
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

/// Step 2: full-time (payroll) vs part-time (gig).
class EmploymentTypeStep extends ConsumerWidget {
  const EmploymentTypeStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(nurseSignupViewModelProvider).data;
    final notifier = ref.read(nurseSignupViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WizardStepHeader(
          title: 'How do you want to work?',
          subtitle: "You can request to switch this later — it just decides how shifts reach you.",
        ),
        _EmploymentCard(
          icon: Icons.badge_outlined,
          title: 'Full-time',
          description: 'On ALLCURO payroll. Shifts are auto-assigned to your schedule.',
          selected: data.employmentType == 'Full-time',
          onTap: () {
            data.employmentType = 'Full-time';
            notifier.touch();
          },
        ),
        const SizedBox(height: 12),
        _EmploymentCard(
          icon: Icons.event_repeat_outlined,
          title: 'Part-time',
          description: 'Per-shift gig work. Accept or decline each request yourself.',
          selected: data.employmentType == 'Part-time',
          onTap: () {
            data.employmentType = 'Part-time';
            notifier.touch();
          },
        ),
      ],
    );
  }
}

class _EmploymentCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  const _EmploymentCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.xxl),
      side: BorderSide(
        color: selected ? AppColors.primarySoft : AppColors.primaryForeground.withValues(alpha: 0.25),
        width: selected ? 1.5 : 1,
      ),
    );
    return Material(
      color: selected
          ? AppColors.primaryForeground.withValues(alpha: 0.2)
          : AppColors.primaryForeground.withValues(alpha: 0.08),
      shape: shape,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryForeground.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: AppColors.primaryForeground),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primaryForeground),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: AppColors.primaryForeground.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: selected
                    ? AppColors.primaryForeground
                    : AppColors.primaryForeground.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Step 3: qualification, years of experience, previous employer.
class QualificationStep extends ConsumerStatefulWidget {
  const QualificationStep({super.key});

  @override
  ConsumerState<QualificationStep> createState() => _QualificationStepState();
}

class _QualificationStepState extends ConsumerState<QualificationStep> {
  late final _years = TextEditingController(text: _data.experienceYears);
  late final _employer = TextEditingController(text: _data.previousEmployer);

  NurseSignupData get _data => ref.read(nurseSignupViewModelProvider).data;

  @override
  void dispose() {
    _years.dispose();
    _employer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(nurseSignupViewModelProvider).data;
    final notifier = ref.read(nurseSignupViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WizardStepHeader(
          title: 'Qualification & experience',
          subtitle: 'This decides which specialised requests you\'re eligible for.',
        ),
        const WizardSectionLabel('Qualification'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: qualificationOptions.map((q) {
            return WizardChoiceChip(
              label: q,
              selected: data.qualification == q,
              onTap: () {
                data.qualification = q;
                notifier.touch();
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        WizardTextField(
          controller: _years,
          label: 'Years of experience',
          hint: 'e.g. 4',
          keyboardType: TextInputType.number,
          onChanged: (v) {
            data.experienceYears = v;
            notifier.touch();
          },
        ),
        const SizedBox(height: 16),
        WizardTextField(
          controller: _employer,
          label: 'Previous employer(s)',
          hint: 'Hospital / agency / centre names',
          maxLines: 2,
          onChanged: (v) {
            data.previousEmployer = v;
            notifier.touch();
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

/// Step 4: govt ID, council registration, edu certs, pay slip, address
/// proof, selfie match.
class DocumentUploadStep extends ConsumerWidget {
  const DocumentUploadStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _UploadStepBody(
      title: 'Upload your documents',
      subtitle: 'Clear photos or PDFs — this is what ALLCURO ops reviews before you go live.',
      labels: documentLabels,
      mapSelector: (data) => data.documents,
    );
  }
}

/// Step 5: self-certificate + TB/health screening.
class MedicalFitnessStep extends ConsumerWidget {
  const MedicalFitnessStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _UploadStepBody(
      title: 'Medical fitness',
      subtitle: 'A recent fitness certificate and screening report — required before placement.',
      labels: medicalDocumentLabels,
      mapSelector: (data) => data.medicalDocuments,
    );
  }
}

class _UploadStepBody extends ConsumerWidget {
  final String title;
  final String subtitle;
  final Map<String, String> labels;
  final Map<String, String?> Function(NurseSignupData data) mapSelector;

  const _UploadStepBody({
    required this.title,
    required this.subtitle,
    required this.labels,
    required this.mapSelector,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nurseSignupViewModelProvider);
    final notifier = ref.read(nurseSignupViewModelProvider.notifier);
    final target = mapSelector(state.data);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WizardStepHeader(title: title, subtitle: subtitle),
        ...labels.entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: WizardUploadTile(
              label: entry.value,
              fileName: target[entry.key],
              uploading: state.uploadingIds.contains(entry.key),
              onTap: () => notifier.mockUpload(target, entry.key, '${entry.value}.pdf'),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

/// Step 6: consent + info about the mandatory third-party background
/// check.
class PoliceVerificationStep extends ConsumerWidget {
  const PoliceVerificationStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(nurseSignupViewModelProvider).data;
    final notifier = ref.read(nurseSignupViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WizardStepHeader(
          title: 'Police verification',
          subtitle: 'Mandatory for every nurse before your profile is visible to families.',
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.warningSoft,
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.shield_outlined, color: AppColors.warning, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'We run a background check through a third-party verification '
                  'partner using the government ID you uploaded. This usually '
                  'takes 2–4 working days and happens automatically — no extra '
                  'steps needed from you.',
                  style: TextStyle(fontSize: 13, height: 1.4, color: AppColors.ink),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Material(
          color: AppColors.primaryForeground.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            onTap: () {
              data.policeConsent = !data.policeConsent;
              notifier.touch();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryForeground.withValues(alpha: 0.25)),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Row(
                children: [
                  Icon(
                    data.policeConsent ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                    color: data.policeConsent
                        ? AppColors.accent
                        : AppColors.primaryForeground.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'I consent to ALLCURO running a police verification / '
                      'background check on my behalf.',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryForeground),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

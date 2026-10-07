import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/ui/app_shell.dart';
import '../../../core/ui/surface.dart';
import '../../../core/utils/currency.dart';
import '../../auth/presentation/auth_view_model.dart';
import '../../auth/presentation/quick_login_sheet.dart';
import '../../nurses/data/models/nurse.dart';
import '../../nurses/data/nurses_repository.dart';
import '../data/master_services_catalog.dart';
import '../data/services_catalog.dart';

class ServiceDetailScreen extends ConsumerStatefulWidget {
  final String serviceId;

  const ServiceDetailScreen({super.key, required this.serviceId});

  @override
  ConsumerState<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends ConsumerState<ServiceDetailScreen> {
  bool _proceduresExpanded = false;

  // Cached nurses future so it doesn't re-trigger on every rebuild
  Future<List<Nurse>>? _nursesFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nursesFuture ??= ref.read(nursesRepositoryProvider).getAll();
  }

  void _handleBookingGuard(VoidCallback onAuthenticated) {
    final authState = ref.read(authViewModelProvider);
    final isAuthenticated =
        authState.status == AuthStatus.onboarded || authState.status == AuthStatus.authenticated;

    if (isAuthenticated) {
      onAuthenticated();
    } else {
      QuickLoginSheet.show(
        context,
        title: 'Login to Book',
        subtitle: 'Verify your mobile number to proceed with booking',
        onSuccess: onAuthenticated,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final masterService = MasterServicesCatalog.getById(widget.serviceId);
    final fallbackCat =
        ServicesCatalog.getById(widget.serviceId) ?? ServicesCatalog.allServices.first;

    final serviceName = masterService?.name ?? fallbackCat.name;
    final servicePrice = masterService?.price ?? fallbackCat.priceRange;
    final serviceDesc = masterService?.description ?? fallbackCat.description;
    final serviceDuration = masterService?.duration ?? '30–45 min';
    final serviceProfessional = masterService?.professional ?? fallbackCat.requiredDegree;
    final serviceNotes = masterService?.notes;
    final serviceNotIncluded = masterService?.notIncluded;

    final List<String> proceduresList = masterService != null
        ? masterService.includes
            .split(';')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList()
        : fallbackCat.procedures;

    return AppShell(
      currentPath: '/services/${widget.serviceId}',
      bottomBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: const Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    servicePrice,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.ink,
                    ),
                  ),
                  Text(
                    serviceDuration,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.mutedForeground,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  _handleBookingGuard(() {
                    context.push('/nurse-quick-booking');
                  });
                },
                icon: const Icon(Icons.bolt_rounded, size: 18),
                label: const Text(
                  'Book Service',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
      ),
      child: Column(
        children: [
          // -----------------------------------------------------------------
          // 1. HEADER: BACK + TITLE + DESCRIPTION + PROCEDURES ACCORDION
          // -----------------------------------------------------------------
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back row
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          size: 18,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            serviceName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.ink,
                            ),
                          ),
                          Text(
                            '$serviceDuration · $serviceProfessional',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.mutedForeground,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Price badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        servicePrice,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  serviceDesc,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: AppColors.mutedForeground,
                  ),
                ),
                const SizedBox(height: 10),

                // ── Procedures & Inclusions accordion ──────────────────────
                GestureDetector(
                  onTap: () => setState(() => _proceduresExpanded = !_proceduresExpanded),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 15,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 7),
                        const Expanded(
                          child: Text(
                            'What\'s Included in this Visit',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        Icon(
                          _proceduresExpanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                if (_proceduresExpanded) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...proceduresList.map((proc) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 1),
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    size: 13,
                                    color: AppColors.success,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Expanded(
                                  child: Text(
                                    proc,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.ink,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        if (serviceNotIncluded != null &&
                            serviceNotIncluded.isNotEmpty &&
                            serviceNotIncluded != '—') ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.info_outline, size: 14, color: AppColors.mutedForeground),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Excludes: $serviceNotIncluded',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.mutedForeground,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (serviceNotes != null &&
                            serviceNotes.isNotEmpty &&
                            serviceNotes != '—') ...[
                          const SizedBox(height: 6),
                          Text(
                            'Note: $serviceNotes',
                            style: const TextStyle(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                              color: AppColors.mutedForeground,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 10),

                const SizedBox(height: 12),

                // ── Nurse Section Header ────────────────────────────────
                Row(
                  children: [
                    const Icon(
                      Icons.verified_user_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Available Certified Nurses & Clinicians',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: const Text(
                        'Verified · On-Duty',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 2. DIRECT NURSES LIST (No tabs for centres/equipment)
          // -----------------------------------------------------------------
          Expanded(
            child: FutureBuilder<List<Nurse>>(
              future: _nursesFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                final all = snapshot.data!;
                final degreeFilters = fallbackCat.nurseDegreeFilters;
                final filtered = all.where((n) {
                  if (degreeFilters.isEmpty) return true;
                  return degreeFilters.any((f) =>
                      n.level.toLowerCase().contains(f.toLowerCase()) ||
                      n.tags.any((t) => t.toLowerCase().contains(f.toLowerCase())));
                }).toList();
                final nurses = filtered.isNotEmpty ? filtered : all;
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                  physics: const BouncingScrollPhysics(),
                  itemCount: nurses.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, i) => _NurseCard(
                    nurse: nurses[i],
                    onView: () => context.push('/nurses/${nurses[i].id}'),
                    onBookOrSlot: () {
                      _showSlotBookingSheet(context, nurses[i], serviceName);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSlotBookingSheet(BuildContext context, Nurse nurse, String serviceName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _NurseSlotBookingSheet(
        nurse: nurse,
        serviceName: serviceName,
        onProceed: () {
          Navigator.of(sheetContext).pop();
          _handleBookingGuard(() {
            context.push('/nurse-quick-booking');
          });
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NURSE CARD (No fixed price; displays availability & slot selector)
// ─────────────────────────────────────────────────────────────────────────────
class _NurseCard extends StatelessWidget {
  final Nurse nurse;
  final VoidCallback onView;
  final VoidCallback onBookOrSlot;

  const _NurseCard({
    required this.nurse,
    required this.onView,
    required this.onBookOrSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Surface(
      onTap: onBookOrSlot,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar initials
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  nurse.name.trim().split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  nurse.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.5,
                                    color: AppColors.ink,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.verified, color: AppColors.success, size: 14),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 14),
                            const SizedBox(width: 2),
                            Text(
                              nurse.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                                color: AppColors.ink,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${nurse.level} · ${nurse.experience} yrs exp · ${nurse.city}',
                      style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Availability badge and action buttons (No individual fixed price shown!)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Available Today · 30m, 1h, custom',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: onView,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.border),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Profile',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onBookOrSlot,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      elevation: 0,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Book Slot',
                            style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, size: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NURSE DURATION & AVAILABILITY BOOKING SHEET
// ─────────────────────────────────────────────────────────────────────────────
class _NurseSlotBookingSheet extends StatefulWidget {
  final Nurse nurse;
  final String serviceName;
  final VoidCallback onProceed;

  const _NurseSlotBookingSheet({
    required this.nurse,
    required this.serviceName,
    required this.onProceed,
  });

  @override
  State<_NurseSlotBookingSheet> createState() => _NurseSlotBookingSheetState();
}

class _NurseSlotBookingSheetState extends State<_NurseSlotBookingSheet> {
  // '30min', '1hr', '2hr', 'custom'
  String _selectedDuration = '30min';
  int _customHours = 4;
  String _selectedSlot = '⚡ Within 45 mins (Immediate)';

  int _calculatePrice() {
    switch (_selectedDuration) {
      case '30min':
        return 399;
      case '1hr':
        return 699;
      case '2hr':
        return 1199;
      case 'custom':
        if (_customHours == 4) return 1999;
        if (_customHours == 8) return 3499;
        if (_customHours == 12) return 4899;
        if (_customHours == 24) return 8499;
        return _customHours * 450;
      default:
        return 699;
    }
  }

  String _getDurationLabel() {
    switch (_selectedDuration) {
      case '30min':
        return '30 Mins (Quick Procedure)';
      case '1hr':
        return '1 Hour (Standard Visit)';
      case '2hr':
        return '2 Hours (Extended Care)';
      case 'custom':
        return '$_customHours Hours (Bedside Monitoring)';
      default:
        return '1 Hour Visit';
    }
  }

  @override
  Widget build(BuildContext context) {
    final price = _calculatePrice();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Nurse Profile Header
              Row(
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
                      widget.nurse.name
                          .trim()
                          .split(' ')
                          .map((e) => e.isNotEmpty ? e[0] : '')
                          .take(2)
                          .join(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.nurse.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: AppColors.ink,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.verified, color: AppColors.success, size: 14),
                          ],
                        ),
                        Text(
                          '${widget.nurse.level} · ${widget.nurse.experience} yrs exp · ⭐ ${widget.nurse.rating.toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: AppColors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: 14),

              // 1. DURATION SELECTOR
              const Text(
                'Select Visit Duration',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Price dynamically adjusts based on required time and clinical scope',
                style: TextStyle(fontSize: 11, color: AppColors.mutedForeground),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _DurationOptionTile(
                      title: '30 Mins',
                      subtitle: 'Quick Visit',
                      price: '₹399',
                      isSelected: _selectedDuration == '30min',
                      onTap: () => setState(() => _selectedDuration = '30min'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _DurationOptionTile(
                      title: '1 Hour',
                      subtitle: 'Standard Care',
                      price: '₹699',
                      isSelected: _selectedDuration == '1hr',
                      onTap: () => setState(() => _selectedDuration = '1hr'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _DurationOptionTile(
                      title: '2 Hours',
                      subtitle: 'Extended Visit',
                      price: '₹1,199',
                      isSelected: _selectedDuration == '2hr',
                      onTap: () => setState(() => _selectedDuration = '2hr'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _DurationOptionTile(
                      title: 'Custom',
                      subtitle: 'Extended Shifts',
                      price: '₹1,999+',
                      isSelected: _selectedDuration == 'custom',
                      onTap: () => setState(() => _selectedDuration = 'custom'),
                    ),
                  ),
                ],
              ),

              // Custom hours selector if 'custom' is picked
              if (_selectedDuration == 'custom') ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Shift Hours:',
                        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 8),
                      ...[4, 8, 12, 24].map((hours) {
                        final isHSelected = _customHours == hours;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: InkWell(
                            onTap: () => setState(() => _customHours = hours),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                              decoration: BoxDecoration(
                                color: isHSelected ? AppColors.primary : Colors.white,
                                borderRadius: BorderRadius.circular(AppRadius.sm),
                                border: Border.all(
                                  color: isHSelected ? AppColors.primary : AppColors.border,
                                ),
                              ),
                              child: Text(
                                '${hours}h',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: isHSelected ? Colors.white : AppColors.ink,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 16),

              // 2. AVAILABILITY SLOT SELECTOR
              const Text(
                'Preferred Arrival Time',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 8),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  '⚡ Within 45 mins (Immediate)',
                  'Today 2:30 PM',
                  'Today 6:00 PM',
                  'Tomorrow 9:00 AM',
                ].map((slot) {
                  final isSlotSelected = _selectedSlot == slot;
                  return InkWell(
                    onTap: () => setState(() => _selectedSlot = slot),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSlotSelected ? AppColors.primarySoft : Colors.white,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(
                          color: isSlotSelected ? AppColors.primary : AppColors.border,
                          width: isSlotSelected ? 1.4 : 1,
                        ),
                      ),
                      child: Text(
                        slot,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSlotSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSlotSelected ? AppColors.primary : AppColors.ink,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 18),

              // 3. PRICE SUMMARY & CTA
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          inr(price),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          _getDurationLabel(),
                          style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: widget.onProceed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'Confirm & Book',
                            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Duration Option Tile
class _DurationOptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  const _DurationOptionTile({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySoft : Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: isSelected ? AppColors.primary : AppColors.ink,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: isSelected ? AppColors.primary : const Color(0xFF16A34A),
              ),
            ),
            const SizedBox(height: 1),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 8.5,
                color: AppColors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


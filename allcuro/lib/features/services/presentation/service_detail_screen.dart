import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/ui/app_shell.dart';
import '../../../core/ui/surface.dart';
import '../../../core/utils/currency.dart';
import '../../auth/presentation/auth_view_model.dart';
import '../../auth/presentation/quick_login_sheet.dart';
import '../../centres/data/centres_repository.dart';
import '../../centres/data/models/centre.dart';
import '../../equipment/data/equipment_repository.dart';
import '../../equipment/data/models/equipment.dart';
import '../../nurses/data/models/nurse.dart';
import '../../nurses/data/nurses_repository.dart';
import '../data/services_catalog.dart';

class ServiceDetailScreen extends ConsumerStatefulWidget {
  final String serviceId;

  const ServiceDetailScreen({super.key, required this.serviceId});

  @override
  ConsumerState<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends ConsumerState<ServiceDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _proceduresExpanded = false;

  // Cached futures so they don't re-trigger on every rebuild
  Future<List<Nurse>>? _nursesFuture;
  Future<List<Centre>>? _centresFuture;
  Future<List<Equipment>>? _equipmentFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nursesFuture ??= ref.read(nursesRepositoryProvider).getAll();
    _centresFuture ??= ref.read(centresRepositoryProvider).getAll();
    _equipmentFuture ??= ref.read(equipmentRepositoryProvider).getAll();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
    final service =
        ServicesCatalog.getById(widget.serviceId) ?? ServicesCatalog.allServices.first;

    return AppShell(
      currentPath: '/services/${widget.serviceId}',
      showQuickActions: false,
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
                      onTap: () => context.pop(),
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
                      child: Text(
                        service.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    // Price badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        service.priceRange,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  service.description,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: AppColors.mutedForeground,
                  ),
                ),
                const SizedBox(height: 10),

                // ── Procedures accordion ──────────────────────────────────
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
                          Icons.list_alt_rounded,
                          size: 15,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 7),
                        const Expanded(
                          child: Text(
                            'Procedures & Clinical Scope',
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
                      children: service.procedures.map((proc) {
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
                      }).toList(),
                    ),
                  ),
                ],
                const SizedBox(height: 10),

                // ── Tab bar ──────────────────────────────────────────────
                TabBar(
                  controller: _tabController,
                  labelStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
                  unselectedLabelStyle:
                      const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.mutedForeground,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 2.5,
                  tabs: const [Tab(text: 'Nurses'), Tab(text: 'Care Centres'), Tab(text: 'Equipment')],
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // 2. TAB VIEWS
          // -----------------------------------------------------------------
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // ── NURSES ─────────────────────────────────────────────
                FutureBuilder<List<Nurse>>(
                  future: _nursesFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator(color: AppColors.primary));
                    }
                    final all = snapshot.data!;
                    final filtered = all.where((n) {
                      if (service.nurseDegreeFilters.isEmpty) return true;
                      return service.nurseDegreeFilters.any((f) =>
                          n.level.toLowerCase().contains(f.toLowerCase()) ||
                          n.tags.any((t) => t.toLowerCase().contains(f.toLowerCase())));
                    }).toList();
                    final nurses = filtered.isNotEmpty ? filtered : all;
                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                      physics: const BouncingScrollPhysics(),
                      itemCount: nurses.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) => _NurseCard(
                        nurse: nurses[i],
                        onView: () => context.push('/nurses/${nurses[i].id}'),
                        onBook: () =>
                            _handleBookingGuard(() => context.push('/nurse-quick-booking')),
                      ),
                    );
                  },
                ),

                // ── CARE CENTRES ────────────────────────────────────────
                FutureBuilder<List<Centre>>(
                  future: _centresFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator(color: AppColors.primary));
                    }
                    final centres = snapshot.data!;
                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                      physics: const BouncingScrollPhysics(),
                      itemCount: centres.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) => _CentreCard(
                        centre: centres[i],
                        onView: () => context.push('/centres/${centres[i].id}'),
                        onBook: () => _handleBookingGuard(
                            () => context.push('/centre-booking/${centres[i].id}')),
                      ),
                    );
                  },
                ),

                // ── EQUIPMENT ───────────────────────────────────────────
                FutureBuilder<List<Equipment>>(
                  future: _equipmentFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator(color: AppColors.primary));
                    }
                    final equipment = snapshot.data!;
                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                      physics: const BouncingScrollPhysics(),
                      itemCount: equipment.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) => _EquipmentCard(
                        equipment: equipment[i],
                        onRent: () => _handleBookingGuard(() => context.push('/equipment')),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NURSE CARD
// ─────────────────────────────────────────────────────────────────────────────
class _NurseCard extends StatelessWidget {
  final Nurse nurse;
  final VoidCallback onView;
  final VoidCallback onBook;

  const _NurseCard({required this.nurse, required this.onView, required this.onBook});

  @override
  Widget build(BuildContext context) {
    final shiftPrice = nurse.shifts.isNotEmpty ? nurse.shifts.first.price : 600;
    return Surface(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar initials
              Container(
                width: 46,
                height: 46,
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
                                    fontSize: 14,
                                    color: AppColors.ink,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.verified, color: AppColors.success, size: 13),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 13),
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
                    const SizedBox(height: 2),
                    Text(
                      '${nurse.level} · ${nurse.experience} yrs · ${nurse.city}',
                      style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${inr(shiftPrice)} / visit',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
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
                          borderRadius: BorderRadius.circular(AppRadius.md)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Profile', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md)),
                      elevation: 0,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Book Now',
                        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
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
// CENTRE CARD
// ─────────────────────────────────────────────────────────────────────────────
class _CentreCard extends StatelessWidget {
  final Centre centre;
  final VoidCallback onView;
  final VoidCallback onBook;

  const _CentreCard({required this.centre, required this.onView, required this.onBook});

  @override
  Widget build(BuildContext context) {
    return Surface(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                child: const Icon(Icons.apartment_rounded, color: AppColors.primary, size: 22),
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
                          child: Text(
                            centre.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 13),
                            const SizedBox(width: 2),
                            Text(
                              centre.rating.toStringAsFixed(1),
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${centre.type} · ${centre.locality}',
                      style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${inr(centre.pricePerDay)} / day',
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink),
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
                          borderRadius: BorderRadius.circular(AppRadius.md)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Facility',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md)),
                      elevation: 0,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Book Stay',
                        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
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
// EQUIPMENT CARD
// ─────────────────────────────────────────────────────────────────────────────
class _EquipmentCard extends StatelessWidget {
  final Equipment equipment;
  final VoidCallback onRent;

  const _EquipmentCard({required this.equipment, required this.onRent});

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
            decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
            child: const Icon(Icons.inventory_2_outlined, color: AppColors.primary, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  equipment.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13.5,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  '${equipment.category} · ${inr(equipment.perMonth)}/month',
                  style:
                      const TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onRent,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size.zero,
            ),
            child: const Text('Rent', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/ui/app_shell.dart';
import '../../../core/ui/surface.dart';
import '../../../core/utils/currency.dart';
import '../../auth/presentation/auth_view_model.dart';
import '../../auth/presentation/quick_login_sheet.dart';

import '../../centres/data/models/centre.dart';
import '../../nurses/data/models/nurse.dart';
import '../../services/data/models/service_category.dart';
import '../../services/data/services_catalog.dart';
import 'home_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleBookingGuard(VoidCallback onAuthenticated) {
    final authState = ref.read(authViewModelProvider);
    final isAuthenticated = authState.status == AuthStatus.onboarded || authState.status == AuthStatus.authenticated;

    if (isAuthenticated) {
      onAuthenticated();
    } else {
      QuickLoginSheet.show(
        context,
        title: 'Quick Login to Book',
        subtitle: 'Enter your phone number to proceed with verified booking',
        onSuccess: onAuthenticated,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeAsync = ref.watch(homeViewModelProvider);
    final authState = ref.watch(authViewModelProvider);

    final isGuest = authState.status == AuthStatus.unauthenticated || authState.status == AuthStatus.unknown;
    final userName = authState.userProfile['name'] ?? (isGuest ? 'Guest' : 'Customer');
    final initials = isGuest
        ? '👤'
        : (userName.isNotEmpty ? userName.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join() : 'AC');


    final allServices = ServicesCatalog.allServices;
    final filteredServices = _searchQuery.isEmpty
        ? allServices
        : allServices.where((s) =>
            s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            s.shortName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            s.procedures.any((p) => p.toLowerCase().contains(_searchQuery.toLowerCase()))).toList();

    return AppShell(
      currentPath: '/',
      initials: initials,
      timeStatus: 'Instant Care Active · 45m',
      onProfileTap: () {
        if (isGuest) {
          QuickLoginSheet.show(
            context,
            title: 'Welcome to ALLCURO',
            subtitle: 'Log in to view your profile and saved bookings',
            onSuccess: () => context.go('/profile'),
          );
        } else {
          context.go('/profile');
        }
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          // -----------------------------------------------------------------
          // 1. TOP SEARCH BAR (Clean, modern, prominent)
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val.trim()),
                decoration: InputDecoration(
                  hintText: 'Search injections, wound dressing, nurses, ICU beds...',
                  hintStyle: const TextStyle(fontSize: 12.5, color: AppColors.mutedForeground),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.mutedForeground, size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18, color: AppColors.mutedForeground),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : Container(
                          margin: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
                          child: const Icon(Icons.tune_rounded, size: 15, color: AppColors.ink),
                        ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 13),
                ),
              ),
            ),
          ),

          if (_searchQuery.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
              child: Text(
                'Matching Services (${filteredServices.length})',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.74,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 4,
                ),
                itemCount: filteredServices.length,
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  return _ServiceCubeTile(
                    service: service,
                    onTap: () {
                      if (service.id == 'quick-care') {
                        _handleBookingGuard(() => context.push('/nurse-quick-booking'));
                      } else if (service.id == 'care-centres') {
                        context.push('/centres');
                      } else if (service.id == 'equipment-rental') {
                        context.push('/equipment');
                      } else if (service.id == 'doctor-visit') {
                        context.push('/nurses');
                      } else {
                        context.push('/services/${service.id}');
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ] else ...[
            // -----------------------------------------------------------------
            // 2. OUR NURSE CARE (8 Grid Items: 7 Clinical + 8th See All)
            // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
            child: const Text(
              'Our Nurse Care',
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                color: AppColors.ink,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              childAspectRatio: 0.74,
              crossAxisSpacing: 8,
              mainAxisSpacing: 6,
              children: [
                _HomeGridItem(
                  title: 'Catheter Care',
                  icon: Icons.medical_services_rounded,
                  iconColor: const Color(0xFF7C3AED),
                  iconBg: const Color(0xFFEDE9FE),
                  imageAsset: 'assets/images/services/catheter_care.jpg',
                  onTap: () => context.push('/nurse-services'),
                ),
                _HomeGridItem(
                  title: 'Ryles Tube',
                  icon: Icons.medication_liquid_rounded,
                  iconColor: const Color(0xFFEA580C),
                  iconBg: const Color(0xFFFFEDD5),
                  imageAsset: 'assets/images/services/ryles_tube.jpg',
                  onTap: () => context.push('/nurse-services'),
                ),
                _HomeGridItem(
                  title: 'Wound Dressing',
                  icon: Icons.healing_rounded,
                  iconColor: const Color(0xFF0D9488),
                  iconBg: const Color(0xFFCCFBF1),
                  imageAsset: 'assets/images/services/wound_dressing.jpg',
                  onTap: () => context.push('/nurse-services'),
                ),
                _HomeGridItem(
                  title: 'Injection',
                  icon: Icons.vaccines_rounded,
                  iconColor: const Color(0xFF2563EB),
                  iconBg: const Color(0xFFDBEAFE),
                  imageAsset: 'assets/images/services/injection.jpg',
                  onTap: () => context.push('/nurse-services'),
                ),
                _HomeGridItem(
                  title: 'IV Care',
                  icon: Icons.water_drop_rounded,
                  iconColor: const Color(0xFF0284C7),
                  iconBg: const Color(0xFFE0F2FE),
                  imageAsset: 'assets/images/services/iv_care.jpg',
                  onTap: () => context.push('/nurse-services'),
                ),
                _HomeGridItem(
                  title: 'Tracheostomy',
                  icon: Icons.masks_rounded,
                  iconColor: const Color(0xFFDC2626),
                  iconBg: const Color(0xFFFEE2E2),
                  imageAsset: 'assets/images/services/tracheostomy.jpg',
                  onTap: () => context.push('/nurse-services'),
                ),
                _HomeGridItem(
                  title: 'Vital Monitoring',
                  icon: Icons.monitor_heart_rounded,
                  iconColor: const Color(0xFFE11D48),
                  iconBg: const Color(0xFFFFE4E6),
                  imageAsset: 'assets/images/services/vital_monitoring.jpg',
                  onTap: () => context.push('/nurse-services'),
                ),
                _HomeGridItem(
                  title: 'See All',
                  icon: Icons.grid_view_rounded,
                  iconColor: AppColors.primary,
                  iconBg: AppColors.primarySoft,
                  imageAsset: 'assets/images/services/see_all.jpg',
                  isSeeAll: true,
                  onTap: () => context.push('/nurse-services'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // -----------------------------------------------------------------
          // 3. QUICK 45-MIN CARE PROMO BANNER
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                _handleBookingGuard(() => context.push('/nurse-quick-booking'));
              },
              borderRadius: BorderRadius.circular(AppRadius.xl),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F766E), Color(0xFF134E4A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F766E).withValues(alpha: 0.25),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                      ),
                      child: const Icon(Icons.bolt_rounded, size: 28, color: Color(0xFFFDE047)),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Need a Nurse in 45 Mins?',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward_rounded, size: 14, color: Colors.white),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Emergency injections, dressing & vitals check at your doorstep',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFFCCFBF1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          // -----------------------------------------------------------------
          // 4. HEALTHCARE SERVICES (Nursing Services, Care Centres, Equipments, Physio, Doctor, Elder, Baby/Mother, Physio Rehab)
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'HealthCare Services',
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                    color: AppColors.ink,
                  ),
                ),
                InkWell(
                  onTap: () => context.push('/nurse-services'),
                  child: const Text(
                    'View all ➔',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              childAspectRatio: 0.74,
              crossAxisSpacing: 8,
              mainAxisSpacing: 6,
              children: [
                // 1. Nursing Services
                _HomeGridItem(
                  title: 'Nursing Services',
                  icon: Icons.medical_services_rounded,
                  iconColor: const Color(0xFF0F766E),
                  iconBg: const Color(0xFFCCFBF1),
                  imageAsset: 'assets/images/services/nursing_services.jpg',
                  badgeText: 'All List',
                  onTap: () => context.push('/nurse-services'),
                ),
                // 2. Care Centres (2nd Position as requested)
                _HomeGridItem(
                  title: 'Care Centres',
                  icon: Icons.apartment_rounded,
                  iconColor: const Color(0xFF0284C7),
                  iconBg: const Color(0xFFE0F2FE),
                  imageAsset: 'assets/images/services/care_centres.jpg',
                  onTap: () => context.push('/centres'),
                ),
                // 3. Equipment’s (3rd Position as requested)
                _HomeGridItem(
                  title: 'Equipment’s',
                  icon: Icons.wheelchair_pickup_rounded,
                  iconColor: const Color(0xFF16A34A),
                  iconBg: const Color(0xFFDCFCE7),
                  imageAsset: 'assets/images/services/equipment.jpg',
                  onTap: () => context.push('/equipment'),
                ),
                // 4. Physiotherapy
                _HomeGridItem(
                  title: 'Physiotherapy',
                  icon: Icons.accessibility_new_rounded,
                  iconColor: const Color(0xFF4F46E5),
                  iconBg: const Color(0xFFE0E7FF),
                  imageAsset: 'assets/images/services/physiotherapy.jpg',
                  onTap: () => context.push('/services/physiotherapy'),
                ),
                // 5. Doctor Visit
                _HomeGridItem(
                  title: 'Doctor Visit',
                  icon: Icons.medical_information_rounded,
                  iconColor: const Color(0xFF9333EA),
                  iconBg: const Color(0xFFF3E8FF),
                  imageAsset: 'assets/images/services/doctor_visit.jpg',
                  onTap: () => context.push('/services/doctor-visit'),
                ),
                // 6. Elder Care
                _HomeGridItem(
                  title: 'Elder Care',
                  icon: Icons.elderly_rounded,
                  iconColor: const Color(0xFFD97706),
                  iconBg: const Color(0xFFFEF3C7),
                  onTap: () => context.push('/services/elderly-attendant'),
                ),
                // 7. Baby / Mother
                _HomeGridItem(
                  title: 'Baby / Mother',
                  icon: Icons.child_care_rounded,
                  iconColor: const Color(0xFFDB2777),
                  iconBg: const Color(0xFFFCE7F3),
                  onTap: () => context.push('/services/maternal-baby'),
                ),
                // 8. Physio Services
                _HomeGridItem(
                  title: 'Physio Services',
                  icon: Icons.fitness_center_rounded,
                  iconColor: const Color(0xFF2563EB),
                  iconBg: const Color(0xFFDBEAFE),
                  imageAsset: 'assets/images/services/physiotherapy.jpg',
                  onTap: () => context.push('/services/physiotherapy'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // -----------------------------------------------------------------
          // 5. BANNER: EXPLORE OUR HEALTH CARE CENTRES
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () => context.push('/centres'),
              borderRadius: BorderRadius.circular(AppRadius.xl),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF075985), Color(0xFF0369A1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF075985).withValues(alpha: 0.25),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                          ),
                          child: const Icon(Icons.apartment_rounded, size: 26, color: Colors.white),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Explore Health Care Centres',
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(Icons.arrow_forward_rounded, size: 14, color: Colors.white),
                                ],
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Audited 24/7 ICU step-down, rehab & senior living centres',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFFE0F2FE),
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: const Text(
                            '✓ Field Audited',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: const Text(
                            '✓ 1:3 Nurse Ratio',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: const Text(
                            '✓ Doctor on Call',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],

        const SizedBox(height: 24),

          // -----------------------------------------------------------------
          // 5. TOP VERIFIED NURSES (Curated Section with Degree Badges)
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top Verified Nurses',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
                    ),
                    Text(
                      'Degree certified · Police checked · HPR verified',
                      style: TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => context.push('/nurses'),
                  child: const Text(
                    'View all ➔',
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),

          homeAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
            ),
            error: (err, _) => Center(child: Text('Error: $err')),
            data: (homeData) {
              final nurses = homeData.nurses;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: nurses.take(3).map((nurse) {
                    return _NurseCardUrban(
                      nurse: nurse,
                      onBook: () {
                        _handleBookingGuard(() => context.push('/nurse-quick-booking'));
                      },
                      onView: () => context.push('/nurses/${nurse.id}'),
                    );
                  }).toList(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // -----------------------------------------------------------------
          // 6. TOP HOME CARE CENTRES (Curated Section)
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Audited Home Care Centres',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
                    ),
                    Text(
                      '24/7 ICU step-down, elderly care & rehab beds',
                      style: TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => context.push('/centres'),
                  child: const Text(
                    'View all ➔',
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),

          homeAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
            data: (homeData) {
              final centres = homeData.centres;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: centres.take(2).map((centre) {
                    return _CentreCardUrban(
                      centre: centre,
                      onBook: () {
                        _handleBookingGuard(() => context.push('/centre-booking/${centre.id}'));
                      },
                      onView: () => context.push('/centres/${centre.id}'),
                    );
                  }).toList(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // -----------------------------------------------------------------
          // 7. MEDICAL EQUIPMENT RENTALS
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medical Equipment On-Rent',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
                    ),
                    Text(
                      'Hospital beds, 5L oxygen concentrators & BiPAP',
                      style: TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => context.push('/equipment'),
                  child: const Text(
                    'View all ➔',
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _EquipmentCardUrban(
                  title: 'Philips EverFlo 5L Oxygen Concentrator',
                  category: 'Respiratory · 93% Oxygen Purity',
                  monthlyPrice: 4500,
                  badge: 'Sterilised Delivery',
                  onRent: () {
                    _handleBookingGuard(() => context.push('/equipment'));
                  },
                ),
                const SizedBox(height: 10),
                _EquipmentCardUrban(
                  title: 'Motorized 5-Function ICU Hospital Bed',
                  category: 'Hospital Bed with Air Mattress',
                  monthlyPrice: 6500,
                  badge: 'Express Dispatch',
                  onRent: () {
                    _handleBookingGuard(() => context.push('/equipment'));
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // -----------------------------------------------------------------
          // 8. ALLCURO BRANDING, ICON & TRUST FOOTER (At the Bottom of App)
          // -----------------------------------------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              border: const Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              children: [
                // ALLCURO Icon & Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: const Icon(
                        Icons.monitor_heart_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'ALLCURO',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Healthcare, Made Simple.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mutedForeground,
                  ),
                ),
                const SizedBox(height: 20),

                // Trust Grid Badges
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _TrustBadgeItem(
                      icon: Icons.verified_user_rounded,
                      title: '100% Verified',
                      subtitle: 'HPR & Background Checked',
                    ),
                    _TrustBadgeItem(
                      icon: Icons.apartment_rounded,
                      title: 'Audited Centres',
                      subtitle: 'Quality Inspected',
                    ),
                    _TrustBadgeItem(
                      icon: Icons.support_agent_rounded,
                      title: '24/7 Clinical Desk',
                      subtitle: 'Emergency Support',
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const Divider(color: AppColors.border, height: 1),
                const SizedBox(height: 14),

                Text(
                  '© 2026 ALLCURO Healthcare Technologies Pvt. Ltd.\nAyushman Bharat Digital Mission (ABDM) Compliant Partner',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.5,
                    color: AppColors.mutedForeground.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// HOME GRID ITEM (Nurse Care & Healthcare Services Grid)
// ---------------------------------------------------------------------------
class _HomeGridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback onTap;
  final bool isSeeAll;
  final String? badgeText;
  final String? imageAsset;

  const _HomeGridItem({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.onTap,
    this.isSeeAll = false,
    this.badgeText,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withValues(alpha: 0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: iconColor.withValues(alpha: isSeeAll ? 0.5 : 0.2),
                    width: isSeeAll ? 1.5 : 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.lg - 1),
                  child: imageAsset != null
                      ? Image.asset(
                          imageAsset!,
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                          errorBuilder: (_, _, _) => Icon(
                            icon,
                            size: isSeeAll ? 26 : 28,
                            color: iconColor,
                          ),
                        )
                      : Icon(
                          icon,
                          size: isSeeAll ? 26 : 28,
                          color: iconColor,
                        ),
                ),
              ),
              if (badgeText != null)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      badgeText!,
                      style: const TextStyle(
                        fontSize: 7.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSeeAll ? FontWeight.w900 : FontWeight.w700,
              height: 1.15,
              color: isSeeAll ? AppColors.primary : AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SERVICE CUBE TILE COMPONENT (Urban Company Style)
// ---------------------------------------------------------------------------
class _ServiceCubeTile extends StatelessWidget {
  final ServiceCategory service;
  final VoidCallback onTap;

  const _ServiceCubeTile({required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cube Icon Container
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 62,
                height: 62,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: service.iconBgColor,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: service.iconColor.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Icon(
                  service.icon,
                  size: 28,
                  color: service.iconColor,
                ),
              ),
              // Micro Badge for special services (e.g. ⚡ 45m)
              if (service.group == ServiceGroup.instant)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE11D48),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: const Text(
                      '⚡ 45m',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            service.shortName,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              height: 1.15,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TOP NURSE CARD COMPONENT (With Degree Tagging)
// ---------------------------------------------------------------------------
class _NurseCardUrban extends StatelessWidget {
  final Nurse nurse;
  final VoidCallback onBook;
  final VoidCallback onView;

  const _NurseCardUrban({
    required this.nurse,
    required this.onBook,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final shiftPrice = nurse.shifts.isNotEmpty ? nurse.shifts.first.price : 600;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Surface(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Nurse Avatar
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    nurse.name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join(),
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.primary),
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
                          Row(
                            children: [
                              Text(
                                nurse.name,
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.ink),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.verified, color: AppColors.success, size: 14),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 15),
                              const SizedBox(width: 2),
                              Text(
                                '${nurse.rating}',
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: AppColors.ink),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: AppColors.primarySoft,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              nurse.level,
                              style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: AppColors.primary),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${nurse.experience} yrs exp · ${nurse.city}',
                            style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                          ),
                        ],
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
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink),
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: onView,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
                      ),
                      child: const Text('View Profile', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: onBook,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
                        elevation: 0,
                      ),
                      child: const Text('Book Now', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CENTRE CARD COMPONENT
// ---------------------------------------------------------------------------
class _CentreCardUrban extends StatelessWidget {
  final Centre centre;
  final VoidCallback onBook;
  final VoidCallback onView;

  const _CentreCardUrban({
    required this.centre,
    required this.onBook,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Surface(
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
                  decoration: const BoxDecoration(color: AppColors.primarySoft, shape: BoxShape.circle),
                  child: const Icon(Icons.apartment_rounded, color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            centre.name,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: AppColors.ink),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 15),
                              const SizedBox(width: 2),
                              Text('${centre.rating}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${centre.locality} · ${centre.staffRatio} Nurse Ratio',
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
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink),
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: onView,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
                      ),
                      child: const Text('Facility Tour', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: onBook,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
                        elevation: 0,
                      ),
                      child: const Text('Book Stay', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// EQUIPMENT CARD COMPONENT
// ---------------------------------------------------------------------------
class _EquipmentCardUrban extends StatelessWidget {
  final String title;
  final String category;
  final int monthlyPrice;
  final String badge;
  final VoidCallback onRent;

  const _EquipmentCardUrban({
    required this.title,
    required this.category,
    required this.monthlyPrice,
    required this.badge,
    required this.onRent,
  });

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
            child: const Icon(Icons.inventory_2_outlined, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.ink)),
                const SizedBox(height: 2),
                Text('$category · ${inr(monthlyPrice)}/mo', style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onRent,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
              elevation: 0,
            ),
            child: const Text('Rent', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TRUST BADGE FOOTER ITEM
// ---------------------------------------------------------------------------
class _TrustBadgeItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _TrustBadgeItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 22, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.ink)),
        Text(subtitle, style: const TextStyle(fontSize: 9.5, color: AppColors.mutedForeground)),
      ],
    );
  }
}

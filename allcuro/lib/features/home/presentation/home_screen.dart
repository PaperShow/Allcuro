import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/ui/app_shell.dart';
import '../../auth/presentation/auth_view_model.dart';
import '../../auth/presentation/quick_login_sheet.dart';

import '../../services/data/master_services_catalog.dart';

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

  void _showAdvisorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFED6C00).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(
                    Icons.support_agent_rounded,
                    color: Color(0xFFED6C00),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Clinical Advisory & Help Desk',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                      Text(
                        'Speak with an ALLCURO Care Coordinator',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7ED),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: const Color(0xFFFED7AA)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.verified_outlined, color: Color(0xFFED6C00), size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Our medical team helps you select the exact clinician, shift duration, or medical care required for your loved one.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7C2D12),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            InkWell(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Connecting to ALLCURO Clinical Helpline (+91 1800-ALLCURO)...'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.phone_in_talk_rounded, color: Colors.white, size: 22),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Call Clinical Coordinator Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '24/7 Free Consultation · Instant Response',
                            style: TextStyle(
                              color: Color(0xFFD1FAE5),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 14),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening WhatsApp chat with Care Advisory team...'),
                    backgroundColor: Color(0xFF25D366),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: const Color(0xFFBBF7D0)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF16A34A), size: 22),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chat on WhatsApp',
                            style: TextStyle(
                              color: Color(0xFF14532D),
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Send prescription or question · Replies in 5 mins',
                            style: TextStyle(
                              color: Color(0xFF16A34A),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF16A34A), size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    final isGuest = authState.status == AuthStatus.unauthenticated || authState.status == AuthStatus.unknown;
    final userName = authState.userProfile['name'] ?? (isGuest ? 'Guest' : 'Customer');
    final initials = isGuest
        ? '👤'
        : (userName.isNotEmpty ? userName.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join() : 'AC');


    final matchingMasterServices = _searchQuery.isEmpty
        ? <MasterServiceItem>[]
        : MasterServicesCatalog.allServices.where((s) =>
            s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            s.mainCategory.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            s.subcategory.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            s.includes.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return AppShell(
      currentPath: '/',
      initials: initials,
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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
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
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
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
                'Matching Services (${matchingMasterServices.length})',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink),
              ),
            ),
            if (matchingMasterServices.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Center(
                  child: Text(
                    'No services found matching your search',
                    style: TextStyle(color: AppColors.mutedForeground, fontSize: 13),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: matchingMasterServices.length,
                  itemBuilder: (context, index) {
                    final service = matchingMasterServices[index];
                    return _HomeGridItem(
                      title: service.name,
                      imageAsset: service.imageAsset,
                      icon: service.icon,
                      onTap: () => context.push('/services/${service.id}'),
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
          ] else ...[
            // -----------------------------------------------------------------
            // 2. HEALTHCARE SERVICES (Nursing, Mother/Baby, Elder, Physio, Doctor, Centres, Equipments, See All)
            // -----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
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
                    onTap: () => context.push('/category-services/all'),
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
                childAspectRatio: 0.70,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
                children: [
                  // 1. Nursing Services
                  _HomeGridItem(
                    title: 'Nursing Services',
                    imageAsset: 'assets/images/services/nursing_services.jpg',
                    icon: Icons.medical_services_rounded,
                    onTap: () => context.push('/category-services/nursing'),
                  ),
                  // 2. Mother & Baby Care
                  _HomeGridItem(
                    title: 'Mother & Baby',
                    imageAsset: 'assets/images/services/baby_care.jpg',
                    icon: Icons.child_care_rounded,
                    onTap: () => context.push('/category-services/mother-baby'),
                  ),
                  // 3. Elder Care
                  _HomeGridItem(
                    title: 'Elder Care',
                    icon: Icons.elderly_rounded,
                    onTap: () => context.push('/category-services/elder-care'),
                  ),
                  // 4. Physiotherapy
                  _HomeGridItem(
                    title: 'Physiotherapy',
                    imageAsset: 'assets/images/services/physiotherapy.jpg',
                    icon: Icons.accessibility_new_rounded,
                    onTap: () => context.push('/category-services/physiotherapy'),
                  ),
                  // 5. Doctor Visit
                  _HomeGridItem(
                    title: 'Doctor Visit',
                    imageAsset: 'assets/images/services/doctor_visit.jpg',
                    icon: Icons.medical_information_rounded,
                    onTap: () => context.push('/category-services/doctor-care'),
                  ),
                  // 6. Care Centres
                  _HomeGridItem(
                    title: 'Care Centres',
                    imageAsset: 'assets/images/services/care_centres.jpg',
                    icon: Icons.apartment_rounded,
                    onTap: () => context.push('/centres'),
                  ),
                  // 7. Caregivers
                  _HomeGridItem(
                    title: 'Caregivers',
                    icon: Icons.volunteer_activism_rounded,
                    onTap: () => context.push('/category-services/caregiver'),
                  ),
                  // 8. See All
                  _HomeGridItem(
                    title: 'See All',
                    icon: Icons.grid_view_rounded,
                    isSeeAll: true,
                    onTap: () => context.push('/category-services/all'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // -----------------------------------------------------------------
            // 3. QUICK 45-MIN CARE PROMO BANNER (Minimal & Reduced Height)
            // -----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  _handleBookingGuard(() => context.push('/nurse-quick-booking'));
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0F766E), Color(0xFF115E59)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0F766E).withValues(alpha: 0.16),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryAccent.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.secondaryAccent.withValues(alpha: 0.5)),
                        ),
                        child: const Icon(Icons.bolt_rounded, size: 22, color: AppColors.secondaryAccent),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Need a Nurse in 45 Mins?',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryAccent,
                                    borderRadius: BorderRadius.circular(AppRadius.pill),
                                  ),
                                  child: const Text(
                                    'EXPRESS',
                                    style: TextStyle(
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Emergency injections, dressing & vitals check at doorstep',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFFCCFBF1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_forward_rounded, size: 13, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // -----------------------------------------------------------------
            // 4. OUR NURSE CARE (8 Grid Items: 7 Clinical + 8th See All)
            // -----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Our Nurse Care',
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                      color: AppColors.ink,
                    ),
                  ),
                  InkWell(
                    onTap: () => context.push('/category-services/nursing'),
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
                childAspectRatio: 0.70,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
                children: [
                  _HomeGridItem(
                    title: 'Catheter Care',
                    imageAsset: 'assets/images/services/catheter_care.jpg',
                    icon: Icons.medical_services_rounded,
                    onTap: () => context.push('/services/catheter-care'),
                  ),
                  _HomeGridItem(
                    title: 'Ryles Tube',
                    imageAsset: 'assets/images/services/ryles_tube.jpg',
                    icon: Icons.medication_liquid_rounded,
                    onTap: () => context.push('/services/ryle-s-tube-care'),
                  ),
                  _HomeGridItem(
                    title: 'Wound Dressing',
                    imageAsset: 'assets/images/services/wound_dressing.jpg',
                    icon: Icons.healing_rounded,
                    onTap: () => context.push('/services/wound-dressing'),
                  ),
                  _HomeGridItem(
                    title: 'Injection',
                    imageAsset: 'assets/images/services/injection.jpg',
                    icon: Icons.vaccines_rounded,
                    onTap: () => context.push('/services/injection-administration'),
                  ),
                  _HomeGridItem(
                    title: 'IV Care',
                    imageAsset: 'assets/images/services/iv_care.jpg',
                    icon: Icons.water_drop_rounded,
                    onTap: () => context.push('/services/iv-medication-administration'),
                  ),
                  _HomeGridItem(
                    title: 'Tracheostomy',
                    imageAsset: 'assets/images/services/tracheostomy.jpg',
                    icon: Icons.masks_rounded,
                    onTap: () => context.push('/services/tracheostomy-care'),
                  ),
                  _HomeGridItem(
                    title: 'Vital Monitoring',
                    imageAsset: 'assets/images/services/vital_monitoring.jpg',
                    icon: Icons.monitor_heart_rounded,
                    onTap: () => context.push('/services/vital-signs-check'),
                  ),
                  _HomeGridItem(
                    title: 'See All',
                    icon: Icons.grid_view_rounded,
                    isSeeAll: true,
                    onTap: () => context.push('/category-services/nursing'),
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

          // 4b. TALK TO OUR TEAM ADVISORY BANNER (Directly below Explore Health Care Centres)
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              onTap: () => _showAdvisorySheet(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFF7ED),
                      Color(0xFFFFEDD5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: const Color(0xFFFED7AA),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFED6C00).withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFED6C00),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFED6C00).withValues(alpha: 0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.support_agent_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Talk to Our Team',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF9A3412),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFED6C00),
                                  borderRadius: BorderRadius.circular(AppRadius.pill),
                                ),
                                child: const Text(
                                  'FREE',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Need advice or help choosing care? Speak with our clinical coordinators.',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFF7C2D12),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: const Color(0xFFED6C00).withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13,
                        color: Color(0xFFED6C00),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // -----------------------------------------------------------------
          // 5. POPULAR QUICK PROCEDURES AT HOME (30-Min & Hourly Direct Care)
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
                      'Popular Procedures at Home',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
                    ),
                    Text(
                      '30m & 1h visits · Sterile kits · Fast arrival',
                      style: TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => context.push('/category-services/nursing'),
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
                Row(
                  children: [
                    Expanded(
                      child: _QuickProcedureCard(
                        title: 'Injection & IV Care',
                        duration: '30 Mins',
                        icon: Icons.vaccines_rounded,
                        tag: 'Quick Visit',
                        onTap: () => context.push('/category-services/nursing'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _QuickProcedureCard(
                        title: 'Wound Dressing',
                        duration: '45 Mins',
                        icon: Icons.healing_rounded,
                        tag: 'Post-Op / Bedsores',
                        onTap: () => context.push('/category-services/nursing'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _QuickProcedureCard(
                        title: 'Catheter / Tube Care',
                        duration: '45 Mins',
                        icon: Icons.medical_services_rounded,
                        tag: 'Sterile Care',
                        onTap: () => context.push('/category-services/nursing'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _QuickProcedureCard(
                        title: 'Elderly Caregiver',
                        duration: '1h / Custom Shift',
                        icon: Icons.volunteer_activism_rounded,
                        tag: 'Daily Assistance',
                        onTap: () => context.push('/category-services/caregiver'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // -----------------------------------------------------------------
          // 6. HOW HOME CARE WORKS (3 Simple Steps)
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'How Home Care Works',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
                ),
                Text(
                  'Hospital-standard medical attention in 3 simple steps',
                  style: TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  _HowItWorksStep(
                    stepNumber: '1',
                    title: 'Select Service & Duration',
                    subtitle: 'Choose between 30-min quick visits, hourly attention, or full 12/24-hour shifts.',
                    icon: Icons.timer_outlined,
                  ),
                  Divider(height: 24, thickness: 0.8),
                  _HowItWorksStep(
                    stepNumber: '2',
                    title: 'Verified Clinician Assigned',
                    subtitle: 'Degree-certified, police-verified nurse or caregiver arrives at your doorstep.',
                    icon: Icons.verified_user_outlined,
                  ),
                  Divider(height: 24, thickness: 0.8),
                  _HowItWorksStep(
                    stepNumber: '3',
                    title: 'Supervised Care at Home',
                    subtitle: 'Real-time vitals logging and 24/7 senior medical supervisor support.',
                    icon: Icons.health_and_safety_outlined,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // -----------------------------------------------------------------
          // 7. WHY FAMILIES TRUST ALLCURO (Trust & Safety Guarantees)
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Why Families Trust ALLCURO',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
                ),
                Text(
                  'Clinical excellence, patient dignity, and rigorous safety protocols',
                  style: TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: const [
                Row(
                  children: [
                    Expanded(
                      child: _WhyTrustCard(
                        icon: Icons.shield_rounded,
                        iconColor: Color(0xFF10B981),
                        title: '100% Verified',
                        subtitle: 'Police & State Nursing Council verified credentials',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _WhyTrustCard(
                        icon: Icons.access_time_filled_rounded,
                        iconColor: Color(0xFF0284C7),
                        title: 'Flexible Slots',
                        subtitle: '30 min quick care, custom hours, or full shifts',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _WhyTrustCard(
                        icon: Icons.payments_rounded,
                        iconColor: Color(0xFFED6C00),
                        title: 'Transparent Pricing',
                        subtitle: 'Standardized rates with zero hidden hospital markups',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _WhyTrustCard(
                        icon: Icons.medical_services_rounded,
                        iconColor: Color(0xFF8B5CF6),
                        title: 'Clinical Oversight',
                        subtitle: 'Continuous doctor & nursing supervisor on call',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // -----------------------------------------------------------------
          // 8. FREQUENTLY ASKED QUESTIONS
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Frequently Asked Questions',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
                ),
                Text(
                  'Everything you need to know about home health care',
                  style: TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: const [
                _FaqTile(
                  question: 'Can I book a nurse for just 30 minutes?',
                  answer: 'Yes! For procedures like IV injections, wound dressing, or catheterization, you can book a 30-minute or 45-minute quick visit without paying for a full shift.',
                ),
                SizedBox(height: 8),
                _FaqTile(
                  question: 'How quickly can a clinician reach my home?',
                  answer: 'Our verified clinicians are stationed across primary city sectors. For urgent requirements, an available clinician can reach your doorstep within 45 to 60 minutes.',
                ),
                SizedBox(height: 8),
                _FaqTile(
                  question: 'Are caregivers different from registered nurses?',
                  answer: 'Yes. Registered nurses hold B.Sc or GNM degrees for clinical procedures, injections, and post-op care. Caregivers assist with daily living activities, mobility, and companionship.',
                ),
                SizedBox(height: 8),
                _FaqTile(
                  question: 'Can I replace or reschedule if needed?',
                  answer: 'Yes. You can reschedule easily or request clinician replacement through our 24/7 care support desk with zero penalty.',
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
  final IconData? icon;
  final VoidCallback onTap;
  final bool isSeeAll;
  final String? imageAsset;

  const _HomeGridItem({
    required this.title,
    this.icon,
    required this.onTap,
    this.isSeeAll = false,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 68,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSeeAll ? AppColors.primary.withValues(alpha: 0.35) : const Color(0xFFE5E7EB),
                width: isSeeAll ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 5,
                  offset: const Offset(0, 1.5),
                ),
              ],
            ),
            child: Center(
              child: imageAsset != null
                  ? Image.asset(
                      imageAsset!,
                      fit: BoxFit.contain,
                      cacheWidth: 150,
                      cacheHeight: 150,
                      filterQuality: FilterQuality.medium,
                      errorBuilder: (_, _, _) => Icon(
                        icon ?? Icons.medical_services_rounded,
                        size: isSeeAll ? 26 : 28,
                        color: isSeeAll ? AppColors.primary : const Color(0xFF475569),
                      ),
                    )
                  : Icon(
                      icon ?? Icons.medical_services_rounded,
                      size: isSeeAll ? 26 : 28,
                      color: isSeeAll ? AppColors.primary : const Color(0xFF475569),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: isSeeAll ? FontWeight.w700 : FontWeight.w500,
              height: 1.18,
              color: isSeeAll ? AppColors.primary : const Color(0xFF1E293B),
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}


// ---------------------------------------------------------------------------
// QUICK PROCEDURE CARD
// ---------------------------------------------------------------------------
class _QuickProcedureCard extends StatelessWidget {
  final String title;
  final String duration;
  final IconData icon;
  final String tag;
  final VoidCallback onTap;

  const _QuickProcedureCard({
    required this.title,
    required this.duration,
    required this.icon,
    required this.tag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              tag,
              style: const TextStyle(
                fontSize: 10.5,
                color: AppColors.mutedForeground,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// HOW IT WORKS STEP
// ---------------------------------------------------------------------------
class _HowItWorksStep extends StatelessWidget {
  final String stepNumber;
  final String title;
  final String subtitle;
  final IconData icon;

  const _HowItWorksStep({
    required this.stepNumber,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Text(
            stepNumber,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
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
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.mutedForeground,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// WHY TRUST US CARD
// ---------------------------------------------------------------------------
class _WhyTrustCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _WhyTrustCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10.5,
              color: AppColors.mutedForeground,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// FAQ EXPANDABLE TILE
// ---------------------------------------------------------------------------
class _FaqTile extends StatefulWidget {
  final String question;
  final String answer;

  const _FaqTile({
    required this.question,
    required this.answer,
  });

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: AppColors.mutedForeground,
                  ),
                ],
              ),
              if (_expanded) ...[
                const SizedBox(height: 8),
                Text(
                  widget.answer,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF475569),
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
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

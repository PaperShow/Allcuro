import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/ui/app_shell.dart';
import '../../../core/ui/surface.dart';
import '../../../core/utils/currency.dart';
import '../../bookings/data/models/booking.dart';
import '../../bookings/presentation/bookings_view_model.dart';
import '../../centres/data/models/centre.dart';
import '../../nurses/data/models/nurse.dart';
import 'home_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedFilterTab = 0; // 0: All, 1: Nurses, 2: Centres, 3: Equipment
  String _selectedSubCategory = 'All';

  final List<({String title, IconData icon})> _filterTabs = const [
    (title: 'All Listings', icon: Icons.auto_awesome_mosaic_rounded),
    (title: 'Nurses', icon: Icons.medical_services_rounded),
    (title: 'Care Centres', icon: Icons.apartment_rounded),
    (title: 'Equipment', icon: Icons.wheelchair_pickup_rounded),
  ];

  List<String> _getSubCategories() {
    switch (_selectedFilterTab) {
      case 1:
        return const ['All', 'GNM Staff', 'ANM Nurse', 'Critical Care / ICU', 'Physio Attendant', '24x7 Live-in'];
      case 2:
        return const ['All', 'Elderly Homes', 'Rehabilitation', 'Dementia Care', 'Palliative Care', 'Day Care'];
      case 3:
        return const ['All', 'Oxygen Concentrators', 'Hospital Beds', 'Wheelchairs', 'BiPAP / CPAP'];
      default:
        return const ['All', '⚡ Instant (< 45m)', 'Elderly Care', 'Post-Op Recovery', 'ICU Step-down', 'Wound Care'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeAsync = ref.watch(homeViewModelProvider);
    final bookingsAsync = ref.watch(bookingsViewModelProvider);

    // Find if there is an active ongoing visit
    Booking? activeBooking;
    final bookings = bookingsAsync.valueOrNull ?? [];
    for (final b in bookings) {
      if (b.status == 'In Progress' || b.status == 'Confirmed' || b.status == 'Active') {
        activeBooking = b;
        break;
      }
    }

    final subCats = _getSubCategories();
    if (!subCats.contains(_selectedSubCategory)) {
      _selectedSubCategory = 'All';
    }

    return AppShell(
      currentPath: '/',
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          // -------------------------------------------------------------
          // 1. TOP SEARCH BAR (Location & Quick Actions are in Green Header)
          // -------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search nurses, centres, ICU beds, oxygen...',
                  hintStyle: const TextStyle(fontSize: 13, color: AppColors.mutedForeground),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.mutedForeground, size: 20),
                  suffixIcon: Container(
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

          // -------------------------------------------------------------
          // 2. AIRBNB-STYLE TOP FILTER TABS
          // -------------------------------------------------------------
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: _filterTabs.asMap().entries.map((entry) {
                final idx = entry.key;
                final tab = entry.value;
                final isSelected = _selectedFilterTab == idx;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedFilterTab = idx;
                        _selectedSubCategory = 'All';
                      });
                    },
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.card,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                          width: 1.2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            tab.icon,
                            size: 16,
                            color: isSelected ? Colors.white : AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            tab.title,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                              color: isSelected ? Colors.white : AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // -------------------------------------------------------------
          // 3. SUB-CATEGORY FILTER PILLS (Below Top Tabs)
          // -------------------------------------------------------------
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: subCats.map((cat) {
                final isSelected = _selectedSubCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: InkWell(
                    onTap: () => setState(() => _selectedSubCategory = cat),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primarySoft : AppColors.secondary,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(
                          color: isSelected ? AppColors.primary.withValues(alpha: 0.3) : Colors.transparent,
                        ),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                          color: isSelected ? AppColors.primaryDeep : AppColors.mutedForeground,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // -------------------------------------------------------------
          // 4. ACTIVE LIVE BOOKING BANNER (If Active)
          // -------------------------------------------------------------
          if (activeBooking != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: _ActiveBookingLiveCard(booking: activeBooking),
            ),
          ],

          // -------------------------------------------------------------
          // 6. TOP LISTINGS AIRBNB-STYLE DIRECT FEED
          // -------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedFilterTab == 1
                      ? 'Top Verified Nurses'
                      : (_selectedFilterTab == 2
                          ? 'Top Home Care Centres'
                          : (_selectedFilterTab == 3 ? 'Medical Equipment Rental' : 'Top Healthcare Listings')),
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.ink),
                ),
                Text(
                  'Hyperlocal',
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
              ],
            ),
          ),

          homeAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
            ),
            error: (err, _) => Center(child: Text('Error: $err')),
            data: (homeData) {
              final nurses = homeData.nurses;
              final centres = homeData.centres;

              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                child: Column(
                  children: [
                    // Render Nurses if All or Nurses tab
                    if (_selectedFilterTab == 0 || _selectedFilterTab == 1) ...[
                      ...nurses.map((nurse) => _NurseAirbnbCard(nurse: nurse)),
                    ],

                    // Render Care Centres if All or Centres tab
                    if (_selectedFilterTab == 0 || _selectedFilterTab == 2) ...[
                      ...centres.map((centre) => _CentreAirbnbCard(centre: centre)),
                    ],

                    // Render Equipment if Equipment tab or All
                    if (_selectedFilterTab == 0 || _selectedFilterTab == 3) ...[
                      const _EquipmentAirbnbCard(
                        title: 'Philips EverFlo 5L Oxygen Concentrator',
                        category: 'Respiratory · 93% Purity',
                        monthlyPrice: 4500,
                        deposit: 5000,
                        badge: 'Sanitised & Tested',
                        locality: 'Indiranagar (In Stock)',
                      ),
                      const _EquipmentAirbnbCard(
                        title: 'Motorized 5-Function ICU Hospital Bed',
                        category: 'Hospital Bed with Air Mattress',
                        monthlyPrice: 6500,
                        deposit: 8000,
                        badge: 'Sterilised Delivery',
                        locality: 'Bengaluru Express Dispatch',
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActiveBookingLiveCard extends StatelessWidget {
  final Booking booking;

  const _ActiveBookingLiveCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    final isNurse = booking.type == BookingType.nurse;
    final isCentre = booking.type == BookingType.careCentre;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.primary, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      isNurse ? 'NURSE ON THE WAY · LIVE VISIT' : 'CARE CENTRE ADMISSION PASS',
                      style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  'OTP: ${booking.otp}',
                  style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: AppColors.primarySoft, shape: BoxShape.circle),
                child: Icon(isNurse ? Icons.directions_walk_rounded : Icons.apartment, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.ink),
                    ),
                    Text(
                      isNurse
                          ? 'Share OTP ${booking.otp} upon nurse arrival to activate service'
                          : 'Show OTP ${booking.otp} at centre desk to complete check-in',
                      style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (isNurse) {
                    context.push('/nurse-tracker/${booking.id}');
                  } else if (isCentre) {
                    context.push('/centre-pass/${booking.id}');
                  } else {
                    context.push('/bookings');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
                  elevation: 0,
                ),
                child: Text(
                  isNurse ? 'Track Nurse' : 'View Pass',
                  style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NurseAirbnbCard extends StatelessWidget {
  final Nurse nurse;

  const _NurseAirbnbCard({required this.nurse});

  @override
  Widget build(BuildContext context) {
    final shiftPrice = nurse.shifts.isNotEmpty ? nurse.shifts.first.price : 1600;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Surface(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nurse Avatar
                Container(
                  width: 54,
                  height: 54,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    nurse.name.split(' ').map((e) => e[0]).take(2).join(),
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppColors.primary),
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
                                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.ink),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified, color: AppColors.success, size: 16),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                              const SizedBox(width: 2),
                              Text(
                                '${nurse.rating}',
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.ink),
                              ),
                              Text(
                                ' (${nurse.reviews})',
                                style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${nurse.level} · ${nurse.experience} yrs experience · ${nurse.city}',
                        style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.successSoft,
                              borderRadius: BorderRadius.circular(AppRadius.pill),
                            ),
                            child: const Text(
                              'HPR Verified',
                              style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: AppColors.success),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(AppRadius.pill),
                            ),
                            child: const Text(
                              'Police Checked',
                              style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: AppColors.ink),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Skills tags
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: nurse.tags.take(3).map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Text(tag, style: const TextStyle(fontSize: 10.5, color: AppColors.ink, fontWeight: FontWeight.w500)),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 10),

            // Pricing & Booking Action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('STARTING FROM', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: AppColors.mutedForeground)),
                    Text(
                      '${inr(shiftPrice)} / shift',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink),
                    ),
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () => context.push('/nurses/${nurse.id}'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
                      ),
                      child: const Text('View Profile', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => context.push('/nurse-quick-booking'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
                        elevation: 0,
                      ),
                      child: const Text('Quick Book', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
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

class _CentreAirbnbCard extends StatelessWidget {
  final Centre centre;

  const _CentreAirbnbCard({required this.centre});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Surface(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.primarySoft, shape: BoxShape.circle),
                  child: const Icon(Icons.apartment, color: AppColors.primary, size: 28),
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
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.ink),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                              const SizedBox(width: 2),
                              Text(
                                '${centre.rating}',
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.ink),
                              ),
                              Text(
                                ' (${centre.reviews})',
                                style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${centre.type} · ${centre.locality}, ${centre.city}',
                        style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primarySoft,
                              borderRadius: BorderRadius.circular(AppRadius.pill),
                            ),
                            child: Text(
                              centre.staffRatio,
                              style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: AppColors.primary),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.successSoft,
                              borderRadius: BorderRadius.circular(AppRadius.pill),
                            ),
                            child: const Text(
                              'Field Audited',
                              style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: AppColors.success),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: centre.services.take(3).map((s) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Text(s, style: const TextStyle(fontSize: 10.5, color: AppColors.ink, fontWeight: FontWeight.w500)),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ROOMS FROM', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: AppColors.mutedForeground)),
                    Text(
                      '${inr(centre.pricePerDay)} / day',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink),
                    ),
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () => context.push('/centres/${centre.id}'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
                      ),
                      child: const Text('View Facility', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => context.push('/centre-booking/${centre.id}'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
                        elevation: 0,
                      ),
                      child: const Text('Book Stay', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
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

class _EquipmentAirbnbCard extends StatelessWidget {
  final String title;
  final String category;
  final int monthlyPrice;
  final int deposit;
  final String badge;
  final String locality;

  const _EquipmentAirbnbCard({
    required this.title,
    required this.category,
    required this.monthlyPrice,
    required this.deposit,
    required this.badge,
    required this.locality,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Surface(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
                  child: const Icon(Icons.inventory_2_outlined, color: AppColors.primary, size: 26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.ink)),
                      const SizedBox(height: 2),
                      Text(category, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: AppColors.successSoft, borderRadius: BorderRadius.circular(AppRadius.pill)),
                            child: Text(badge, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: AppColors.success)),
                          ),
                          const SizedBox(width: 6),
                          Text(locality, style: const TextStyle(fontSize: 10.5, color: AppColors.mutedForeground)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('MONTHLY RENTAL', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: AppColors.mutedForeground)),
                    Text('${inr(monthlyPrice)} / month', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => context.push('/equipment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
                    elevation: 0,
                  ),
                  child: const Text('Rent Equipment', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

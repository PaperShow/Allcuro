import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/ui/app_shell.dart';
import '../../../core/ui/surface.dart';
import '../../../core/ui/tappable.dart';
import '../../auth/presentation/auth_view_model.dart';
import '../../auth/presentation/quick_login_sheet.dart';

class NurseServiceItem {
  final String id;
  final String name;
  final String category;
  final String qualification;
  final String duration;
  final String price;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String description;
  final List<String> procedures;
  final String? badge;

  const NurseServiceItem({
    required this.id,
    required this.name,
    required this.category,
    required this.qualification,
    required this.duration,
    required this.price,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.description,
    required this.procedures,
    this.badge,
  });
}

class AllNurseServicesScreen extends ConsumerStatefulWidget {
  const AllNurseServicesScreen({super.key});

  @override
  ConsumerState<AllNurseServicesScreen> createState() => _AllNurseServicesScreenState();
}

class _AllNurseServicesScreenState extends ConsumerState<AllNurseServicesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  static const List<NurseServiceItem> _services = [
    NurseServiceItem(
      id: 'catheter-care',
      name: 'Catheter Care',
      category: 'Clinical Care',
      qualification: 'GNM / B.Sc Nursing',
      duration: '45–60 mins',
      price: '₹550',
      badge: 'High Skill',
      icon: Icons.medical_services_rounded,
      iconColor: Color(0xFF7C3AED),
      iconBg: Color(0xFFEDE9FE),
      description: 'Foley catheterization, sterile bag change, bladder irrigation & leakage assessment.',
      procedures: [
        'Foley catheter insertion & removal',
        'Urine bag replacement & drainage check',
        'Sterile bladder wash / irrigation',
        'Catheter site hygiene & blockage inspection',
      ],
    ),
    NurseServiceItem(
      id: 'ryles-tube-care',
      name: 'Ryles Tube Care',
      category: 'Clinical Care',
      qualification: 'GNM / B.Sc Registered',
      duration: '45–60 mins',
      price: '₹600',
      badge: 'Certified Procedure',
      icon: Icons.medication_liquid_rounded,
      iconColor: Color(0xFFEA580C),
      iconBg: Color(0xFFFFEDD5),
      description: 'Nasogastric (NG) / Ryles tube insertion, feeding protocol guidance & tube clearance.',
      procedures: [
        'Nasogastric (Ryles) tube insertion & positioning test',
        'Enteral feeding & medicine flush assistance',
        'Tube clearance & blockage release',
        'Aspiration check & oral hygiene guidance',
      ],
    ),
    NurseServiceItem(
      id: 'wound-dressing',
      name: 'Wound Dressing',
      category: 'Clinical Care',
      qualification: 'GNM / B.Sc Nursing',
      duration: '30–45 mins',
      price: '₹499',
      badge: 'Aseptic Sterile Kit',
      icon: Icons.healing_rounded,
      iconColor: Color(0xFF0D9488),
      iconBg: Color(0xFFCCFBF1),
      description: 'Sterile dressing for post-operative incisions, bedsores (stages 1–4), and diabetic foot ulcers.',
      procedures: [
        'Aseptic cleaning & sterile bandage application',
        'Post-operative surgical incision dressing',
        'Diabetic foot ulcer treatment & debridement care',
        'Pressure ulcer (bedsore) staging & dressing',
      ],
    ),
    NurseServiceItem(
      id: 'injection',
      name: 'Injection Administration',
      category: 'Clinical Care',
      qualification: 'ANM / GNM Nursing',
      duration: '20–30 mins',
      price: '₹349',
      badge: 'Doctor Rx Required',
      icon: Icons.vaccines_rounded,
      iconColor: Color(0xFF2563EB),
      iconBg: Color(0xFFDBEAFE),
      description: 'Intramuscular (IM), Subcutaneous (SC), and prescribed insulin injection administration.',
      procedures: [
        'Intramuscular (IM) injection administration',
        'Subcutaneous (SC) injections & insulin dose setup',
        'Injection site rotation & aseptic swab',
        'Pre & post vital checkup (Pulse & BP)',
      ],
    ),
    NurseServiceItem(
      id: 'iv-care',
      name: 'IV Care & Cannulation',
      category: 'Clinical Care',
      qualification: 'GNM / B.Sc Registered',
      duration: '45–90 mins',
      price: '₹599',
      badge: 'Instant 45m Support',
      icon: Icons.water_drop_rounded,
      iconColor: Color(0xFF0284C7),
      iconBg: Color(0xFFE0F2FE),
      description: 'IV cannula insertion, saline / antibiotic IV drip administration, and central line flushes.',
      procedures: [
        'IV cannula insertion & vein selection',
        'Normal saline / Dextrose / Antibiotic infusion',
        'Flow rate calibration & infiltration monitoring',
        'PICC line / Central venous line heparin flush',
      ],
    ),
    NurseServiceItem(
      id: 'tracheostomy-care',
      name: 'Tracheostomy Care',
      category: 'Critical & Post-Op',
      qualification: 'Critical Care Certified Nurse',
      duration: '60 mins',
      price: '₹750',
      badge: 'Specialized ICU',
      icon: Icons.masks_rounded,
      iconColor: Color(0xFFDC2626),
      iconBg: Color(0xFFFEE2E2),
      description: 'Inner cannula cleansing, stoma dressing, cuff pressure monitoring, and airway clearance.',
      procedures: [
        'Inner cannula removal, sterilization & reinsertion',
        'Stoma site antiseptic cleaning & tie replacement',
        'Tracheal cuff pressure monitoring',
        'Emergency airway patency verification',
      ],
    ),
    NurseServiceItem(
      id: 'suction',
      name: 'Suction Care',
      category: 'Critical & Post-Op',
      qualification: 'GNM / Critical Care',
      duration: '30–45 mins',
      price: '₹450',
      badge: 'Airway Hygiene',
      icon: Icons.air_rounded,
      iconColor: Color(0xFF0891B2),
      iconBg: Color(0xFFCFFAFE),
      description: 'Oral, nasal, and endotracheal suctioning for secretion clearance and respiratory comfort.',
      procedures: [
        'Oral & pharyngeal suctioning',
        'Endotracheal / Tracheostomy deep suctioning',
        'Catheter lubrication & aseptic technique',
        'Pre & post oxygen saturation (SpO2) monitoring',
      ],
    ),
    NurseServiceItem(
      id: 'post-operative-care',
      name: 'Post-operative Care',
      category: 'Critical & Post-Op',
      qualification: 'GNM / B.Sc Nursing',
      duration: '60–120 mins',
      price: '₹699',
      badge: 'Hospital Discharge',
      icon: Icons.health_and_safety_rounded,
      iconColor: Color(0xFF059669),
      iconBg: Color(0xFFD1FAE5),
      description: 'Complete post-surgery recovery monitoring, drain measurement, surgical suture removal & pain assessment.',
      procedures: [
        'Suture / surgical staple removal',
        'Surgical drain volume & character measurement',
        'Infection surveillance (redness, exudate, fever)',
        'Post-operative ambulation & respiratory therapy',
      ],
    ),
    NurseServiceItem(
      id: 'vital-monitoring',
      name: 'Vital Monitoring & Check',
      category: 'General & Support',
      qualification: 'ANM / GNM Nursing',
      duration: '30 mins',
      price: '₹399',
      badge: 'Clinical Grade',
      icon: Icons.monitor_heart_rounded,
      iconColor: Color(0xFFE11D48),
      iconBg: Color(0xFFFFE4E6),
      description: 'Accurate clinical vitals assessment: Blood Pressure, Pulse, SpO2, Temp & Blood Glucose.',
      procedures: [
        'Dual-arm Blood Pressure recording',
        'Continuous pulse oximetry (SpO2) & heart rate',
        'Random / Fasting blood glucose testing',
        'Digital clinical observation log sharing',
      ],
    ),
    NurseServiceItem(
      id: 'mother-and-baby',
      name: 'Mother & Baby Care',
      category: 'Maternal & Newborn',
      qualification: 'Certified Midwife / GNM',
      duration: '60–90 mins',
      price: '₹750',
      badge: 'Certified Midwife',
      icon: Icons.child_care_rounded,
      iconColor: Color(0xFFDB2777),
      iconBg: Color(0xFFFCE7F3),
      description: 'Postnatal mother vitals, C-section incision monitoring, newborn bath, cord care & lactation support.',
      procedures: [
        'Post-caesarean wound dressing & vitals check',
        'Newborn sterile bath & umbilical cord care',
        'Baby jaundice inspection & weight tracking',
        'Latching, burping & lactation guidance',
      ],
    ),
    NurseServiceItem(
      id: 'general-nursing',
      name: 'General Nursing',
      category: 'General & Support',
      qualification: 'ANM / GNM Diploma',
      duration: '60 mins',
      price: '₹499',
      badge: 'Routine Care',
      icon: Icons.medical_information_rounded,
      iconColor: Color(0xFF10B981),
      iconBg: Color(0xFFD1FAE5),
      description: 'Routine bedside nursing assistance, medication reminders, hygiene support, and health logging.',
      procedures: [
        'Daily medication reconciliation & dosage timing',
        'Bed bath & pressure sore prevention positioning',
        'General health status review & vitals assessment',
        'Doctor report coordination & family updates',
      ],
    ),
    NurseServiceItem(
      id: 'physiotherapy',
      name: 'Physiotherapy & Rehab',
      category: 'Rehabilitation',
      qualification: 'BPT Physiotherapist',
      duration: '45–60 mins',
      price: '₹850',
      badge: 'BPT Qualified',
      icon: Icons.accessibility_new_rounded,
      iconColor: Color(0xFF4F46E5),
      iconBg: Color(0xFFE0E7FF),
      description: 'Post-op knee/hip rehab, post-stroke neuromuscular therapy, elderly mobility & chest physiotherapy.',
      procedures: [
        'Post-joint replacement range-of-motion therapy',
        'Stroke paralysis neuromuscular re-education',
        'Geriatric gait, balance & fall-prevention training',
        'Pain relief electrotherapy & manual mobilization',
      ],
    ),
    NurseServiceItem(
      id: 'nebulization-respiratory',
      name: 'Nebulization & Oxygen Support',
      category: 'Clinical Care',
      qualification: 'ANM / GNM Registered',
      duration: '30 mins',
      price: '₹399',
      badge: 'Respiratory Comfort',
      icon: Icons.air_outlined,
      iconColor: Color(0xFF0284C7),
      iconBg: Color(0xFFE0F2FE),
      description: 'Prescribed nebulizer medicine administration, oxygen flow titration, and chest vibration.',
      procedures: [
        'Prescribed bronchodilator nebulization',
        'Oxygen concentrator flow & cannula calibration',
        'SpO2 pre & post treatment recording',
        'Breathing exercises & postural drainage',
      ],
    ),
  ];

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
        subtitle: 'Enter your phone number to proceed with verified nurse booking',
        onSuccess: onAuthenticated,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Clinical Care', 'Critical & Post-Op', 'Maternal & Newborn', 'Rehabilitation', 'General & Support'];

    final filtered = _services.where((item) {
      final matchesCat = _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesQuery = _searchQuery.isEmpty ||
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.procedures.any((p) => p.toLowerCase().contains(_searchQuery.toLowerCase()));
      return matchesCat && matchesQuery;
    }).toList();

    return AppShell(
      currentPath: '/nurse-services',
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, color: AppColors.ink),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/');
                    }
                  },
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Nurse Care Services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.3,
                          color: AppColors.ink,
                        ),
                      ),
                      Text(
                        'Clinical procedures performed by certified nurses',
                        style: TextStyle(fontSize: 11.5, color: AppColors.mutedForeground),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val.trim()),
                decoration: InputDecoration(
                  hintText: 'Search catheter, ryles tube, wound dressing, IV...',
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
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // Category Pills
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = cat == _selectedCategory;
                return ChoiceChip(
                  label: Text(
                    cat,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.ink,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.card,
                  side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.pill)),
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedCategory = cat);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 14),

          // Service Items List
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.search_off_rounded, size: 48, color: AppColors.mutedForeground.withValues(alpha: 0.5)),
                    const SizedBox(height: 12),
                    const Text(
                      'No matching clinical services found',
                      style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Try searching with keywords like catheter, wound, or injection',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: AppColors.mutedForeground),
                    ),
                  ],
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: filtered.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Surface(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: item.iconBg,
                                  borderRadius: BorderRadius.circular(AppRadius.md),
                                  border: Border.all(color: item.iconColor.withValues(alpha: 0.2)),
                                ),
                                child: Icon(item.icon, color: item.iconColor, size: 24),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.ink,
                                            ),
                                          ),
                                        ),
                                        if (item.badge != null)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: AppColors.primarySoft,
                                              borderRadius: BorderRadius.circular(AppRadius.pill),
                                            ),
                                            child: Text(
                                              item.badge!,
                                              style: const TextStyle(
                                                fontSize: 9.5,
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${item.qualification} · ${item.duration}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.mutedForeground,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.description,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.35,
                              color: AppColors.ink,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: item.procedures.take(3).map((p) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(AppRadius.sm),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.check_circle_rounded, size: 11, color: AppColors.primary),
                                    const SizedBox(width: 4),
                                    Text(
                                      p,
                                      style: const TextStyle(fontSize: 10.5, color: AppColors.ink, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 14),
                          const Divider(height: 1, color: AppColors.border),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Starts from',
                                    style: TextStyle(fontSize: 10, color: AppColors.mutedForeground),
                                  ),
                                  Text(
                                    item.price,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      _handleBookingGuard(() => context.push('/nurse-quick-booking'));
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: AppColors.primary),
                                      foregroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.pill)),
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    child: const Text('⚡ 45m Express', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700)),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      _handleBookingGuard(() => context.push('/nurses'));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.pill)),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      elevation: 0,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    child: const Text('Book Nurse', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

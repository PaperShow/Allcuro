import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/ui/app_shell.dart';
import '../../../core/ui/care_icon.dart';
import '../data/master_services_catalog.dart';

/// Dynamic Category Services Screen displaying all services belonging to a care category
/// (Nursing, Mother & Baby Care, Elder Care, Physiotherapy, Doctor Care, etc.)
/// in the clean grid structure matching the homecare style.
class CategoryServicesScreen extends ConsumerStatefulWidget {
  final String category;

  const CategoryServicesScreen({
    super.key,
    required this.category,
  });

  @override
  ConsumerState<CategoryServicesScreen> createState() => _CategoryServicesScreenState();
}

class _CategoryServicesScreenState extends ConsumerState<CategoryServicesScreen> {
  String _selectedSubcategory = 'All';

  _CategoryMeta _getCategoryMeta(String key) {
    final k = key.toLowerCase().trim();
    if (k.contains('nurs')) {
      return const _CategoryMeta(
        title: 'Nursing Care',
        badge: 'Clinical & Advanced',
        subtitle: 'Verified home nursing, injections, catheter, wound & IV care',
        icon: Icons.medical_services_rounded,
        accentColor: AppColors.primary,
      );
    } else if (k.contains('baby') || k.contains('matern') || k.contains('mother')) {
      return const _CategoryMeta(
        title: 'Mother & Baby Care',
        badge: 'Maternal & Newborn',
        subtitle: 'Antenatal visits, postnatal recovery, newborn bath & hygiene',
        icon: Icons.child_care_rounded,
        accentColor: Color(0xFF0F766E),
      );
    } else if (k.contains('elder')) {
      return const _CategoryMeta(
        title: 'Elder Care',
        badge: 'Assisted & Dignified',
        subtitle: 'Assisted bathing, mobility, daily companionship & vital monitoring',
        icon: Icons.elderly_rounded,
        accentColor: Color(0xFFD97706),
      );
    } else if (k.contains('caregiv')) {
      return const _CategoryMeta(
        title: 'Caregivers',
        badge: 'Compassionate Care',
        subtitle: 'Bedside assistance, bathing, mobility, feeding & daily companionship',
        icon: Icons.volunteer_activism_rounded,
        accentColor: Color(0xFFD97706),
      );
    } else if (k.contains('physio')) {
      return const _CategoryMeta(
        title: 'Physiotherapy',
        badge: 'Rehab & Mobility',
        subtitle: 'Comprehensive assessment, stroke recovery & mobility exercises',
        icon: Icons.accessibility_new_rounded,
        accentColor: Color(0xFF2563EB),
      );
    } else if (k.contains('doc')) {
      return const _CategoryMeta(
        title: 'Doctor Visit',
        badge: 'Home Consultation',
        subtitle: 'Doctor and geriatric physician consultations at home',
        icon: Icons.medical_information_rounded,
        accentColor: Color(0xFF7C3AED),
      );
    } else if (k.contains('diag')) {
      return const _CategoryMeta(
        title: 'Diagnostics & Labs',
        badge: 'Lab at Doorstep',
        subtitle: 'ECG recording and professional blood sample collection',
        icon: Icons.biotech_rounded,
        accentColor: Color(0xFF0891B2),
      );
    } else if (k.contains('well')) {
      return const _CategoryMeta(
        title: 'Wellness & Nutrition',
        badge: 'Diet & Lactation',
        subtitle: 'Personalised clinical dietitian and lactation guidance',
        icon: Icons.restaurant_rounded,
        accentColor: Color(0xFF059669),
      );
    } else {
      return const _CategoryMeta(
        title: 'All Healthcare Services',
        badge: 'Master Catalog',
        subtitle: 'Explore the complete directory of certified home healthcare services',
        icon: Icons.grid_view_rounded,
        accentColor: AppColors.primary,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meta = _getCategoryMeta(widget.category);
    final allCategoryServices = MasterServicesCatalog.getByCategory(widget.category);

    // Extract unique subcategories
    final subcategories = ['All', ...allCategoryServices.map((s) => s.subcategory).toSet()];

    final filteredServices = allCategoryServices
        .where((s) => _selectedSubcategory == 'All' || s.subcategory == _selectedSubcategory)
        .toList();

    return AppShell(
      currentPath: '/category-services/${widget.category}',
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          // -----------------------------------------------------------------
          // 1. HEADER ROW: Back Button + Category Title + Subtitle
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: const EdgeInsets.all(8),
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
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              meta.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primarySoft,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              '${allCategoryServices.length} Services',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        meta.subtitle,
                        style: const TextStyle(
                          fontSize: 11.5,
                          height: 1.35,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // -----------------------------------------------------------------
          // 2. SUBCATEGORY PILL TABS (if multiple)
          // -----------------------------------------------------------------
          if (subcategories.length > 2) ...[
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: subcategories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final sub = subcategories[i];
                  final isSelected = sub == _selectedSubcategory;
                  return InkWell(
                    onTap: () => setState(() => _selectedSubcategory = sub),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.card,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Text(
                        sub,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSelected ? Colors.white : AppColors.ink,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],

          // -----------------------------------------------------------------
          // 3. GRID STRUCTURE: SERVICES
          // -----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 12,
                ),
                itemCount: filteredServices.length,
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  return _CategoryServiceGridTile(
                    service: service,
                    onTap: () {
                      context.push('/services/${service.id}');
                    },
                  );
                },
              ),
            ),

          const SizedBox(height: 24),

          // -----------------------------------------------------------------
          // 4. HELPDESK & CALL SUPPORT BANNER
          // -----------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.support_agent_rounded, size: 20, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need custom clinical guidance?',
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5, color: AppColors.ink),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Our care coordinators help plan your doctor & nursing regimen',
                          style: TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

/// Metadata describing each top-level service category
class _CategoryMeta {
  final String title;
  final String badge;
  final String subtitle;
  final IconData icon;
  final Color accentColor;

  const _CategoryMeta({
    required this.title,
    required this.badge,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
  });
}

/// Single Service Tile in the Grid (mirrors Home Screen grid design)
class _CategoryServiceGridTile extends StatelessWidget {
  final MasterServiceItem service;
  final VoidCallback onTap;

  const _CategoryServiceGridTile({
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon / Image Container
          Stack(
            clipBehavior: Clip.none,
            children: [
              CareIconTile(
                asset: CareIcons.forService(service.id),
                tone: CareTone.forCategory(service.mainCategory),
              ),

              // Micro Badge if available (e.g. Popular, Advanced, Value)
              if (service.badge.isNotEmpty)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: service.badge == 'Advanced'
                          ? const Color(0xFF7C3AED)
                          : (service.badge == 'Popular' ? AppColors.secondaryAccent : AppColors.primary),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      service.badge,
                      style: const TextStyle(
                        fontSize: 7.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 6),

          // Title
          Text(
            service.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              height: 1.15,
              color: AppColors.ink,
            ),
          ),

          const SizedBox(height: 3),

          // Price Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              service.price,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

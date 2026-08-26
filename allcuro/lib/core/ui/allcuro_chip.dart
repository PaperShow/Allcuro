import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Ports the `<Chip>` component from `AppShell.tsx`.
class AllcuroChip extends StatelessWidget {
  final String label;

  const AllcuroChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryForeground,
        ),
      ),
    );
  }
}

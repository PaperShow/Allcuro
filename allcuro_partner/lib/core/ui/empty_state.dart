import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Small centered message for an empty list (no pending requests, no
/// shifts in the selected filter, etc.) — shared across nurse and centre
/// screens so the empty-state look stays consistent.
class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: AppColors.mutedForeground),
        ),
      ),
    );
  }
}

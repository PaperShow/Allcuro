import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/screen_header.dart';
import '../../../../core/ui/surface.dart';

/// Nurse's support & SOS screen — a demo-only escalation surface pushed
/// from the "More tools" grid. There's no real telephony or chat backend
/// wired up yet; every action here just confirms the interaction via a
/// dialog and/or a SnackBar.
class SupportScreen extends StatelessWidget {
  final VoidCallback onBack;

  const SupportScreen({super.key, required this.onBack});

  Future<void> _confirmSos(BuildContext context) async {
    final shouldCall = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Call ALLCURO Ops?'),
        content: const Text(
          'This is for genuine emergencies during an active shift.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.destructive),
            child: const Text('Call'),
          ),
        ],
      ),
    );

    if (shouldCall == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Calling ALLCURO Ops... (demo)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(title: 'Support & SOS', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                children: [
                  Material(
                    color: AppColors.destructive,
                    borderRadius: BorderRadius.circular(AppRadius.xxl),
                    child: InkWell(
                      onTap: () => _confirmSos(context),
                      borderRadius: BorderRadius.circular(AppRadius.xxl),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emergency_outlined,
                              color: AppColors.destructiveForeground,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Emergency SOS — Call ALLCURO Ops',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.destructiveForeground,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'General support',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Surface(
                    padding: const EdgeInsets.all(16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Chat coming soon — demo')),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.chat_outlined, color: AppColors.primary),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Chat with support',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded, color: AppColors.mutedForeground),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Support hours: Mon–Sat, 8 AM – 10 PM',
                    style: TextStyle(fontSize: 12, color: AppColors.mutedForeground),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

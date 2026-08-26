import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/wizard_scaffold.dart';
import '../../../auth/presentation/auth_view_model.dart';
import 'centre_signup_steps.dart';
import 'centre_signup_view_model.dart';

/// Streamlined 3-step centre sign-up wizard.
/// Collects core entity details and unlocks the dashboard immediately.
/// Compliance NOCs, staff roster, site visit booking, and bed listings can be
/// completed progressively from the Centre Home, Compliance Hub and Listing screens.
class CentreSignupScreen extends ConsumerWidget {
  const CentreSignupScreen({super.key});

  bool _canContinue(CentreSignupState s) {
    final d = s.data;
    switch (s.stepIndex) {
      case 0:
        return d.centreName.trim().isNotEmpty &&
            d.centreType != null &&
            d.yearEstablished.trim().isNotEmpty;
      case 1:
        return d.businessEmail.trim().contains('@');
      case 2:
        return true;
      default:
        return false;
    }
  }

  Widget _stepContent(int index) {
    return switch (index) {
      0 => const EntityDetailsStep(),
      1 => const BusinessEmailStep(),
      _ => const CentreReviewSubmitStep(),
    };
  }

  Future<void> _confirmExit(BuildContext context, WidgetRef ref) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit sign-up?'),
        content: const Text(
          "You'll need to log in again to pick up where you left off.",
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Log out', style: TextStyle(color: AppColors.destructive)),
          ),
        ],
      ),
    );
    if (shouldExit == true) {
      await ref.read(authViewModelProvider.notifier).logout();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(centreSignupViewModelProvider);
    final notifier = ref.read(centreSignupViewModelProvider.notifier);
    final isLastStep = state.stepIndex == CentreSignupViewModel.stepCount - 1;
    final canContinue = _canContinue(state);

    return WizardScaffold(
      onBack: () {
        if (state.stepIndex > 0) {
          notifier.back();
        } else {
          _confirmExit(context, ref);
        }
      },
      stepIndex: state.stepIndex,
      stepCount: CentreSignupViewModel.stepCount,
      step: _stepContent(state.stepIndex),
      bottomBar: WizardPrimaryButton(
        label: isLastStep ? 'Submit & Enter Dashboard' : 'Continue',
        loading: state.isSubmitting,
        onPressed: canContinue
            ? () {
                if (isLastStep) {
                  notifier.submit();
                } else {
                  notifier.next();
                }
              }
            : null,
      ),
    );
  }
}

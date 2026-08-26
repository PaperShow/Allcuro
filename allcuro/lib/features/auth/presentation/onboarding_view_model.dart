import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_view_model.dart';

class OnboardingState {
  final bool isSubmitting;
  final String? error;

  const OnboardingState({this.isSubmitting = false, this.error});

  OnboardingState copyWith({bool? isSubmitting, String? Function()? error}) {
    return OnboardingState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error != null ? error() : this.error,
    );
  }
}

final onboardingViewModelProvider =
    StateNotifierProvider.autoDispose<OnboardingViewModel, OnboardingState>((
      ref,
    ) {
      return OnboardingViewModel(
        ref.read(authViewModelProvider.notifier),
      );
    });

class OnboardingViewModel extends StateNotifier<OnboardingState> {
  final AuthViewModel _authViewModel;

  OnboardingViewModel(this._authViewModel)
    : super(const OnboardingState());

  Future<bool> completeOnboarding({
    required String name,
    required String email,
    required String city,
    required String emergencyContact,
  }) async {
    if (name.trim().isEmpty) {
      state = state.copyWith(error: () => 'Please enter your full name.');
      return false;
    }
    if (city.trim().isEmpty) {
      state = state.copyWith(error: () => 'Please select your city / area.');
      return false;
    }

    state = state.copyWith(isSubmitting: true, error: () => null);
    try {
      await _authViewModel.onOnboardingCompleted(
        name: name.trim(),
        email: email.trim(),
        city: city.trim(),
        emergencyContact: emergencyContact.trim(),
      );
      state = state.copyWith(isSubmitting: false);
      return true;
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        error: () => 'Could not complete profile setup. Please try again.',
      );
      return false;
    }
  }
}

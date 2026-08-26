import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';
import 'auth_view_model.dart';

enum PhoneAuthStep { phone, otp }

/// State for the two-step phone → OTP sign-in flow (`PhoneAuthScreen`).
/// `phone` is only meaningful once [step] has advanced past the phone
/// step — it's what the OTP step verifies against and displays back to
/// the user ("Sent to +91 …").
class PhoneAuthState {
  final PhoneAuthStep step;
  final String phone;
  final bool isSubmitting;
  final String? error;

  const PhoneAuthState({
    this.step = PhoneAuthStep.phone,
    this.phone = '',
    this.isSubmitting = false,
    this.error,
  });

  PhoneAuthState copyWith({
    PhoneAuthStep? step,
    String? phone,
    bool? isSubmitting,
    String? error,
    bool clearError = false,
  }) {
    return PhoneAuthState(
      step: step ?? this.step,
      phone: phone ?? this.phone,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

final phoneAuthViewModelProvider =
    NotifierProvider.autoDispose<PhoneAuthViewModel, PhoneAuthState>(
      PhoneAuthViewModel.new,
    );

/// Drives `PhoneAuthScreen`'s two steps. Kept as `.autoDispose` — this
/// state is only meaningful while that screen is on screen, unlike
/// `AuthViewModel`'s session state which the whole app depends on.
class PhoneAuthViewModel extends AutoDisposeNotifier<PhoneAuthState> {
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  PhoneAuthState build() => const PhoneAuthState();

  Future<void> submitPhone(String phone) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.sendOtp(phone);
      state = state.copyWith(
        step: PhoneAuthStep.otp,
        phone: phone,
        isSubmitting: false,
      );
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: '$e');
    }
  }

  Future<void> resendOtp() async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      await _repository.sendOtp(state.phone);
      state = state.copyWith(isSubmitting: false);
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: '$e');
    }
  }

  Future<void> verifyOtp(String otp) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      final session = await _repository.verifyOtp(phone: state.phone, otp: otp);
      ref.read(authViewModelProvider.notifier).applySession(session);
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: '$e');
    }
  }

  void editPhoneNumber() {
    state = state.copyWith(step: PhoneAuthStep.phone, clearError: true);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';
import '../data/auth_service.dart';
import 'auth_view_model.dart';

enum PhoneAuthStep { phone, otp }

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
    String? Function()? error,
  }) {
    return PhoneAuthState(
      step: step ?? this.step,
      phone: phone ?? this.phone,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error != null ? error() : this.error,
    );
  }
}

final phoneAuthViewModelProvider =
    StateNotifierProvider.autoDispose<PhoneAuthViewModel, PhoneAuthState>((
      ref,
    ) {
      return PhoneAuthViewModel(
        ref.watch(authRepositoryProvider),
        ref.read(authViewModelProvider.notifier),
      );
    });

class PhoneAuthViewModel extends StateNotifier<PhoneAuthState> {
  final AuthRepository _repository;
  final AuthViewModel _authViewModel;

  PhoneAuthViewModel(this._repository, this._authViewModel)
    : super(const PhoneAuthState());

  Future<void> submitPhone(String rawPhone) async {
    final digits = rawPhone.replaceAll(RegExp(r'\D'), '');
    state = state.copyWith(isSubmitting: true, error: () => null);
    try {
      await _repository.sendOtp(digits);
      state = state.copyWith(
        step: PhoneAuthStep.otp,
        phone: digits,
        isSubmitting: false,
        error: () => null,
      );
    } on AuthException catch (e) {
      state = state.copyWith(isSubmitting: false, error: () => e.message);
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        error: () => 'Something went wrong. Please try again.',
      );
    }
  }

  Future<void> resendOtp() async {
    if (state.phone.isEmpty) return;
    state = state.copyWith(isSubmitting: true, error: () => null);
    try {
      await _repository.sendOtp(state.phone);
      state = state.copyWith(isSubmitting: false, error: () => null);
    } on AuthException catch (e) {
      state = state.copyWith(isSubmitting: false, error: () => e.message);
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        error: () => 'Could not resend code. Try again later.',
      );
    }
  }

  Future<void> verifyOtp(String code) async {
    state = state.copyWith(isSubmitting: true, error: () => null);
    try {
      await _repository.verifyOtp(phone: state.phone, otp: code.trim());
      await _authViewModel.onOtpVerified();
      state = state.copyWith(isSubmitting: false, error: () => null);
    } on AuthException catch (e) {
      state = state.copyWith(isSubmitting: false, error: () => e.message);
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        error: () => 'Verification failed. Please try again.',
      );
    }
  }

  void editPhoneNumber() {
    state = state.copyWith(step: PhoneAuthStep.phone, error: () => null);
  }
}

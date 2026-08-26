import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';

enum AuthStatus { unknown, unauthenticated, authenticated, onboarded }

class AuthState {
  final AuthStatus status;
  final Map<String, String> userProfile;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.userProfile = const {},
  });

  AuthState copyWith({
    AuthStatus? status,
    Map<String, String>? userProfile,
  }) {
    return AuthState(
      status: status ?? this.status,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(ref.watch(authRepositoryProvider));
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthViewModel(this._repository) : super(const AuthState()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    final loggedIn = await _repository.isLoggedIn();
    if (!loggedIn) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    }

    final onboarded = await _repository.isOnboarded();
    final profile = await _repository.getUserProfile();
    state = state.copyWith(
      status: onboarded ? AuthStatus.onboarded : AuthStatus.authenticated,
      userProfile: profile,
    );
  }

  Future<void> onOtpVerified() async {
    final onboarded = await _repository.isOnboarded();
    final profile = await _repository.getUserProfile();
    state = state.copyWith(
      status: onboarded ? AuthStatus.onboarded : AuthStatus.authenticated,
      userProfile: profile,
    );
  }

  Future<void> onOnboardingCompleted({
    required String name,
    required String email,
    required String city,
    required String emergencyContact,
  }) async {
    await _repository.completeOnboarding(
      name: name,
      email: email,
      city: city,
      emergencyContact: emergencyContact,
    );
    final profile = await _repository.getUserProfile();
    state = state.copyWith(
      status: AuthStatus.onboarded,
      userProfile: profile,
    );
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

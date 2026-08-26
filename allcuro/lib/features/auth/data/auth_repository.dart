import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(authServiceProvider));
});

class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  Future<bool> isLoggedIn() => _service.isLoggedIn();
  Future<bool> isOnboarded() => _service.isOnboarded();
  Future<Map<String, String>> getUserProfile() => _service.getUserProfile();
  Future<void> sendOtp(String phone) => _service.sendOtp(phone);
  Future<void> verifyOtp({required String phone, required String otp}) =>
      _service.verifyOtp(phone: phone, otp: otp);
  Future<void> completeOnboarding({
    required String name,
    required String email,
    required String city,
    required String emergencyContact,
  }) => _service.completeOnboarding(
    name: name,
    email: email,
    city: city,
    emergencyContact: emergencyContact,
  );
  Future<void> setKycTier(String tier) => _service.setKycTier(tier);
  Future<void> logout() => _service.logout();
}

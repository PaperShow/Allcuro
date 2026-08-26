import '../../../core/provider_role.dart';
import '../../../core/verification_status.dart';
import 'auth_service.dart';

/// Signed-in state: whether there's a session at all, which
/// [ProviderRole] (if any) that account has picked, and how far each
/// role's sign-up wizard has gotten. `app_router.dart` redirects between
/// welcome / phone-auth / role-select / sign-up / the right shell based on
/// this. Both verification statuses are carried regardless of the active
/// role — cheap to load together, and it means switching roles never
/// requires a second round-trip to find out where that role's onboarding
/// left off.
class AuthSession {
  final bool isLoggedIn;
  final ProviderRole? role;
  final NurseVerificationStatus nurseVerificationStatus;
  final CentreVerificationStatus centreVerificationStatus;

  const AuthSession({
    required this.isLoggedIn,
    this.role,
    this.nurseVerificationStatus = NurseVerificationStatus.incomplete,
    this.centreVerificationStatus = CentreVerificationStatus.incomplete,
  });

  static const initial = AuthSession(isLoggedIn: false);

  AuthSession copyWith({
    NurseVerificationStatus? nurseVerificationStatus,
    CentreVerificationStatus? centreVerificationStatus,
  }) {
    return AuthSession(
      isLoggedIn: isLoggedIn,
      role: role,
      nurseVerificationStatus: nurseVerificationStatus ?? this.nurseVerificationStatus,
      centreVerificationStatus: centreVerificationStatus ?? this.centreVerificationStatus,
    );
  }
}

/// Domain layer over [AuthService] — `AuthViewModel` talks to this, never
/// to `SharedPreferences` directly.
class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  Future<AuthSession> loadSession() async {
    final loggedIn = await _service.isLoggedIn();
    if (!loggedIn) return AuthSession.initial;
    return AuthSession(
      isLoggedIn: true,
      role: await _service.getPersistedRole(),
      nurseVerificationStatus: await _service.getNurseVerificationStatus(),
      centreVerificationStatus: await _service.getCentreVerificationStatus(),
    );
  }

  Future<void> sendOtp(String phone) => _service.sendOtp(phone);

  Future<AuthSession> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    await _service.verifyOtp(phone: phone, otp: otp);
    return loadSession();
  }

  Future<AuthSession> selectRole(ProviderRole role) async {
    await _service.saveRole(role);
    return loadSession();
  }

  Future<AuthSession> setNurseVerificationStatus(NurseVerificationStatus status) async {
    await _service.setNurseVerificationStatus(status);
    return loadSession();
  }

  Future<AuthSession> setCentreVerificationStatus(CentreVerificationStatus status) async {
    await _service.setCentreVerificationStatus(status);
    return loadSession();
  }

  Future<AuthSession> logout() async {
    await _service.logout();
    return AuthSession.initial;
  }
}

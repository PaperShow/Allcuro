import 'package:shared_preferences/shared_preferences.dart';

/// Thrown by [AuthService.sendOtp] / [AuthService.verifyOtp] on invalid input.
class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}

/// Local auth backend & persistence for Customer App.
class AuthService {
  static const _loggedInKey = 'auth.customer_logged_in';
  static const _onboardedKey = 'auth.customer_onboarded';
  static const _userNameKey = 'auth.customer_name';
  static const _userPhoneKey = 'auth.customer_phone';
  static const _userEmailKey = 'auth.customer_email';
  static const _userCityKey = 'auth.customer_city';
  static const _emergencyContactKey = 'auth.customer_emergency_contact';
  static const _kycTierKey = 'auth.customer_kyc_tier'; // 'light', 'id_verified'

  static const demoOtp = '123456';

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  Future<bool> isOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardedKey) ?? false;
  }

  Future<Map<String, String>> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_userNameKey) ?? 'Abhishek Kumar',
      'phone': prefs.getString(_userPhoneKey) ?? '9876543210',
      'email': prefs.getString(_userEmailKey) ?? 'abhishek@allcuro.care',
      'city': prefs.getString(_userCityKey) ?? 'Indiranagar, Bengaluru',
      'emergencyContact': prefs.getString(_emergencyContactKey) ?? '+91 91234 56789 (Brother)',
      'kycTier': prefs.getString(_kycTierKey) ?? 'light',
    };
  }

  Future<void> sendOtp(String phone) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (_digitsOf(phone).length != 10) {
      throw const AuthException('Enter a valid 10-digit phone number.');
    }
  }

  Future<void> verifyOtp({required String phone, required String otp}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (otp != demoOtp) {
      throw const AuthException('Incorrect code. Use demo code $demoOtp.');
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, true);
    await prefs.setString(_userPhoneKey, phone);
  }

  Future<void> completeOnboarding({
    required String name,
    required String email,
    required String city,
    required String emergencyContact,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
    await prefs.setString(_userEmailKey, email);
    await prefs.setString(_userCityKey, city);
    await prefs.setString(_emergencyContactKey, emergencyContact);
    await prefs.setBool(_onboardedKey, true);
  }

  Future<void> setKycTier(String tier) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kycTierKey, tier);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInKey);
    await prefs.remove(_onboardedKey);
  }

  String _digitsOf(String phone) => phone.replaceAll(RegExp(r'\D'), '');
}

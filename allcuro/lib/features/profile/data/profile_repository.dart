import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/profile.dart';
import 'profile_service.dart';

class ProfileRepository {
  final ProfileService _service;

  const ProfileRepository(this._service);

  Future<Profile> getCurrent() => _service.fetchCurrent();
}

final profileServiceProvider = Provider<ProfileService>((ref) => const ProfileService());

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.watch(profileServiceProvider)),
);

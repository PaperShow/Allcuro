import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/profile.dart';
import '../data/profile_repository.dart';

class ProfileViewModel extends AsyncNotifier<Profile> {
  @override
  Future<Profile> build() {
    return ref.watch(profileRepositoryProvider).getCurrent();
  }
}

final profileViewModelProvider = AsyncNotifierProvider<ProfileViewModel, Profile>(ProfileViewModel.new);

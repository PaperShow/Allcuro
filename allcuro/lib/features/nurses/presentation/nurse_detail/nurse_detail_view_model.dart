import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/nurse.dart';
import '../../data/nurses_repository.dart';

class NurseDetailViewModel extends FamilyAsyncNotifier<Nurse?, String> {
  @override
  Future<Nurse?> build(String arg) {
    return ref.watch(nursesRepositoryProvider).getById(arg);
  }
}

final nurseDetailViewModelProvider =
    AsyncNotifierProvider.family<NurseDetailViewModel, Nurse?, String>(NurseDetailViewModel.new);

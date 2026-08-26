import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/nurse.dart';
import '../../data/nurses_repository.dart';

class NursesListViewModel extends AsyncNotifier<List<Nurse>> {
  @override
  Future<List<Nurse>> build() {
    return ref.watch(nursesRepositoryProvider).getAll();
  }
}

final nursesListViewModelProvider =
    AsyncNotifierProvider<NursesListViewModel, List<Nurse>>(NursesListViewModel.new);

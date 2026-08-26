import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/centres_repository.dart';
import '../../data/models/centre.dart';

class CentresListViewModel extends AsyncNotifier<List<Centre>> {
  @override
  Future<List<Centre>> build() {
    return ref.watch(centresRepositoryProvider).getAll();
  }
}

final centresListViewModelProvider =
    AsyncNotifierProvider<CentresListViewModel, List<Centre>>(CentresListViewModel.new);

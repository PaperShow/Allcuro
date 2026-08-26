import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/nurse_performance_model.dart';
import '../../data/nurse_repository.dart';
import '../nurse_providers.dart';

final nursePerformanceViewModelProvider =
    AsyncNotifierProvider<NursePerformanceViewModel, NursePerformance>(
      NursePerformanceViewModel.new,
    );

class NursePerformanceViewModel extends AsyncNotifier<NursePerformance> {
  NurseRepository get _repository => ref.read(nurseRepositoryProvider);

  @override
  Future<NursePerformance> build() async {
    return _repository.getPerformance();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getPerformance());
  }
}

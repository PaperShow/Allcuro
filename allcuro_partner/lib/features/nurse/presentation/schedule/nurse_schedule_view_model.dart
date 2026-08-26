import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/shift.dart';
import '../../data/nurse_repository.dart';
import '../nurse_providers.dart';

final nurseScheduleViewModelProvider =
    AsyncNotifierProvider<NurseScheduleViewModel, List<Shift>>(
      NurseScheduleViewModel.new,
    );

/// The status filter (upcoming/ongoing/completed) is transient UI state
/// owned by `NurseScheduleScreen` itself — this view model only fetches
/// the underlying list.
class NurseScheduleViewModel extends AsyncNotifier<List<Shift>> {
  NurseRepository get _repository => ref.read(nurseRepositoryProvider);

  @override
  Future<List<Shift>> build() => _repository.shifts();
}

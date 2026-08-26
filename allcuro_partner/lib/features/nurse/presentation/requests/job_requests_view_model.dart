import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/job_request_summary.dart';
import '../../data/nurse_repository.dart';
import '../nurse_providers.dart';

final jobRequestsViewModelProvider =
    AsyncNotifierProvider<JobRequestsViewModel, List<JobRequestSummary>>(
      JobRequestsViewModel.new,
    );

/// Backs both `JobRequestsScreen` (the full list) and `JobDetailScreen`'s
/// accept/decline actions, so accepting from the detail screen removes the
/// same request the list screen shows.
class JobRequestsViewModel extends AsyncNotifier<List<JobRequestSummary>> {
  NurseRepository get _repository => ref.read(nurseRepositoryProvider);

  @override
  Future<List<JobRequestSummary>> build() => _repository.pendingRequests();

  Future<void> accept(String id) => _mutate(() => _repository.acceptRequest(id));

  Future<void> decline(String id) =>
      _mutate(() => _repository.declineRequest(id));

  Future<void> _mutate(Future<void> Function() action) async {
    await action();
    state = await AsyncValue.guard(_repository.pendingRequests);
  }
}

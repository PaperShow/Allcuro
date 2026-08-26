import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/centre_repository.dart';
import '../../data/models/placement_request_summary.dart';
import '../centre_providers.dart';

final centreRequestsViewModelProvider =
    AsyncNotifierProvider<CentreRequestsViewModel, List<PlacementRequestSummary>>(
      CentreRequestsViewModel.new,
    );

class CentreRequestsViewModel extends AsyncNotifier<List<PlacementRequestSummary>> {
  CentreRepository get _repository => ref.read(centreRepositoryProvider);

  @override
  Future<List<PlacementRequestSummary>> build() => _repository.pendingRequests();

  Future<void> accept(String id) => _mutate(() => _repository.acceptRequest(id));

  Future<void> decline(String id) => _mutate(() => _repository.declineRequest(id));

  Future<void> _mutate(Future<void> Function() action) async {
    await action();
    state = await AsyncValue.guard(_repository.pendingRequests);
  }
}

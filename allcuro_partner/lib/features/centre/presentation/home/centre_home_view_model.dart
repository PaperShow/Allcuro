import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/centre_repository.dart';
import '../../data/models/placement_request_summary.dart';
import '../centre_providers.dart';

/// Aggregated view of everything `CentreHomeScreen` shows. Occupancy is
/// derived from the same room/bed list `RoomInventoryScreen` uses, so the
/// dashboard never drifts out of sync with it.
class CentreHomeSummary {
  final int occupiedBeds;
  final int totalBeds;
  final int pendingRequestCount;
  final int admittedThisMonth;
  final List<PlacementRequestSummary> previewRequests;

  const CentreHomeSummary({
    required this.occupiedBeds,
    required this.totalBeds,
    required this.pendingRequestCount,
    required this.admittedThisMonth,
    required this.previewRequests,
  });
}

final centreHomeViewModelProvider =
    AsyncNotifierProvider<CentreHomeViewModel, CentreHomeSummary>(
      CentreHomeViewModel.new,
    );

class CentreHomeViewModel extends AsyncNotifier<CentreHomeSummary> {
  CentreRepository get _repository => ref.read(centreRepositoryProvider);

  @override
  Future<CentreHomeSummary> build() async {
    final rooms = await _repository.rooms();
    final requests = await _repository.pendingRequests();
    final admitted = await _repository.admittedThisMonth();

    final allBeds = rooms.expand((room) => room.beds).toList();
    final occupied = allBeds.where((bed) => bed.occupied).length;

    return CentreHomeSummary(
      occupiedBeds: occupied,
      totalBeds: allBeds.length,
      pendingRequestCount: requests.length,
      admittedThisMonth: admitted,
      previewRequests: requests.take(2).toList(),
    );
  }
}

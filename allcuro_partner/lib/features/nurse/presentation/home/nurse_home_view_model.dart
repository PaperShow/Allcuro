import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/job_request_summary.dart';
import '../../data/models/nurse_visit_model.dart';
import '../../data/models/shift.dart';
import '../../data/nurse_repository.dart';
import '../nurse_providers.dart';

/// Aggregated view of everything `NurseHomeScreen` shows — computed from
/// the same pending-requests, shifts, and live visit data.
class NurseHomeSummary {
  final int pendingRequestCount;
  final int shiftsThisWeek;
  final Shift? nextShift;
  final NurseVisit? activeVisit;
  final List<JobRequestSummary> previewRequests;
  final bool isOnDuty;
  final String shiftTiming;

  const NurseHomeSummary({
    required this.pendingRequestCount,
    required this.shiftsThisWeek,
    required this.nextShift,
    required this.activeVisit,
    required this.previewRequests,
    required this.isOnDuty,
    required this.shiftTiming,
  });
}

final nurseHomeViewModelProvider =
    AsyncNotifierProvider<NurseHomeViewModel, NurseHomeSummary>(
      NurseHomeViewModel.new,
    );

class NurseHomeViewModel extends AsyncNotifier<NurseHomeSummary> {
  NurseRepository get _repository => ref.read(nurseRepositoryProvider);

  @override
  Future<NurseHomeSummary> build() async {
    final requests = await _repository.pendingRequests();
    final shifts = await _repository.shifts();
    final activeVisit = await _repository.getActiveVisit();
    final active = shifts.where((s) => s.status != ShiftStatus.completed);

    Shift? nextShift;
    for (final shift in shifts) {
      if (shift.status == ShiftStatus.ongoing ||
          shift.status == ShiftStatus.upcoming) {
        nextShift = shift;
        break;
      }
    }

    return NurseHomeSummary(
      pendingRequestCount: requests.length,
      shiftsThisWeek: active.length,
      nextShift: nextShift,
      activeVisit: activeVisit,
      previewRequests: requests.take(2).toList(),
      isOnDuty: _repository.isOnDuty,
      shiftTiming: _repository.currentShiftTiming,
    );
  }

  Future<void> toggleDutyStatus(bool onDuty, {String? timing}) async {
    final t = timing ?? _repository.currentShiftTiming;
    await _repository.setDutyStatus(onDuty, t);
    ref.invalidateSelf();
  }
}

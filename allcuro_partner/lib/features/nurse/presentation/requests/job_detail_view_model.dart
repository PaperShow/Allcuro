import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/job_request_detail.dart';
import '../nurse_providers.dart';

/// Read-only fetch of a single request's detail. Accepting/declining is
/// handled by `JobRequestsViewModel` — the request is a single record, not
/// something the detail screen owns independently.
final jobRequestDetailProvider =
    FutureProvider.family<JobRequestDetail, String>((ref, id) {
      return ref.read(nurseRepositoryProvider).requestDetail(id);
    });

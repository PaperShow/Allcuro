import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/centres_repository.dart';
import '../../data/models/centre.dart';

class CentreDetailViewModel extends FamilyAsyncNotifier<Centre?, String> {
  @override
  Future<Centre?> build(String arg) {
    return ref.watch(centresRepositoryProvider).getById(arg);
  }
}

final centreDetailViewModelProvider =
    AsyncNotifierProvider.family<CentreDetailViewModel, Centre?, String>(CentreDetailViewModel.new);

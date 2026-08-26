import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../centres/data/centres_repository.dart';
import '../../centres/data/models/centre.dart';
import '../../nurses/data/models/nurse.dart';
import '../../nurses/data/nurses_repository.dart';

class HomeData {
  final List<Centre> centres;
  final List<Nurse> nurses;

  const HomeData({required this.centres, required this.nurses});
}

/// Composes two feature repositories — the home dashboard has no data of
/// its own, it's a curated view over centres and nurses.
class HomeViewModel extends AsyncNotifier<HomeData> {
  @override
  Future<HomeData> build() async {
    final results = await Future.wait([
      ref.watch(centresRepositoryProvider).getAll(),
      ref.watch(nursesRepositoryProvider).getAll(),
    ]);
    return HomeData(centres: results[0] as List<Centre>, nurses: results[1] as List<Nurse>);
  }
}

final homeViewModelProvider = AsyncNotifierProvider<HomeViewModel, HomeData>(HomeViewModel.new);

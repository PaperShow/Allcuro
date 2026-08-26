import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/centre_repository.dart';
import '../../data/models/room.dart';
import '../centre_providers.dart';

final roomInventoryViewModelProvider =
    AsyncNotifierProvider<RoomInventoryViewModel, List<Room>>(
      RoomInventoryViewModel.new,
    );

class RoomInventoryViewModel extends AsyncNotifier<List<Room>> {
  CentreRepository get _repository => ref.read(centreRepositoryProvider);

  @override
  Future<List<Room>> build() => _repository.rooms();
}

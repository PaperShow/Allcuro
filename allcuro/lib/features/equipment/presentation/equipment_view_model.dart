import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/equipment_repository.dart';
import '../data/models/equipment.dart';

class EquipmentListData {
  final List<Equipment> equipment;
  final List<String> categories;

  const EquipmentListData({required this.equipment, required this.categories});
}

class EquipmentViewModel extends AsyncNotifier<EquipmentListData> {
  @override
  Future<EquipmentListData> build() async {
    final repository = ref.watch(equipmentRepositoryProvider);
    final results = await Future.wait([repository.getAll(), repository.getCategories()]);
    return EquipmentListData(
      equipment: results[0] as List<Equipment>,
      categories: results[1] as List<String>,
    );
  }
}

final equipmentViewModelProvider =
    AsyncNotifierProvider<EquipmentViewModel, EquipmentListData>(EquipmentViewModel.new);

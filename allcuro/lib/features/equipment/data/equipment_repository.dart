import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'equipment_service.dart';
import 'models/equipment.dart';

class EquipmentRepository {
  final EquipmentService _service;

  const EquipmentRepository(this._service);

  Future<List<Equipment>> getAll() => _service.fetchAll();

  Future<List<String>> getCategories() => _service.fetchCategories();
}

final equipmentServiceProvider = Provider<EquipmentService>((ref) => const EquipmentService());

final equipmentRepositoryProvider = Provider<EquipmentRepository>(
  (ref) => EquipmentRepository(ref.watch(equipmentServiceProvider)),
);

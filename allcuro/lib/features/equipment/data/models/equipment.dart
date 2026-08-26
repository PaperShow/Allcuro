import 'package:freezed_annotation/freezed_annotation.dart';

part 'equipment.freezed.dart';
part 'equipment.g.dart';

@freezed
class Equipment with _$Equipment {
  const factory Equipment({
    required String id,
    required String name,
    required String category,
    required String photo,
    required int perDay,
    required int perMonth,
    required int deposit,
    required String condition,
    required String availableIn,
  }) = _Equipment;

  factory Equipment.fromJson(Map<String, dynamic> json) => _$EquipmentFromJson(json);
}

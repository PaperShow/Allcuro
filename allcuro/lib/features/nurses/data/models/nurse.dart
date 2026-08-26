import 'package:freezed_annotation/freezed_annotation.dart';

import 'employment.dart';
import 'shift_option.dart';

export 'employment.dart';

part 'nurse.freezed.dart';
part 'nurse.g.dart';

@freezed
class Nurse with _$Nurse {
  const factory Nurse({
    required String id,
    required String name,
    required String photo,
    required String allcuroId,
    required String level,
    required int experience,
    required String city,
    required List<String> languages,
    required List<String> tags,
    required double rating,
    required int reviews,
    required List<String> highlights,
    required List<ShiftOption> shifts,
    required Employment employment,
  }) = _Nurse;

  factory Nurse.fromJson(Map<String, dynamic> json) => _$NurseFromJson(json);
}

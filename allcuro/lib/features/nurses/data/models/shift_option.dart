import 'package:freezed_annotation/freezed_annotation.dart';

part 'shift_option.freezed.dart';
part 'shift_option.g.dart';

@freezed
class ShiftOption with _$ShiftOption {
  const factory ShiftOption({
    required String label,
    required int price,
    required bool available,
  }) = _ShiftOption;

  factory ShiftOption.fromJson(Map<String, dynamic> json) => _$ShiftOptionFromJson(json);
}

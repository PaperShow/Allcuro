// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShiftOptionImpl _$$ShiftOptionImplFromJson(Map<String, dynamic> json) =>
    _$ShiftOptionImpl(
      label: json['label'] as String,
      price: (json['price'] as num).toInt(),
      available: json['available'] as bool,
    );

Map<String, dynamic> _$$ShiftOptionImplToJson(_$ShiftOptionImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'price': instance.price,
      'available': instance.available,
    };

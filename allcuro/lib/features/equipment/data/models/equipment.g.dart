// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EquipmentImpl _$$EquipmentImplFromJson(Map<String, dynamic> json) =>
    _$EquipmentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      photo: json['photo'] as String,
      perDay: (json['perDay'] as num).toInt(),
      perMonth: (json['perMonth'] as num).toInt(),
      deposit: (json['deposit'] as num).toInt(),
      condition: json['condition'] as String,
      availableIn: json['availableIn'] as String,
    );

Map<String, dynamic> _$$EquipmentImplToJson(_$EquipmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'photo': instance.photo,
      'perDay': instance.perDay,
      'perMonth': instance.perMonth,
      'deposit': instance.deposit,
      'condition': instance.condition,
      'availableIn': instance.availableIn,
    };

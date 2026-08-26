// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_breakdown.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PricingBreakdownImpl _$$PricingBreakdownImplFromJson(
  Map<String, dynamic> json,
) => _$PricingBreakdownImpl(
  base: (json['base'] as num).toInt(),
  discount: (json['discount'] as num).toInt(),
  fee: (json['fee'] as num).toInt(),
  gst: (json['gst'] as num).toInt(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$$PricingBreakdownImplToJson(
  _$PricingBreakdownImpl instance,
) => <String, dynamic>{
  'base': instance.base,
  'discount': instance.discount,
  'fee': instance.fee,
  'gst': instance.gst,
  'total': instance.total,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'centre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CentreImpl _$$CentreImplFromJson(Map<String, dynamic> json) => _$CentreImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  locality: json['locality'] as String,
  city: json['city'] as String,
  photo: json['photo'] as String,
  photoCount: (json['photoCount'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
  reviews: (json['reviews'] as num).toInt(),
  since: (json['since'] as num).toInt(),
  licence: json['licence'] as String,
  staffRatio: json['staffRatio'] as String,
  pricePerDay: (json['pricePerDay'] as num).toInt(),
  pricePerMonth: (json['pricePerMonth'] as num).toInt(),
  bedsLeft: (json['bedsLeft'] as num).toInt(),
  services: (json['services'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  scores: (json['scores'] as List<dynamic>)
      .map((e) => ScoreItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$CentreImplToJson(_$CentreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'locality': instance.locality,
      'city': instance.city,
      'photo': instance.photo,
      'photoCount': instance.photoCount,
      'rating': instance.rating,
      'reviews': instance.reviews,
      'since': instance.since,
      'licence': instance.licence,
      'staffRatio': instance.staffRatio,
      'pricePerDay': instance.pricePerDay,
      'pricePerMonth': instance.pricePerMonth,
      'bedsLeft': instance.bedsLeft,
      'services': instance.services,
      'scores': instance.scores,
    };

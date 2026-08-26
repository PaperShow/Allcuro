// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nurse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NurseImpl _$$NurseImplFromJson(Map<String, dynamic> json) => _$NurseImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  photo: json['photo'] as String,
  allcuroId: json['allcuroId'] as String,
  level: json['level'] as String,
  experience: (json['experience'] as num).toInt(),
  city: json['city'] as String,
  languages: (json['languages'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  rating: (json['rating'] as num).toDouble(),
  reviews: (json['reviews'] as num).toInt(),
  highlights: (json['highlights'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  shifts: (json['shifts'] as List<dynamic>)
      .map((e) => ShiftOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  employment: $enumDecode(_$EmploymentEnumMap, json['employment']),
);

Map<String, dynamic> _$$NurseImplToJson(_$NurseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'allcuroId': instance.allcuroId,
      'level': instance.level,
      'experience': instance.experience,
      'city': instance.city,
      'languages': instance.languages,
      'tags': instance.tags,
      'rating': instance.rating,
      'reviews': instance.reviews,
      'highlights': instance.highlights,
      'shifts': instance.shifts,
      'employment': _$EmploymentEnumMap[instance.employment]!,
    };

const _$EmploymentEnumMap = {
  Employment.fullTime: 'fullTime',
  Employment.partTime: 'partTime',
  Employment.liveIn: 'liveIn',
};

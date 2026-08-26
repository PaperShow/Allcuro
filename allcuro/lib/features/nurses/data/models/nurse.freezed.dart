// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nurse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Nurse _$NurseFromJson(Map<String, dynamic> json) {
  return _Nurse.fromJson(json);
}

/// @nodoc
mixin _$Nurse {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get photo => throw _privateConstructorUsedError;
  String get allcuroId => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  int get experience => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  List<String> get languages => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get reviews => throw _privateConstructorUsedError;
  List<String> get highlights => throw _privateConstructorUsedError;
  List<ShiftOption> get shifts => throw _privateConstructorUsedError;
  Employment get employment => throw _privateConstructorUsedError;

  /// Serializes this Nurse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Nurse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NurseCopyWith<Nurse> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NurseCopyWith<$Res> {
  factory $NurseCopyWith(Nurse value, $Res Function(Nurse) then) =
      _$NurseCopyWithImpl<$Res, Nurse>;
  @useResult
  $Res call({
    String id,
    String name,
    String photo,
    String allcuroId,
    String level,
    int experience,
    String city,
    List<String> languages,
    List<String> tags,
    double rating,
    int reviews,
    List<String> highlights,
    List<ShiftOption> shifts,
    Employment employment,
  });
}

/// @nodoc
class _$NurseCopyWithImpl<$Res, $Val extends Nurse>
    implements $NurseCopyWith<$Res> {
  _$NurseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Nurse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photo = null,
    Object? allcuroId = null,
    Object? level = null,
    Object? experience = null,
    Object? city = null,
    Object? languages = null,
    Object? tags = null,
    Object? rating = null,
    Object? reviews = null,
    Object? highlights = null,
    Object? shifts = null,
    Object? employment = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            photo: null == photo
                ? _value.photo
                : photo // ignore: cast_nullable_to_non_nullable
                      as String,
            allcuroId: null == allcuroId
                ? _value.allcuroId
                : allcuroId // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String,
            experience: null == experience
                ? _value.experience
                : experience // ignore: cast_nullable_to_non_nullable
                      as int,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            languages: null == languages
                ? _value.languages
                : languages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviews: null == reviews
                ? _value.reviews
                : reviews // ignore: cast_nullable_to_non_nullable
                      as int,
            highlights: null == highlights
                ? _value.highlights
                : highlights // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            shifts: null == shifts
                ? _value.shifts
                : shifts // ignore: cast_nullable_to_non_nullable
                      as List<ShiftOption>,
            employment: null == employment
                ? _value.employment
                : employment // ignore: cast_nullable_to_non_nullable
                      as Employment,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NurseImplCopyWith<$Res> implements $NurseCopyWith<$Res> {
  factory _$$NurseImplCopyWith(
    _$NurseImpl value,
    $Res Function(_$NurseImpl) then,
  ) = __$$NurseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String photo,
    String allcuroId,
    String level,
    int experience,
    String city,
    List<String> languages,
    List<String> tags,
    double rating,
    int reviews,
    List<String> highlights,
    List<ShiftOption> shifts,
    Employment employment,
  });
}

/// @nodoc
class __$$NurseImplCopyWithImpl<$Res>
    extends _$NurseCopyWithImpl<$Res, _$NurseImpl>
    implements _$$NurseImplCopyWith<$Res> {
  __$$NurseImplCopyWithImpl(
    _$NurseImpl _value,
    $Res Function(_$NurseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Nurse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photo = null,
    Object? allcuroId = null,
    Object? level = null,
    Object? experience = null,
    Object? city = null,
    Object? languages = null,
    Object? tags = null,
    Object? rating = null,
    Object? reviews = null,
    Object? highlights = null,
    Object? shifts = null,
    Object? employment = null,
  }) {
    return _then(
      _$NurseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        photo: null == photo
            ? _value.photo
            : photo // ignore: cast_nullable_to_non_nullable
                  as String,
        allcuroId: null == allcuroId
            ? _value.allcuroId
            : allcuroId // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String,
        experience: null == experience
            ? _value.experience
            : experience // ignore: cast_nullable_to_non_nullable
                  as int,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        languages: null == languages
            ? _value._languages
            : languages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviews: null == reviews
            ? _value.reviews
            : reviews // ignore: cast_nullable_to_non_nullable
                  as int,
        highlights: null == highlights
            ? _value._highlights
            : highlights // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        shifts: null == shifts
            ? _value._shifts
            : shifts // ignore: cast_nullable_to_non_nullable
                  as List<ShiftOption>,
        employment: null == employment
            ? _value.employment
            : employment // ignore: cast_nullable_to_non_nullable
                  as Employment,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NurseImpl implements _Nurse {
  const _$NurseImpl({
    required this.id,
    required this.name,
    required this.photo,
    required this.allcuroId,
    required this.level,
    required this.experience,
    required this.city,
    required final List<String> languages,
    required final List<String> tags,
    required this.rating,
    required this.reviews,
    required final List<String> highlights,
    required final List<ShiftOption> shifts,
    required this.employment,
  }) : _languages = languages,
       _tags = tags,
       _highlights = highlights,
       _shifts = shifts;

  factory _$NurseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NurseImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String photo;
  @override
  final String allcuroId;
  @override
  final String level;
  @override
  final int experience;
  @override
  final String city;
  final List<String> _languages;
  @override
  List<String> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final double rating;
  @override
  final int reviews;
  final List<String> _highlights;
  @override
  List<String> get highlights {
    if (_highlights is EqualUnmodifiableListView) return _highlights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_highlights);
  }

  final List<ShiftOption> _shifts;
  @override
  List<ShiftOption> get shifts {
    if (_shifts is EqualUnmodifiableListView) return _shifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shifts);
  }

  @override
  final Employment employment;

  @override
  String toString() {
    return 'Nurse(id: $id, name: $name, photo: $photo, allcuroId: $allcuroId, level: $level, experience: $experience, city: $city, languages: $languages, tags: $tags, rating: $rating, reviews: $reviews, highlights: $highlights, shifts: $shifts, employment: $employment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NurseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.allcuroId, allcuroId) ||
                other.allcuroId == allcuroId) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.city, city) || other.city == city) &&
            const DeepCollectionEquality().equals(
              other._languages,
              _languages,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviews, reviews) || other.reviews == reviews) &&
            const DeepCollectionEquality().equals(
              other._highlights,
              _highlights,
            ) &&
            const DeepCollectionEquality().equals(other._shifts, _shifts) &&
            (identical(other.employment, employment) ||
                other.employment == employment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    photo,
    allcuroId,
    level,
    experience,
    city,
    const DeepCollectionEquality().hash(_languages),
    const DeepCollectionEquality().hash(_tags),
    rating,
    reviews,
    const DeepCollectionEquality().hash(_highlights),
    const DeepCollectionEquality().hash(_shifts),
    employment,
  );

  /// Create a copy of Nurse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NurseImplCopyWith<_$NurseImpl> get copyWith =>
      __$$NurseImplCopyWithImpl<_$NurseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NurseImplToJson(this);
  }
}

abstract class _Nurse implements Nurse {
  const factory _Nurse({
    required final String id,
    required final String name,
    required final String photo,
    required final String allcuroId,
    required final String level,
    required final int experience,
    required final String city,
    required final List<String> languages,
    required final List<String> tags,
    required final double rating,
    required final int reviews,
    required final List<String> highlights,
    required final List<ShiftOption> shifts,
    required final Employment employment,
  }) = _$NurseImpl;

  factory _Nurse.fromJson(Map<String, dynamic> json) = _$NurseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get photo;
  @override
  String get allcuroId;
  @override
  String get level;
  @override
  int get experience;
  @override
  String get city;
  @override
  List<String> get languages;
  @override
  List<String> get tags;
  @override
  double get rating;
  @override
  int get reviews;
  @override
  List<String> get highlights;
  @override
  List<ShiftOption> get shifts;
  @override
  Employment get employment;

  /// Create a copy of Nurse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NurseImplCopyWith<_$NurseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

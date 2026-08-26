// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'centre.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Centre _$CentreFromJson(Map<String, dynamic> json) {
  return _Centre.fromJson(json);
}

/// @nodoc
mixin _$Centre {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get locality => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get photo => throw _privateConstructorUsedError;
  int get photoCount => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get reviews => throw _privateConstructorUsedError;
  int get since => throw _privateConstructorUsedError;
  String get licence => throw _privateConstructorUsedError;
  String get staffRatio => throw _privateConstructorUsedError;
  int get pricePerDay => throw _privateConstructorUsedError;
  int get pricePerMonth => throw _privateConstructorUsedError;
  int get bedsLeft => throw _privateConstructorUsedError;
  List<String> get services => throw _privateConstructorUsedError;
  List<ScoreItem> get scores => throw _privateConstructorUsedError;

  /// Serializes this Centre to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Centre
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CentreCopyWith<Centre> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CentreCopyWith<$Res> {
  factory $CentreCopyWith(Centre value, $Res Function(Centre) then) =
      _$CentreCopyWithImpl<$Res, Centre>;
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    String locality,
    String city,
    String photo,
    int photoCount,
    double rating,
    int reviews,
    int since,
    String licence,
    String staffRatio,
    int pricePerDay,
    int pricePerMonth,
    int bedsLeft,
    List<String> services,
    List<ScoreItem> scores,
  });
}

/// @nodoc
class _$CentreCopyWithImpl<$Res, $Val extends Centre>
    implements $CentreCopyWith<$Res> {
  _$CentreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Centre
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? locality = null,
    Object? city = null,
    Object? photo = null,
    Object? photoCount = null,
    Object? rating = null,
    Object? reviews = null,
    Object? since = null,
    Object? licence = null,
    Object? staffRatio = null,
    Object? pricePerDay = null,
    Object? pricePerMonth = null,
    Object? bedsLeft = null,
    Object? services = null,
    Object? scores = null,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            locality: null == locality
                ? _value.locality
                : locality // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            photo: null == photo
                ? _value.photo
                : photo // ignore: cast_nullable_to_non_nullable
                      as String,
            photoCount: null == photoCount
                ? _value.photoCount
                : photoCount // ignore: cast_nullable_to_non_nullable
                      as int,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviews: null == reviews
                ? _value.reviews
                : reviews // ignore: cast_nullable_to_non_nullable
                      as int,
            since: null == since
                ? _value.since
                : since // ignore: cast_nullable_to_non_nullable
                      as int,
            licence: null == licence
                ? _value.licence
                : licence // ignore: cast_nullable_to_non_nullable
                      as String,
            staffRatio: null == staffRatio
                ? _value.staffRatio
                : staffRatio // ignore: cast_nullable_to_non_nullable
                      as String,
            pricePerDay: null == pricePerDay
                ? _value.pricePerDay
                : pricePerDay // ignore: cast_nullable_to_non_nullable
                      as int,
            pricePerMonth: null == pricePerMonth
                ? _value.pricePerMonth
                : pricePerMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            bedsLeft: null == bedsLeft
                ? _value.bedsLeft
                : bedsLeft // ignore: cast_nullable_to_non_nullable
                      as int,
            services: null == services
                ? _value.services
                : services // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            scores: null == scores
                ? _value.scores
                : scores // ignore: cast_nullable_to_non_nullable
                      as List<ScoreItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CentreImplCopyWith<$Res> implements $CentreCopyWith<$Res> {
  factory _$$CentreImplCopyWith(
    _$CentreImpl value,
    $Res Function(_$CentreImpl) then,
  ) = __$$CentreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    String locality,
    String city,
    String photo,
    int photoCount,
    double rating,
    int reviews,
    int since,
    String licence,
    String staffRatio,
    int pricePerDay,
    int pricePerMonth,
    int bedsLeft,
    List<String> services,
    List<ScoreItem> scores,
  });
}

/// @nodoc
class __$$CentreImplCopyWithImpl<$Res>
    extends _$CentreCopyWithImpl<$Res, _$CentreImpl>
    implements _$$CentreImplCopyWith<$Res> {
  __$$CentreImplCopyWithImpl(
    _$CentreImpl _value,
    $Res Function(_$CentreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Centre
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? locality = null,
    Object? city = null,
    Object? photo = null,
    Object? photoCount = null,
    Object? rating = null,
    Object? reviews = null,
    Object? since = null,
    Object? licence = null,
    Object? staffRatio = null,
    Object? pricePerDay = null,
    Object? pricePerMonth = null,
    Object? bedsLeft = null,
    Object? services = null,
    Object? scores = null,
  }) {
    return _then(
      _$CentreImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        locality: null == locality
            ? _value.locality
            : locality // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        photo: null == photo
            ? _value.photo
            : photo // ignore: cast_nullable_to_non_nullable
                  as String,
        photoCount: null == photoCount
            ? _value.photoCount
            : photoCount // ignore: cast_nullable_to_non_nullable
                  as int,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviews: null == reviews
            ? _value.reviews
            : reviews // ignore: cast_nullable_to_non_nullable
                  as int,
        since: null == since
            ? _value.since
            : since // ignore: cast_nullable_to_non_nullable
                  as int,
        licence: null == licence
            ? _value.licence
            : licence // ignore: cast_nullable_to_non_nullable
                  as String,
        staffRatio: null == staffRatio
            ? _value.staffRatio
            : staffRatio // ignore: cast_nullable_to_non_nullable
                  as String,
        pricePerDay: null == pricePerDay
            ? _value.pricePerDay
            : pricePerDay // ignore: cast_nullable_to_non_nullable
                  as int,
        pricePerMonth: null == pricePerMonth
            ? _value.pricePerMonth
            : pricePerMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        bedsLeft: null == bedsLeft
            ? _value.bedsLeft
            : bedsLeft // ignore: cast_nullable_to_non_nullable
                  as int,
        services: null == services
            ? _value._services
            : services // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        scores: null == scores
            ? _value._scores
            : scores // ignore: cast_nullable_to_non_nullable
                  as List<ScoreItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CentreImpl implements _Centre {
  const _$CentreImpl({
    required this.id,
    required this.name,
    required this.type,
    required this.locality,
    required this.city,
    required this.photo,
    required this.photoCount,
    required this.rating,
    required this.reviews,
    required this.since,
    required this.licence,
    required this.staffRatio,
    required this.pricePerDay,
    required this.pricePerMonth,
    required this.bedsLeft,
    required final List<String> services,
    required final List<ScoreItem> scores,
  }) : _services = services,
       _scores = scores;

  factory _$CentreImpl.fromJson(Map<String, dynamic> json) =>
      _$$CentreImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String locality;
  @override
  final String city;
  @override
  final String photo;
  @override
  final int photoCount;
  @override
  final double rating;
  @override
  final int reviews;
  @override
  final int since;
  @override
  final String licence;
  @override
  final String staffRatio;
  @override
  final int pricePerDay;
  @override
  final int pricePerMonth;
  @override
  final int bedsLeft;
  final List<String> _services;
  @override
  List<String> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  final List<ScoreItem> _scores;
  @override
  List<ScoreItem> get scores {
    if (_scores is EqualUnmodifiableListView) return _scores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scores);
  }

  @override
  String toString() {
    return 'Centre(id: $id, name: $name, type: $type, locality: $locality, city: $city, photo: $photo, photoCount: $photoCount, rating: $rating, reviews: $reviews, since: $since, licence: $licence, staffRatio: $staffRatio, pricePerDay: $pricePerDay, pricePerMonth: $pricePerMonth, bedsLeft: $bedsLeft, services: $services, scores: $scores)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CentreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.locality, locality) ||
                other.locality == locality) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.photoCount, photoCount) ||
                other.photoCount == photoCount) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviews, reviews) || other.reviews == reviews) &&
            (identical(other.since, since) || other.since == since) &&
            (identical(other.licence, licence) || other.licence == licence) &&
            (identical(other.staffRatio, staffRatio) ||
                other.staffRatio == staffRatio) &&
            (identical(other.pricePerDay, pricePerDay) ||
                other.pricePerDay == pricePerDay) &&
            (identical(other.pricePerMonth, pricePerMonth) ||
                other.pricePerMonth == pricePerMonth) &&
            (identical(other.bedsLeft, bedsLeft) ||
                other.bedsLeft == bedsLeft) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            const DeepCollectionEquality().equals(other._scores, _scores));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    locality,
    city,
    photo,
    photoCount,
    rating,
    reviews,
    since,
    licence,
    staffRatio,
    pricePerDay,
    pricePerMonth,
    bedsLeft,
    const DeepCollectionEquality().hash(_services),
    const DeepCollectionEquality().hash(_scores),
  );

  /// Create a copy of Centre
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CentreImplCopyWith<_$CentreImpl> get copyWith =>
      __$$CentreImplCopyWithImpl<_$CentreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CentreImplToJson(this);
  }
}

abstract class _Centre implements Centre {
  const factory _Centre({
    required final String id,
    required final String name,
    required final String type,
    required final String locality,
    required final String city,
    required final String photo,
    required final int photoCount,
    required final double rating,
    required final int reviews,
    required final int since,
    required final String licence,
    required final String staffRatio,
    required final int pricePerDay,
    required final int pricePerMonth,
    required final int bedsLeft,
    required final List<String> services,
    required final List<ScoreItem> scores,
  }) = _$CentreImpl;

  factory _Centre.fromJson(Map<String, dynamic> json) = _$CentreImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get locality;
  @override
  String get city;
  @override
  String get photo;
  @override
  int get photoCount;
  @override
  double get rating;
  @override
  int get reviews;
  @override
  int get since;
  @override
  String get licence;
  @override
  String get staffRatio;
  @override
  int get pricePerDay;
  @override
  int get pricePerMonth;
  @override
  int get bedsLeft;
  @override
  List<String> get services;
  @override
  List<ScoreItem> get scores;

  /// Create a copy of Centre
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CentreImplCopyWith<_$CentreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

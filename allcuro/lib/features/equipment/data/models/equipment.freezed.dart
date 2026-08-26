// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'equipment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Equipment _$EquipmentFromJson(Map<String, dynamic> json) {
  return _Equipment.fromJson(json);
}

/// @nodoc
mixin _$Equipment {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get photo => throw _privateConstructorUsedError;
  int get perDay => throw _privateConstructorUsedError;
  int get perMonth => throw _privateConstructorUsedError;
  int get deposit => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  String get availableIn => throw _privateConstructorUsedError;

  /// Serializes this Equipment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Equipment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EquipmentCopyWith<Equipment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EquipmentCopyWith<$Res> {
  factory $EquipmentCopyWith(Equipment value, $Res Function(Equipment) then) =
      _$EquipmentCopyWithImpl<$Res, Equipment>;
  @useResult
  $Res call({
    String id,
    String name,
    String category,
    String photo,
    int perDay,
    int perMonth,
    int deposit,
    String condition,
    String availableIn,
  });
}

/// @nodoc
class _$EquipmentCopyWithImpl<$Res, $Val extends Equipment>
    implements $EquipmentCopyWith<$Res> {
  _$EquipmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Equipment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? photo = null,
    Object? perDay = null,
    Object? perMonth = null,
    Object? deposit = null,
    Object? condition = null,
    Object? availableIn = null,
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
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            photo: null == photo
                ? _value.photo
                : photo // ignore: cast_nullable_to_non_nullable
                      as String,
            perDay: null == perDay
                ? _value.perDay
                : perDay // ignore: cast_nullable_to_non_nullable
                      as int,
            perMonth: null == perMonth
                ? _value.perMonth
                : perMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            deposit: null == deposit
                ? _value.deposit
                : deposit // ignore: cast_nullable_to_non_nullable
                      as int,
            condition: null == condition
                ? _value.condition
                : condition // ignore: cast_nullable_to_non_nullable
                      as String,
            availableIn: null == availableIn
                ? _value.availableIn
                : availableIn // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EquipmentImplCopyWith<$Res>
    implements $EquipmentCopyWith<$Res> {
  factory _$$EquipmentImplCopyWith(
    _$EquipmentImpl value,
    $Res Function(_$EquipmentImpl) then,
  ) = __$$EquipmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String category,
    String photo,
    int perDay,
    int perMonth,
    int deposit,
    String condition,
    String availableIn,
  });
}

/// @nodoc
class __$$EquipmentImplCopyWithImpl<$Res>
    extends _$EquipmentCopyWithImpl<$Res, _$EquipmentImpl>
    implements _$$EquipmentImplCopyWith<$Res> {
  __$$EquipmentImplCopyWithImpl(
    _$EquipmentImpl _value,
    $Res Function(_$EquipmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Equipment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? photo = null,
    Object? perDay = null,
    Object? perMonth = null,
    Object? deposit = null,
    Object? condition = null,
    Object? availableIn = null,
  }) {
    return _then(
      _$EquipmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        photo: null == photo
            ? _value.photo
            : photo // ignore: cast_nullable_to_non_nullable
                  as String,
        perDay: null == perDay
            ? _value.perDay
            : perDay // ignore: cast_nullable_to_non_nullable
                  as int,
        perMonth: null == perMonth
            ? _value.perMonth
            : perMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        deposit: null == deposit
            ? _value.deposit
            : deposit // ignore: cast_nullable_to_non_nullable
                  as int,
        condition: null == condition
            ? _value.condition
            : condition // ignore: cast_nullable_to_non_nullable
                  as String,
        availableIn: null == availableIn
            ? _value.availableIn
            : availableIn // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EquipmentImpl implements _Equipment {
  const _$EquipmentImpl({
    required this.id,
    required this.name,
    required this.category,
    required this.photo,
    required this.perDay,
    required this.perMonth,
    required this.deposit,
    required this.condition,
    required this.availableIn,
  });

  factory _$EquipmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$EquipmentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String category;
  @override
  final String photo;
  @override
  final int perDay;
  @override
  final int perMonth;
  @override
  final int deposit;
  @override
  final String condition;
  @override
  final String availableIn;

  @override
  String toString() {
    return 'Equipment(id: $id, name: $name, category: $category, photo: $photo, perDay: $perDay, perMonth: $perMonth, deposit: $deposit, condition: $condition, availableIn: $availableIn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EquipmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.perDay, perDay) || other.perDay == perDay) &&
            (identical(other.perMonth, perMonth) ||
                other.perMonth == perMonth) &&
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.availableIn, availableIn) ||
                other.availableIn == availableIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    category,
    photo,
    perDay,
    perMonth,
    deposit,
    condition,
    availableIn,
  );

  /// Create a copy of Equipment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EquipmentImplCopyWith<_$EquipmentImpl> get copyWith =>
      __$$EquipmentImplCopyWithImpl<_$EquipmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EquipmentImplToJson(this);
  }
}

abstract class _Equipment implements Equipment {
  const factory _Equipment({
    required final String id,
    required final String name,
    required final String category,
    required final String photo,
    required final int perDay,
    required final int perMonth,
    required final int deposit,
    required final String condition,
    required final String availableIn,
  }) = _$EquipmentImpl;

  factory _Equipment.fromJson(Map<String, dynamic> json) =
      _$EquipmentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get category;
  @override
  String get photo;
  @override
  int get perDay;
  @override
  int get perMonth;
  @override
  int get deposit;
  @override
  String get condition;
  @override
  String get availableIn;

  /// Create a copy of Equipment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EquipmentImplCopyWith<_$EquipmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

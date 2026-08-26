// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_menu_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileMenuRow _$ProfileMenuRowFromJson(Map<String, dynamic> json) {
  return _ProfileMenuRow.fromJson(json);
}

/// @nodoc
mixin _$ProfileMenuRow {
  String get iconKey => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get hint => throw _privateConstructorUsedError;

  /// Serializes this ProfileMenuRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileMenuRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileMenuRowCopyWith<ProfileMenuRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileMenuRowCopyWith<$Res> {
  factory $ProfileMenuRowCopyWith(
    ProfileMenuRow value,
    $Res Function(ProfileMenuRow) then,
  ) = _$ProfileMenuRowCopyWithImpl<$Res, ProfileMenuRow>;
  @useResult
  $Res call({String iconKey, String label, String hint});
}

/// @nodoc
class _$ProfileMenuRowCopyWithImpl<$Res, $Val extends ProfileMenuRow>
    implements $ProfileMenuRowCopyWith<$Res> {
  _$ProfileMenuRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileMenuRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iconKey = null,
    Object? label = null,
    Object? hint = null,
  }) {
    return _then(
      _value.copyWith(
            iconKey: null == iconKey
                ? _value.iconKey
                : iconKey // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            hint: null == hint
                ? _value.hint
                : hint // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileMenuRowImplCopyWith<$Res>
    implements $ProfileMenuRowCopyWith<$Res> {
  factory _$$ProfileMenuRowImplCopyWith(
    _$ProfileMenuRowImpl value,
    $Res Function(_$ProfileMenuRowImpl) then,
  ) = __$$ProfileMenuRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String iconKey, String label, String hint});
}

/// @nodoc
class __$$ProfileMenuRowImplCopyWithImpl<$Res>
    extends _$ProfileMenuRowCopyWithImpl<$Res, _$ProfileMenuRowImpl>
    implements _$$ProfileMenuRowImplCopyWith<$Res> {
  __$$ProfileMenuRowImplCopyWithImpl(
    _$ProfileMenuRowImpl _value,
    $Res Function(_$ProfileMenuRowImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileMenuRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iconKey = null,
    Object? label = null,
    Object? hint = null,
  }) {
    return _then(
      _$ProfileMenuRowImpl(
        iconKey: null == iconKey
            ? _value.iconKey
            : iconKey // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        hint: null == hint
            ? _value.hint
            : hint // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileMenuRowImpl implements _ProfileMenuRow {
  const _$ProfileMenuRowImpl({
    required this.iconKey,
    required this.label,
    required this.hint,
  });

  factory _$ProfileMenuRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileMenuRowImplFromJson(json);

  @override
  final String iconKey;
  @override
  final String label;
  @override
  final String hint;

  @override
  String toString() {
    return 'ProfileMenuRow(iconKey: $iconKey, label: $label, hint: $hint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileMenuRowImpl &&
            (identical(other.iconKey, iconKey) || other.iconKey == iconKey) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.hint, hint) || other.hint == hint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, iconKey, label, hint);

  /// Create a copy of ProfileMenuRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileMenuRowImplCopyWith<_$ProfileMenuRowImpl> get copyWith =>
      __$$ProfileMenuRowImplCopyWithImpl<_$ProfileMenuRowImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileMenuRowImplToJson(this);
  }
}

abstract class _ProfileMenuRow implements ProfileMenuRow {
  const factory _ProfileMenuRow({
    required final String iconKey,
    required final String label,
    required final String hint,
  }) = _$ProfileMenuRowImpl;

  factory _ProfileMenuRow.fromJson(Map<String, dynamic> json) =
      _$ProfileMenuRowImpl.fromJson;

  @override
  String get iconKey;
  @override
  String get label;
  @override
  String get hint;

  /// Create a copy of ProfileMenuRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileMenuRowImplCopyWith<_$ProfileMenuRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScoreItem _$ScoreItemFromJson(Map<String, dynamic> json) {
  return _ScoreItem.fromJson(json);
}

/// @nodoc
mixin _$ScoreItem {
  String get label => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;

  /// Serializes this ScoreItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScoreItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScoreItemCopyWith<ScoreItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreItemCopyWith<$Res> {
  factory $ScoreItemCopyWith(ScoreItem value, $Res Function(ScoreItem) then) =
      _$ScoreItemCopyWithImpl<$Res, ScoreItem>;
  @useResult
  $Res call({String label, double value});
}

/// @nodoc
class _$ScoreItemCopyWithImpl<$Res, $Val extends ScoreItem>
    implements $ScoreItemCopyWith<$Res> {
  _$ScoreItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScoreItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? value = null}) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScoreItemImplCopyWith<$Res>
    implements $ScoreItemCopyWith<$Res> {
  factory _$$ScoreItemImplCopyWith(
    _$ScoreItemImpl value,
    $Res Function(_$ScoreItemImpl) then,
  ) = __$$ScoreItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, double value});
}

/// @nodoc
class __$$ScoreItemImplCopyWithImpl<$Res>
    extends _$ScoreItemCopyWithImpl<$Res, _$ScoreItemImpl>
    implements _$$ScoreItemImplCopyWith<$Res> {
  __$$ScoreItemImplCopyWithImpl(
    _$ScoreItemImpl _value,
    $Res Function(_$ScoreItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScoreItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? value = null}) {
    return _then(
      _$ScoreItemImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScoreItemImpl implements _ScoreItem {
  const _$ScoreItemImpl({required this.label, required this.value});

  factory _$ScoreItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreItemImplFromJson(json);

  @override
  final String label;
  @override
  final double value;

  @override
  String toString() {
    return 'ScoreItem(label: $label, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreItemImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, value);

  /// Create a copy of ScoreItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreItemImplCopyWith<_$ScoreItemImpl> get copyWith =>
      __$$ScoreItemImplCopyWithImpl<_$ScoreItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreItemImplToJson(this);
  }
}

abstract class _ScoreItem implements ScoreItem {
  const factory _ScoreItem({
    required final String label,
    required final double value,
  }) = _$ScoreItemImpl;

  factory _ScoreItem.fromJson(Map<String, dynamic> json) =
      _$ScoreItemImpl.fromJson;

  @override
  String get label;
  @override
  double get value;

  /// Create a copy of ScoreItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScoreItemImplCopyWith<_$ScoreItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShiftOption _$ShiftOptionFromJson(Map<String, dynamic> json) {
  return _ShiftOption.fromJson(json);
}

/// @nodoc
mixin _$ShiftOption {
  String get label => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;

  /// Serializes this ShiftOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShiftOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftOptionCopyWith<ShiftOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftOptionCopyWith<$Res> {
  factory $ShiftOptionCopyWith(
    ShiftOption value,
    $Res Function(ShiftOption) then,
  ) = _$ShiftOptionCopyWithImpl<$Res, ShiftOption>;
  @useResult
  $Res call({String label, int price, bool available});
}

/// @nodoc
class _$ShiftOptionCopyWithImpl<$Res, $Val extends ShiftOption>
    implements $ShiftOptionCopyWith<$Res> {
  _$ShiftOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShiftOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? price = null,
    Object? available = null,
  }) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            available: null == available
                ? _value.available
                : available // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShiftOptionImplCopyWith<$Res>
    implements $ShiftOptionCopyWith<$Res> {
  factory _$$ShiftOptionImplCopyWith(
    _$ShiftOptionImpl value,
    $Res Function(_$ShiftOptionImpl) then,
  ) = __$$ShiftOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, int price, bool available});
}

/// @nodoc
class __$$ShiftOptionImplCopyWithImpl<$Res>
    extends _$ShiftOptionCopyWithImpl<$Res, _$ShiftOptionImpl>
    implements _$$ShiftOptionImplCopyWith<$Res> {
  __$$ShiftOptionImplCopyWithImpl(
    _$ShiftOptionImpl _value,
    $Res Function(_$ShiftOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShiftOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? price = null,
    Object? available = null,
  }) {
    return _then(
      _$ShiftOptionImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        available: null == available
            ? _value.available
            : available // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftOptionImpl implements _ShiftOption {
  const _$ShiftOptionImpl({
    required this.label,
    required this.price,
    required this.available,
  });

  factory _$ShiftOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftOptionImplFromJson(json);

  @override
  final String label;
  @override
  final int price;
  @override
  final bool available;

  @override
  String toString() {
    return 'ShiftOption(label: $label, price: $price, available: $available)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftOptionImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.available, available) ||
                other.available == available));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, price, available);

  /// Create a copy of ShiftOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftOptionImplCopyWith<_$ShiftOptionImpl> get copyWith =>
      __$$ShiftOptionImplCopyWithImpl<_$ShiftOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftOptionImplToJson(this);
  }
}

abstract class _ShiftOption implements ShiftOption {
  const factory _ShiftOption({
    required final String label,
    required final int price,
    required final bool available,
  }) = _$ShiftOptionImpl;

  factory _ShiftOption.fromJson(Map<String, dynamic> json) =
      _$ShiftOptionImpl.fromJson;

  @override
  String get label;
  @override
  int get price;
  @override
  bool get available;

  /// Create a copy of ShiftOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftOptionImplCopyWith<_$ShiftOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

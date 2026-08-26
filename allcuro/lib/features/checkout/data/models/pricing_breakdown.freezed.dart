// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pricing_breakdown.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PricingBreakdown _$PricingBreakdownFromJson(Map<String, dynamic> json) {
  return _PricingBreakdown.fromJson(json);
}

/// @nodoc
mixin _$PricingBreakdown {
  int get base => throw _privateConstructorUsedError;
  int get discount => throw _privateConstructorUsedError;
  int get fee => throw _privateConstructorUsedError;
  int get gst => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this PricingBreakdown to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PricingBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PricingBreakdownCopyWith<PricingBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PricingBreakdownCopyWith<$Res> {
  factory $PricingBreakdownCopyWith(
    PricingBreakdown value,
    $Res Function(PricingBreakdown) then,
  ) = _$PricingBreakdownCopyWithImpl<$Res, PricingBreakdown>;
  @useResult
  $Res call({int base, int discount, int fee, int gst, int total});
}

/// @nodoc
class _$PricingBreakdownCopyWithImpl<$Res, $Val extends PricingBreakdown>
    implements $PricingBreakdownCopyWith<$Res> {
  _$PricingBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PricingBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base = null,
    Object? discount = null,
    Object? fee = null,
    Object? gst = null,
    Object? total = null,
  }) {
    return _then(
      _value.copyWith(
            base: null == base
                ? _value.base
                : base // ignore: cast_nullable_to_non_nullable
                      as int,
            discount: null == discount
                ? _value.discount
                : discount // ignore: cast_nullable_to_non_nullable
                      as int,
            fee: null == fee
                ? _value.fee
                : fee // ignore: cast_nullable_to_non_nullable
                      as int,
            gst: null == gst
                ? _value.gst
                : gst // ignore: cast_nullable_to_non_nullable
                      as int,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PricingBreakdownImplCopyWith<$Res>
    implements $PricingBreakdownCopyWith<$Res> {
  factory _$$PricingBreakdownImplCopyWith(
    _$PricingBreakdownImpl value,
    $Res Function(_$PricingBreakdownImpl) then,
  ) = __$$PricingBreakdownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int base, int discount, int fee, int gst, int total});
}

/// @nodoc
class __$$PricingBreakdownImplCopyWithImpl<$Res>
    extends _$PricingBreakdownCopyWithImpl<$Res, _$PricingBreakdownImpl>
    implements _$$PricingBreakdownImplCopyWith<$Res> {
  __$$PricingBreakdownImplCopyWithImpl(
    _$PricingBreakdownImpl _value,
    $Res Function(_$PricingBreakdownImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PricingBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base = null,
    Object? discount = null,
    Object? fee = null,
    Object? gst = null,
    Object? total = null,
  }) {
    return _then(
      _$PricingBreakdownImpl(
        base: null == base
            ? _value.base
            : base // ignore: cast_nullable_to_non_nullable
                  as int,
        discount: null == discount
            ? _value.discount
            : discount // ignore: cast_nullable_to_non_nullable
                  as int,
        fee: null == fee
            ? _value.fee
            : fee // ignore: cast_nullable_to_non_nullable
                  as int,
        gst: null == gst
            ? _value.gst
            : gst // ignore: cast_nullable_to_non_nullable
                  as int,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PricingBreakdownImpl implements _PricingBreakdown {
  const _$PricingBreakdownImpl({
    required this.base,
    required this.discount,
    required this.fee,
    required this.gst,
    required this.total,
  });

  factory _$PricingBreakdownImpl.fromJson(Map<String, dynamic> json) =>
      _$$PricingBreakdownImplFromJson(json);

  @override
  final int base;
  @override
  final int discount;
  @override
  final int fee;
  @override
  final int gst;
  @override
  final int total;

  @override
  String toString() {
    return 'PricingBreakdown(base: $base, discount: $discount, fee: $fee, gst: $gst, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PricingBreakdownImpl &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.gst, gst) || other.gst == gst) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, base, discount, fee, gst, total);

  /// Create a copy of PricingBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PricingBreakdownImplCopyWith<_$PricingBreakdownImpl> get copyWith =>
      __$$PricingBreakdownImplCopyWithImpl<_$PricingBreakdownImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PricingBreakdownImplToJson(this);
  }
}

abstract class _PricingBreakdown implements PricingBreakdown {
  const factory _PricingBreakdown({
    required final int base,
    required final int discount,
    required final int fee,
    required final int gst,
    required final int total,
  }) = _$PricingBreakdownImpl;

  factory _PricingBreakdown.fromJson(Map<String, dynamic> json) =
      _$PricingBreakdownImpl.fromJson;

  @override
  int get base;
  @override
  int get discount;
  @override
  int get fee;
  @override
  int get gst;
  @override
  int get total;

  /// Create a copy of PricingBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PricingBreakdownImplCopyWith<_$PricingBreakdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

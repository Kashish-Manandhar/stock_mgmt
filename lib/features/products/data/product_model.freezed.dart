// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get productCode => throw _privateConstructorUsedError;
  Map<String, dynamic> get category => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  Map<String, dynamic> get availableSizeWithQuantity =>
      throw _privateConstructorUsedError;
  int get createdTimeStamp => throw _privateConstructorUsedError;
  int? get updatedTimeStamp => throw _privateConstructorUsedError;
  String get productImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {String productCode,
      Map<String, dynamic> category,
      String productName,
      double price,
      Map<String, dynamic> availableSizeWithQuantity,
      int createdTimeStamp,
      int? updatedTimeStamp,
      String productImage});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productCode = null,
    Object? category = null,
    Object? productName = null,
    Object? price = null,
    Object? availableSizeWithQuantity = null,
    Object? createdTimeStamp = null,
    Object? updatedTimeStamp = freezed,
    Object? productImage = null,
  }) {
    return _then(_value.copyWith(
      productCode: null == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      availableSizeWithQuantity: null == availableSizeWithQuantity
          ? _value.availableSizeWithQuantity
          : availableSizeWithQuantity // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdTimeStamp: null == createdTimeStamp
          ? _value.createdTimeStamp
          : createdTimeStamp // ignore: cast_nullable_to_non_nullable
              as int,
      updatedTimeStamp: freezed == updatedTimeStamp
          ? _value.updatedTimeStamp
          : updatedTimeStamp // ignore: cast_nullable_to_non_nullable
              as int?,
      productImage: null == productImage
          ? _value.productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productCode,
      Map<String, dynamic> category,
      String productName,
      double price,
      Map<String, dynamic> availableSizeWithQuantity,
      int createdTimeStamp,
      int? updatedTimeStamp,
      String productImage});
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productCode = null,
    Object? category = null,
    Object? productName = null,
    Object? price = null,
    Object? availableSizeWithQuantity = null,
    Object? createdTimeStamp = null,
    Object? updatedTimeStamp = freezed,
    Object? productImage = null,
  }) {
    return _then(_$ProductImpl(
      productCode: null == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value._category
          : category // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      availableSizeWithQuantity: null == availableSizeWithQuantity
          ? _value._availableSizeWithQuantity
          : availableSizeWithQuantity // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdTimeStamp: null == createdTimeStamp
          ? _value.createdTimeStamp
          : createdTimeStamp // ignore: cast_nullable_to_non_nullable
              as int,
      updatedTimeStamp: freezed == updatedTimeStamp
          ? _value.updatedTimeStamp
          : updatedTimeStamp // ignore: cast_nullable_to_non_nullable
              as int?,
      productImage: null == productImage
          ? _value.productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl(
      {required this.productCode,
      required final Map<String, dynamic> category,
      required this.productName,
      required this.price,
      required final Map<String, dynamic> availableSizeWithQuantity,
      required this.createdTimeStamp,
      this.updatedTimeStamp,
      required this.productImage})
      : _category = category,
        _availableSizeWithQuantity = availableSizeWithQuantity;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String productCode;
  final Map<String, dynamic> _category;
  @override
  Map<String, dynamic> get category {
    if (_category is EqualUnmodifiableMapView) return _category;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_category);
  }

  @override
  final String productName;
  @override
  final double price;
  final Map<String, dynamic> _availableSizeWithQuantity;
  @override
  Map<String, dynamic> get availableSizeWithQuantity {
    if (_availableSizeWithQuantity is EqualUnmodifiableMapView)
      return _availableSizeWithQuantity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_availableSizeWithQuantity);
  }

  @override
  final int createdTimeStamp;
  @override
  final int? updatedTimeStamp;
  @override
  final String productImage;

  @override
  String toString() {
    return 'Product(productCode: $productCode, category: $category, productName: $productName, price: $price, availableSizeWithQuantity: $availableSizeWithQuantity, createdTimeStamp: $createdTimeStamp, updatedTimeStamp: $updatedTimeStamp, productImage: $productImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.productCode, productCode) ||
                other.productCode == productCode) &&
            const DeepCollectionEquality().equals(other._category, _category) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(
                other._availableSizeWithQuantity, _availableSizeWithQuantity) &&
            (identical(other.createdTimeStamp, createdTimeStamp) ||
                other.createdTimeStamp == createdTimeStamp) &&
            (identical(other.updatedTimeStamp, updatedTimeStamp) ||
                other.updatedTimeStamp == updatedTimeStamp) &&
            (identical(other.productImage, productImage) ||
                other.productImage == productImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productCode,
      const DeepCollectionEquality().hash(_category),
      productName,
      price,
      const DeepCollectionEquality().hash(_availableSizeWithQuantity),
      createdTimeStamp,
      updatedTimeStamp,
      productImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  const factory _Product(
      {required final String productCode,
      required final Map<String, dynamic> category,
      required final String productName,
      required final double price,
      required final Map<String, dynamic> availableSizeWithQuantity,
      required final int createdTimeStamp,
      final int? updatedTimeStamp,
      required final String productImage}) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get productCode;
  @override
  Map<String, dynamic> get category;
  @override
  String get productName;
  @override
  double get price;
  @override
  Map<String, dynamic> get availableSizeWithQuantity;
  @override
  int get createdTimeStamp;
  @override
  int? get updatedTimeStamp;
  @override
  String get productImage;
  @override
  @JsonKey(ignore: true)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

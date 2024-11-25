// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      productCode: json['productCode'] as String,
      category: json['category'] as Map<String, dynamic>,
      productName: json['productName'] as String,
      price: (json['price'] as num).toDouble(),
      availableSizeWithQuantity:
          json['availableSizeWithQuantity'] as Map<String, dynamic>,
      createdTimeStamp: (json['createdTimeStamp'] as num).toInt(),
      updatedTimeStamp: (json['updatedTimeStamp'] as num?)?.toInt(),
      productImage: json['productImage'] as String,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'productCode': instance.productCode,
      'category': instance.category,
      'productName': instance.productName,
      'price': instance.price,
      'availableSizeWithQuantity': instance.availableSizeWithQuantity,
      'createdTimeStamp': instance.createdTimeStamp,
      'updatedTimeStamp': instance.updatedTimeStamp,
      'productImage': instance.productImage,
    };

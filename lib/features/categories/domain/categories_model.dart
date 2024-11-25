import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';

part 'categories_model.g.dart';

part 'categories_model.freezed.dart';

@freezed
class CategoriesModel with _$CategoriesModel {
  @HiveType(typeId: 1)
  const factory CategoriesModel({
    @HiveField(0) required String categoryId,
    @HiveField(1) required String categoryName,
    @HiveField(2) required int createdAt,
  }) = _CategoriesModel;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);
}

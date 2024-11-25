import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/categories/data/categories_local_source.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

@injectable
class CategoriesDataSource {
  CategoriesDataSource(this._firebaseFirestore, this._categoriesLocalSource);

  final FirebaseFirestore _firebaseFirestore;
  final CategoriesLocalSource _categoriesLocalSource;

  Future<void> addCategories(CategoriesModel categories) async {
    try {
      await _firebaseFirestore
          .collection('categories')
          .add(categories.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CategoriesModel>> getCategories() async {
    try {
      final result = await _firebaseFirestore
          .collection('categories')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .get();

      final categoriesList = result.docs
          .map((category) => CategoriesModel.fromJson(category.data()))
          .toList();

      _addAllListToLocal(categoriesList);

      return categoriesList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _addAllListToLocal(List<CategoriesModel> categoriesList) async {
    for (final categoryModel in categoriesList) {
      await _categoriesLocalSource.addCategory(categoryModel);
    }
  }
}

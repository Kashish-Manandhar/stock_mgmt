import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';

@injectable
class CategoriesDataSource {
  CategoriesDataSource(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  Future<void> addCategories(CategoriesModel categories) async {
    try {
      await _firebaseFirestore
          .collection('categories')
          .doc(categories.categoryId)
          .set(
            categories.toJson(),
          );
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

      return categoriesList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

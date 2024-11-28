import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/categories/domain/categories_model.dart';
import 'package:stock_management/features/products/data/product_model.dart';
import 'package:stock_management/features/products/data/product_response_model.dart';

@injectable
class ProductDataSource {
  ProductDataSource(
    this._firebaseFirestore,
  );

  final FirebaseFirestore _firebaseFirestore;

  Future<void> addProduct(
      {required Product product, bool isEdit = false}) async {
    try {
      final hasProductRecord = await _isProductCodeSame(product.productCode);

      if (hasProductRecord.$1) {
        if (isEdit) {
          await _firebaseFirestore
              .collection('products')
              .doc(hasProductRecord.$2)
              .update(
                product.toJson(),
              );
        } else {
          throw (Exception('Same Product code'));
        }
      } else {
        await _firebaseFirestore
            .collection('products')
            .doc(product.productCode)
            .set(product.toJson());
      }
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  Future<List<Product>> searchProduct(
      {String search = '', CategoriesModel? category}) async {
    late Query<Map<String, dynamic>> query;

    if (category != null) {
      query = _filterProductByCategory(category.categoryId);
    } else {
      query = _firebaseFirestore.collection('products');
    }

    final upperCaseResult = await query
        .where('productCode', isGreaterThanOrEqualTo: search.toUpperCase())
        .where('productCode',
            isLessThanOrEqualTo: '${search.toUpperCase()}\uf7ff')
        .get();
    final lowerCaseResult = await query
        .where('productCode', isGreaterThanOrEqualTo: search.toLowerCase())
        .where('productCode',
            isLessThanOrEqualTo: '${search.toLowerCase()}\uf7ff')
        .get();
    final upperCaseList = upperCaseResult.docs
        .map((element) => Product.fromJson(element.data()))
        .toList()
        .where((element) =>
            element.productCode.toLowerCase().contains(search.toLowerCase()))
        .toList();
    final lowerCaseList = lowerCaseResult.docs
        .map((element) => Product.fromJson(element.data()))
        .toList()
        .where((element) =>
            element.productCode.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return upperCaseList..addAll(lowerCaseList);
  }

  Query<Map<String, dynamic>> _filterProductByCategory(String categoryId) =>
      _firebaseFirestore
          .collection('products')
          .where('category.categoryId', isEqualTo: categoryId);

  Future<ProductResponseModel> getProducts() async {
    try {
      final list = await _firebaseFirestore
          .collection('products')
          .orderBy(
            'createdTimeStamp',
            descending: true,
          )
          .limit(10)
          .get();

      return ProductResponseModel(
          productList: list.docs
              .map(
                (element) => Product.fromJson(
                  element.data(),
                ),
              )
              .toList(),
          snapshot: list.docs.isEmpty ? null : list.docs.last,
          hasMoreData: list.docs.length == 10);
    } catch (e) {
      throw (
        Exception(
          e.toString(),
        ),
      );
    }
  }

  Future<ProductResponseModel> getMoreProducts(
      QueryDocumentSnapshot snapshot) async {
    try {
      final list = await _firebaseFirestore
          .collection('products')
          .orderBy(
            'createdTimeStamp',
            descending: true,
          )
          .startAfterDocument(snapshot)
          .limit(10)
          .get();

      return ProductResponseModel(
          productList: list.docs
              .map(
                (element) => Product.fromJson(
                  element.data(),
                ),
              )
              .toList(),
          snapshot: list.docs.last,
          hasMoreData: list.docs.length == 10);
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  Future<(bool, String)> _isProductCodeSame(String productCode) async {
    final queryList = await _firebaseFirestore
        .collection('products')
        .where('productCode', isEqualTo: productCode)
        .get();
    bool hasData = queryList.docs.isNotEmpty;

    return (hasData, hasData ? queryList.docs.first.id : '');
  }
}

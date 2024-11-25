import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/core/helpers/image_upload_helper.dart';
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
              .set(
                product.toJson(),
              );
        } else {
          throw (Exception('Same Product code'));
        }
      } else {
        await _firebaseFirestore.collection('products').add(product.toJson());
      }
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  // Future<List<Product>> getProductsForType({String search = ''}) async {
  //   final result = await _firebaseFirestore
  //       .collection('products')
  //       .where('productName', isGreaterThanOrEqualTo: search.toUpperCase())
  //       .where('productCode',isGreaterThanOrEqualTo: search.toUpperCase())
  //       .get();
  //
  //
  //
  // }

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

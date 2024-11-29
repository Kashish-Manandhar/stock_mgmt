import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:stock_management/features/sales/data/sales_data_model.dart';
import 'package:stock_management/features/sales/data/sales_response_model.dart';

@injectable
class SalesDataSource {
  SalesDataSource(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  Future<void> addSalesToFireStore(SalesDataModel salesDataModel) async {
    try {
      await _firebaseFirestore.collection('sales').add(
            salesDataModel.toJson(),
          );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<SalesResponseModel> getProducts() async {
    try {
      final list = await _firebaseFirestore
          .collection('sales')
          // .orderBy(
          //   'createdTimeStamp',
          //   descending: true,
          // )
          .limit(10)
          .get();

      return SalesResponseModel(
          salesList: list.docs
              .map(
                (element) => SalesDataModel.fromJson(
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

  Future<SalesResponseModel> getMoreProducts(
      QueryDocumentSnapshot snapshot) async {
    try {
      final list = await _firebaseFirestore
          .collection('sales')
          // .orderBy(
          //   'createdTimeStamp',
          //   descending: true,
          // )
          .startAfterDocument(snapshot)
          .limit(10)
          .get();

      return SalesResponseModel(
          salesList: list.docs
              .map(
                (element) => SalesDataModel.fromJson(
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
}

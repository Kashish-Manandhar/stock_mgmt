import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class SalesDataSource {
  SalesDataSource(this.firebaseFirestore);

  final FirebaseFirestore firebaseFirestore;
}

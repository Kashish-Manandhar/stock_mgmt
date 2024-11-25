import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class ImageUploadHelper {
  ImageUploadHelper(this._firebaseStorage);

  final FirebaseStorage _firebaseStorage;

  Future<String?> uploadImage(
      {XFile? image,
      required String collectionName,
      required String documentName}) async {
    if (image != null) {
      await _firebaseStorage.ref(collectionName).child(documentName).putFile(
            File(image.path),
          );

      return _firebaseStorage
          .ref(collectionName)
          .child(documentName)
          .getDownloadURL();
    }
    return null;
  }
}

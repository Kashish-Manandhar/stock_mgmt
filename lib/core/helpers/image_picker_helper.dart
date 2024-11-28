import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_management/core/extensions/context_extension.dart';
import 'package:stock_management/core/helpers/permission_helper.dart';

class ImagePickerHelper {
  static Future<XFile?> pickImageFromGallery(BuildContext context) async {
    try {
      if (await PermissionHelper.hasGalleryPersmission()) {
        final result = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        return result;
      } else {
        if (!context.mounted) return null;
        await context.showPermissionAlertDialog(
            'You need permission to access gallery.');

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<XFile?> pickImageFromCamera(BuildContext context) async {
    try {
      if (await PermissionHelper.hasCameraPermission()) {
        final result = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );
        return result;
      } else {
        if (!context.mounted) return null;
        await context
            .showPermissionAlertDialog('You need permission to access camera.');

        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

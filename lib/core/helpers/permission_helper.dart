
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> hasGalleryPersmission() async {
    PermissionStatus status = await Permission.photos.status;

    if (status == PermissionStatus.permanentlyDenied) {
      return false;
    }

    if (status == PermissionStatus.denied) {
      PermissionStatus newStatus = await Permission.photos.request();

      if (newStatus == PermissionStatus.granted ||
          newStatus == PermissionStatus.limited) {
        return true;
      } else {
        return false;
      }
    }

    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      return true;
    }

    return false;
  }

  static Future<bool> hasCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;

    if (status == PermissionStatus.permanentlyDenied) {
      return false;
    }

    if (status == PermissionStatus.denied) {
      PermissionStatus newStatus = await Permission.camera.request();
      if (newStatus == PermissionStatus.granted ||
          newStatus == PermissionStatus.limited) {
        return true;
      } else {
        return false;
      }
    }

    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      return true;
    }

    return false;
  }
}

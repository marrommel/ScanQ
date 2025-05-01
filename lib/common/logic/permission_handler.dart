import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<void> requestCameraPermission(BuildContext context) async {
    final status = await Permission.camera.request();

    if (status.isDenied) {
      Navigator.pop(context);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  static Future<void> requestGalleryPermission(BuildContext context) async {
    final status = await Permission.mediaLibrary.request();

    if (status.isDenied) {
      Navigator.pop(context);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

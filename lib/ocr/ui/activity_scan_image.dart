import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/brand_colors.dart';
import '../../common/permission_handler.dart';

class ActivityScanImage extends StatefulWidget {
  const ActivityScanImage({super.key});

  @override
  State<ActivityScanImage> createState() => _ActivityScanImageState();
}

class _ActivityScanImageState extends State<ActivityScanImage> {
  final _controller = DocumentScannerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (Platform.isAndroid) {
      // Reset to default when leaving this screen
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    }

    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadImage(ImageSource imageSource) async {
    try {
      if (imageSource == ImageSource.camera) {
        // request the required permission
        await PermissionHandler.requestCameraPermission(context);
      } else if (imageSource == ImageSource.gallery) {
        // request the required permission
        await PermissionHandler.requestGalleryPermission(context);
      }

      final picker = ImagePicker();
      final image = await picker.pickImage(source: imageSource);

      if (image != null) {
        await _controller.findContoursFromExternalImage(image: File(image.path));
      }
    } catch (e) {
      print("TAP_ $e");
    }
  }

  void _cropAndSave() {
    Uint8List? imageBytes = _controller.pictureCropped;
    Navigator.pop(context, imageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DocumentScanner(
          controller: _controller,
          onSave: (Uint8List imageBytes) {
            Future.delayed(Duration(milliseconds: 10), () {
              Navigator.pop(context, imageBytes);
            });
          },
          generalStyles: GeneralStyles(
            baseColor: BrandColors.colorPrimary,
            messageCroppingPicture: "Zuschneiden...",
            hideDefaultBottomNavigation: true,
            showCameraPreview: false,
            widgetInsteadOfCameraPreview: Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20, height: 70),
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Zurück",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Wie möchtest du\nVokabeln einscannen?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () => _loadImage(ImageSource.camera),
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Colors.white)),
                    child: Text(
                      "Kamera",
                      style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "oder",
                    style: TextStyle(fontSize: 35, color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () => _loadImage(ImageSource.gallery),
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Colors.white)),
                    child: Text(
                      "Galerie",
                      style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          cropPhotoDocumentStyle: CropPhotoDocumentStyle(
            textButtonSave: "Weiter",
            dotRadius: 3,
            dotSize: 30,
            minDistanceDots: 50,
            maskColor: Colors.black.withAlpha(128),
          ),
          editPhotoDocumentStyle: EditPhotoDocumentStyle(
            textButtonSave: "Speichern",
            hideBottomBarDefault: true,
          ),
        ),
      ),
    );
  }
}

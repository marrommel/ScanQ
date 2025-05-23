import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanq_multiplatform/gen/l10n/app_localizations.dart';

import '../../common/data/brand_colors.dart';
import '../../common/logic/permission_handler.dart';

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

  Container _createSelectionUi() {
    return Container(
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
                  AppLocalizations.of(context)!.back,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
          Text(
            AppLocalizations.of(context)!.chooseScanMedium,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          ElevatedButton(
            onPressed: () => _loadImage(ImageSource.camera),
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Colors.white)),
            child: Text(
              AppLocalizations.of(context)!.camera,
              style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            AppLocalizations.of(context)!.or,
            style: TextStyle(fontSize: 35, color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () => _loadImage(ImageSource.gallery),
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Colors.white)),
            child: Text(
              AppLocalizations.of(context)!.gallery,
              style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
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
            messageCroppingPicture: AppLocalizations.of(context)!.cropping,
            hideDefaultBottomNavigation: true,
            showCameraPreview: false,
            widgetInsteadOfCameraPreview: _createSelectionUi(),
          ),
          cropPhotoDocumentStyle: CropPhotoDocumentStyle(
            textButtonSave: AppLocalizations.of(context)!.next,
            dotRadius: 3,
            dotSize: 30,
            minDistanceDots: 50,
            maskColor: Colors.black.withAlpha(128),
          ),
          editPhotoDocumentStyle: EditPhotoDocumentStyle(
            textButtonSave: AppLocalizations.of(context)!.save,
            hideBottomBarDefault: true,
          ),
        ),
      ),
    );
  }
}

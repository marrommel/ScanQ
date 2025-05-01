import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scanq_multiplatform/ocr/logic/widget_bounding_box_image.dart';

import '../data/recognized_word.dart';

class ActivityRemoveBoundingBoxes extends StatefulWidget {
  /// the original image before any bounding boxes have been removed
  final Uint8List originalImageBytes;

  /// the scan result after perform ocr on the image
  final List<RecognizedWord> scanResult;

  /// the set of bounding box ids selected by user
  final Set<int> removedWordIndexes;

  const ActivityRemoveBoundingBoxes(
      {super.key, required this.originalImageBytes, required this.scanResult, required this.removedWordIndexes});

  @override
  _ActivityRemoveBoundingBoxesState createState() => _ActivityRemoveBoundingBoxesState();
}

class _ActivityRemoveBoundingBoxesState extends State<ActivityRemoveBoundingBoxes> {
  Uint8List? _imageBytes;
  Set<int> _removedWordIndexes = {};

  final GlobalKey _repaintBoundaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _removedWordIndexes = widget.removedWordIndexes;

    _imageBytes = widget.originalImageBytes;
    if (_imageBytes == null) {
      throw Exception("image bytes empty");
    }

    // TODO: add check if scanResult is empty
  }

  Future<Uint8List> _capturePngBytes() async {
    RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    List<Rect> boundingBoxes = widget.scanResult.map((word) => word.getBoundingBox()).toList();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;

        Uint8List updatedImageBytes = await _capturePngBytes();
        Navigator.pop(context, {"box_selections": _removedWordIndexes, "updated_image": updatedImageBytes});
      },
      child: Scaffold(
        appBar: null,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              const Text(
                "Lautschriften entfernen",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              RepaintBoundary(
                key: _repaintBoundaryKey,
                child: WidgetBoundingBoxImage(
                  imageBytes: _imageBytes!,
                  boundingBoxes: boundingBoxes,
                  selectedBoxes: _removedWordIndexes,
                  onBoxSelect: (result) {
                    setState(() {
                      _removedWordIndexes = result;
                    });
                  },
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  Uint8List updatedImageBytes = await _capturePngBytes();
                  Navigator.pop(context, {"box_selections": _removedWordIndexes, "updated_image": updatedImageBytes});
                },
                child: const Text("schließen"),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

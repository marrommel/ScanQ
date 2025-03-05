import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class WidgetBoundingBoxImage extends StatefulWidget {
  final Uint8List imageBytes;
  final List<Rect> boundingBoxes;
  final Set<int> selectedBoxes;
  final void Function(Set<int> eventResult)? onBoxSelect;

  const WidgetBoundingBoxImage(
      {super.key, required this.imageBytes, required this.boundingBoxes, required this.selectedBoxes, required this.onBoxSelect});

  @override
  _WidgetBoundingBoxImageState createState() => _WidgetBoundingBoxImageState();
}

class _WidgetBoundingBoxImageState extends State<WidgetBoundingBoxImage> {
  late img.Image _originalImage;
  Size prefSize = Size.zero;
  late Uint8List? updatedImageBytes = null;
  late final Set<int> _selectedBoxes;

  @override
  void initState() {
    super.initState();

    _selectedBoxes = widget.selectedBoxes;
    _originalImage = img.decodeImage(widget.imageBytes)!;
  }

  Future<void> _handleTap(TapDownDetails details) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    if (prefSize.isEmpty) prefSize = renderBox.size;

    final double scaleX = _originalImage.width / prefSize.width;
    final double scaleY = _originalImage.height / prefSize.height;

    // Map local widget tap position to original image coordinate space
    final Offset localPosition = details.localPosition;
    final double imageX = localPosition.dx * scaleX;
    final double imageY = localPosition.dy * scaleY;

    int boxIndex = 0;
    for (Rect box in widget.boundingBoxes) {
      if (box.contains(Offset(imageX, imageY))) {
        // add the selected box index or remove it, if it already has been added
        if (!_selectedBoxes.add(boxIndex)) {
          _selectedBoxes.remove(boxIndex);
        }

        // final Set<int> updatedBoxSelections = Set<int>.of(_selectedBoxes);
        widget.onBoxSelect?.call(_selectedBoxes);

        setState(() {});
        break;
      }

      // increment the box index
      boxIndex++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTap,
      child: Stack(children: [
        Image.memory(widget.imageBytes, fit: BoxFit.fill),
        CustomPaint(
          size: prefSize,
          painter: _BoundingBoxPainter(
            context,
            originalImage: _originalImage,
            boundingBoxes: widget.boundingBoxes,
            selectedBoxes: _selectedBoxes,
          ),
        ),
      ]),
    );
  }
}

class _BoundingBoxPainter extends CustomPainter {
  final List<Rect> boundingBoxes;
  final Set<int> selectedBoxes;
  final img.Image originalImage;
  final BuildContext context;

  _BoundingBoxPainter(this.context, {required this.boundingBoxes, required this.selectedBoxes, required this.originalImage});

  @override
  void paint(Canvas canvas, Size size) {
    final opaqueWhite = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white70;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    size = renderBox.size;
    final double scaleX = originalImage.width / size.width;
    final double scaleY = originalImage.height / size.height;

    for (int boxId in selectedBoxes) {
      final box = boundingBoxes[boxId];

      Rect scaledBox =
          Rect.fromLTRB(box.left / scaleX - 5, box.top / scaleY - 5, box.right / scaleX + 5, box.bottom / scaleY + 5);

      canvas.drawRect(scaledBox, opaqueWhite);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

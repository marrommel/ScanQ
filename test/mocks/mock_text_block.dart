import 'dart:math';

import 'package:flutter/painting.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// A mock implementation of TextBlock to bypass irrelevant parameters for testing.
class MockTextBlock implements TextBlock {
  @override
  final String text;

  @override
  final Rect boundingBox;

  @override
  final List<String> recognizedLanguages;

  @override
  final List<Point<int>> cornerPoints;

  @override
  final List<TextLine> lines;

  MockTextBlock({
    required this.lines,
    this.text = "",
    this.boundingBox = Rect.zero,
    this.recognizedLanguages = const [],
    this.cornerPoints = const [],
  });
}

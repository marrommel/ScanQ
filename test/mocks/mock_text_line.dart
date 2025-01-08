import 'dart:math';

import 'package:flutter/painting.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// A mock implementation of TextLine to bypass irrelevant parameters for testing.
class MockTextLine implements TextLine {
  @override
  final String text;

  @override
  final List<TextElement> elements;

  @override
  final Rect boundingBox;

  @override
  final List<String> recognizedLanguages;

  @override
  final List<Point<int>> cornerPoints;

  @override
  final double confidence;

  @override
  final double angle;

  MockTextLine({
    required this.elements,
    this.text = "",
    this.boundingBox = Rect.zero,
    this.recognizedLanguages = const [],
    this.cornerPoints = const [],
    this.confidence = 1.0,
    this.angle = 0.0,
  });
}

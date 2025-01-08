import 'dart:math';
import 'dart:ui';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// A mock implementation of TextElement to bypass irrelevant parameters for testing.
class MockTextElement implements TextElement {
  @override
  final String text;

  @override
  final Rect boundingBox;

  @override
  final List<String> recognizedLanguages;

  @override
  final List<TextSymbol> symbols;

  @override
  final List<Point<int>> cornerPoints;

  @override
  final double confidence;

  @override
  final double angle;

  MockTextElement({
    required this.text,
    this.boundingBox = Rect.zero,
    this.recognizedLanguages = const [],
    this.symbols = const [],
    this.cornerPoints = const [],
    this.confidence = 1.0,
    this.angle = 0.0,
  });
}

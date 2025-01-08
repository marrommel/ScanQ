import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:scanq_multiplatform/ocr/data/recognized_word.dart';

import 'mocks/mock_text_element.dart';

/// Test the RecognizedWord type.
/// This type is used to store the recognition result of OcrEngine.

void main() {
  // create a demo word for testing
  final MockTextElement demoWord = MockTextElement(text: "test", boundingBox: Rect.fromLTWH(0, 0, 50, 20));
  final RecognizedWord recognizedWord = RecognizedWord(demoWord, 0);

  test("toggleSelection", () {
    // selection should be false by default
    expect(recognizedWord.isSelected(), isFalse);

    // after first toggle it should be true
    recognizedWord.toggleSelection();
    expect(recognizedWord.isSelected(), isTrue);

    // after second toggle it should be false again
    recognizedWord.toggleSelection();
    expect(recognizedWord.isSelected(), isFalse);
  });

  test("appendText", () {
    // the prefix should be appended at the beginning of the string
    // an empty character should be added as separator
    recognizedWord.appendText('prefix');
    expect(recognizedWord.getText(), "prefix test");
  });
}

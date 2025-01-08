import 'package:flutter_test/flutter_test.dart';
import 'package:scanq_multiplatform/ocr/data/recognized_word.dart';
import 'package:scanq_multiplatform/ocr/logic/ocr_engine.dart';

import 'mocks/mock_ocr_engine.dart';

/// Test the OcrEngine.
/// This test is not used to verify the recognition accuracy, but to check methods that modify the recognition result.

void main() {
  late final List<RecognizedWord> recognizedWords;

  // ensure that the widget binding has been initialized
  TestWidgetsFlutterBinding.ensureInitialized();

  // create a mock instance of OcrEngine and run the word extraction before all tests
  setUpAll(() async {
    final OcrEngine ocrEngine = MockOcrEngine();
    recognizedWords = await ocrEngine.extractWords();
  });

  test("line indexing", () {
    // verify that the recognized words have been assigned to correct line indexes
    expect(recognizedWords[0].getLineNumber(), 0);
    expect(recognizedWords[1].getLineNumber(), 0);
    expect(recognizedWords[2].getLineNumber(), 0);
    expect(recognizedWords[3].getLineNumber(), 0);
    expect(recognizedWords[4].getLineNumber(), 1);
    expect(recognizedWords[5].getLineNumber(), 1);
    expect(recognizedWords[6].getLineNumber(), 1);
  });

  test("mergeWordsIntoLine", () {
    // verify that all words of the same index have been merged into one line
    List<RecognizedWord> lines = OcrEngine.mergeWordsIntoLine(recognizedWords);

    expect(lines[0].getText(), "auflösen, zerstören, niederreißen, zusammenbrechen");
    expect(lines[1].getText(), "die Stirn runzeln");
  });

  test("correctRecognizedString", () {
    // verify that invalid characters at the beginning of a line have been removed
    String removedNumbers = OcrEngine.correctRecognizedString("1test");
    String removedCharacters = OcrEngine.correctRecognizedString("%test");
    String removedSpaces = OcrEngine.correctRecognizedString(" test");

    expect(removedNumbers, "test");
    expect(removedCharacters, "test");
    expect(removedSpaces, "test");
  });
}

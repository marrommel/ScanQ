import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:scanq_multiplatform/ocr/logic/ocr_engine.dart';

import 'mock_text_block.dart';
import 'mock_text_element.dart';
import 'mock_text_line.dart';

/// The mock implementation of OcrEngine uses a TextRecognizer mock to simulate a recognition result for testing.
class MockOcrEngine extends OcrEngine {
  MockOcrEngine() : super(imagePath: "mock_image_path");

  // override the textRecognizer instance to use a mock
  @override
  final TextRecognizer textRecognizer = _MockTextRecognizer();
}

/// This TextRecognizer mock returns a predefined recognition result for testing.
class _MockTextRecognizer extends TextRecognizer {
  // create an empty constructor as no image is required for the recognizer mock
  _MockTextRecognizer() : super(script: TextRecognitionScript.latin);

  // simulate a OCR processing by returning a predefined recognition result
  @override
  Future<RecognizedText> processImage(InputImage inputImage) {
    // return a predefined recognition result with multiline vocabulary
    return Future.value(RecognizedText(text: '', blocks: [
      MockTextBlock(lines: [
        MockTextLine(
          text: "auflösen, zerstören,",
          elements: [
            MockTextElement(text: "auflösen,"),
            MockTextElement(text: "zerstören,"),
          ],
        ),
        MockTextLine(
          text: "niederreißen,",
          elements: [
            MockTextElement(text: "niederreißen,"),
          ],
        ),
        MockTextLine(
          text: "zusammenbrechen",
          elements: [
            MockTextElement(text: "zusammenbrechen"),
          ],
        ),
        MockTextLine(
          text: "die Stirn runzeln",
          elements: [
            MockTextElement(text: "die"),
            MockTextElement(text: "Stirn"),
            MockTextElement(text: "runzeln"),
          ],
        ),
      ])
    ]));
  }

  // the mock recognizer does not require any logic to be closed
  @override
  Future<void> close() async {}
}

import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrEngine {
  final InputImage _inputImage;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  OcrEngine({required File imageFile}) : _inputImage = InputImage.fromFile(imageFile);

  Future<String> extractText() async {
    final RecognizedText recognizedText = await textRecognizer.processImage(_inputImage);

    return recognizedText.text;
  }

  Future<List<String>> extractLines() async {
    final RecognizedText recognizedText = await textRecognizer.processImage(_inputImage);
    List<String> recognizedLines = [];

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        recognizedLines.add(line.text);
      }
    }

    return recognizedLines;
  }
}

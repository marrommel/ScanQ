import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../data/recognized_word.dart';

/// The OcrEngine provides an easy access to the TextRecognizer form Google's ML-Kit.
/// It automatically handles instantiation and closing of the text recognizer.
/// Additionally, useful functionality for modifying the recognition result is provided.
class OcrEngine {
  /// A reference to the image that shall be processed.
  final InputImage _inputImage;

  /// An instance of the actual text recognizer.
  //TODO: Add the option to pass other TextRecognitionScripts
  final TextRecognizer textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  /// Constructor that assigns one image to the OcrEngine.
  OcrEngine({required String imagePath}) : _inputImage = InputImage.fromFilePath(imagePath);

  /// This method calls the actual processing method and handles closing the text recognizer.
  Future<RecognizedText> _processImage() async {
    final RecognizedText recognizedText = await textRecognizer.processImage(_inputImage);
    textRecognizer.close();

    // return the unmodified recognition result
    return recognizedText;
  }

  /// Modify the recognition result to return it in a more useful format.
  Future<List<RecognizedWord>> extractWords() async {
    // process the image to extract text
    final RecognizedText recognitionResult = await _processImage();

    // create an empty list to store all recognized words
    final List<RecognizedWord> recognizedWords = [];

    // give each word an index to mark words from the same line
    int lineIndex = 0;

    // iterate though all lines of the recognition result
    for (TextBlock block in recognitionResult.blocks) {
      for (TextLine line in block.lines) {
        // iterate through all words of a recognized line
        for (TextElement element in line.elements) {
          RecognizedWord word = RecognizedWord(element, lineIndex);
          recognizedWords.add(word);
        }

        // only increment the line index, if the line is complete
        // a line ending with "," or ";" is not complete
        if (line.text.substring(line.text.length - 1) != "," && line.text.substring(line.text.length - 1) != ";") {
          lineIndex++;
        }
      }
    }

    // return all words that could be recognized in the image
    return recognizedWords;
  }

  /// Merge multiple words into one if they share the same line index
  static List<RecognizedWord> mergeWordsIntoLine(List<RecognizedWord> wordList) {
    // remove the selected words
    wordList.removeWhere((word) => word.isSelected());

    for (int i = 0; i < wordList.length; i++) {
      if (i < wordList.length - 1 && wordList[i].getLineNumber() == wordList[i + 1].getLineNumber()) {
        wordList[i + 1].appendText(wordList[i].getText());

        // remove the merged word and modify the current index accordingly
        wordList.removeAt(i);
        i--;
      }
    }

    return wordList;
  }

  /// Remove unexpected characters as numbers, symbols or spaces at the beginning of a word
  static String correctRecognizedString(String text) {
    // remove any symbols at the begging of the string to enforce a letter as first character
    text = text.replaceFirst(RegExp(r'^[^a-zA-ZäöüÄÖÜ(]+'), '');

    // remove trailing comma / semicolon at the end of the string
    text = text.replaceFirst(RegExp(r'[;,]$'), '');

    return text;
  }
}

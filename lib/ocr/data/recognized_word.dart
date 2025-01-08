import 'dart:ui';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// This class is used to store the words recognized by the OcrEngine.
/// It provides useful functionality like a line index, selection state and text appending.
class RecognizedWord {
  /// The String value of the recognized word.
  String _text;

  /// The coordinates of the rectangle surrounding a recognized word in the original image.
  final Rect _boundingBox;

  /// The line index of the recognized word. (Used to map multiple words to one line)
  final int _lineNumber;

  /// Used to mark words that have been selected for removal.
  /// The selection is performed by clicking on the corresponding word or its bounding box location in the image.
  bool _isSelected;

  /// Constructor to create the word form a TextElement and line index.
  RecognizedWord(TextElement word, this._lineNumber)
      : _text = word.text,
        _boundingBox = word.boundingBox,
        _isSelected = false;

  /// Getter for text parameter.
  String getText() {
    return _text;
  }

  /// Getter for the bounding box parameter.
  Rect getBoundingBox() {
    return _boundingBox;
  }

  /// Getter for the line number parameter.
  int getLineNumber() {
    return _lineNumber;
  }

  /// Getter for the selection state parameter.
  bool isSelected() {
    return _isSelected;
  }

  /// Invert the current selection state to perform a (de)selection.
  void toggleSelection() {
    _isSelected = !_isSelected;
  }

  /// Append a provided string at the beginning of the current text.
  /// The new string will be separated by a space.
  void appendText(String appendix) {
    _text = "$appendix $_text";
  }
}

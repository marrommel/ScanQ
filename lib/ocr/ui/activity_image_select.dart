import 'dart:io';
import 'dart:typed_data';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/recognized_word.dart';
import '../data/scan_result.dart';
import '../logic/ocr_engine.dart';
import 'activity_remove_bounding_boxes.dart';
import 'activity_scan_result.dart';

class ActivityImageSelect extends StatefulWidget {
  const ActivityImageSelect({super.key});

  @override
  State<ActivityImageSelect> createState() => _ActivityImageSelectState();
}

enum ScanLanguages {
  german,
  english,
  french,
  spanish,
  italian,
  portuguese,
}

enum ImageTarget { vocabulary, translation }

class _ActivityImageSelectState extends State<ActivityImageSelect> {
  Uint8List? _vocabImageBytes, _translationImageBytes;
  List<RecognizedWord> _rawVocabs = [], _rawTranslations = [];
  Set<int> _removedVocabs = {}, _removedTranslations = {};

  late final Image placeholderImage;

  @override
  void initState() {
    super.initState();

    // load the placeholder image once at the beginning
    placeholderImage = Image.asset("assets/images/placeholder.png", fit: BoxFit.cover, height: 200);
  }

  @override
  Widget build(BuildContext context) {
    bool allImagesProvided = (_translationImageBytes == null) || (_vocabImageBytes == null);

    return Scaffold(
      appBar: null,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(height: 50),
        createScanCard(ScanLanguages.english),
        createScanCard(ScanLanguages.german),
        ElevatedButton(
          onPressed: allImagesProvided ? null : _extractVocabs,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color?>(
              allImagesProvided ? Colors.grey : null,
            ),
          ),
          child: Text(
            "weiter",
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(height: 50),
      ]),
    );
  }

  Container createScanCard(ScanLanguages language) {
    String heading;
    ImageTarget target;
    Uint8List? imageBytes;
    List<RecognizedWord> scanRes;
    Set<int> removedWords;

    if (language == ScanLanguages.german) {
      heading = 'Übersetzungen:';
      target = ImageTarget.translation;
      imageBytes = _translationImageBytes;
      scanRes = _rawTranslations;
      removedWords = _removedTranslations;
    } else {
      heading = 'Vokabeln:';
      target = ImageTarget.vocabulary;
      imageBytes = _vocabImageBytes;
      scanRes = _rawVocabs;
      removedWords = _removedVocabs;
    }

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Material(
          elevation: 3,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                flex: 3,
                child: GestureDetector(
                    onTap: () async {
                      if (imageBytes != null) {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActivityRemoveBoundingBoxes(
                              originalImageBytes: imageBytes!,
                              scanResult: scanRes,
                              removedWordIndexes: removedWords,
                            ),
                          ),
                        );

                        removedWords = result;

                        // update the image according to the removed words
                        for (int id in removedWords) {
                          scanRes[id].toggleSelection();
                        }
                      }
                    },
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                        child: createImageWidget(imageBytes)))),
            Expanded(
                flex: 5,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            heading,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            ElevatedButton(
                                onPressed: () => _pickImage(source: ImageSource.camera, target: target),
                                child: Text("Bild wählen")),
                          ]),
                        ]))),
          ]),
        ));
  }

  Image createImageWidget(Uint8List? imageBytes) {
    // display a placeholder if no image has been selected
    if (imageBytes == null) return placeholderImage;

    // display the selected image
    return Image.memory(imageBytes, fit: BoxFit.cover, height: 200);
  }

  Future<void> _pickImage({required ImageSource source, required ImageTarget target}) async {
    // load the image using the cunning document scanner
    final imagePath = await CunningDocumentScanner.getPictures(noOfPages: 1, isGalleryImportAllowed: true);

    // check if an image has been loaded correctly
    if (imagePath != null) {
      // check if a vocabulary image is provided
      if (target == ImageTarget.vocabulary) {
        // update the vocabulary image view once the image is loaded
        _vocabImageBytes = await File(imagePath.first).readAsBytes();

        // call the OCR Engine to extract vocabulary form the image
        final OcrEngine ocrEngineVocabs = OcrEngine(imagePath: imagePath.first);
        _rawVocabs = await ocrEngineVocabs.extractWords();

        // reset the set for manually removed vocabs
        _removedVocabs = {};
      } else {
        // if no vocabulary image has been provided, assume it is a translation image
        // update the translations image view once the image is loaded
        _translationImageBytes = await File(imagePath.first).readAsBytes();

        // call the OCR Engine to extract translation form the image
        final OcrEngine ocrEngineTranslations = OcrEngine(imagePath: imagePath.first);
        _rawTranslations = await ocrEngineTranslations.extractWords();

        //reset the set for manually removed translations
        _removedTranslations = {};
      }

      // refresh the ui
      setState(() {});
    }
  }

  Future<void> _extractVocabs() async {
    if (mounted) {
      // merge words that have the same line index into one line element
      _rawVocabs = OcrEngine.mergeWordsIntoLine(_rawVocabs);
      _rawTranslations = OcrEngine.mergeWordsIntoLine(_rawTranslations);

      if (_rawVocabs.length != _rawTranslations.length) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fehler beim Einscannen der Vokabeln!")));
      } else {
        List<ScanResult> recognizedVocabs = [];
        for (int i = 0; i < _rawVocabs.length; i++) {
          String vocab = OcrEngine.correctRecognizedString(_rawVocabs[i].getText());
          String translation = OcrEngine.correctRecognizedString(_rawTranslations[i].getText());

          recognizedVocabs.add(ScanResult(vocabulary: vocab, translation: translation));
        }

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => ActivityScanResult(vocabularyData: recognizedVocabs)));
      }
    }
  }
}

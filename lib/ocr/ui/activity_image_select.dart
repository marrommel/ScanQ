import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/transparent_app_bar.dart';
import '../../common/vocabulary_type.dart';
import '../data/recognized_word.dart';
import '../logic/ocr_engine.dart';
import 'activity_remove_bounding_boxes.dart';
import 'activity_scan_image.dart';
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

enum ImageTarget { vocabulary, translation, both }

class _ActivityImageSelectState extends State<ActivityImageSelect> {
  Uint8List? _vocabImageBytes, _translationImageBytes;
  List<RecognizedWord> _rawVocabs = [], _rawTranslations = [];
  Set<int> _removedVocabs = {}, _removedTranslations = {};

  //TODO refactor
  Uint8List? _vocabUpdatedImage, _translationUpdatedImage;
  late final Image placeholderImage;

  @override
  void initState() {
    super.initState();

    // load the placeholder image once at the beginning
    placeholderImage = Image.asset("assets/image/placeholder.png", fit: BoxFit.cover, height: 200);
  }

  @override
  Widget build(BuildContext context) {
    bool allImagesProvided = (_translationImageBytes == null) || (_vocabImageBytes == null);

    return Scaffold(
      appBar: TransparentAppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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

    if (language == ScanLanguages.german) {
      heading = 'Übersetzungen:';
      target = ImageTarget.translation;
      imageBytes = _translationImageBytes;
    } else {
      heading = 'Vokabeln:';
      target = ImageTarget.vocabulary;
      imageBytes = _vocabImageBytes;
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
                    _callBoundingBoxActivity(imageBytes, target);
                  } else {
                    _pickImage(target);
                  }
                },
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                    child: loadCorrectImage(target)
                    //createImageWidget(language == ScanLanguages.german ? _translationUpdatedImage ?? imageBytes : _vocabUpdatedImage ?? imageBytes,),
                    ),
              ),
            ),
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
                            ElevatedButton(onPressed: () => _pickImage(target), child: Text("Bild wählen")),
                          ]),
                        ]))),
          ]),
        ));
  }

  Image loadCorrectImage(ImageTarget target) {
    Uint8List? imageBytes;

    // display the updated image for vocabulary or translation (Note: if there is no update display the initial image)
    if (target == ImageTarget.vocabulary) {
      imageBytes = _vocabUpdatedImage ?? _vocabImageBytes;
    } else if (target == ImageTarget.translation) {
      imageBytes = _translationUpdatedImage ?? _translationImageBytes;
    } else {
      throw Exception("INVALID IMAGE TARGET HAS BEEN PASSED!");
    }

    // display a placeholder if no image has been selected yet
    if (imageBytes == null) return placeholderImage;

    // display the selected image
    return Image.memory(imageBytes, fit: BoxFit.cover, height: 200);
  }

  Future<void> _pickImage(ImageTarget target) async {
    File? image;
    try {
      final Uint8List? scannedImageBytes = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ActivityScanImage()),
      );

      if (scannedImageBytes != null) {
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/fghfgzhj.png').create();
        file.writeAsBytesSync(scannedImageBytes);

        image = file;
        print("TAP_ success! Image saved to: ${image?.path}");
      } else {
        print("TAP_ User cancelled the scan or no image was returned.");
        image = null; // Ensure image is null if no image is returned
      }
    } on PlatformException {
      print("TAP_ Failed to get document path or operation cancelled!");
      image = null; // Ensure image is null in case of an exception
      // 'Failed to get document path or operation cancelled!';
    }

    if (image != null)
      _processImage(target, image.path);
    else
      print("TAP_ User cancelled the scan or no image was returned.");
  }

  Future<void> _processImage(ImageTarget target, String imagePath) async {
    // load the image using the cunning document scanner
    //final imagePath = await CunningDocumentScanner.getPictures(
    //  noOfPages: 1, isGalleryImportAllowed: true);

    // initialise the OCR engine for the selected image
    final OcrEngine ocrEngine = OcrEngine(imagePath: imagePath);

    // reset the according state variables of a new image has been loaded
    resetState(target);

    // check if a vocabulary image is provided
    if (target == ImageTarget.vocabulary) {
      // update the vocabulary image view once the image is loaded
      _vocabImageBytes = await File(imagePath).readAsBytes();

      // call the OCR Engine to extract vocabulary form the image
      _rawVocabs = await ocrEngine.extractWords();
    } else if (target == ImageTarget.translation) {
      // if no vocabulary image has been provided, assume it is a translation image
      // update the translations image view once the image is loaded
      _translationImageBytes = await File(imagePath).readAsBytes();

      // call the OCR Engine to extract translation form the image
      _rawTranslations = await ocrEngine.extractWords();
    } else {
      throw Exception("INVALID IMAGE TARGET HAS BEEN PASSED!");
    }

    // refresh the ui
    setState(() => {});
  }

  Future<void> _callBoundingBoxActivity(Uint8List imageBytes, ImageTarget target) async {
    List<RecognizedWord> scanRes;
    Set<int> removedWords;

    if (target == ImageTarget.vocabulary) {
      scanRes = _rawVocabs;
      removedWords = _removedVocabs;
    } else if (target == ImageTarget.translation) {
      scanRes = _rawTranslations;
      removedWords = _removedTranslations;
    } else {
      throw Exception("INVALID IMAGE TARGET HAS BEEN PASSED!");
    }

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ActivityRemoveBoundingBoxes(
          originalImageBytes: imageBytes,
          scanResult: scanRes,
          removedWordIndexes: removedWords,
        ),
      ),
    );

    // update the selected (=removed) words
    removedWords = result["box_selections"];

    // update the image preview
    setState(() {
      if (target == ImageTarget.vocabulary) {
        _vocabUpdatedImage = result["updated_image"];
      } else if (target == ImageTarget.translation) {
        _translationUpdatedImage = result["updated_image"];
      }
    });

    // unselect all word in the scan result
    for (RecognizedWord word in scanRes) {
      word.resetSelection();
    }

    // TODO: removedWords is always one behind, maybe last selected word is not in list.  [BUG]
    // TODO: Two separate problems or related? Check if approach using call by reference is wrong
    // select only those words that are selected in the current scan result
    for (int id in removedWords) {
      scanRes[id].selectWord();
    }
  }

  Future<void> _extractVocabs() async {
    if (mounted) {
      // merge words that have the same line index into one line element
      _rawVocabs = OcrEngine.mergeWordsIntoLine(_rawVocabs);
      _rawTranslations = OcrEngine.mergeWordsIntoLine(_rawTranslations);

      if (_rawVocabs.length != _rawTranslations.length) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Unterschiedliche Anzahl von Vokabeln und Übersetzungen!")));
        resetState(ImageTarget.both);
        return;
      }

      if (_rawVocabs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Es konnten keine Wörter im Bild erkannt werden.")));
        resetState(ImageTarget.both);
        return;
      }

      List<VocabularyType> recognizedVocabs = [];
      for (int i = 0; i < _rawVocabs.length; i++) {
        String vocab = OcrEngine.correctRecognizedString(_rawVocabs[i].getText());
        String translation = OcrEngine.correctRecognizedString(_rawTranslations[i].getText());

        recognizedVocabs.add(VocabularyType(vocabulary: vocab, translation: translation));
      }

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => ActivityScanResult(vocabularyData: recognizedVocabs)));
    }
  }

  void resetState(ImageTarget target) {
    // reset all state variables for vocabularies
    if (target == ImageTarget.vocabulary || target == ImageTarget.both) {
      _vocabImageBytes = null;
      _vocabUpdatedImage = null;
      _rawVocabs = [];
      _removedVocabs = {};
    }

    // reset all state variables for translations
    if (target == ImageTarget.translation || target == ImageTarget.both) {
      _translationImageBytes = null;
      _translationUpdatedImage = null;
      _rawTranslations = [];
      _removedTranslations = {};
    }

    // refresh the ui
    setState(() => {});
  }
}

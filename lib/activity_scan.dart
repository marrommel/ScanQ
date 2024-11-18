import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'activity_scan_result.dart';
import 'ocr/ocr_engine.dart';
import 'ocr/scan_result.dart';

enum ScanLanguages {
  german,
  english,
  french,
  spanish,
  italian,
  portuguese,
}

enum ImageTarget { vocabulary, translation }

class ActivityVocabularyScan extends StatefulWidget {
  const ActivityVocabularyScan({super.key});

  @override
  State<ActivityVocabularyScan> createState() => _ActivityVocabularyScanState();
}

class _ActivityVocabularyScanState extends State<ActivityVocabularyScan> {
  XFile? _vocabImage;
  XFile? _translationImage;

  @override
  Widget build(BuildContext context) {
    bool allImagesProvided = (_translationImage == null) || (_vocabImage == null);

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
    XFile? image;

    if (language == ScanLanguages.german) {
      heading = 'Übersetzungen einscannen:';
      target = ImageTarget.translation;
      image = _translationImage;
    } else {
      heading = 'Vokabeln einscannen:';
      target = ImageTarget.vocabulary;
      image = _vocabImage;
    }

    return Container(
        margin: const EdgeInsets.all(15),
        child: Material(
          elevation: 3,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            image != null
                ? Expanded(
                    flex: 2,
                    child: ClipRRect(
                        // Add ClipRRect
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                        child: Image.file(
                          File(image.path),
                          fit: BoxFit.cover,
                          height: 200,
                        )))
                : const SizedBox.shrink(),
            Expanded(
                flex: 5,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () => _pickImage(source: ImageSource.camera, target: target),
                            child: Icon(Icons.camera_alt_rounded)),
                        ElevatedButton(
                            onPressed: () => _pickImage(source: ImageSource.gallery, target: target),
                            child: Icon(Icons.image_rounded)),
                      ],
                    )
                  ],
                )),
          ]),
        ));
  }

  Future<void> _pickImage({required ImageSource source, required ImageTarget target}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        (target == ImageTarget.vocabulary) ? (_vocabImage = image) : (_translationImage = image);
      });

      // Call OCR Engine to extract text
      // final OcrEngine ocrEngine = OcrEngine(imageFile: File(image.path));
      // final String extractedText = await ocrEngine.extractText();
    }
  }

  Future<void> _extractVocabs() async {
    // Call the OCR Engine to extract vocabulary and translations
    final OcrEngine ocrEngineVocabs = OcrEngine(imageFile: File(_vocabImage!.path));
    final OcrEngine ocrEngineTranslations = OcrEngine(imageFile: File(_translationImage!.path));

    final List<String> rawVocabs = await ocrEngineVocabs.extractLines();
    final List<String> rawTranslations = await ocrEngineTranslations.extractLines();

    if (mounted) {
      if (rawVocabs.length != rawTranslations.length) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fehler beim Einscannen der Vokabeln!")));
      } else {
        List<ScanResult> recognizedVocabs = [];
        for (int i = 0; i < rawVocabs.length; i++) {
          recognizedVocabs.add(ScanResult(vocabulary: rawVocabs[i], translation: rawTranslations[i]));
        }

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => ActivityScanResult(vocabularyData: recognizedVocabs)));
      }
    }
  }
}

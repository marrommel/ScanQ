import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanq_multiplatform/common/brand_colors.dart';
import 'package:scanq_multiplatform/common/extensions.dart';
import 'package:scanq_multiplatform/database/database.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_config.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_mode.dart';
import 'package:scanq_multiplatform/quiz/ui/widgets/widget_offset_card.dart';

import '../../common/widegt_vertical_slider.dart';

class ActivityQuizSettings extends StatefulWidget {
  final QuizMode quizMode;

  const ActivityQuizSettings({super.key, required this.quizMode});

  @override
  State<ActivityQuizSettings> createState() => _ActivityQuizSettingsState();
}

enum TtsSpeed { fast, normal, slow }

class _ActivityQuizSettingsState extends State<ActivityQuizSettings> {
  List<Category> categories = [];
  Set<String> categoryNames = {};
  Set<String> languages = {};

  String selectedLanguage = "";
  String selectedCategory = "";
  double quizCount = 10;
  TtsSpeed ttsSpeed = TtsSpeed.normal;
  bool reverseTranslation = true;
  bool caseSensitive = true;
  bool hintsEnabled = true;
  bool autoContinue = true;
  bool onlyUntrained = false;

  bool _isDataLoaded = false;

  Future<void> _loadCategories() async {
    final Database db = Modular.get<Database>();
    categories = await db.allNonEmptyCategories().get();

    for (Category category in categories) {
      languages.add(category.categoryLanguage);
    }

    selectedLanguage = languages.first;

    for (Category category in categories) {
      if (category.categoryLanguage == selectedLanguage) {
        categoryNames.add(category.categoryName);
      }
    }

    selectedCategory = categoryNames.first;

    setState(() {
      _isDataLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadCategories();
  }

  Widget _buildSpeedOption(TtsSpeed speed, String asset) {
    final bool isSelected = ttsSpeed == speed;
    final Color color = isSelected ? Colors.black : Colors.grey;

    return GestureDetector(
      onTap: () => setState(() => ttsSpeed = speed),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SvgPicture.asset(
          asset,
          width: 32,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: BrandColors.colorPrimary,
      statusBarIconBrightness: Brightness.light,
    ));

    double headingFontSize = 20;

    // display a loading animation while data from database is loaded
    if (!_isDataLoaded) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: BrandColors.colorPrimary,
      body: OffsetCard(
        heading: widget.quizMode.title,
        children: [
          if (languages.length > 1) ...[
            Text('Sprache', style: TextStyle(fontSize: headingFontSize, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: languages.map((lang) {
                return ChoiceChip(
                  label: Text(lang),
                  selected: selectedLanguage == lang,
                  onSelected: (selected) {
                    setState(() {
                      selectedLanguage = lang;

                      categoryNames.clear();
                      for (Category category in categories) {
                        if (category.categoryLanguage == selectedLanguage) {
                          categoryNames.add(category.categoryName);
                        }
                      }

                      selectedCategory = categoryNames.first;
                    });
                  },
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 10),
          Text('Kategorie', style: TextStyle(fontSize: headingFontSize, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8.0,
            children: categoryNames.map((category) {
              bool isSelected = selectedCategory == category;

              return ChoiceChip(
                label: Text(
                  category.capitalize(),
                  style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black87),
                ),
                selected: isSelected,
                selectedColor: BrandColors.colorPrimary,
                onSelected: (selected) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              );
            }).toList(),
          ),
          const Divider(
            color: BrandColors.colorBorderCV,
            indent: 10,
            height: 60,
            thickness: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Anzahl: ',
                          style: TextStyle(fontSize: headingFontSize, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: quizCount.round().toString().padLeft(2, '  '),
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BrandColors.colorPrimary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  VerticalSlider(
                    value: quizCount,
                    min: 0,
                    max: 25,
                    onChanged: (newValue) {
                      setState(() {
                        if (widget.quizMode == QuizMode.MULTIPLE_CHOICE) {
                          newValue = max(4, newValue);
                        } else {
                          newValue = max(1, newValue);
                        }

                        quizCount = newValue;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(width: 10),
              if (widget.quizMode == QuizMode.LISTENING)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Tempo', style: TextStyle(fontSize: headingFontSize, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    _buildSpeedOption(TtsSpeed.fast, 'assets/icon/speed_fast.svg'),
                    _buildSpeedOption(TtsSpeed.normal, 'assets/icon/speed_normal.svg'),
                    _buildSpeedOption(TtsSpeed.slow, 'assets/icon/speed_slow.svg'),
                  ],
                ),
              if (widget.quizMode != QuizMode.LISTENING)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      reverseTranslation = !reverseTranslation;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Richtung', style: TextStyle(fontSize: headingFontSize, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Image.asset('assets/image/germany.png', width: 55),
                      Icon(
                        reverseTranslation ? Icons.arrow_downward : Icons.arrow_upward,
                        size: 40,
                      ),
                      Image.asset('assets/image/usa.png', width: 55),
                    ],
                  ),
                ),
            ],
          ),
          const Divider(
            color: BrandColors.colorBorderCV,
            indent: 10,
            height: 60,
            thickness: 1.5,
          ),
          Text('Weiteres', style: TextStyle(fontSize: headingFontSize, fontWeight: FontWeight.bold)),
          if (widget.quizMode == QuizMode.INPUT || widget.quizMode == QuizMode.LISTENING)
            CheckboxListTile(
              title: const Text('Groß- und Kleinschreibung bewerten'),
              value: caseSensitive,
              onChanged: (value) {
                setState(() {
                  caseSensitive = value!;
                });
              },
            ),
          if (widget.quizMode == QuizMode.INPUT || widget.quizMode == QuizMode.LISTENING)
            CheckboxListTile(
              title: const Text('Hinweise erlauben'),
              value: hintsEnabled,
              onChanged: (value) {
                setState(() {
                  hintsEnabled = value!;
                });
              },
            ),
          CheckboxListTile(
            //TODO ADD IMPLEMENTAION
            title: const Text('Automatisch weiter'),
            value: autoContinue,
            onChanged: (value) {
              setState(() {
                autoContinue = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Nur ungelernte Vokabeln'),
            value: onlyUntrained,
            onChanged: (value) {
              setState(() {
                onlyUntrained = value!;
              });
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              int categoryId = -1;
              for (Category category in categories) {
                if (category.categoryName == selectedCategory) {
                  categoryId = category.id;
                  break;
                }
              }

              if (categoryId == -1) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kategorie nicht gefunden!")));
              }

              QuizConfig quizConfig = QuizConfig(categoryId, quizCount.round(), reverseTranslation, caseSensitive, hintsEnabled,
                  autoContinue, onlyUntrained, ttsSpeed);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.quizMode.activity(quizConfig)));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: BrandColors.colorPrimary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text(
              'Quiz starten',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

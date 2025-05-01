import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanq_multiplatform/common/data/brand_colors.dart';
import 'package:scanq_multiplatform/common/ui/widget_floating_add_button.dart';
import 'package:scanq_multiplatform/quiz/ui/activity_quiz_settings.dart';
import 'package:scanq_multiplatform/quiz/ui/widgets/widget_offset_card.dart';

import '../data/quiz_mode.dart';

void main() {
  runApp(const MaterialApp(home: ActivityQuizSelect()));
}

class ActivityQuizSelect extends StatefulWidget {
  const ActivityQuizSelect({super.key});

  @override
  State<ActivityQuizSelect> createState() => _ActivityQuizSelectState();
}

class _ActivityQuizSelectState extends State<ActivityQuizSelect> {
  QuizMode? _selectedMode;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: BrandColors.colorPrimary,
        statusBarIconBrightness: Brightness.light,
      ));
    }

    return Scaffold(
        backgroundColor: BrandColors.colorPrimary,
        floatingActionButton: FloatingAddButton(),
        body: OffsetCard(
          heading: "Quiz auswählen",
          children: [
            Wrap(
              runSpacing: 20,
              alignment: WrapAlignment.spaceAround,
              children: QuizMode.values.map((mode) => _buildQuizButton(mode)).toList(),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    if (Platform.isAndroid) {
      // Reset to default when leaving this screen
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    }

    super.dispose();
  }

  Widget _buildQuizButton(QuizMode mode) {
    bool isSelected = (_selectedMode == mode);
    bool isDisabled = (mode == QuizMode.comingSoon);

    List<String> quizNames = ["Multiple\nChoice", "Eingabe", "Zuhören"];
    List<String> quizIcons = ["assets/icon/multiple_choice.png", "assets/icon/pencil.png", "assets/icon/headphones.png"];

    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
              setState(() => _selectedMode = mode);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityQuizSettings(quizMode: mode)));
            },
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(10),
          width: 145,
          height: 145,
          decoration: BoxDecoration(
            color: isSelected ? BrandColors.colorPrimaryMaterial[50] : Colors.white,
            border: Border.all(color: BrandColors.colorBorderCV, width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isDisabled ? const SizedBox(width: 1) : Image.asset(quizIcons[mode.index], width: 60, height: 60),
              const SizedBox(height: 8),
              Text(
                isDisabled ? 'Weitere Quiz in Entwicklung' : quizNames[mode.index],
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: isDisabled ? 18 : 16,
                  fontWeight: FontWeight.bold,
                  color: isDisabled ? Colors.black38 : BrandColors.colorPrimaryExtraDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

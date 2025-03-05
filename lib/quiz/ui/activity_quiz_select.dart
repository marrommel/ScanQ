import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanq_multiplatform/common/brand_colors.dart';

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: BrandColors.colorPrimary,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: BrandColors.colorPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              const Text('Quiz auswählen', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(width: 30)
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    runSpacing: 20,
                    alignment: WrapAlignment.spaceAround,
                    children: QuizMode.values.map((mode) => _buildQuizButton(mode)).toList(),
                  ),
                  ElevatedButton(
                    onPressed: _selectedMode == null || _selectedMode == QuizMode.comingSoon
                        ? null
                        : () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => _selectedMode!.activity));
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: const Text('weiter', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizButton(QuizMode mode) {
    bool isSelected = _selectedMode == mode;
    bool isDisabled = mode == QuizMode.comingSoon;

    List<String> quizNames = ["Multiple Choice", "Eingabe", "Zuhören"];
    List<IconData> quizIcons = [Icons.grid_view_rounded, Icons.text_fields_outlined, Icons.hearing];

    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
              setState(() => _selectedMode = mode);
            },
      child: Container(
        padding: EdgeInsets.all(10),
        width: 135,
        height: 135,
        decoration: BoxDecoration(
          color: isDisabled
              ? Colors.grey[400]
              : isSelected
                  ? BrandColors.colorPrimaryMaterial[400]
                  : BrandColors.colorPrimaryMaterial[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDisabled ? Icons.access_time_rounded : quizIcons[mode.index],
              size: 60,
              color: isDisabled ? Colors.black38 : Colors.black38,
            ),
            const SizedBox(height: 8),
            Text(
              isDisabled ? 'Bald verfügbar' : quizNames[mode.index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDisabled ? Colors.black38 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

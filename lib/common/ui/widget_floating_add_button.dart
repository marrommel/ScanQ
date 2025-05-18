import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../gen/l10n/app_localizations.dart';
import '../../layouts/activity_create_category.dart';
import '../../layouts/activity_vocabulary_manually.dart';
import '../../ocr/ui/activity_image_select.dart';
import '../data/brand_colors.dart';

class FloatingAddButton extends StatelessWidget {
  const FloatingAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      backgroundColor: BrandColors.colorAccent,
      foregroundColor: Colors.white,
      activeIcon: Icons.close,
      animationDuration: const Duration(milliseconds: 400),
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      spacing: 15,
      buttonSize: const Size(60, 60),
      childrenButtonSize: const Size(60, 60),
      childMargin: const EdgeInsets.all(35),
      children: [
        _buildSpeedDialChild(
          context,
          label: AppLocalizations.of(context)!.scanVocabulary,
          icon: Icons.camera_alt_outlined,
          targetPage: ActivityImageSelect(),
        ),
        _buildSpeedDialChild(
          context,
          label: AppLocalizations.of(context)!.typeVocabs,
          icon: Icons.edit,
          targetPage: ActivityVocabularyManually(),
        ),
        _buildSpeedDialChild(
          context,
          label: AppLocalizations.of(context)!.createCategory,
          icon: Icons.category_outlined,
          targetPage: ActivityCreateCategory(),
        ),
      ],
    );
  }

  SpeedDialChild _buildSpeedDialChild(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Widget targetPage,
  }) {
    return SpeedDialChild(
      labelWidget: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      child: Icon(icon, size: 35),
      onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => targetPage),
      ),
    );
  }
}

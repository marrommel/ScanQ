import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scanq_multiplatform/common/brand_colors.dart';
import 'package:scanq_multiplatform/layouts/activity_create_category.dart';
import 'package:scanq_multiplatform/ocr/ui/activity_image_select.dart';
import 'package:scanq_multiplatform/widgets/widget_display_categories.dart';

import '../common/transparent_app_bar.dart';

class ActivityCategoryOverview extends StatelessWidget {
  const ActivityCategoryOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      floatingActionButton: SpeedDial(
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
        childMargin: const EdgeInsets.all(30),
        children: [
          SpeedDialChild(
            labelWidget: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              elevation: 3,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Vokabeln hinzufügen',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            child: const Icon(Icons.abc, size: 35),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ActivityImageSelect())),
          ),
          SpeedDialChild(
            labelWidget: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              elevation: 3,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Kategorie erstellen',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            child: const Icon(Icons.category_outlined, size: 35),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ActivityCreateCategory())),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            Material(
              elevation: 3,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Container(padding: const EdgeInsets.all(32), child: CategoriesOverview()),
            ),
          ]),
        ),
      ),
    );
  }
}

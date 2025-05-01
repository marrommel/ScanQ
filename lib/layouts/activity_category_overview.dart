import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scanq_multiplatform/common/data/brand_colors.dart';
import 'package:scanq_multiplatform/layouts/activity_create_category.dart';
import 'package:scanq_multiplatform/layouts/activity_vocabulary_manually.dart';
import 'package:scanq_multiplatform/ocr/ui/activity_image_select.dart';
import 'package:scanq_multiplatform/widgets/widget_display_categories.dart';

import '../common/ui/transparent_app_bar.dart';
import '../common/ui/widget_floating_add_button.dart';

class ActivityCategoryOverview extends StatelessWidget {
  const ActivityCategoryOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      floatingActionButton: FloatingAddButton(),
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

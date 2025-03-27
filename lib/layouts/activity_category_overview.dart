import 'package:flutter/material.dart';
import 'package:scanq_multiplatform/widgets/widget_display_categories.dart';

import '../common/transparent_app_bar.dart';

class ActivityCategoryOverview extends StatelessWidget {
  const ActivityCategoryOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
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

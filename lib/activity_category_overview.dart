import 'package:flutter/material.dart';
import 'package:scanq_multiplatform/widgets/widget_display_categories.dart';

class ActivityCategoryOverview extends StatelessWidget {
  const ActivityCategoryOverview({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: null,
        body: ListView(
            children: [
              Container(
                  margin: const EdgeInsets.all(15),
                  child: Material (
                      elevation: 3,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Container(
                          padding: const EdgeInsets.all(32),
                          child: const CategoriesOverview()
                      )
                  )
              )
            ]
        )
    );
  }

}
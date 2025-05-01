import 'package:flutter/material.dart';
import 'package:scanq_multiplatform/widgets/widget_create_category.dart';

import '../common/ui/transparent_app_bar.dart';

class ActivityCreateCategory extends StatelessWidget {
  const ActivityCreateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Material(
                elevation: 3,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Container(padding: const EdgeInsets.all(20), child: const CreateCategory()))
          ]),
        ),
      ),
    );
  }
}

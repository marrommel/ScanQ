import 'package:flutter/material.dart';
import 'package:scanq_multiplatform/widgets/widget_create_category.dart';

class ActivityCreateCategory extends StatelessWidget {
  const ActivityCreateCategory({super.key});

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
                          padding: const EdgeInsets.all(20),
                          child: const CreateCategory()
                      )
                  )
              )
            ]
        )
    );
  }

}
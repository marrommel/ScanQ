import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(include: {'./data_model/categories.drift', './data_model/vocabularies.drift', './data_model/weekdays.drift'})
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static String categoryToString(final Category category) {
    return "Category{id: ${category.id}, category_name: ${category.categoryName}, date_created: ${category.dateCreated}, category_language: ${category.categoryLanguage}, is_favourite: ${category.isFavourite}}";
  }

  static String categoryLogToString(final CategoriesLogData log) {
    return "CategoriesLogData{logId: ${log.logId}, actionName: ${log.actionName}, actionTimestamp: ${log.actionTimestamp}, affectedId: ${log.affectedId}, categoryNameNew: ${log.categoryNameNew}, categoryLanguageNew: ${log.categoryLanguageNew}, dateCreatedNew: ${log.dateCreatedNew}, isFavouriteNew: ${log.isFavouriteNew}, categoryNameOld: ${log.categoryNameOld}, categoryLanguageOld: ${log.categoryLanguageOld}, dateCreatedOld: ${log.dateCreatedOld}, isFavouriteOld: ${log.isFavouriteOld}}";
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

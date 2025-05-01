// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get addCategory => 'Add category';

  @override
  String get categoryName => 'Category name';

  @override
  String get english => 'English';

  @override
  String get latin => 'Latin';

  @override
  String get french => 'French';

  @override
  String get italian => 'Italian';

  @override
  String get spanish => 'Spanish';

  @override
  String get pleaseEnterAName => 'Please enter a name.';

  @override
  String get language => 'language';

  @override
  String categoryCreatedText(String categoryName) {
    return 'Category \"$categoryName\" has been created successfully.';
  }

  @override
  String get save => 'Save';

  @override
  String get savedCategories => 'Saved categories';

  @override
  String get noDataFound => 'No data found.';

  @override
  String get addVocabulary => 'Add vocabulary';

  @override
  String get scanVocabulary => 'Scan vocabulary';

  @override
  String get category => 'Category';

  @override
  String get sourceLanguage => 'Source language';

  @override
  String get targetLanguage => 'Target language';

  @override
  String get fieldMustntBeEmpty => 'This field mustn\'t be Empty.';

  @override
  String get vocabSaved => 'Vocabulary saved';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get markAsFavourite => 'Mark as favourite';

  @override
  String get unmarkAsFavourite => 'Unmark as favourite';

  @override
  String get readOut => 'Read out';

  @override
  String xOfXVocabsLearned(int vocabsLearned, int vocabsTotal) {
    String _temp0 = intl.Intl.pluralLogic(
      vocabsTotal,
      locale: localeName,
      other: '$vocabsLearned of $vocabsTotal vocabularies learned',
      one: '$vocabsLearned of $vocabsTotal vocabulary learned',
    );
    return '$_temp0 ';
  }

  @override
  String get noVocabulariesYet => 'No vocabularies yet';

  @override
  String get quizSettings => 'Quiz settings';

  @override
  String get quizSeedOptionRandom => 'random';

  @override
  String get quizSeedOptionOnlyUnlearned => 'only unlearned';

  @override
  String get quizSeedOptionSmart => 'smart';

  @override
  String get editVocabulary => 'Edit vocabulary';

  @override
  String get readOutVocabularyBook => 'Read out vocabulary book';

  @override
  String get stopReadingOut => 'Stop reading out';

  @override
  String get means => 'means';
}

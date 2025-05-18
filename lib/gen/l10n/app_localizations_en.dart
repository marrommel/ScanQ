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

  @override
  String get max100Chars => 'Max. 100 characters';

  @override
  String get max100CharsAllowed => 'Up to 100 characters allowed';

  @override
  String get max25CharsAllowed => 'Up to 25 characters allowed';

  @override
  String get cancelScanWarning => 'Are you sure you want to cancel the scan?\n\n(Note: Scanned vocabulary will be lost)';

  @override
  String get chooseScanMedium => 'How would you like to scan vocabulary?';

  @override
  String get endScan => 'End scanning';

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get addVocabularies => 'Add vocabularies';

  @override
  String get toContinue => 'continue';

  @override
  String get customNoVocabDialogText => 'You haven\'t saved any vocabularies yet. Scan or type new vocabularies';

  @override
  String get back => 'Back';

  @override
  String get scanTitle => 'Scan';

  @override
  String get tapManuallyTitle => 'Typing';

  @override
  String get betaThanks => 'Thank you for trying the beta version of ScanQ! Do you have suggestions or encountered any issues?';

  @override
  String get feedback => 'Feedback';

  @override
  String get contact => 'Contact';

  @override
  String get saveVocabs => 'Save vocabularies';

  @override
  String get createCategory => 'Create category';

  @override
  String get or => 'or';

  @override
  String get next => 'Next';

  @override
  String get matchingCountOfTransAndVocabs => 'Different number of vocabularies and translations!';

  @override
  String get noWordsDetected => 'No words could be detected in the image.';

  @override
  String get removePhonetics => 'Remove phonetics';

  @override
  String get close => 'Close';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get cropping => 'Cropping...';

  @override
  String get scannedVocabs => 'Scanned vocabularies';

  @override
  String get savedVocabsSuccessfully => 'Vocabularies saved successfully!';

  @override
  String get mayNotBeEmpty => 'Must not be empty';

  @override
  String get mpcQuizName => 'Multiple Choice';

  @override
  String get inputQuizName => 'Input Quiz';

  @override
  String get listeningQuizName => 'Listening Quiz';

  @override
  String get mpcQuizName2 => 'Multiple\nChoice';

  @override
  String get inputQuizName2 => 'Input';

  @override
  String get listeningQuizName2 => 'Listening';

  @override
  String get answerLater => 'Answer later';

  @override
  String get end => 'End';

  @override
  String get nextQuestion => 'Next question';

  @override
  String get translate => 'Translate';

  @override
  String get yourAnswer => 'Your answer...';

  @override
  String get later => 'Later';

  @override
  String get answer => 'Answer';

  @override
  String get showHint => 'Show hint';

  @override
  String get categoryTooTiny => 'The selected category doesn\'t have enough vocabularies. Please choose one with at least 4 vocabularies.';

  @override
  String get repeat => 'Play again';

  @override
  String get yourAnswers => 'Your answers';

  @override
  String get questionColon => 'Question:';

  @override
  String get answerColon => 'Answer:';

  @override
  String get selectQuiz => 'Select quiz';

  @override
  String get moreQuizInDevelopment => 'More quizzes in development';

  @override
  String get intentionQuiz => 'to start a quiz';

  @override
  String get readingSpeed => 'Reading\nspeed';

  @override
  String get saved => 'saved';

  @override
  String get noCategoriesFound => 'No categories found';

  @override
  String get instructionAddCategroy => 'Tap the + symbol at the bottom right to create your first category.';

  @override
  String get quiz => 'Quiz';

  @override
  String get categoryNotFound => 'Category not found';

  @override
  String get rename => 'will be renamed';

  @override
  String get toOpen => 'to open';

  @override
  String get selectImage => 'Select image';

  @override
  String get vocabLearn => 'Learn Vocabularies';

  @override
  String get myVocabs => 'My Vocabularies';

  @override
  String get createNewCategory => 'Create new category';

  @override
  String get typeVocabs => 'Type vocabularies';

  @override
  String get dontRemove => 'Please don\'t remove';

  @override
  String get feedbackMailHeader => 'My feedback on the beta version of ScanQ';

  @override
  String get overview => 'Overview';

  @override
  String get scan => 'Scan';

  @override
  String get translations => 'Translations';

  @override
  String get vocabs => 'Vocabularies';

  @override
  String get countOfVocabs => 'Number of\nvocabularies: ';

  @override
  String get translationDirection => 'Translation\ndirection';

  @override
  String get further => 'Further';

  @override
  String get checkCaseCorrectness => 'Evaluate case sensitivity';

  @override
  String get allowHints => 'Allow hints';

  @override
  String get autoContinue => 'Auto continue';

  @override
  String get onlyUnlearned => 'Only unlearned vocabularies';

  @override
  String get startQuiz => 'Start quiz';
}

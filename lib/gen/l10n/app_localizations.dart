import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// The heading of the 'Add category' section
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategory;

  /// Hint for filling out the corresponding form field
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get categoryName;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @latin.
  ///
  /// In en, this message translates to:
  /// **'Latin'**
  String get latin;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @italian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get italian;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// This text is displayed if the 'Category name' field validation fails
  ///
  /// In en, this message translates to:
  /// **'Please enter a name.'**
  String get pleaseEnterAName;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'language'**
  String get language;

  /// This is the text for the SnackBar shown when a new category has been created
  ///
  /// In en, this message translates to:
  /// **'Category \"{categoryName}\" has been created successfully.'**
  String categoryCreatedText(String categoryName);

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @savedCategories.
  ///
  /// In en, this message translates to:
  /// **'Saved categories'**
  String get savedCategories;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No data found.'**
  String get noDataFound;

  /// The heading of the sectiont to add a vocab manually
  ///
  /// In en, this message translates to:
  /// **'Add vocabulary'**
  String get addVocabulary;

  /// No description provided for @scanVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Scan vocabulary'**
  String get scanVocabulary;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @sourceLanguage.
  ///
  /// In en, this message translates to:
  /// **'Source language'**
  String get sourceLanguage;

  /// No description provided for @targetLanguage.
  ///
  /// In en, this message translates to:
  /// **'Target language'**
  String get targetLanguage;

  /// No description provided for @fieldMustntBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'This field mustn\'t be Empty.'**
  String get fieldMustntBeEmpty;

  /// No description provided for @vocabSaved.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary saved'**
  String get vocabSaved;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @markAsFavourite.
  ///
  /// In en, this message translates to:
  /// **'Mark as favourite'**
  String get markAsFavourite;

  /// No description provided for @unmarkAsFavourite.
  ///
  /// In en, this message translates to:
  /// **'Unmark as favourite'**
  String get unmarkAsFavourite;

  /// No description provided for @readOut.
  ///
  /// In en, this message translates to:
  /// **'Read out'**
  String get readOut;

  /// This text is to be shown below the name of a category in the category overview
  ///
  /// In en, this message translates to:
  /// **'{vocabsTotal,plural, =1{{vocabsLearned} of {vocabsTotal} vocabulary learned} other{{vocabsLearned} of {vocabsTotal} vocabularies learned}} '**
  String xOfXVocabsLearned(int vocabsLearned, int vocabsTotal);

  /// No description provided for @noVocabulariesYet.
  ///
  /// In en, this message translates to:
  /// **'No vocabularies yet'**
  String get noVocabulariesYet;

  /// No description provided for @quizSettings.
  ///
  /// In en, this message translates to:
  /// **'Quiz settings'**
  String get quizSettings;

  /// No description provided for @quizSeedOptionRandom.
  ///
  /// In en, this message translates to:
  /// **'random'**
  String get quizSeedOptionRandom;

  /// No description provided for @quizSeedOptionOnlyUnlearned.
  ///
  /// In en, this message translates to:
  /// **'only unlearned'**
  String get quizSeedOptionOnlyUnlearned;

  /// No description provided for @quizSeedOptionSmart.
  ///
  /// In en, this message translates to:
  /// **'smart'**
  String get quizSeedOptionSmart;

  /// No description provided for @editVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Edit vocabulary'**
  String get editVocabulary;

  /// No description provided for @readOutVocabularyBook.
  ///
  /// In en, this message translates to:
  /// **'Read out vocabulary book'**
  String get readOutVocabularyBook;

  /// No description provided for @stopReadingOut.
  ///
  /// In en, this message translates to:
  /// **'Stop reading out'**
  String get stopReadingOut;

  /// No description provided for @means.
  ///
  /// In en, this message translates to:
  /// **'means'**
  String get means;

  /// No description provided for @max100Chars.
  ///
  /// In en, this message translates to:
  /// **'Max. 100 characters'**
  String get max100Chars;

  /// No description provided for @max100CharsAllowed.
  ///
  /// In en, this message translates to:
  /// **'Up to 100 characters allowed'**
  String get max100CharsAllowed;

  /// No description provided for @max25CharsAllowed.
  ///
  /// In en, this message translates to:
  /// **'Up to 25 characters allowed'**
  String get max25CharsAllowed;

  /// No description provided for @cancelScanWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel the scan?\n\n(Note: Scanned vocabulary will be lost)'**
  String get cancelScanWarning;

  /// No description provided for @chooseScanMedium.
  ///
  /// In en, this message translates to:
  /// **'How would you like to scan vocabulary?'**
  String get chooseScanMedium;

  /// No description provided for @endScan.
  ///
  /// In en, this message translates to:
  /// **'End scanning'**
  String get endScan;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @addVocabularies.
  ///
  /// In en, this message translates to:
  /// **'Add vocabularies'**
  String get addVocabularies;

  /// No description provided for @toContinue.
  ///
  /// In en, this message translates to:
  /// **'continue'**
  String get toContinue;

  /// No description provided for @customNoVocabDialogText.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t saved any vocabularies yet. Scan or type new vocabularies'**
  String get customNoVocabDialogText;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @scanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scanTitle;

  /// No description provided for @tapManuallyTitle.
  ///
  /// In en, this message translates to:
  /// **'Typing'**
  String get tapManuallyTitle;

  /// No description provided for @betaThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you for trying the beta version of ScanQ! Do you have suggestions or encountered any issues?'**
  String get betaThanks;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @saveVocabs.
  ///
  /// In en, this message translates to:
  /// **'Save vocabularies'**
  String get saveVocabs;

  /// No description provided for @createCategory.
  ///
  /// In en, this message translates to:
  /// **'Create category'**
  String get createCategory;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @matchingCountOfTransAndVocabs.
  ///
  /// In en, this message translates to:
  /// **'Different number of vocabularies and translations!'**
  String get matchingCountOfTransAndVocabs;

  /// No description provided for @noWordsDetected.
  ///
  /// In en, this message translates to:
  /// **'No words could be detected in the image.'**
  String get noWordsDetected;

  /// No description provided for @removePhonetics.
  ///
  /// In en, this message translates to:
  /// **'Remove phonetics'**
  String get removePhonetics;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @cropping.
  ///
  /// In en, this message translates to:
  /// **'Cropping...'**
  String get cropping;

  /// No description provided for @scannedVocabs.
  ///
  /// In en, this message translates to:
  /// **'Scanned vocabularies'**
  String get scannedVocabs;

  /// No description provided for @savedVocabsSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Vocabularies saved successfully!'**
  String get savedVocabsSuccessfully;

  /// No description provided for @mayNotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Must not be empty'**
  String get mayNotBeEmpty;

  /// No description provided for @mpcQuizName.
  ///
  /// In en, this message translates to:
  /// **'Multiple Choice'**
  String get mpcQuizName;

  /// No description provided for @inputQuizName.
  ///
  /// In en, this message translates to:
  /// **'Input Quiz'**
  String get inputQuizName;

  /// No description provided for @listeningQuizName.
  ///
  /// In en, this message translates to:
  /// **'Listening Quiz'**
  String get listeningQuizName;

  /// No description provided for @mpcQuizName2.
  ///
  /// In en, this message translates to:
  /// **'Multiple\nChoice'**
  String get mpcQuizName2;

  /// No description provided for @inputQuizName2.
  ///
  /// In en, this message translates to:
  /// **'Input'**
  String get inputQuizName2;

  /// No description provided for @listeningQuizName2.
  ///
  /// In en, this message translates to:
  /// **'Listening'**
  String get listeningQuizName2;

  /// No description provided for @answerLater.
  ///
  /// In en, this message translates to:
  /// **'Answer later'**
  String get answerLater;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @nextQuestion.
  ///
  /// In en, this message translates to:
  /// **'Next question'**
  String get nextQuestion;

  /// No description provided for @translate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translate;

  /// No description provided for @yourAnswer.
  ///
  /// In en, this message translates to:
  /// **'Your answer...'**
  String get yourAnswer;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @answer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// No description provided for @showHint.
  ///
  /// In en, this message translates to:
  /// **'Show hint'**
  String get showHint;

  /// No description provided for @categoryTooTiny.
  ///
  /// In en, this message translates to:
  /// **'The selected category doesn\'t have enough vocabularies. Please choose one with at least 4 vocabularies.'**
  String get categoryTooTiny;

  /// No description provided for @repeat.
  ///
  /// In en, this message translates to:
  /// **'Play again'**
  String get repeat;

  /// No description provided for @yourAnswers.
  ///
  /// In en, this message translates to:
  /// **'Your answers'**
  String get yourAnswers;

  /// No description provided for @questionColon.
  ///
  /// In en, this message translates to:
  /// **'Question:'**
  String get questionColon;

  /// No description provided for @answerColon.
  ///
  /// In en, this message translates to:
  /// **'Answer:'**
  String get answerColon;

  /// No description provided for @selectQuiz.
  ///
  /// In en, this message translates to:
  /// **'Select quiz'**
  String get selectQuiz;

  /// No description provided for @moreQuizInDevelopment.
  ///
  /// In en, this message translates to:
  /// **'More quizzes in development'**
  String get moreQuizInDevelopment;

  /// No description provided for @intentionQuiz.
  ///
  /// In en, this message translates to:
  /// **'to start a quiz'**
  String get intentionQuiz;

  /// No description provided for @readingSpeed.
  ///
  /// In en, this message translates to:
  /// **'Reading\nspeed'**
  String get readingSpeed;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'saved'**
  String get saved;

  /// No description provided for @noCategoriesFound.
  ///
  /// In en, this message translates to:
  /// **'No categories found'**
  String get noCategoriesFound;

  /// No description provided for @instructionAddCategroy.
  ///
  /// In en, this message translates to:
  /// **'Tap the + symbol at the bottom right to create your first category.'**
  String get instructionAddCategroy;

  /// No description provided for @quiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quiz;

  /// No description provided for @categoryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Category not found'**
  String get categoryNotFound;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'will be renamed'**
  String get rename;

  /// No description provided for @toOpen.
  ///
  /// In en, this message translates to:
  /// **'to open'**
  String get toOpen;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select image'**
  String get selectImage;

  /// No description provided for @vocabLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn Vocabularies'**
  String get vocabLearn;

  /// No description provided for @myVocabs.
  ///
  /// In en, this message translates to:
  /// **'My Vocabularies'**
  String get myVocabs;

  /// No description provided for @createNewCategory.
  ///
  /// In en, this message translates to:
  /// **'Create new category'**
  String get createNewCategory;

  /// No description provided for @typeVocabs.
  ///
  /// In en, this message translates to:
  /// **'Type vocabularies'**
  String get typeVocabs;

  /// No description provided for @dontRemove.
  ///
  /// In en, this message translates to:
  /// **'Please don\'t remove'**
  String get dontRemove;

  /// No description provided for @feedbackMailHeader.
  ///
  /// In en, this message translates to:
  /// **'My feedback on the beta version of ScanQ'**
  String get feedbackMailHeader;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @translations.
  ///
  /// In en, this message translates to:
  /// **'Translations'**
  String get translations;

  /// No description provided for @vocabs.
  ///
  /// In en, this message translates to:
  /// **'Vocabularies'**
  String get vocabs;

  /// No description provided for @countOfVocabs.
  ///
  /// In en, this message translates to:
  /// **'Number of\nvocabularies: '**
  String get countOfVocabs;

  /// No description provided for @translationDirection.
  ///
  /// In en, this message translates to:
  /// **'Translation\ndirection'**
  String get translationDirection;

  /// No description provided for @further.
  ///
  /// In en, this message translates to:
  /// **'Further'**
  String get further;

  /// No description provided for @checkCaseCorrectness.
  ///
  /// In en, this message translates to:
  /// **'Evaluate case sensitivity'**
  String get checkCaseCorrectness;

  /// No description provided for @allowHints.
  ///
  /// In en, this message translates to:
  /// **'Allow hints'**
  String get allowHints;

  /// No description provided for @autoContinue.
  ///
  /// In en, this message translates to:
  /// **'Auto continue'**
  String get autoContinue;

  /// No description provided for @onlyUnlearned.
  ///
  /// In en, this message translates to:
  /// **'Only unlearned vocabularies'**
  String get onlyUnlearned;

  /// No description provided for @startQuiz.
  ///
  /// In en, this message translates to:
  /// **'Start quiz'**
  String get startQuiz;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

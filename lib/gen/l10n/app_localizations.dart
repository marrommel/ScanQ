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

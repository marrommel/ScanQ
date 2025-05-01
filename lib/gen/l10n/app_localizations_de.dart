// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get addCategory => 'Kategorie hinzufügen';

  @override
  String get categoryName => 'Name der Kategorie';

  @override
  String get english => 'Englisch';

  @override
  String get latin => 'Lateinisch';

  @override
  String get french => 'Französisch';

  @override
  String get italian => 'Italienisch';

  @override
  String get spanish => 'Spanisch';

  @override
  String get pleaseEnterAName => 'Bitte gib einen Namen ein.';

  @override
  String get language => 'Sprache';

  @override
  String categoryCreatedText(String categoryName) {
    return 'Die Kategorie \"$categoryName\" wurde erfolgreich erstellt.';
  }

  @override
  String get save => 'Speichern';

  @override
  String get savedCategories => 'Gespeicherte Kategorien';

  @override
  String get noDataFound => 'Keine Daten gefunden.';

  @override
  String get addVocabulary => 'Vokabel hinzufügen';

  @override
  String get scanVocabulary => 'Vokabeln einscannen';

  @override
  String get category => 'Kategorie';

  @override
  String get sourceLanguage => 'Ausgangssprache';

  @override
  String get targetLanguage => 'Zielsprache';

  @override
  String get fieldMustntBeEmpty => 'Dieses Feld darf nicht leer sein.';

  @override
  String get vocabSaved => 'Vokabel gespeichert';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get delete => 'Löschen';

  @override
  String get markAsFavourite => 'Als Favorit markieren';

  @override
  String get unmarkAsFavourite => 'Als Favorit entfernen';

  @override
  String get readOut => 'Vorlesen';

  @override
  String xOfXVocabsLearned(int vocabsLearned, int vocabsTotal) {
    String _temp0 = intl.Intl.pluralLogic(
      vocabsTotal,
      locale: localeName,
      other: '$vocabsLearned von $vocabsTotal Vokabeln gelernt',
      one: '$vocabsLearned von $vocabsTotal Vokabel gelernt',
    );
    return '$_temp0';
  }

  @override
  String get noVocabulariesYet => 'Noch keine Vokabeln';

  @override
  String get quizSettings => 'Quiz-Einstellungen';

  @override
  String get quizSeedOptionRandom => 'zufällig';

  @override
  String get quizSeedOptionOnlyUnlearned => 'nur ungelernte';

  @override
  String get quizSeedOptionSmart => 'intelligent';

  @override
  String get editVocabulary => 'Vokabel bearbeiten';

  @override
  String get readOutVocabularyBook => 'Vokabelbuch vorlesen';

  @override
  String get stopReadingOut => 'Vorlesen beenden';

  @override
  String get means => 'bedeutet';
}

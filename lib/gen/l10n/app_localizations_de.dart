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

  @override
  String get max100Chars => 'Maximal 100 Zeichen';

  @override
  String get max100CharsAllowed => 'Maximal 100 Zeichen erlaubt';

  @override
  String get max25CharsAllowed => 'Maximal 25 Zeichen erlaubt';

  @override
  String get cancelScanWarning => 'Bist du sicher, dass du das Einscannen abbrechen willst?\n\n(Hinweis: Die eingescannten Vokabeln gehen verloren)';

  @override
  String get chooseScanMedium => 'Wie möchtest du\nVokabeln einscannen?';

  @override
  String get endScan => 'Einscannen beenden';

  @override
  String get no => 'Nein';

  @override
  String get yes => 'Ja';

  @override
  String get addVocabularies => 'Vokabeln hinzufügen';

  @override
  String get toContinue => 'fortzufahren';

  @override
  String get customNoVocabDialogText => 'Du hast noch keine Vokabeln gespeichert. Scanne oder tippe neue Vokabeln ein, um';

  @override
  String get back => 'Zurück';

  @override
  String get scanTitle => 'Einscannen';

  @override
  String get tapManuallyTitle => 'Eintippen';

  @override
  String get betaThanks => 'Vielen Dank, dass du die Beta-Version von ScanQ ausprobierst! Hast du Verbesserungen oder gab es Probleme?';

  @override
  String get feedback => 'Feedback';

  @override
  String get contact => 'Kontakt';

  @override
  String get saveVocabs => 'Vokabeln speichern';

  @override
  String get createCategory => 'Kategorie erstellen';

  @override
  String get or => 'oder';

  @override
  String get next => 'Weiter';

  @override
  String get matchingCountOfTransAndVocabs => 'Unterschiedliche Anzahl von Vokabeln und Übersetzungen!';

  @override
  String get noWordsDetected => 'Es konnten keine Wörter im Bild erkannt werden.';

  @override
  String get removePhonetics => 'Lautschriften entfernen';

  @override
  String get close => 'Schließen';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galerie';

  @override
  String get cropping => 'Zuschneiden...';

  @override
  String get scannedVocabs => 'Eingescannte Vokabeln';

  @override
  String get savedVocabsSuccessfully => 'Vokabeln erfolgreich gespeichert!';

  @override
  String get mayNotBeEmpty => 'Darf nicht leer sein';

  @override
  String get mpcQuizName => 'Multiple-Choice';

  @override
  String get inputQuizName => 'Eingabe-Quiz';

  @override
  String get listeningQuizName => 'Zuhören-Quiz';

  @override
  String get mpcQuizName2 => 'Multiple\nChoice';

  @override
  String get inputQuizName2 => 'Eingabe';

  @override
  String get listeningQuizName2 => 'Zuhören';

  @override
  String get answerLater => 'Später antworten';

  @override
  String get end => 'Beenden';

  @override
  String get nextQuestion => 'Nächste Frage';

  @override
  String get translate => 'Übersetze';

  @override
  String get yourAnswer => 'Deine Antwort...';

  @override
  String get later => 'Später';

  @override
  String get answer => 'Antworten';

  @override
  String get showHint => 'Hinweis anzeigen';

  @override
  String get categoryTooTiny => 'Die ausgewählte Kategorie hat nicht genug Vokabeln. Bitte wähle eine Kategorie mit mindestens 4 Vokablen aus.';

  @override
  String get repeat => 'Wiederholen';

  @override
  String get yourAnswers => 'Deine Antworten';

  @override
  String get questionColon => 'Frage:';

  @override
  String get answerColon => 'Lösung:';

  @override
  String get selectQuiz => 'Quiz auswählen';

  @override
  String get moreQuizInDevelopment => 'Weitere Quiz in Entwicklung';

  @override
  String get intentionQuiz => 'ein Quiz zu starten';

  @override
  String get readingSpeed => 'Vorlese-\nTempo';

  @override
  String get saved => 'gespeichert';

  @override
  String get noCategoriesFound => 'Keine Kategorien gefunden';

  @override
  String get instructionAddCategroy => 'Klicke auf das + Symbol unten rechts, um deine erste Kategorie zu erstellen.';

  @override
  String get quiz => 'Quiz';

  @override
  String get categoryNotFound => 'Kategorie nicht gefunden';

  @override
  String get rename => 'umbenennen';

  @override
  String get toOpen => 'zu öffnen';

  @override
  String get selectImage => 'Bild wählen';

  @override
  String get vocabLearn => 'Vokabeln lernen';

  @override
  String get myVocabs => 'Meine Vokabeln';

  @override
  String get createNewCategory => 'Neue Kategorie erstellen';

  @override
  String get typeVocabs => 'Vokabeln eintippen';

  @override
  String get dontRemove => 'Bitte nicht entferen';

  @override
  String get feedbackMailHeader => 'Mein Feedback zur Beta-Version von ScanQ';

  @override
  String get overview => 'Übersicht';

  @override
  String get scan => 'Scannen';

  @override
  String get translations => 'Übersetzungen';

  @override
  String get vocabs => 'Vokabeln';

  @override
  String get countOfVocabs => 'Anzahl\nVokablen: ';

  @override
  String get translationDirection => 'Übersetzungs-\nrichtung';

  @override
  String get further => 'Weiteres';

  @override
  String get checkCaseCorrectness => 'Groß- und Kleinschreibung bewerten';

  @override
  String get allowHints => 'Hinweise erlauben';

  @override
  String get autoContinue => 'Automatisch weiter';

  @override
  String get onlyUnlearned => 'Nur ungelernte Vokabeln';

  @override
  String get startQuiz => 'Quiz starten';
}

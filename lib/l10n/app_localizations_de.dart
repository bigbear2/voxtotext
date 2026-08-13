// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => 'Transkribieren';

  @override
  String get navHistory => 'Verlauf';

  @override
  String get langLabel => 'Sprache:';

  @override
  String get languageAuto => 'Automatisch (Erkennung)';

  @override
  String get homeStatusWaiting =>
      'Warte auf eine Audiodatei, die von WhatsApp oder Telegram geteilt wurde...';

  @override
  String get statusProcessing => 'Sprachnachricht mit Groq wird verarbeitet...';

  @override
  String get transcriptionCompleted => 'Transkription abgeschlossen!';

  @override
  String get noTextExtracted => 'Kein Text extrahiert.';

  @override
  String get errorFileNotFound =>
      'Fehler: Audiodatei auf dem Gerät nicht gefunden.';

  @override
  String loadedFromHistory(String date) {
    return 'Aus dem Verlauf geladen ($date)';
  }

  @override
  String errorApi(int code, String body) {
    return 'Groq-API-Fehler [$code]: $body';
  }

  @override
  String errorConversion(String error) {
    return 'Fehler bei der Konvertierung: $error';
  }

  @override
  String get copiedClipboard => 'Text in die Zwischenablage kopiert!';

  @override
  String get shareSubject => 'Sprachtranskription';

  @override
  String get transcribedLabel => 'Transkribierter Text:';

  @override
  String get btnCopy => 'Kopieren';

  @override
  String get btnShare => 'Teilen';

  @override
  String get historyTitle => 'Transkriptionsverlauf';

  @override
  String get historyEmpty => 'Keine Transkriptionen im Verlauf.';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel: $language';
  }

  @override
  String get historyLangLabel => 'Sprache';

  @override
  String get clearHistoryTitle => 'Verlauf löschen';

  @override
  String get clearHistoryBody =>
      'Möchtest du wirklich den gesamten Verlauf leeren?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get clear => 'Leeren';
}

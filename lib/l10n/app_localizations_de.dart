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
  String get statusProcessingLocal =>
      'Sprachnachricht wird lokal auf dem Gerät verarbeitet...';

  @override
  String get engineLabelLocal => 'Lokal';

  @override
  String get engineLabelGroq => 'Groq';

  @override
  String statusDownloadingModel(int percent) {
    return 'Modell wird heruntergeladen... $percent%';
  }

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

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsSectionApi => 'Groq-Transkription';

  @override
  String get settingsSectionEngine => 'Transkriptions-Engine';

  @override
  String get settingsEngineTitle => 'Transkriptions-Engine';

  @override
  String get settingsEngineLocal => 'Lokal (offline)';

  @override
  String get settingsEngineGroq => 'Groq (Cloud)';

  @override
  String settingsModelDownloadTitle(String size) {
    return 'Lokales Modell ($size)';
  }

  @override
  String get settingsModelDownloaded => 'Installiert';

  @override
  String settingsModelNotDownloaded(String size) {
    return 'Nicht installiert ($size)';
  }

  @override
  String get settingsModelDownload => 'Modell herunterladen';

  @override
  String settingsModelDownloading(int percent) {
    return 'Wird heruntergeladen… $percent%';
  }

  @override
  String get settingsModelDownloadedOk => 'Modell heruntergeladen';

  @override
  String get settingsSectionModel => 'Lokales Modell';

  @override
  String get settingsModelSelectTitle => 'Whisper-Modell';

  @override
  String get modelTinyLabel => 'Tiny';

  @override
  String get modelBaseLabel => 'Base';

  @override
  String get modelSmallLabel => 'Small';

  @override
  String get modelMediumLabel => 'Medium';

  @override
  String get modelLargeLabel => 'Large';

  @override
  String get modelTinyDesc =>
      'Das kleinste und schnellste (~39 Mio. Parameter), ideal für Geräte mit sehr begrenzten Ressourcen, aber geringere Genauigkeit.';

  @override
  String get modelBaseDesc =>
      'Etwa 74 Mio. Parameter, gut für schnelle Tests oder einfache Aufgaben.';

  @override
  String get modelSmallDesc =>
      'Kleine Größe, guter Kompromiss für den allgemeinen Gebrauch.';

  @override
  String get modelMediumDesc =>
      'Hohe Leistung, benötigt mehr Speicher (RAM/VRAM).';

  @override
  String get modelLargeDesc =>
      'Das Flaggschiff-Modell mit über 1,5 Milliarden Parametern. Maximale Genauigkeit, bewältigt Dialekte, Hintergrundgeräusche und komplexe Übersetzungen.';

  @override
  String get settingsModelDownloadHint =>
      'Das gewählte Modell wird bei der ersten Verwendung heruntergeladen.';

  @override
  String get settingsApiKeyTitle => 'Groq-API-Schlüssel';

  @override
  String get settingsApiKeyHint =>
      'Fügen Sie Ihren Groq-API-Schlüssel ein (gsk_...)';

  @override
  String get settingsApiKeyHelper =>
      'Wird zum Transkribieren von Sprachnachrichten verwendet. Holen Sie unten einen kostenlosen Schlüssel.';

  @override
  String get settingsGetKey => 'Kostenlosen Schlüssel erhalten';

  @override
  String get settingsSectionGeneral => 'Allgemein';

  @override
  String get settingsAppLangTitle => 'App-Sprache';

  @override
  String get settingsAppLangSystem => 'System (Standard)';

  @override
  String get settingsThemeTitle => 'Design';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsRepoTitle => 'Projekt-Repository';

  @override
  String get settingsRepoSub => 'Quellcode auf GitHub ansehen';

  @override
  String get settingsTranscriptionLangTitle => 'Transkriptionssprache';

  @override
  String get settingsSectionBehavior => 'Verhalten';

  @override
  String get settingsPlayAudioTitle =>
      'Audio während der Transkription abspielen';

  @override
  String get settingsPlayAudioSub =>
      'Sprachnachricht während der Transkription anhören';

  @override
  String get settingsSaveHistoryTitle => 'Transkriptionen im Verlauf speichern';

  @override
  String get settingsSaveHistorySub =>
      'Eine Kopie jeder Transkription aufbewahren';

  @override
  String get settingsNotificationsTitle =>
      'Transkriptions- Benachrichtigungen anzeigen';

  @override
  String get settingsNotificationsSub =>
      'Den transkribierten Text nach Abschluss in einer Benachrichtigung anzeigen';

  @override
  String get settingsSave => 'Speichern';

  @override
  String get settingsSaved => 'Einstellungen gespeichert';

  @override
  String get settingsKeyEmpty =>
      'Der API-Schlüssel ist leer: Die Transkription wird nicht funktionieren.';
}

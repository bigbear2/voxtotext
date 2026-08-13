// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => 'Transcrire';

  @override
  String get navHistory => 'Historique';

  @override
  String get langLabel => 'Langue :';

  @override
  String get languageAuto => 'Automatique (détection)';

  @override
  String get homeStatusWaiting =>
      'En attente d\'un fichier audio partagé depuis WhatsApp ou Telegram...';

  @override
  String get statusProcessing => 'Traitement du message vocal avec Groq...';

  @override
  String get transcriptionCompleted => 'Transcription terminée !';

  @override
  String get noTextExtracted => 'Aucun texte extrait.';

  @override
  String get errorFileNotFound =>
      'Erreur : fichier audio introuvable sur l\'appareil.';

  @override
  String loadedFromHistory(String date) {
    return 'Chargé depuis l\'historique ($date)';
  }

  @override
  String errorApi(int code, String body) {
    return 'Erreur d\'API Groq [$code] : $body';
  }

  @override
  String errorConversion(String error) {
    return 'Erreur lors de la conversion : $error';
  }

  @override
  String get copiedClipboard => 'Texte copié dans le presse-papiers !';

  @override
  String get shareSubject => 'Transcription vocale';

  @override
  String get transcribedLabel => 'Texte transcrit :';

  @override
  String get btnCopy => 'Copier';

  @override
  String get btnShare => 'Partager';

  @override
  String get historyTitle => 'Historique des Transcriptions';

  @override
  String get historyEmpty => 'Aucune transcription dans l\'historique.';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel : $language';
  }

  @override
  String get historyLangLabel => 'Langue';

  @override
  String get clearHistoryTitle => 'Effacer l\'historique';

  @override
  String get clearHistoryBody =>
      'Voulez-vous vraiment vider tout l\'historique ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get clear => 'Vider';
}

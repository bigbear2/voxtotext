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
  String get statusProcessingLocal => 'Transcription locale sur l\'appareil...';

  @override
  String statusDownloadingModel(int percent) {
    return 'Téléchargement du modèle... $percent%';
  }

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

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsSectionApi => 'Transcription Groq';

  @override
  String get settingsSectionEngine => 'Moteur de transcription';

  @override
  String get settingsEngineTitle => 'Moteur de transcription';

  @override
  String get settingsEngineLocal => 'Local (hors ligne)';

  @override
  String get settingsEngineGroq => 'Groq (cloud)';

  @override
  String settingsModelDownloadTitle(String size) {
    return 'Modèle local ($size)';
  }

  @override
  String get settingsModelDownloaded => 'Installé';

  @override
  String settingsModelNotDownloaded(String size) {
    return 'Non installé ($size)';
  }

  @override
  String get settingsModelDownload => 'Télécharger le modèle';

  @override
  String settingsModelDownloading(int percent) {
    return 'Téléchargement… $percent%';
  }

  @override
  String get settingsModelDownloadedOk => 'Modèle téléchargé';

  @override
  String get settingsApiKeyTitle => 'Clé API Groq';

  @override
  String get settingsApiKeyHint => 'Collez votre clé API Groq (gsk_...)';

  @override
  String get settingsApiKeyHelper =>
      'Utilisée pour transcrire les notes vocales. Obtenez une clé gratuite ci-dessous.';

  @override
  String get settingsGetKey => 'Obtenir une clé gratuite';

  @override
  String get settingsSectionGeneral => 'Général';

  @override
  String get settingsAppLangTitle => 'Langue de l\'application';

  @override
  String get settingsAppLangSystem => 'Système (par défaut)';

  @override
  String get settingsThemeTitle => 'Thème';

  @override
  String get settingsThemeSystem => 'Système';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsRepoTitle => 'Dépôt du projet';

  @override
  String get settingsRepoSub => 'Voir le code source sur GitHub';

  @override
  String get settingsTranscriptionLangTitle => 'Langue de transcription';

  @override
  String get settingsSectionBehavior => 'Comportement';

  @override
  String get settingsPlayAudioTitle => 'Lire l\'audio pendant la transcription';

  @override
  String get settingsPlayAudioSub =>
      'Écouter la note vocale pendant sa transcription';

  @override
  String get settingsSaveHistoryTitle =>
      'Enregistrer les transcriptions dans l\'historique';

  @override
  String get settingsSaveHistorySub =>
      'Conserver une copie de chaque transcription';

  @override
  String get settingsSave => 'Enregistrer';

  @override
  String get settingsSaved => 'Paramètres enregistrés';

  @override
  String get settingsKeyEmpty =>
      'La clé API est vide : la transcription ne fonctionnera pas.';
}

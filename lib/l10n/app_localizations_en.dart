// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => 'Transcribe';

  @override
  String get navHistory => 'History';

  @override
  String get langLabel => 'Language:';

  @override
  String get languageAuto => 'Automatic (auto-detect)';

  @override
  String get homeStatusWaiting =>
      'Waiting for an audio file shared from WhatsApp or Telegram...';

  @override
  String get statusProcessing => 'Processing voice note with Groq...';

  @override
  String get transcriptionCompleted => 'Transcription completed!';

  @override
  String get noTextExtracted => 'No text extracted.';

  @override
  String get errorFileNotFound => 'Error: audio file not found on the device.';

  @override
  String loadedFromHistory(String date) {
    return 'Loaded from history ($date)';
  }

  @override
  String errorApi(int code, String body) {
    return 'Groq API error [$code]: $body';
  }

  @override
  String errorConversion(String error) {
    return 'Error during conversion: $error';
  }

  @override
  String get copiedClipboard => 'Text copied to the clipboard!';

  @override
  String get shareSubject => 'Voice transcription';

  @override
  String get transcribedLabel => 'Transcribed text:';

  @override
  String get btnCopy => 'Copy';

  @override
  String get btnShare => 'Share';

  @override
  String get historyTitle => 'Transcription History';

  @override
  String get historyEmpty => 'No transcriptions in history.';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel: $language';
  }

  @override
  String get historyLangLabel => 'Lang';

  @override
  String get clearHistoryTitle => 'Clear History';

  @override
  String get clearHistoryBody => 'Really clear the whole history?';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSectionApi => 'Groq Transcription';

  @override
  String get settingsApiKeyTitle => 'Groq API Key';

  @override
  String get settingsApiKeyHint => 'Paste your Groq API key (gsk_...)';

  @override
  String get settingsApiKeyHelper =>
      'Used to transcribe voice notes. Get your free key below.';

  @override
  String get settingsGetKey => 'Get a free key';

  @override
  String get settingsSectionGeneral => 'General';

  @override
  String get settingsAppLangTitle => 'App language';

  @override
  String get settingsAppLangSystem => 'System (default)';

  @override
  String get settingsTranscriptionLangTitle => 'Transcription language';

  @override
  String get settingsSectionBehavior => 'Behaviour';

  @override
  String get settingsPlayAudioTitle => 'Play audio while transcribing';

  @override
  String get settingsPlayAudioSub =>
      'Listen to the voice note while it is being transcribed';

  @override
  String get settingsSaveHistoryTitle => 'Save transcriptions to history';

  @override
  String get settingsSaveHistorySub =>
      'Keep a copy of each transcription summary';

  @override
  String get settingsSave => 'Save';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String get settingsKeyEmpty =>
      'The API key is empty: transcribing will not work.';
}

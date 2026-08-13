// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => 'Trascrivi';

  @override
  String get navHistory => 'Cronologia';

  @override
  String get langLabel => 'Lingua:';

  @override
  String get languageAuto => 'Automatico (auto rilevamento)';

  @override
  String get homeStatusWaiting =>
      'In attesa di un file audio condiviso da WhatsApp o Telegram...';

  @override
  String get statusProcessing => 'Elaborazione vocale in corso con Groq...';

  @override
  String get transcriptionCompleted => 'Trascrizione completata!';

  @override
  String get noTextExtracted => 'Nessun testo estratto.';

  @override
  String get errorFileNotFound =>
      'Errore: file audio non trovato sul dispositivo.';

  @override
  String loadedFromHistory(String date) {
    return 'Caricato dalla cronologia ($date)';
  }

  @override
  String errorApi(int code, String body) {
    return 'Errore API Groq [$code]: $body';
  }

  @override
  String errorConversion(String error) {
    return 'Errore durante la conversione: $error';
  }

  @override
  String get copiedClipboard => 'Testo copiato negli appunti!';

  @override
  String get shareSubject => 'Trascrizione vocale';

  @override
  String get transcribedLabel => 'Testo trascritto:';

  @override
  String get btnCopy => 'Copia';

  @override
  String get btnShare => 'Condividi';

  @override
  String get historyTitle => 'Cronologia Trascrizioni';

  @override
  String get historyEmpty => 'Nessuna trascrizione in cronologia.';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel: $language';
  }

  @override
  String get historyLangLabel => 'Lingua';

  @override
  String get clearHistoryTitle => 'Cancella Cronologia';

  @override
  String get clearHistoryBody => 'Vuoi davvero svuotare tutta la cronologia?';

  @override
  String get cancel => 'Annulla';

  @override
  String get clear => 'Svuota';
}

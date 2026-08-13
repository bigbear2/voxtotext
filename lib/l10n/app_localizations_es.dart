// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => 'Transcribir';

  @override
  String get navHistory => 'Historial';

  @override
  String get langLabel => 'Idioma:';

  @override
  String get languageAuto => 'Automático (detección)';

  @override
  String get homeStatusWaiting =>
      'Esperando un archivo de audio compartido desde WhatsApp o Telegram...';

  @override
  String get statusProcessing => 'Procesando nota de voz con Groq...';

  @override
  String get transcriptionCompleted => '¡Transcripción completada!';

  @override
  String get noTextExtracted => 'No se extrajo texto.';

  @override
  String get errorFileNotFound =>
      'Error: archivo de audio no encontrado en el dispositivo.';

  @override
  String loadedFromHistory(String date) {
    return 'Cargado desde el historial ($date)';
  }

  @override
  String errorApi(int code, String body) {
    return 'Error de API de Groq [$code]: $body';
  }

  @override
  String errorConversion(String error) {
    return 'Error durante la conversión: $error';
  }

  @override
  String get copiedClipboard => '¡Texto copiado al portapapeles!';

  @override
  String get shareSubject => 'Transcripción de voz';

  @override
  String get transcribedLabel => 'Texto transcrito:';

  @override
  String get btnCopy => 'Copiar';

  @override
  String get btnShare => 'Compartir';

  @override
  String get historyTitle => 'Historial de Transcripciones';

  @override
  String get historyEmpty => 'No hay transcripciones en el historial.';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel: $language';
  }

  @override
  String get historyLangLabel => 'Idioma';

  @override
  String get clearHistoryTitle => 'Borrar Historial';

  @override
  String get clearHistoryBody =>
      '¿Seguro que quieres vaciar todo el historial?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get clear => 'Vaciar';
}

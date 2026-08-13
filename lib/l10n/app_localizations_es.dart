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

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsSectionApi => 'Transcripción Groq';

  @override
  String get settingsApiKeyTitle => 'Clave de API de Groq';

  @override
  String get settingsApiKeyHint => 'Pega tu clave de API de Groq (gsk_...)';

  @override
  String get settingsApiKeyHelper =>
      'Se usa para transcribir notas de voz. Obtén una clave gratuita abajo.';

  @override
  String get settingsGetKey => 'Obtener una clave gratuita';

  @override
  String get settingsSectionGeneral => 'General';

  @override
  String get settingsAppLangTitle => 'Idioma de la app';

  @override
  String get settingsAppLangSystem => 'Sistema (predeterminado)';

  @override
  String get settingsTranscriptionLangTitle => 'Idioma de transcripción';

  @override
  String get settingsSectionBehavior => 'Comportamiento';

  @override
  String get settingsPlayAudioTitle => 'Reproducir audio mientras transcribe';

  @override
  String get settingsPlayAudioSub =>
      'Escucha la nota de voz mientras se transcribe';

  @override
  String get settingsSaveHistoryTitle =>
      'Guardar transcripciones en el historial';

  @override
  String get settingsSaveHistorySub =>
      'Conserva una copia de cada transcripción';

  @override
  String get settingsSave => 'Guardar';

  @override
  String get settingsSaved => 'Configuración guardada';

  @override
  String get settingsKeyEmpty =>
      'La clave de API está vacía: la transcripción no funcionará.';
}

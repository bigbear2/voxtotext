// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => 'Transcrever';

  @override
  String get navHistory => 'Histórico';

  @override
  String get langLabel => 'Idioma:';

  @override
  String get languageAuto => 'Automático (deteção)';

  @override
  String get homeStatusWaiting =>
      'A aguardar um ficheiro de áudio partilhado do WhatsApp ou Telegram...';

  @override
  String get statusProcessing => 'A processar nota de voz com Groq...';

  @override
  String get transcriptionCompleted => 'Transcrição concluída!';

  @override
  String get noTextExtracted => 'Nenhum texto extraído.';

  @override
  String get errorFileNotFound =>
      'Erro: ficheiro de áudio não encontrado no dispositivo.';

  @override
  String loadedFromHistory(String date) {
    return 'Carregado do histórico ($date)';
  }

  @override
  String errorApi(int code, String body) {
    return 'Erro de API do Groq [$code]: $body';
  }

  @override
  String errorConversion(String error) {
    return 'Erro durante a conversão: $error';
  }

  @override
  String get copiedClipboard => 'Texto copiado para a área de transferência!';

  @override
  String get shareSubject => 'Transcrição de voz';

  @override
  String get transcribedLabel => 'Texto transcrito:';

  @override
  String get btnCopy => 'Copiar';

  @override
  String get btnShare => 'Partilhar';

  @override
  String get historyTitle => 'Histórico de Transcrições';

  @override
  String get historyEmpty => 'Sem transcrições no histórico.';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel: $language';
  }

  @override
  String get historyLangLabel => 'Idioma';

  @override
  String get clearHistoryTitle => 'Limpar Histórico';

  @override
  String get clearHistoryBody =>
      'Tem a certeza de que quer limpar todo o histórico?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get clear => 'Limpar';
}

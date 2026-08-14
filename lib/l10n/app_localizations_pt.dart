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
  String get statusProcessingLocal =>
      'A transcrever localmente no dispositivo...';

  @override
  String get engineLabelLocal => 'Local';

  @override
  String get engineLabelGroq => 'Groq';

  @override
  String statusDownloadingModel(int percent) {
    return 'A transferir o modelo... $percent%';
  }

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

  @override
  String get settingsTitle => 'Definições';

  @override
  String get settingsSectionApi => 'Transcrição Groq';

  @override
  String get settingsSectionEngine => 'Motor de transcrição';

  @override
  String get settingsEngineTitle => 'Motor de transcrição';

  @override
  String get settingsEngineLocal => 'Local (offline)';

  @override
  String get settingsEngineGroq => 'Groq (nuvem)';

  @override
  String settingsModelDownloadTitle(String size) {
    return 'Modelo local ($size)';
  }

  @override
  String get settingsModelDownloaded => 'Instalado';

  @override
  String settingsModelNotDownloaded(String size) {
    return 'Não instalado ($size)';
  }

  @override
  String get settingsModelDownload => 'Transferir modelo';

  @override
  String settingsModelDownloading(int percent) {
    return 'A transferir… $percent%';
  }

  @override
  String get settingsModelDownloadedOk => 'Modelo transferido';

  @override
  String get settingsSectionModel => 'Modelo local';

  @override
  String get settingsModelSelectTitle => 'Modelo Whisper';

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
      'O menor e mais rápido (~39 milhões de parâmetros), ideal para dispositivos com recursos muito limitados, mas com menor precisão.';

  @override
  String get modelBaseDesc =>
      'Cerca de 74 milhões de parâmetros, útil para testes rápidos ou tarefas simples.';

  @override
  String get modelSmallDesc =>
      'Tamanho reduzido, bom compromisso para uso geral.';

  @override
  String get modelMediumDesc =>
      'Alto desempenho, requer mais memória (RAM/VRAM).';

  @override
  String get modelLargeDesc =>
      'O modelo principal com mais de 1,5 bilhão de parâmetros. Precisão máxima, lida com dialetos, ruído de fundo e traduções complexas.';

  @override
  String get settingsModelDownloadHint =>
      'O modelo selecionado é baixado no primeiro uso.';

  @override
  String get settingsApiKeyTitle => 'Chave de API Groq';

  @override
  String get settingsApiKeyHint => 'Cole a sua chave de API Groq (gsk_...)';

  @override
  String get settingsApiKeyHelper =>
      'Usada para transcrever notas de voz. Obtenha uma chave gratuita abaixo.';

  @override
  String get settingsGetKey => 'Obter uma chave gratuita';

  @override
  String get settingsSectionGeneral => 'Geral';

  @override
  String get settingsAppLangTitle => 'Idioma da aplicação';

  @override
  String get settingsAppLangSystem => 'Sistema (predefinido)';

  @override
  String get settingsThemeTitle => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Escuro';

  @override
  String get settingsRepoTitle => 'Repositório do projeto';

  @override
  String get settingsRepoSub => 'Ver o código-fonte no GitHub';

  @override
  String get settingsTranscriptionLangTitle => 'Idioma de transcrição';

  @override
  String get settingsSectionBehavior => 'Comportamento';

  @override
  String get settingsPlayAudioTitle => 'Reproduzir áudio durante a transcrição';

  @override
  String get settingsPlayAudioSub =>
      'Ouvir a nota de voz enquanto é transcrita';

  @override
  String get settingsSaveHistoryTitle => 'Guardar transcrições no histórico';

  @override
  String get settingsSaveHistorySub => 'Manter uma cópia de cada transcrição';

  @override
  String get settingsSave => 'Guardar';

  @override
  String get settingsSaved => 'Definições guardadas';

  @override
  String get settingsKeyEmpty =>
      'A chave de API está vazia: a transcrição não funcionará.';
}

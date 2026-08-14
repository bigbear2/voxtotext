import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:whisper_ggml/whisper_ggml.dart';

/// Descrizione di un modello whisper selezionabile dall'utente.
class WhisperModelInfo {
  const WhisperModelInfo({required this.model, required this.sizeLabel});

  /// Il modello whisper.cpp sottostante.
  final WhisperModel model;

  /// Etichetta dimensione mostrata nella UI (es. '~142 MB').
  final String sizeLabel;

  /// Identificatore usato come valore nei dropdown / prefs.
  String get id => model.name;

  /// Nome tecnico del file scaricato (es. 'ggml-base.bin').
  String get fileName => 'ggml-${model.modelName}.bin';
}

/// Servizio per la trascrizione locale con whisper.cpp.
///
/// I modelli GGML vengono scaricati a runtime (la prima volta che servono) e
/// salvati nella directory dei file di supporto dell'app; NON vengono inclusi
/// nell'APK per non gonfiarlo.
///
/// Usa [downloadModel] per scaricare un modello con progresso, e
/// [transcribe] per trascrivere un file audio (FFmpeg integrato converte
/// automaticamente `.opus` → wav 16 kHz mono).
class WhisperService {
  WhisperService._();

  static final WhisperService instance = WhisperService._();

  final WhisperController _controller = WhisperController();

  /// Modelli selezionabili dall'utente nelle Impostazioni.
  static const List<WhisperModelInfo> models = [
    WhisperModelInfo(model: WhisperModel.tiny, sizeLabel: '~75 MB'),
    WhisperModelInfo(model: WhisperModel.base, sizeLabel: '~142 MB'),
    WhisperModelInfo(model: WhisperModel.small, sizeLabel: '~466 MB'),
    WhisperModelInfo(model: WhisperModel.medium, sizeLabel: '~1.5 GB'),
    WhisperModelInfo(model: WhisperModel.large, sizeLabel: '~3.1 GB'),
  ];

  /// Modello di default. `base` è il miglior compromesso qualità/velocità.
  WhisperModel get defaultModel => WhisperModel.base;

  /// Trova le info di un modello, o quelle del [defaultModel] se assente.
  WhisperModelInfo infoFor(WhisperModel model) {
    for (final m in models) {
      if (m.model == model) return m;
    }
    return models[1];
  }

  /// Se il [model] è già presente su disco.
  Future<bool> isModelDownloaded([WhisperModel? model]) async {
    final m = model ?? defaultModel;
    try {
      final path = await _controller.getPath(m);
      return File(path).existsSync();
    } catch (_) {
      return false;
    }
  }

  /// Etichetta dimensione del modello, per mostrarla nella UI.
  String modelSizeLabel([WhisperModel? model]) =>
      infoFor(model ?? defaultModel).sizeLabel;

  /// Scarica [model] (se non presente) riportando il progresso 0-100.
  ///
  /// [onProgress] viene invocato con la percentuale (e i byte ricevuti).
  Future<String> downloadModel(
    WhisperModel model, {
    required void Function(int percent) onProgress,
  }) async {
    final String destPath = await _controller.getPath(model);
    final File destFile = File(destPath);

    if (destFile.existsSync()) {
      onProgress(100);
      return destPath;
    }

    await destFile.parent.create(recursive: true);

    final request = http.Request('GET', model.modelUri);
    final streamed = await request.send();

    if (streamed.statusCode != 200) {
      throw HttpException(
        'Download modello fallito: HTTP ${streamed.statusCode}',
      );
    }

    final int total = streamed.contentLength ?? 0;
    int received = 0;

    final IOSink sink = destFile.openWrite();
    try {
      await for (final chunk in streamed.stream) {
        sink.add(chunk);
        received += chunk.length;
        if (total > 0) {
          onProgress((received / total * 100).clamp(0, 100).toInt());
        }
      }
      await sink.flush();
    } finally {
      await sink.close();
    }

    onProgress(100);
    return destPath;
  }

  /// Trascrive [audioPath] localmente con [model].
  ///
  /// [lang]: codice lingua ISO-639-1 (es. 'it'), oppure vuoto per il
  /// rilevamento automatico. Restituisce il testo trascritto, o null in
  /// caso di errore (che viene loggato).
  Future<String?> transcribe(
    String audioPath, {
    WhisperModel? model,
    required String lang,
    void Function(int percent)? onProgress,
  }) async {
    final m = model ?? defaultModel;
    try {
      final result = await _controller.transcribe(
        model: m,
        audioPath: audioPath,
        lang: lang,
        onProgress: onProgress,
      );

      final String? text = result?.transcription.text;
      if (text == null || text.trim().isEmpty) {
        debugPrint('whisper: nessun testo estratto');
        return null;
      }
      return text.trim();
    } catch (e) {
      debugPrint('whisper transcribe error: $e');
      return null;
    }
  }
}

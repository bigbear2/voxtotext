import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:whisper_ggml/whisper_ggml.dart';

/// Servizio per la trascrizione locale con whisper.cpp.
///
/// Il modello GGML (default [WhisperModel.base], ~142 MB) viene scaricato a
/// runtime la prima volta e salvato nella directory dei file di supporto
/// dell'app; NON viene incluso nell'APK per non gonfiarlo.
///
/// Usa [downloadModel] per scaricare il modello con progresso, e
/// [transcribe] per trascrivere un file audio (FFmpeg integrato converte
/// automaticamente `.opus` → wav 16 kHz mono).
class WhisperService {
  WhisperService._();

  static final WhisperService instance = WhisperService._();

  final WhisperController _controller = WhisperController();

  /// Modello di default. `base` è il miglior compromesso qualità/velocità.
  WhisperModel get defaultModel => WhisperModel.base;

  /// Se il modello è già presente su disco.
  Future<bool> isModelDownloaded() async {
    try {
      final path = await _controller.getPath(defaultModel);
      return File(path).existsSync();
    } catch (_) {
      return false;
    }
  }

  /// Dimensione in MB del modello, per mostrarla nella UI.
  String get modelSizeLabel => '~142 MB';

  /// Scarica il modello (se non presente) riportando il progresso 0-100.
  ///
  /// [onProgress] viene invocato con la percentuale (e i byte ricevuti).
  Future<String> downloadModel({
    required void Function(int percent) onProgress,
  }) async {
    final String destPath = await _controller.getPath(defaultModel);
    final File destFile = File(destPath);

    if (destFile.existsSync()) {
      onProgress(100);
      return destPath;
    }

    await destFile.parent.create(recursive: true);

    final request = http.Request('GET', defaultModel.modelUri);
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

  /// Trascrive [audioPath] localmente.
  ///
  /// [lang]: codice lingua ISO-639-1 (es. 'it'), oppure vuoto per il
  /// rilevamento automatico. Restituisce il testo trascritto, o null in
  /// caso di errore (che viene loggato).
  Future<String?> transcribe(
    String audioPath, {
    required String lang,
    void Function(int percent)? onProgress,
  }) async {
    try {
      final result = await _controller.transcribe(
        model: defaultModel,
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

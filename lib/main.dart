import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:share_handler/share_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'db_helper.dart';
import 'l10n/app_localizations.dart';
import 'l10n_ext.dart';
import 'languages.dart';
import 'settings_screen.dart';
import 'settings_service.dart';
import 'whisper_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SettingsService.instance.load();
  await _configureAudioSession();
  runApp(const VoxToTextApp());
}

/// Configura la sessione audio per il playback.
///
/// Necessario soprattutto su Xiaomi/MIUI: senza `AudioAttributes` e `Audio
/// Focus` espliciti, `AudioTrack` parte con `streamType -1` e va subito in
/// pausa (nessun audio). Qui forziamo contenuto "speech" + uso "media" +
/// focus `gain` (che richiede il focus e avvia la riproduzione).
Future<void> _configureAudioSession() async {
  try {
    final session = await AudioSession.instance;
    await session.configure(
      const AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playback,
        avAudioSessionCategoryOptions:
            AVAudioSessionCategoryOptions.allowBluetooth,
        androidAudioAttributes: AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          usage: AndroidAudioUsage.media,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: true,
      ),
    );
  } catch (e) {
    debugPrint('audio_session setup failed: $e');
  }
}

class VoxToTextApp extends StatefulWidget {
  const VoxToTextApp({super.key});

  @override
  State<VoxToTextApp> createState() => _VoxToTextAppState();
}

class _VoxToTextAppState extends State<VoxToTextApp> {
  @override
  void initState() {
    super.initState();
    SettingsService.instance.addListener(_onSettingsChanged);
  }

  @override
  void dispose() {
    SettingsService.instance.removeListener(_onSettingsChanged);
    super.dispose();
  }

  void _onSettingsChanged() {
    if (mounted) setState(() {});
  }

  Locale? get _localeOverride {
    final code = SettingsService.instance.appLanguage;
    if (code == 'system') return null;
    return Locale(code);
  }

  @override
  Widget build(BuildContext context) {
    final themeModeValue = SettingsService.instance.themeMode;
    return MaterialApp(
      title: 'VoxToText',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: switch (themeModeValue) {
        'dark' => ThemeMode.dark,
        'light' => ThemeMode.light,
        _ => ThemeMode.system,
      },
      locale: _localeOverride,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (final locale in supportedLocales) {
          if (locale.languageCode == deviceLocale?.languageCode) {
            return locale;
          }
        }
        return supportedLocales.first;
      },
      home: const MainTabScreen(),
    );
  }
}

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;
  final GlobalKey<_HomeScreenState> _homeKey = GlobalKey<_HomeScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(key: _homeKey),
          HistoryScreen(
            onSelectHistory: (item) {
              setState(() {
                _currentIndex = 0;
              });
              _homeKey.currentState?.loadFromHistory(item);
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.mic),
            label: context.l10n.navTranscribe,
          ),
          NavigationDestination(
            icon: const Icon(Icons.history),
            label: context.l10n.navHistory,
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _transcription = "";
  bool _isLoading = false;
  String _statusMessage = "";
  StreamSubscription? _intentSubscription;

  // Player Audio
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAudioPath;

  @override
  void initState() {
    super.initState();
    _initShareHandler();
  }

  @override
  void dispose() {
    _intentSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _initShareHandler() async {
    final handler = ShareHandlerPlatform.instance;

    final initialMedia = await handler.getInitialSharedMedia();
    if (initialMedia != null &&
        initialMedia.attachments != null &&
        initialMedia.attachments!.isNotEmpty) {
      final path = initialMedia.attachments!.first?.path;
      if (path != null) _processAudioFile(path);
    }

    _intentSubscription = handler.sharedMediaStream.listen((SharedMedia media) {
      if (media.attachments != null && media.attachments!.isNotEmpty) {
        final path = media.attachments!.first?.path;
        if (path != null) _processAudioFile(path);
      }
    });
  }

  void loadFromHistory(TranscriptionItem item) async {
    final l10n = context.l10n;
    await _audioPlayer.stop();
    // Mostra il player SOLO se il file audio esiste ancora sul dispositivo,
    // altrimenti resta nascosto (l'utente non vede un player "muto").
    final audioExists = File(item.audioPath).existsSync();
    setState(() {
      _transcription = item.text;
      _currentAudioPath = audioExists ? item.audioPath : null;
      _statusMessage = l10n.loadedFromHistory(item.date);
    });
    if (audioExists) {
      await _setupAndPlayAudio(item.audioPath);
    }
  }

  Future<void> _setupAndPlayAudio(String filePath) async {
    try {
      _currentAudioPath = filePath;
      // Imposta la sorgente audio
      await _audioPlayer.setFilePath(filePath);
      // Forzi il volume al massimo
      await _audioPlayer.setVolume(1.0);
      // Riproduzione automatica (impostabile dalle Impostazioni)
      if (SettingsService.instance.playAudio) {
        await _audioPlayer.play();
      }
    } catch (e) {
      debugPrint("Errore caricamento player: $e");
    }
  }

  Future<void> _processAudioFile(String rawPath) async {
    final l10n = context.l10n;
    await _audioPlayer.stop();
    setState(() {
      _isLoading = true;
      _transcription = "";
      _statusMessage = l10n.statusProcessing;
    });

    try {
      String cleanPath = rawPath.startsWith("file://")
          ? Uri.parse(rawPath).toFilePath()
          : rawPath;

      final file = File(cleanPath);
      if (!await file.exists()) {
        setState(() {
          _isLoading = false;
          _statusMessage = l10n.errorFileNotFound;
        });
        return;
      }

      // Prepara il player audio
      await _setupAndPlayAudio(cleanPath);

      final String lang = _whisperLangCode(
        SettingsService.instance.prefLanguage,
      );
      final String text = SettingsService.instance.useLocal
          ? await _transcribeLocal(cleanPath, lang, l10n)
          : await _transcribeGroq(cleanPath, l10n);

      if (text.isEmpty) {
        setState(() {
          _isLoading = false;
          _statusMessage = l10n.noTextExtracted;
        });
        return;
      }

      setState(() {
        _transcription = text;
        _statusMessage = l10n.transcriptionCompleted;
      });

      // Salvataggio in SQLite (se abilitato nelle Impostazioni)
      if (SettingsService.instance.saveHistory) {
        final now = DateTime.now();
        String formattedDate =
            "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}";

        await DBHelper.insert(
          TranscriptionItem(
            text: text,
            date: formattedDate,
            audioPath: cleanPath,
            language: SettingsService.instance.prefLanguage,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _statusMessage = l10n.errorConversion(e.toString());
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Mappa il codice lingua delle Impostazioni sul codice usato da whisper:
  /// 'auto' → stringa vuota (whisper.cpp rileva da solo), altrimenti il codice.
  String _whisperLangCode(String pref) => pref == 'auto' ? '' : pref;

  /// Trascrizione locale (whisper.cpp on-device). Scarica il modello la prima
  /// volta, poi trascrive con FFmpeg integrato.
  Future<String> _transcribeLocal(
    String path,
    String lang,
    AppLocalizations l10n,
  ) async {
    setState(() {
      _isLoading = true;
      _statusMessage = l10n.statusProcessingLocal;
    });

    if (!await WhisperService.instance.isModelDownloaded()) {
      setState(() {
        _statusMessage = l10n.statusDownloadingModel(0);
      });
      await WhisperService.instance.downloadModel(
        onProgress: (percent) {
          if (!mounted) return;
          setState(() => _statusMessage = l10n.statusDownloadingModel(percent));
        },
      );
    }

    final String? result = await WhisperService.instance.transcribe(
      path,
      lang: lang,
      onProgress: (percent) {
        if (!mounted) return;
        setState(() => _statusMessage = l10n.statusProcessingLocal);
      },
    );
    if (result == null) {
      setState(() {
        _isLoading = false;
        _statusMessage = l10n.errorFileNotFound;
      });
    }
    return result ?? '';
  }

  /// Trascrizione cloud con Groq (Endpoint OpenAI /audio/transcriptions).
  Future<String> _transcribeGroq(
    String cleanPath,
    AppLocalizations l10n,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.groq.com/openai/v1/audio/transcriptions'),
    );

    request.headers['Authorization'] =
        'Bearer ${SettingsService.instance.apiKey}';
    request.fields['model'] = 'whisper-large-v3';
    request.fields['response_format'] = 'json';

    if (SettingsService.instance.prefLanguage != "auto") {
      request.fields['language'] = SettingsService.instance.prefLanguage;
    }

    request.files.add(await http.MultipartFile.fromPath('file', cleanPath));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['text'] ?? '';
    } else {
      setState(() {
        _statusMessage = l10n.errorApi(response.statusCode, response.body);
      });
      return '';
    }
  }

  void _copyToClipboard() {
    final l10n = context.l10n;
    if (_transcription.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _transcription));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.copiedClipboard)));
    }
  }

  void _shareText() {
    if (_transcription.isNotEmpty) {
      Share.share(_transcription, subject: context.l10n.shareSubject);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final statusMessage = _statusMessage.isEmpty
        ? l10n.homeStatusWaiting
        : _statusMessage;
    return Scaffold(
      appBar: AppBar(
        title: const Text('VoxToText'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settingsTitle,
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SELETTORE LINGUA (FIX OVERFLOW GRAFICO)
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.language, color: Colors.teal),
                    const SizedBox(width: 8),
                    Text(
                      l10n.langLabel,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: SettingsService.instance.prefLanguage,
                          items: [
                            DropdownMenuItem<String>(
                              value: 'auto',
                              child: Text(
                                l10n.languageAuto,
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ...kTranscriptionLanguages.entries.map((entry) {
                              return DropdownMenuItem<String>(
                                value: entry.key,
                                child: Text(
                                  entry.value,
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              SettingsService.instance.setPrefLanguage(val);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // STATUS CARD
            Card(
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  statusMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(color: Colors.teal),
                ),
              ),

            // PLAYER AUDIO INTEGRATO
            if (_currentAudioPath != null && !_isLoading) ...[
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      StreamBuilder<PlayerState>(
                        stream: _audioPlayer.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          final processingState = playerState?.processingState;
                          final playing = playerState?.playing;

                          if (playing != true) {
                            return IconButton(
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.teal,
                                size: 32,
                              ),
                              onPressed: () {
                                _audioPlayer.play();
                              },
                            );
                          } else if (processingState !=
                              ProcessingState.completed) {
                            return IconButton(
                              icon: const Icon(
                                Icons.pause,
                                color: Colors.teal,
                                size: 32,
                              ),
                              onPressed: () {
                                _audioPlayer.pause();
                              },
                            );
                          } else {
                            return IconButton(
                              icon: const Icon(
                                Icons.replay,
                                color: Colors.teal,
                                size: 32,
                              ),
                              onPressed: () {
                                _audioPlayer.seek(Duration.zero);
                                _audioPlayer.play();
                              },
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: StreamBuilder<Duration>(
                          stream: _audioPlayer.positionStream,
                          builder: (context, snapshot) {
                            final position = snapshot.data ?? Duration.zero;
                            final duration =
                                _audioPlayer.duration ?? Duration.zero;
                            return Slider(
                              activeColor: Colors.teal,
                              value: position.inMilliseconds.toDouble().clamp(
                                0.0,
                                duration.inMilliseconds.toDouble(),
                              ),
                              max: duration.inMilliseconds.toDouble() > 0
                                  ? duration.inMilliseconds.toDouble()
                                  : 1.0,
                              onChanged: (val) {
                                _audioPlayer.seek(
                                  Duration(milliseconds: val.toInt()),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // AREA TESTO TRASCRITTO + PULSANTI
            if (_transcription.isNotEmpty) ...[
              Text(
                l10n.transcribedLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                constraints: const BoxConstraints(
                  minHeight: 120,
                  maxHeight: 250,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    _transcription,
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _copyToClipboard,
                      icon: const Icon(Icons.copy),
                      label: Text(l10n.btnCopy),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _shareText,
                      icon: const Icon(Icons.share),
                      label: Text(l10n.btnShare),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade700,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// SCHERMATA CRONOLOGIA
class HistoryScreen extends StatefulWidget {
  final Function(TranscriptionItem) onSelectHistory;

  const HistoryScreen({super.key, required this.onSelectHistory});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<TranscriptionItem> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final list = await DBHelper.getHistory();
    setState(() {
      _history = list;
      _isLoading = false;
    });
  }

  Future<void> _deleteItem(int id) async {
    await DBHelper.delete(id);
    _loadHistory();
  }

  Future<void> _clearAll() async {
    await DBHelper.clearAll();
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.historyTitle),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          if (_history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(l10n.clearHistoryTitle),
                    content: Text(l10n.clearHistoryBody),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(l10n.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _clearAll();
                        },
                        child: Text(
                          l10n.clear,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : _history.isEmpty
          ? Center(child: Text(l10n.historyEmpty))
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (ctx, i) {
                final item = _history[i];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(
                      item.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      l10n.historyItemSubtitle(
                        item.date,
                        l10n.historyLangLabel,
                        item.language,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        if (item.id != null) _deleteItem(item.id!);
                      },
                    ),
                    onTap: () => widget.onSelectHistory(item),
                  ),
                );
              },
            ),
    );
  }
}

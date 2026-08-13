import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:share_handler/share_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'db_helper.dart';

const String GROQ_API_KEY = "VOXTOTEXT_DEFAULT_KEY_PLACEHOLDER";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VocaleToTextApp());
}

class VocaleToTextApp extends StatelessWidget {
  const VocaleToTextApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocale2Testo Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
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
          HistoryScreen(onSelectHistory: (item) {
            setState(() {
              _currentIndex = 0;
            });
            _homeKey.currentState?.loadFromHistory(item);
          }),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.mic), label: 'Trascrivi'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Cronologia'),
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
  String _statusMessage = "In attesa di un file audio condiviso da WhatsApp...";
  StreamSubscription? _intentSubscription;

  // Player Audio
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAudioPath;

  // Lingue
  String _selectedLanguageCode = "auto";
  final Map<String, String> _languages = {
    "auto": "AUTOMATICO (Auto-Detect)",
    "it": "Italiano",
    "en": "Inglese",
    "es": "Spagnolo",
    "fr": "Francese",
    "de": "Tedesco",
  };

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
    _initShareHandler();
  }

  @override
  void dispose() {
    _intentSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguageCode = prefs.getString('selected_language') ?? 'auto';
    });
  }

  Future<void> _saveLanguagePreference(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', code);
    setState(() {
      _selectedLanguageCode = code;
    });
  }

  Future<void> _initShareHandler() async {
    final handler = ShareHandlerPlatform.instance;

    final initialMedia = await handler.getInitialSharedMedia();
    if (initialMedia != null && initialMedia.attachments != null && initialMedia.attachments!.isNotEmpty) {
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
    await _audioPlayer.stop();
    setState(() {
      _transcription = item.text;
      _currentAudioPath = item.audioPath;
      _statusMessage = "Caricato dalla cronologia (${item.date})";
    });
    if (File(item.audioPath).existsSync()) {
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
    } catch (e) {
      debugPrint("Errore caricamento player: $e");
    }
  }

  Future<void> _processAudioFile(String rawPath) async {
    await _audioPlayer.stop();
    setState(() {
      _isLoading = true;
      _transcription = "";
      _statusMessage = "Elaborazione vocale WhatsApp in corso con Groq...";
    });

    try {
      String cleanPath = rawPath.startsWith("file://")
          ? Uri.parse(rawPath).toFilePath()
          : rawPath;

      final file = File(cleanPath);
      if (!await file.exists()) {
        setState(() {
          _isLoading = false;
          _statusMessage = "Errore: File audio non trovato sul dispositivo.";
        });
        return;
      }

      // Prepara il player audio
      await _setupAndPlayAudio(cleanPath);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.groq.com/openai/v1/audio/transcriptions'),
      );

      request.headers['Authorization'] = 'Bearer $GROQ_API_KEY';
      request.fields['model'] = 'whisper-large-v3';
      request.fields['response_format'] = 'json';

      if (_selectedLanguageCode != "auto") {
        request.fields['language'] = _selectedLanguageCode;
      }

      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String extractedText = data['text'] ?? "Nessun testo estratto.";

        setState(() {
          _transcription = extractedText;
          _statusMessage = "Trascrizione completata!";
        });

        // Salvataggio in SQLite
        final now = DateTime.now();
        String formattedDate = "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}";
        
        await DBHelper.insert(TranscriptionItem(
          text: extractedText,
          date: formattedDate,
          audioPath: cleanPath,
          language: _selectedLanguageCode,
        ));

      } else {
        setState(() {
          _statusMessage = "Errore API Groq [${response.statusCode}]: ${response.body}";
        });
      }

    } catch (e) {
      setState(() {
        _statusMessage = "Errore durante la conversione: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _copyToClipboard() {
    if (_transcription.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _transcription));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Testo copiato negli appunti!')),
      );
    }
  }

  void _shareText() {
    if (_transcription.isNotEmpty) {
      Share.share(_transcription, subject: 'Trascrizione Vocale');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocale2Testo Pro'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
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
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.language, color: Colors.teal),
                    const SizedBox(width: 8),
                    const Text("Lingua:", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedLanguageCode,
                          items: _languages.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.key,
                              child: Text(
                                entry.value, 
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) _saveLanguagePreference(val);
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
              color: Colors.teal.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  _statusMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                              icon: const Icon(Icons.play_arrow, color: Colors.teal, size: 32),
                              onPressed: () {
                                _audioPlayer.play();
                              },
                            );
                          } else if (processingState != ProcessingState.completed) {
                            return IconButton(
                              icon: const Icon(Icons.pause, color: Colors.teal, size: 32),
                              onPressed: () {
                                _audioPlayer.pause();
                              },
                            );
                          } else {
                            return IconButton(
                              icon: const Icon(Icons.replay, color: Colors.teal, size: 32),
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
                            final duration = _audioPlayer.duration ?? Duration.zero;
                            return Slider(
                              activeColor: Colors.teal,
                              value: position.inMilliseconds.toDouble().clamp(0.0, duration.inMilliseconds.toDouble()),
                              max: duration.inMilliseconds.toDouble() > 0 ? duration.inMilliseconds.toDouble() : 1.0,
                              onChanged: (val) {
                                _audioPlayer.seek(Duration(milliseconds: val.toInt()));
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
              const Text(
                "Testo Trascritto:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                constraints: const BoxConstraints(minHeight: 120, maxHeight: 250),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
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
                      label: const Text("Copia"),
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
                      label: const Text("Condividi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade700,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ]
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronologia Trascrizioni'),
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
                    title: const Text("Cancella Cronologia"),
                    content: const Text("Vuoi davvero svuotare tutta la cronologia?"),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Annulla")),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _clearAll();
                        },
                        child: const Text("Svuota", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : _history.isEmpty
              ? const Center(child: Text("Nessuna trascrizione in cronologia."))
              : ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (ctx, i) {
                    final item = _history[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(
                          item.text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text("${item.date} • Lang: ${item.language}"),
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
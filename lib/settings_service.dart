import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'secrets.dart';

/// Servizio di impostazioni dell'app.
///
/// I valori vengono caricati all'avvio (in [load], chiamato da `main`) e
/// salvati + riletti ad ogni modifica tramite `shared_preferences`.
/// È un `ChangeNotifier` così la UI si aggiorna subito dopo ogni modifica.
class SettingsService extends ChangeNotifier {
  SettingsService._();

  static final SettingsService instance = SettingsService._();

  static const _kApiKey = 'groq_api_key';
  static const _kPrefLanguage = 'selected_language';
  static const _kAppLanguage = 'app_language';
  static const _kThemeMode = 'theme_mode';
  static const _kPlayAudio = 'play_audio';
  static const _kSaveHistory = 'save_history';
  static const _kEngine = 'engine';
  static const _kWhisperModel = 'whisper_model';
  static const _kNotifications = 'notifications_enabled';

  /// Motore di trascrizione: 'local' (whisper.cpp on-device) o 'groq' (cloud).
  static const String engineLocal = 'local';
  static const String engineGroq = 'groq';

  /// Nome del modello whisper selezionato (vedi `WhisperModel`):
  /// 'tiny', 'base', 'small', 'medium', 'large'.
  static const String defaultWhisperModel = 'base';

  late SharedPreferences _prefs;

  String _apiKey = defaultGroqApiKey;
  String _prefLanguage = 'auto';
  String _appLanguage = 'system'; // 'system' oppure codice lingua es. 'it'
  String _themeMode = 'system'; // 'system' | 'light' | 'dark'
  bool _playAudio = true;
  bool _saveHistory = true;
  bool _notificationsEnabled = true;
  String _engine = engineLocal; // default: locale (offline, senza chiave)
  String _whisperModel = defaultWhisperModel; // default: 'base'

  bool _loaded = false;

  bool get isLoaded => _loaded;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    _apiKey = _prefs.getString(_kApiKey) ?? defaultGroqApiKey;
    _prefLanguage = _prefs.getString(_kPrefLanguage) ?? 'auto';
    _appLanguage = _prefs.getString(_kAppLanguage) ?? 'system';
    _themeMode = _prefs.getString(_kThemeMode) ?? 'system';
    _playAudio = _prefs.getBool(_kPlayAudio) ?? true;
    _saveHistory = _prefs.getBool(_kSaveHistory) ?? true;
    _notificationsEnabled = _prefs.getBool(_kNotifications) ?? true;
    _engine = _prefs.getString(_kEngine) ?? engineLocal;
    _whisperModel = _prefs.getString(_kWhisperModel) ?? defaultWhisperModel;
    _loaded = true;
    notifyListeners();
  }

  String get apiKey => _apiKey;
  String get prefLanguage => _prefLanguage;
  String get appLanguage => _appLanguage;
  String get themeMode => _themeMode;
  bool get playAudio => _playAudio;
  bool get saveHistory => _saveHistory;
  bool get notificationsEnabled => _notificationsEnabled;
  String get engine => _engine;
  String get whisperModel => _whisperModel;

  bool get useLocal => _engine == engineLocal;

  Future<void> setApiKey(String value) async {
    _apiKey = value.trim();
    await _prefs.setString(_kApiKey, _apiKey);
    notifyListeners();
  }

  Future<void> setPrefLanguage(String value) async {
    _prefLanguage = value;
    await _prefs.setString(_kPrefLanguage, value);
    notifyListeners();
  }

  Future<void> setAppLanguage(String value) async {
    _appLanguage = value;
    await _prefs.setString(_kAppLanguage, value);
    notifyListeners();
  }

  Future<void> setThemeMode(String value) async {
    _themeMode = value;
    await _prefs.setString(_kThemeMode, value);
    notifyListeners();
  }

  Future<void> setPlayAudio(bool value) async {
    _playAudio = value;
    await _prefs.setBool(_kPlayAudio, value);
    notifyListeners();
  }

  Future<void> setSaveHistory(bool value) async {
    _saveHistory = value;
    await _prefs.setBool(_kSaveHistory, value);
    notifyListeners();
  }

  Future<void> setNotificationsEnabled(bool value) async {
    _notificationsEnabled = value;
    await _prefs.setBool(_kNotifications, value);
    notifyListeners();
  }

  Future<void> setEngine(String value) async {
    _engine = value;
    await _prefs.setString(_kEngine, value);
    notifyListeners();
  }

  Future<void> setWhisperModel(String value) async {
    _whisperModel = value;
    await _prefs.setString(_kWhisperModel, value);
    notifyListeners();
  }
}

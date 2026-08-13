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
  static const _kPlayAudio = 'play_audio';
  static const _kSaveHistory = 'save_history';

  late SharedPreferences _prefs;

  String _apiKey = defaultGroqApiKey;
  String _prefLanguage = 'auto';
  String _appLanguage = 'system'; // 'system' oppure codice lingua es. 'it'
  bool _playAudio = true;
  bool _saveHistory = true;

  bool _loaded = false;

  bool get isLoaded => _loaded;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    _apiKey = _prefs.getString(_kApiKey) ?? defaultGroqApiKey;
    _prefLanguage = _prefs.getString(_kPrefLanguage) ?? 'auto';
    _appLanguage = _prefs.getString(_kAppLanguage) ?? 'system';
    _playAudio = _prefs.getBool(_kPlayAudio) ?? true;
    _saveHistory = _prefs.getBool(_kSaveHistory) ?? true;
    _loaded = true;
    notifyListeners();
  }

  String get apiKey => _apiKey;
  String get prefLanguage => _prefLanguage;
  String get appLanguage => _appLanguage;
  bool get playAudio => _playAudio;
  bool get saveHistory => _saveHistory;

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
}

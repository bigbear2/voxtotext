import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n/app_localizations.dart';
import 'l10n_ext.dart';
import 'languages.dart';
import 'settings_service.dart';
import 'whisper_service.dart';

/// Schermata Impostazioni.
///
/// Ogni modifica viene salvata immediatamente tramite [SettingsService]
/// (persistita su shared_preferences) e riletta dall'app.
/// La schermata è reattiva: si aggiorna via [ListenableBuilder] quando il
/// servizio notifica un cambio.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _apiKeyController = TextEditingController();
  bool _obscureKey = true;

  bool _modelDownloading = false;
  int _downloadProgress = 0;
  bool _modelDownloaded = false;

  @override
  void initState() {
    super.initState();
    _apiKeyController.text = SettingsService.instance.apiKey;
    _refreshModelStatus();
  }

  Future<void> _refreshModelStatus() async {
    final downloaded = await WhisperService.instance.isModelDownloaded();
    if (!mounted) return;
    setState(() => _modelDownloaded = downloaded);
  }

  Future<void> _downloadModel() async {
    final l10n = context.l10n;
    setState(() {
      _modelDownloading = true;
      _downloadProgress = 0;
    });
    try {
      await WhisperService.instance.downloadModel(
        onProgress: (percent) {
          if (!mounted) return;
          setState(() => _downloadProgress = percent);
        },
      );
      if (!mounted) return;
      setState(() {
        _modelDownloading = false;
        _modelDownloaded = true;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.settingsModelDownloadedOk)));
    } catch (e) {
      if (!mounted) return;
      setState(() => _modelDownloading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Download errore: $e')));
    }
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  Future<void> _openGroqKeys() async {
    await _openExternalUrl('https://console.groq.com/keys');
  }

  Future<void> _openRepo() async {
    await _openExternalUrl('https://github.com/bigbear2/voxtotext');
  }

  Future<void> _openExternalUrl(String url) async {
    final ok = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossibile aprire il browser')),
      );
    }
  }

  Future<void> _saveApiKey() async {
    final l10n = context.l10n;
    await SettingsService.instance.setApiKey(_apiKeyController.text);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.settingsSaved)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListenableBuilder(
        listenable: SettingsService.instance,
        builder: (context, _) {
          final settings = SettingsService.instance;
          final keyIsEmpty = settings.apiKey.isEmpty;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── GROQ API ──
              _sectionHeader(l10n.settingsSectionApi),
              TextField(
                controller: _apiKeyController,
                obscureText: _obscureKey,
                decoration: InputDecoration(
                  labelText: l10n.settingsApiKeyTitle,
                  hintText: l10n.settingsApiKeyHint,
                  helperText: l10n.settingsApiKeyHelper,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.key),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureKey ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => _obscureKey = !_obscureKey),
                  ),
                  errorText: keyIsEmpty ? l10n.settingsKeyEmpty : null,
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              FilledButton.tonalIcon(
                onPressed: _openGroqKeys,
                icon: const Icon(Icons.open_in_new),
                label: Text(l10n.settingsGetKey),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: _saveApiKey,
                icon: const Icon(Icons.save),
                label: Text(l10n.settingsSave),
              ),
              const SizedBox(height: 24),

              // ── MOTORE DI TRASCRIZIONE ──
              _sectionHeader(l10n.settingsSectionEngine),
              _dropdownTile<String>(
                label: l10n.settingsEngineTitle,
                value: settings.engine,
                items: [
                  DropdownMenuItem(
                    value: SettingsService.engineLocal,
                    child: Text(l10n.settingsEngineLocal),
                  ),
                  DropdownMenuItem(
                    value: SettingsService.engineGroq,
                    child: Text(l10n.settingsEngineGroq),
                  ),
                ],
                onChanged: (v) {
                  if (v != null) settings.setEngine(v);
                },
              ),
              if (settings.useLocal) _modelTile(l10n),
              const SizedBox(height: 24),

              // ── GENERALE ──
              _sectionHeader(l10n.settingsSectionGeneral),
              _dropdownTile<String>(
                label: l10n.settingsAppLangTitle,
                value: settings.appLanguage,
                items: kAppLanguageCodes.map((code) {
                  return DropdownMenuItem(
                    value: code,
                    child: Text(_appLangLabel(l10n, code)),
                  );
                }).toList(),
                onChanged: (v) {
                  if (v != null) settings.setAppLanguage(v);
                },
              ),
              _dropdownTile<String>(
                label: l10n.settingsThemeTitle,
                value: settings.themeMode,
                items: [
                  DropdownMenuItem(
                    value: 'system',
                    child: Text(l10n.settingsThemeSystem),
                  ),
                  DropdownMenuItem(
                    value: 'light',
                    child: Text(l10n.settingsThemeLight),
                  ),
                  DropdownMenuItem(
                    value: 'dark',
                    child: Text(l10n.settingsThemeDark),
                  ),
                ],
                onChanged: (v) {
                  if (v != null) settings.setThemeMode(v);
                },
              ),
              _dropdownTile<String>(
                label: l10n.settingsTranscriptionLangTitle,
                value: settings.prefLanguage,
                items: [
                  DropdownMenuItem(
                    value: 'auto',
                    child: Text(l10n.languageAuto),
                  ),
                  ...kTranscriptionLanguages.entries.map((e) {
                    return DropdownMenuItem(value: e.key, child: Text(e.value));
                  }),
                ],
                onChanged: (v) {
                  if (v != null) settings.setPrefLanguage(v);
                },
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.code),
                  title: Text(l10n.settingsRepoTitle),
                  subtitle: Text(l10n.settingsRepoSub),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: _openRepo,
                ),
              ),
              const SizedBox(height: 24),

              // ── COMPORTAMENTO ──
              _sectionHeader(l10n.settingsSectionBehavior),
              SwitchListTile(
                title: Text(l10n.settingsPlayAudioTitle),
                subtitle: Text(l10n.settingsPlayAudioSub),
                value: settings.playAudio,
                onChanged: settings.setPlayAudio,
              ),
              SwitchListTile(
                title: Text(l10n.settingsSaveHistoryTitle),
                subtitle: Text(l10n.settingsSaveHistorySub),
                value: settings.saveHistory,
                onChanged: settings.setSaveHistory,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _modelTile(AppLocalizations l10n) {
    final showProgress =
        _modelDownloading || (_downloadProgress > 0 && !_modelDownloaded);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _modelDownloaded
                      ? Icons.check_circle
                      : Icons.download_for_offline,
                  color: _modelDownloaded
                      ? Colors.green
                      : Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _modelDownloaded
                      ? Text(l10n.settingsModelDownloaded)
                      : Text(
                          l10n.settingsModelNotDownloaded(
                            WhisperService.instance.modelSizeLabel,
                          ),
                        ),
                ),
                if (_modelDownloaded)
                  const Icon(Icons.cloud_done, color: Colors.green),
              ],
            ),
            if (showProgress) ...[
              const SizedBox(height: 12),
              LinearProgressIndicator(value: _downloadProgress / 100),
              const SizedBox(height: 4),
              Text(
                _modelDownloading
                    ? l10n.settingsModelDownloading(_downloadProgress)
                    : '$_downloadProgress%',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (!_modelDownloaded) ...[
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _modelDownloading ? null : _downloadModel,
                icon: const Icon(Icons.download),
                label: Text(l10n.settingsModelDownload),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _dropdownTile<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 12),
            DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                items: items,
                isExpanded: false,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _appLangLabel(AppLocalizations l10n, String code) {
    if (code == 'system') return l10n.settingsAppLangSystem;
    return kTranscriptionLanguages[code] ?? code;
  }
}

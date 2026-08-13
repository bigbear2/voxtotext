import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n/app_localizations.dart';
import 'l10n_ext.dart';
import 'languages.dart';
import 'settings_service.dart';

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

  @override
  void initState() {
    super.initState();
    _apiKeyController.text = SettingsService.instance.apiKey;
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  Future<void> _openGroqKeys() async {
    const url = 'https://console.groq.com/keys';
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

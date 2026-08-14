import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'settings_service.dart';

/// Servizio per le notifiche locali.
///
/// Mostra una notifica col testo trascritto, con un'azione "Copia" e il tap
/// che riapre l'app. La visualizzazione è opzionale: attiva solo se nelle
/// Impostazioni è abilitata l'opzione apposita.
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const int _channelId = 0;

  /// Inizializza il plugin e crea il canale notifiche.
  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const settings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        _handleAction(response.actionId);
      },
    );
  }

  /// Richiede il permesso di mostrare notifiche (Android 13+).
  Future<void> requestPermission() async {
    if (!Platform.isAndroid) return;
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.requestNotificationsPermission();
  }

  void _handleAction(String? actionId) {
    if (actionId == 'copy') {
      Clipboard.setData(ClipboardData(text: _lastText));
    }
  }

  String _lastText = '';

  /// Mostra la notifica col testo trascritto (se abilitata nelle Impostazioni).
  Future<void> showTranscription(String text) async {
    final settings = SettingsService.instance;
    if (!settings.notificationsEnabled) return;

    _lastText = text;
    const androidDetails = AndroidNotificationDetails(
      'transcription',
      'Trascrizione',
      channelDescription: 'Notifiche col testo trascritto',
      importance: Importance.high,
      priority: Priority.high,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('copy', 'Copy', showsUserInterface: false),
      ],
    );
    const details = NotificationDetails(android: androidDetails);
    await _plugin.show(_channelId, 'VoxToText', text, details);
  }
}

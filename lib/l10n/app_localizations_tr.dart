// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => 'Yazıya Dök';

  @override
  String get navHistory => 'Geçmiş';

  @override
  String get langLabel => 'Dil:';

  @override
  String get languageAuto => 'Otomatik (algılama)';

  @override
  String get homeStatusWaiting =>
      'WhatsApp veya Telegram\'dan paylaşılan bir ses dosyası bekleniyor...';

  @override
  String get statusProcessing => 'Groq ile sesli not işleniyor...';

  @override
  String get statusProcessingLocal =>
      'Cihazda yerel olarak yazıya dökülüyor...';

  @override
  String get engineLabelLocal => 'Yerel';

  @override
  String get engineLabelGroq => 'Groq';

  @override
  String statusDownloadingModel(int percent) {
    return 'Model indiriliyor... $percent%';
  }

  @override
  String get transcriptionCompleted => 'Yazıya dökme tamamlandı!';

  @override
  String get noTextExtracted => 'Metin çıkarılamadı.';

  @override
  String get errorFileNotFound => 'Hata: cihazda ses dosyası bulunamadı.';

  @override
  String loadedFromHistory(String date) {
    return 'Geçmişten yüklendi ($date)';
  }

  @override
  String errorApi(int code, String body) {
    return 'Groq API hatası [$code]: $body';
  }

  @override
  String errorConversion(String error) {
    return 'Dönüştürme sırasında hata: $error';
  }

  @override
  String get copiedClipboard => 'Metin panoya kopyalandı!';

  @override
  String get shareSubject => 'Ses yazıya dökme';

  @override
  String get transcribedLabel => 'Yazıya dökülen metin:';

  @override
  String get btnCopy => 'Kopyala';

  @override
  String get btnShare => 'Paylaş';

  @override
  String get historyTitle => 'Yazıya Dökme Geçmişi';

  @override
  String get historyEmpty => 'Geçmişte yazıya dökme yok.';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel: $language';
  }

  @override
  String get historyLangLabel => 'Dil';

  @override
  String get clearHistoryTitle => 'Geçmişi Temizle';

  @override
  String get clearHistoryBody => 'Geçmişin tamamı gerçekten temizlensin mi?';

  @override
  String get cancel => 'İptal';

  @override
  String get clear => 'Temizle';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsSectionApi => 'Groq Dönüştürme';

  @override
  String get settingsSectionEngine => 'Transkripsiyon motoru';

  @override
  String get settingsEngineTitle => 'Transkripsiyon motoru';

  @override
  String get settingsEngineLocal => 'Yerel (çevrimdışı)';

  @override
  String get settingsEngineGroq => 'Groq (bulut)';

  @override
  String settingsModelDownloadTitle(String size) {
    return 'Yerel model ($size)';
  }

  @override
  String get settingsModelDownloaded => 'Kuruldu';

  @override
  String settingsModelNotDownloaded(String size) {
    return 'Kurulmadı ($size)';
  }

  @override
  String get settingsModelDownload => 'Modeli indir';

  @override
  String settingsModelDownloading(int percent) {
    return 'İndiriliyor… $percent%';
  }

  @override
  String get settingsModelDownloadedOk => 'Model indirildi';

  @override
  String get settingsSectionModel => 'Yerel Model';

  @override
  String get settingsModelSelectTitle => 'Whisper Modeli';

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
      'En küçük ve en hızlı (~39 milyon parametre), çok sınırlı kaynaklara sahip cihazlar için idealdir, ancak doğruluk daha düşüktür.';

  @override
  String get modelBaseDesc =>
      'Yaklaşık 74 milyon parametre, hızlı testler veya basit görevler için uygundur.';

  @override
  String get modelSmallDesc =>
      'Küçük boyut, genel kullanım için iyi bir denge.';

  @override
  String get modelMediumDesc =>
      'Yüksek performans, daha fazla bellek (RAM/VRAM) gerektirir.';

  @override
  String get modelLargeDesc =>
      '1,5 milyardan fazla parametreye sahip amiral gemisi modeli. Maksimum doğruluk, lehçeleri, arka plan gürültüsünü ve karmaşık çevirileri yönetir.';

  @override
  String get settingsModelDownloadHint =>
      'Seçilen model ilk kullanımda indirilir.';

  @override
  String get settingsApiKeyTitle => 'Groq API Anahtarı';

  @override
  String get settingsApiKeyHint => 'Groq API anahtarınızı yapıştırın (gsk_...)';

  @override
  String get settingsApiKeyHelper =>
      'Sesli notları metne dönüştürmek için kullanılır. Aşağıdan ücretsiz bir anahtar alın.';

  @override
  String get settingsGetKey => 'Ücretsiz anahtar al';

  @override
  String get settingsSectionGeneral => 'Genel';

  @override
  String get settingsAppLangTitle => 'Uygulama dili';

  @override
  String get settingsAppLangSystem => 'Sistem (varsayılan)';

  @override
  String get settingsThemeTitle => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistem';

  @override
  String get settingsThemeLight => 'Açık';

  @override
  String get settingsThemeDark => 'Koyu';

  @override
  String get settingsRepoTitle => 'Proje deposu';

  @override
  String get settingsRepoSub => 'Kaynak kodu GitHub\'da görüntüle';

  @override
  String get settingsTranscriptionLangTitle => 'Dönüştürme dili';

  @override
  String get settingsSectionBehavior => 'Davranış';

  @override
  String get settingsPlayAudioTitle => 'Dönüştürme sırasında sesi çal';

  @override
  String get settingsPlayAudioSub => 'Dönüştürülürken sesli notu dinle';

  @override
  String get settingsSaveHistoryTitle => 'Dönüştürmeleri geçmişe kaydet';

  @override
  String get settingsSaveHistorySub => 'Her dönüştürmenin bir kopyasını sakla';

  @override
  String get settingsNotificationsTitle =>
      'Transkripsiyon bildirimlerini göster';

  @override
  String get settingsNotificationsSub =>
      'Bittiğinde bildirimde transkripte edilmiş metni göster';

  @override
  String get settingsSave => 'Kaydet';

  @override
  String get settingsSaved => 'Ayarlar kaydedildi';

  @override
  String get settingsKeyEmpty => 'API anahtarı boş: dönüştürme çalışmayacak.';
}

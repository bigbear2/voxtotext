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
}

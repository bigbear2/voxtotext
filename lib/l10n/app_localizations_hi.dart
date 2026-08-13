// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => 'लिप्यंतरण';

  @override
  String get navHistory => 'इतिहास';

  @override
  String get langLabel => 'भाषा:';

  @override
  String get languageAuto => 'स्वचालित (पहचान)';

  @override
  String get homeStatusWaiting =>
      'WhatsApp या Telegram से साझा किए गए ऑडियो फ़ाइल की प्रतीक्षा में...';

  @override
  String get statusProcessing =>
      'Groq के साथ वॉइस नोट संसाधित किया जा रहा है...';

  @override
  String get transcriptionCompleted => 'लिप्यंतरण पूर्ण!';

  @override
  String get noTextExtracted => 'कोई पाठ निकाला नहीं गया।';

  @override
  String get errorFileNotFound => 'त्रुटि: डिवाइस पर ऑडियो फ़ाइल नहीं मिली।';

  @override
  String loadedFromHistory(String date) {
    return 'इतिहास से लोड किया गया ($date)';
  }

  @override
  String errorApi(int code, String body) {
    return 'Groq API त्रुटि [$code]: $body';
  }

  @override
  String errorConversion(String error) {
    return 'रूपांतरण के दौरान त्रुटि: $error';
  }

  @override
  String get copiedClipboard => 'पाठ क्लिपबोर्ड पर कॉपी हो गया!';

  @override
  String get shareSubject => 'वॉइस लिप्यंतरण';

  @override
  String get transcribedLabel => 'लिप्यंतरित पाठ:';

  @override
  String get btnCopy => 'कॉपी करें';

  @override
  String get btnShare => 'साझा करें';

  @override
  String get historyTitle => 'लिप्यंतरण इतिहास';

  @override
  String get historyEmpty => 'इतिहास में कोई लिप्यंतरण नहीं।';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel: $language';
  }

  @override
  String get historyLangLabel => 'भाषा';

  @override
  String get clearHistoryTitle => 'इतिहास साफ़ करें';

  @override
  String get clearHistoryBody => 'क्या वाकई पूरा इतिहास साफ़ करें?';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get clear => 'साफ़ करें';
}

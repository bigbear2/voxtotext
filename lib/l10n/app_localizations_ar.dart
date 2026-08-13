// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => 'نسخ';

  @override
  String get navHistory => 'السجل';

  @override
  String get langLabel => 'اللغة:';

  @override
  String get languageAuto => 'تلقائي (كشف)';

  @override
  String get homeStatusWaiting =>
      'في انتظار ملف صوتي تمت مشاركته من واتساب أو تيليجرام...';

  @override
  String get statusProcessing => 'جارٍ معالجة رسالة صوتية مع Groq...';

  @override
  String get transcriptionCompleted => 'اكتمل النسخ!';

  @override
  String get noTextExtracted => 'لم يتم استخراج نص.';

  @override
  String get errorFileNotFound => 'خطأ: ملف الصوت غير موجود على الجهاز.';

  @override
  String loadedFromHistory(String date) {
    return 'تم التحميل من السجل ($date)';
  }

  @override
  String errorApi(int code, String body) {
    return 'خطأ API من Groq [$code]: $body';
  }

  @override
  String errorConversion(String error) {
    return 'خطأ أثناء التحويل: $error';
  }

  @override
  String get copiedClipboard => 'تم نسخ النص إلى الحافظة!';

  @override
  String get shareSubject => 'نسخ صوتي';

  @override
  String get transcribedLabel => 'النص المنسوخ:';

  @override
  String get btnCopy => 'نسخ';

  @override
  String get btnShare => 'مشاركة';

  @override
  String get historyTitle => 'سجل النسخ';

  @override
  String get historyEmpty => 'لا توجد نصوص منسوخة في السجل.';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel: $language';
  }

  @override
  String get historyLangLabel => 'اللغة';

  @override
  String get clearHistoryTitle => 'مسح السجل';

  @override
  String get clearHistoryBody => 'هل تريد بالتأكيد مسح السجل بالكامل؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get clear => 'مسح';
}

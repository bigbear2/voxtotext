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
  String get statusProcessingLocal =>
      'डिवाइस पर स्थानीय रूप से ट्रांसक्राइब हो रहा है...';

  @override
  String get engineLabelLocal => 'स्थानीय';

  @override
  String get engineLabelGroq => 'Groq';

  @override
  String statusDownloadingModel(int percent) {
    return 'मॉडल डाउनलोड हो रहा है... $percent%';
  }

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

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsSectionApi => 'Groq ट्रांसक्रिप्शन';

  @override
  String get settingsSectionEngine => 'ट्रांसक्रिप्शन इंजन';

  @override
  String get settingsEngineTitle => 'ट्रांसक्रिप्शन इंजन';

  @override
  String get settingsEngineLocal => 'स्थानीय (ऑफ़लाइन)';

  @override
  String get settingsEngineGroq => 'Groq (क्लाउड)';

  @override
  String settingsModelDownloadTitle(String size) {
    return 'स्थानीय मॉडल ($size)';
  }

  @override
  String get settingsModelDownloaded => 'स्थापित';

  @override
  String settingsModelNotDownloaded(String size) {
    return 'स्थापित नहीं ($size)';
  }

  @override
  String get settingsModelDownload => 'मॉडल डाउनलोड करें';

  @override
  String settingsModelDownloading(int percent) {
    return 'डाउनलोड हो रहा है... $percent%';
  }

  @override
  String get settingsModelDownloadedOk => 'मॉडल डाउनलोड हो गया';

  @override
  String get settingsSectionModel => 'स्थानीय मॉडल';

  @override
  String get settingsModelSelectTitle => 'Whisper मॉडल';

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
      'सबसे छोटा और तेज़ (~39 मिलियन पैरामीटर), बहुत सीमित संसाधनों वाले उपकरणों के लिए आदर्श, लेकिन सटीकता कम।';

  @override
  String get modelBaseDesc =>
      'लगभग 74 मिलियन पैरामीटर, त्वरित परीक्षण या सरल कार्यों के लिए उपयोगी।';

  @override
  String get modelSmallDesc => 'छोटा आकार, सामान्य उपयोग के लिए अच्छा समझौता।';

  @override
  String get modelMediumDesc =>
      'उच्च प्रदर्शन, अधिक मेमोरी (RAM/VRAM) की आवश्यकता है।';

  @override
  String get modelLargeDesc =>
      '1.5 अरब से अधिक पैरामीटर वाला प्रमुख मॉडल। अधिकतम सटीकता, बोलियों, पृष्ठभूमि शोर और जटिल अनुवादों को संभालता है।';

  @override
  String get settingsModelDownloadHint =>
      'चयनित मॉडल पहले उपयोग पर डाउनलोड किया जाता है।';

  @override
  String get settingsApiKeyTitle => 'Groq API कुंजी';

  @override
  String get settingsApiKeyHint => 'अपनी Groq API कुंजी पेस्ट करें (gsk_...)';

  @override
  String get settingsApiKeyHelper =>
      'वॉइस नोट ट्रांसक्राइब करने के लिए। नीचे मुफ़्त कुंजी पाएं।';

  @override
  String get settingsGetKey => 'मुफ़्त कुंजी प्राप्त करें';

  @override
  String get settingsSectionGeneral => 'सामान्य';

  @override
  String get settingsAppLangTitle => 'ऐप भाषा';

  @override
  String get settingsAppLangSystem => 'सिस्टम (डिफ़ॉल्ट)';

  @override
  String get settingsThemeTitle => 'थीम';

  @override
  String get settingsThemeSystem => 'सिस्टम';

  @override
  String get settingsThemeLight => 'हल्का';

  @override
  String get settingsThemeDark => 'गहरा';

  @override
  String get settingsRepoTitle => 'प्रोजेक्ट रिपॉज़िटरी';

  @override
  String get settingsRepoSub => 'GitHub पर सोर्स कोड देखें';

  @override
  String get settingsTranscriptionLangTitle => 'ट्रांसक्रिप्शन भाषा';

  @override
  String get settingsSectionBehavior => 'व्यवहार';

  @override
  String get settingsPlayAudioTitle => 'ट्रांसक्रिप्शन के दौरान ऑडियो चलाएं';

  @override
  String get settingsPlayAudioSub => 'ट्रांसक्राइब होते समय वॉइस नोट सुनें';

  @override
  String get settingsSaveHistoryTitle => 'ट्रांसक्रिप्शन इतिहास में सहेजें';

  @override
  String get settingsSaveHistorySub =>
      'प्रत्येक ट्रांसक्रिप्शन की एक प्रति रखें';

  @override
  String get settingsSave => 'सहेजें';

  @override
  String get settingsSaved => 'सेटिंग्स सहेजी गईं';

  @override
  String get settingsKeyEmpty =>
      'API कुंजी खाली है: ट्रांसक्रिप्शन काम नहीं करेगा।';
}

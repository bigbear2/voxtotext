// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => '转写';

  @override
  String get navHistory => '历史记录';

  @override
  String get langLabel => '语言：';

  @override
  String get languageAuto => '自动（检测）';

  @override
  String get homeStatusWaiting => '正在等待从 WhatsApp 或 Telegram 分享的音频文件……';

  @override
  String get statusProcessing => '正在使用 Groq 处理语音消息……';

  @override
  String get transcriptionCompleted => '转写完成！';

  @override
  String get noTextExtracted => '未提取到文本。';

  @override
  String get errorFileNotFound => '错误：设备上找不到音频文件。';

  @override
  String loadedFromHistory(String date) {
    return '已从历史记录加载（$date）';
  }

  @override
  String errorApi(int code, String body) {
    return 'Groq API 错误 [$code]：$body';
  }

  @override
  String errorConversion(String error) {
    return '转换期间出错：$error';
  }

  @override
  String get copiedClipboard => '文本已复制到剪贴板！';

  @override
  String get shareSubject => '语音转写';

  @override
  String get transcribedLabel => '转写文本：';

  @override
  String get btnCopy => '复制';

  @override
  String get btnShare => '分享';

  @override
  String get historyTitle => '转写历史记录';

  @override
  String get historyEmpty => '历史记录中没有转写内容。';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel：$language';
  }

  @override
  String get historyLangLabel => '语言';

  @override
  String get clearHistoryTitle => '清除历史记录';

  @override
  String get clearHistoryBody => '确定要清空全部历史记录吗？';

  @override
  String get cancel => '取消';

  @override
  String get clear => '清空';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsSectionApi => 'Groq 转录';

  @override
  String get settingsApiKeyTitle => 'Groq API 密钥';

  @override
  String get settingsApiKeyHint => '粘贴您的 Groq API 密钥 (gsk_...)';

  @override
  String get settingsApiKeyHelper => '用于转录语音消息。在下方获取免费密钥。';

  @override
  String get settingsGetKey => '获取免费密钥';

  @override
  String get settingsSectionGeneral => '常规';

  @override
  String get settingsAppLangTitle => '应用语言';

  @override
  String get settingsAppLangSystem => '系统（默认）';

  @override
  String get settingsThemeTitle => '主题';

  @override
  String get settingsThemeSystem => '系统';

  @override
  String get settingsThemeLight => '浅色';

  @override
  String get settingsThemeDark => '深色';

  @override
  String get settingsTranscriptionLangTitle => '转录语言';

  @override
  String get settingsSectionBehavior => '行为';

  @override
  String get settingsPlayAudioTitle => '转录时播放音频';

  @override
  String get settingsPlayAudioSub => '转录时收听语音消息';

  @override
  String get settingsSaveHistoryTitle => '将转录保存到历史记录';

  @override
  String get settingsSaveHistorySub => '保留每次转录的副本';

  @override
  String get settingsSave => '保存';

  @override
  String get settingsSaved => '设置已保存';

  @override
  String get settingsKeyEmpty => 'API 密钥为空：转录将无法工作。';
}

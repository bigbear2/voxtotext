// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => 'Расшифровать';

  @override
  String get navHistory => 'История';

  @override
  String get langLabel => 'Язык:';

  @override
  String get languageAuto => 'Автоматически (определение)';

  @override
  String get homeStatusWaiting =>
      'Ожидание аудиофайла, отправленного из WhatsApp или Telegram...';

  @override
  String get statusProcessing => 'Обработка голосового сообщения с Groq...';

  @override
  String get statusProcessingLocal => 'Транскрибация локально на устройстве...';

  @override
  String get engineLabelLocal => 'Локально';

  @override
  String get engineLabelGroq => 'Groq';

  @override
  String statusDownloadingModel(int percent) {
    return 'Загрузка модели... $percent%';
  }

  @override
  String get transcriptionCompleted => 'Расшифровка завершена!';

  @override
  String get noTextExtracted => 'Текст не извлечён.';

  @override
  String get errorFileNotFound => 'Ошибка: аудиофайл не найден на устройстве.';

  @override
  String loadedFromHistory(String date) {
    return 'Загружено из истории ($date)';
  }

  @override
  String errorApi(int code, String body) {
    return 'Ошибка API Groq [$code]: $body';
  }

  @override
  String errorConversion(String error) {
    return 'Ошибка при конвертации: $error';
  }

  @override
  String get copiedClipboard => 'Текст скопирован в буфер обмена!';

  @override
  String get shareSubject => 'Расшифровка голоса';

  @override
  String get transcribedLabel => 'Расшифрованный текст:';

  @override
  String get btnCopy => 'Копировать';

  @override
  String get btnShare => 'Поделиться';

  @override
  String get historyTitle => 'История расшифровок';

  @override
  String get historyEmpty => 'В истории нет расшифровок.';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel: $language';
  }

  @override
  String get historyLangLabel => 'Язык';

  @override
  String get clearHistoryTitle => 'Очистить историю';

  @override
  String get clearHistoryBody => 'Точно очистить всю историю?';

  @override
  String get cancel => 'Отмена';

  @override
  String get clear => 'Очистить';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsSectionApi => 'Распознавание Groq';

  @override
  String get settingsSectionEngine => 'Движок транскрибации';

  @override
  String get settingsEngineTitle => 'Движок транскрибации';

  @override
  String get settingsEngineLocal => 'Локально (офлайн)';

  @override
  String get settingsEngineGroq => 'Groq (облако)';

  @override
  String settingsModelDownloadTitle(String size) {
    return 'Локальная модель ($size)';
  }

  @override
  String get settingsModelDownloaded => 'Установлен';

  @override
  String settingsModelNotDownloaded(String size) {
    return 'Не установлен ($size)';
  }

  @override
  String get settingsModelDownload => 'Скачать модель';

  @override
  String settingsModelDownloading(int percent) {
    return 'Загрузка… $percent%';
  }

  @override
  String get settingsModelDownloadedOk => 'Модель загружена';

  @override
  String get settingsSectionModel => 'Локальная модель';

  @override
  String get settingsModelSelectTitle => 'Модель Whisper';

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
      'Самая маленькая и быстрая (~39 млн параметров), идеальна для устройств с очень ограниченными ресурсами, но ниже точность.';

  @override
  String get modelBaseDesc =>
      'Около 74 млн параметров, подходит для быстрых тестов или простых задач.';

  @override
  String get modelSmallDesc =>
      'Небольшой размер, хороший компромисс для общего использования.';

  @override
  String get modelMediumDesc =>
      'Высокая производительность, требует больше памяти (RAM/VRAM).';

  @override
  String get modelLargeDesc =>
      'Флагманская модель с более чем 1,5 млрд параметров. Максимальная точность, справляется с диалектами, шумом и сложными переводами.';

  @override
  String get settingsModelDownloadHint =>
      'Выбранная модель загружается при первом использовании.';

  @override
  String get settingsApiKeyTitle => 'API-ключ Groq';

  @override
  String get settingsApiKeyHint => 'Вставьте ваш API-ключ Groq (gsk_...)';

  @override
  String get settingsApiKeyHelper =>
      'Используется для распознавания голосовых сообщений. Получите бесплатный ключ ниже.';

  @override
  String get settingsGetKey => 'Получить бесплатный ключ';

  @override
  String get settingsSectionGeneral => 'Общие';

  @override
  String get settingsAppLangTitle => 'Язык приложения';

  @override
  String get settingsAppLangSystem => 'Системный (по умолчанию)';

  @override
  String get settingsThemeTitle => 'Тема';

  @override
  String get settingsThemeSystem => 'Система';

  @override
  String get settingsThemeLight => 'Светлая';

  @override
  String get settingsThemeDark => 'Тёмная';

  @override
  String get settingsRepoTitle => 'Репозиторий проекта';

  @override
  String get settingsRepoSub => 'Посмотреть исходный код на GitHub';

  @override
  String get settingsTranscriptionLangTitle => 'Язык распознавания';

  @override
  String get settingsSectionBehavior => 'Поведение';

  @override
  String get settingsPlayAudioTitle =>
      'Воспроизводить аудио во время распознавания';

  @override
  String get settingsPlayAudioSub =>
      'Слушать голосовое сообщение во время распознавания';

  @override
  String get settingsSaveHistoryTitle => 'Сохранять распознавания в историю';

  @override
  String get settingsSaveHistorySub =>
      'Сохранять копию каждого распознанного текста';

  @override
  String get settingsSave => 'Сохранить';

  @override
  String get settingsSaved => 'Настройки сохранены';

  @override
  String get settingsKeyEmpty =>
      'API-ключ пуст: распознавание не будет работать.';
}

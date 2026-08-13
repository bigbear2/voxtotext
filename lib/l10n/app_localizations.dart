import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'VoxToText'**
  String get appTitle;

  /// Bottom navigation tab to transcribe a voice note
  ///
  /// In en, this message translates to:
  /// **'Transcribe'**
  String get navTranscribe;

  /// Bottom navigation tab showing past transcriptions
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// Label before the language dropdown
  ///
  /// In en, this message translates to:
  /// **'Language:'**
  String get langLabel;

  /// Dropdown option: auto-detects the audio language
  ///
  /// In en, this message translates to:
  /// **'Automatic (auto-detect)'**
  String get languageAuto;

  /// Idle status message on the home screen
  ///
  /// In en, this message translates to:
  /// **'Waiting for an audio file shared from WhatsApp or Telegram...'**
  String get homeStatusWaiting;

  /// Status shown while transcribing
  ///
  /// In en, this message translates to:
  /// **'Processing voice note with Groq...'**
  String get statusProcessing;

  /// Status shown after a successful transcription
  ///
  /// In en, this message translates to:
  /// **'Transcription completed!'**
  String get transcriptionCompleted;

  /// Fallback when the API returns no text
  ///
  /// In en, this message translates to:
  /// **'No text extracted.'**
  String get noTextExtracted;

  /// Shown when the shared audio file does not exist
  ///
  /// In en, this message translates to:
  /// **'Error: audio file not found on the device.'**
  String get errorFileNotFound;

  /// Status when loading a past transcription
  ///
  /// In en, this message translates to:
  /// **'Loaded from history ({date})'**
  String loadedFromHistory(String date);

  /// Shown when the Groq API returns an error
  ///
  /// In en, this message translates to:
  /// **'Groq API error [{code}]: {body}'**
  String errorApi(int code, String body);

  /// Generic conversion error
  ///
  /// In en, this message translates to:
  /// **'Error during conversion: {error}'**
  String errorConversion(String error);

  /// Snackbar after copying the transcription
  ///
  /// In en, this message translates to:
  /// **'Text copied to the clipboard!'**
  String get copiedClipboard;

  /// Subject used when sharing the transcription text
  ///
  /// In en, this message translates to:
  /// **'Voice transcription'**
  String get shareSubject;

  /// Heading above the resulting text
  ///
  /// In en, this message translates to:
  /// **'Transcribed text:'**
  String get transcribedLabel;

  /// Button to copy the transcription
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get btnCopy;

  /// Button to share the transcription
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get btnShare;

  /// Title of the history screen
  ///
  /// In en, this message translates to:
  /// **'Transcription History'**
  String get historyTitle;

  /// Empty history message
  ///
  /// In en, this message translates to:
  /// **'No transcriptions in history.'**
  String get historyEmpty;

  /// Subtitle of a history item
  ///
  /// In en, this message translates to:
  /// **'{date} • {langLabel}: {language}'**
  String historyItemSubtitle(String date, String langLabel, String language);

  /// Short label meaning Language in history items
  ///
  /// In en, this message translates to:
  /// **'Lang'**
  String get historyLangLabel;

  /// Dialog title to confirm clearing history
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get clearHistoryTitle;

  /// Dialog body asking confirmation
  ///
  /// In en, this message translates to:
  /// **'Really clear the whole history?'**
  String get clearHistoryBody;

  /// Button to dismiss a dialog
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button to confirm clearing
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Title of the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Section header for the API settings
  ///
  /// In en, this message translates to:
  /// **'Groq Transcription'**
  String get settingsSectionApi;

  /// Label of the API key field
  ///
  /// In en, this message translates to:
  /// **'Groq API Key'**
  String get settingsApiKeyTitle;

  /// Hint text inside the API key field
  ///
  /// In en, this message translates to:
  /// **'Paste your Groq API key (gsk_...)'**
  String get settingsApiKeyHint;

  /// Helper text under the API key field
  ///
  /// In en, this message translates to:
  /// **'Used to transcribe voice notes. Get your free key below.'**
  String get settingsApiKeyHelper;

  /// Button opening the Groq console keys page
  ///
  /// In en, this message translates to:
  /// **'Get a free key'**
  String get settingsGetKey;

  /// Section header for general settings
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsSectionGeneral;

  /// Label of the app language dropdown
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get settingsAppLangTitle;

  /// Option to follow the system language
  ///
  /// In en, this message translates to:
  /// **'System (default)'**
  String get settingsAppLangSystem;

  /// Label of the transcription language dropdown
  ///
  /// In en, this message translates to:
  /// **'Transcription language'**
  String get settingsTranscriptionLangTitle;

  /// Section header for behaviour toggles
  ///
  /// In en, this message translates to:
  /// **'Behaviour'**
  String get settingsSectionBehavior;

  /// Title of the play-audio switch
  ///
  /// In en, this message translates to:
  /// **'Play audio while transcribing'**
  String get settingsPlayAudioTitle;

  /// Subtitle of the play-audio switch
  ///
  /// In en, this message translates to:
  /// **'Listen to the voice note while it is being transcribed'**
  String get settingsPlayAudioSub;

  /// Title of the save-history switch
  ///
  /// In en, this message translates to:
  /// **'Save transcriptions to history'**
  String get settingsSaveHistoryTitle;

  /// Subtitle of the save-history switch
  ///
  /// In en, this message translates to:
  /// **'Keep a copy of each transcription summary'**
  String get settingsSaveHistorySub;

  /// Button to save the API key
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsSave;

  /// Snackbar after saving settings
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get settingsSaved;

  /// Warning when the API key is empty
  ///
  /// In en, this message translates to:
  /// **'The API key is empty: transcribing will not work.'**
  String get settingsKeyEmpty;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'it',
    'pt',
    'ru',
    'tr',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

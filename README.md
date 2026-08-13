# VoxToText

[ENG]
**VoxToText** is a Flutter application designed to intercept, process, and transcribe voice notes (`.opus` format) from WhatsApp and Telegram into text. It integrates directly with Android's system share menu, allowing users to route audio files straight into the transcription pipeline.

[ITA]
**VoxToText** è un'applicazione Flutter sviluppata per intercettare, elaborare e trascrivere i messaggi vocali (in formato `.opus`) di WhatsApp e Telegram in testo. Si integra direttamente nel menu di condivisione nativo di Android per inviare i file audio direttamente alla pipeline di trascrizione.

---

## 🏗️ Technical Architecture / Architettura Tecnica

- **Framework**: Flutter (Dart)
- **Target Platform**: Android (Kotlin DSL / AGP 8.6.0+)
- **Package / Bundle**: `com.bigbear2.voxtotext`
- **Key Dependencies**:
  - `share_handler` / `share_plus`: Android Intent handling (voice note share).
  - `just_audio`: Audio playback and stream routing.
  - Groq API (`whisper-large-v3`): Speech-to-text transcription.
  - `sqflite`: Local history of transcriptions.
- **Native Audio Codec Handling**: Android `MediaCodec` (`c2.android.opus.decoder`) set to 48kHz sampling rate.

---

## 🌐 Languages / Lingue

The UI is localized and follows the system language. Supported / Lingue supportate:
Italiano, English, Español, Deutsch, Français, Português, Русский, Türkçe,
العربية (RTL), हिन्दी, Bahasa Indonesia, 中文.

---

## 📦 Publishing / Distribuzione

- Read the F-DROID publishing guide: [PUBBLICARE_FDROID.md](PUBBLICARE_FDROID.md)
  (ITA/ENG).

---

## ⚡ Quick Start / Avvio Rapido

```bash
# Get dependencies / Scarica dipendenze
flutter pub get

# Clean build cache / Pulisci cache
flutter clean

# Run on target device / Esegui su dispositivo
flutter run -d <device_id>
```
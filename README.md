# AudioScribe (audio_to_text_wa)

[ENG]  
**AudioScribe** is a Flutter application designed to intercept, process, and transcribe WhatsApp voice notes (`.opus` format) into text. It integrates directly with Android's system share menu, allowing users to route audio files straight into the transcription pipeline.

[ITA]  
**AudioScribe** è un'applicazione Flutter sviluppata per intercettare, elaborare e trascrivere i messaggi vocali di WhatsApp (in formato `.opus`) in testo. Si integra direttamente nel menu di condivisione nativo di Android per inviare i file audio direttamente alla pipeline di trascrizione.

---

## 🏗️ Technical Architecture / Architettura Tecnica

- **Framework**: Flutter (Dart)
- **Target Platform**: Android (Kotlin DSL / AGP 8.6.0+)
- **Key Dependencies**:
  - `share_handler` / `share_plus`: Android Intent handling (WhatsApp PTT share).
  - `just_audio` + `audio_session`: Low-level native audio playback and stream routing.
- **Native Audio Codec Handling**: Android `MediaCodec` (`c2.android.opus.decoder`) set to 48kHz sampling rate.

---

## ⚡ Quick Start / Avvio Rapido

```bash
# Get dependencies / Scarica dipendenze
flutter pub get

# Clean build cache / Pulisci cache
flutter clean

# Run on target device / Esegui su dispositivo
flutter run -d <device_id>
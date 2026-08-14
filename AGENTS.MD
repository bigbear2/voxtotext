# 🧠 AGENTS.MD - AI Context & Project Memory

This document serves as the persistent contextual memory for AI agents (Gemini, Copilot, ChatGPT) interacting with this codebase.

---

## 📌 Project Summary
- **App Name**: `VoxToText` (Package: `com.bigbear2.voxtotext` — ex `audio_to_text_wa` / `dev.bigbear2.audioscribe`)
- **Core Purpose**: Receive shared voice notes from WhatsApp/Telegram (`.opus`), decode/play them reliably on Android, and pass them to a transcription engine.

---

## ⚠️ Critical Quirks & Technical Constraints

1. **Gradle Build System (`.kts`)**:
   - The project uses **Kotlin DSL** (`settings.gradle.kts` and `app/build.gradle.kts`).
   - Do NOT attempt to create or reference `.gradle` Groovy files.
   - Minimum AGP requirement: **8.6.0** | Minimum Kotlin version: **2.0.0**.

2. **Android Native Audio Handling (MIUI/Xiaomi Devices)**:
   - WhatsApp `.opus` audio files trigger `c2.android.opus.decoder`.
   - On Xiaomi/MIUI devices, `AudioTrack` defaults to `streamType -1` and triggers an instant `pause(STATE_ACTIVE)` if `AudioAttributes` and `Audio Focus` are not explicitly requested.
   - Always route audio using `audio_session` with `AndroidAudioUsage.media` and `AndroidAudioContentType.speech`.

3. **Incoming Data Flow**:
   `WhatsApp Share` ➔ `Intent Filter (share_handler)` ➔ `Temp File Resolution (.opus)` ➔ `Audio Engine (just_audio / ExoPlayer)` ➔ `STT Engine`.

4. **STT Engines (2, selectable in Settings default = Local)**:
   - **Local (on-device, default)**: `whisper_ggml` 2.6.0 + bundled `ffmpeg_kit_flutter_new_min` (converts `.opus` → 16kHz mono wav). Model downloaded at runtime from HuggingFace (NOT in APK): default `WhisperModel.base` ≈ 142 MB, `modelUri` = `https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.bin`. Entry: `WhisperService` (`lib/whisper_service.dart`).
     - **Key APIs**: `downloadModel()` has NO progress callback → WhisperService implements a custom streaming HTTP download to surface progress. `TranscribeResult` is NOT exported → use `final result`, don't type it. `lang: 'auto'` must be passed as empty string `''`. Requires Android NDK 29 (`ndkVersion = "29.0.13113456"` — others use 26, that's fine, 29 is backward compatible).
   - **Groq (cloud)**: HTTP multipart to `https://api.groq.com/openai/v1/audio/transcriptions`, model `whisper-large-v3`, Bearer key from Settings. Marks the app `NonFreeNet` on F-DROID.
   - Language map for whisper: `langCode` in `main.dart` (`_whisperLangCode`), `auto` → `''`.

5. **F-DROID Metadata** (submission via GitLab `fdroid/fdroiddata`, NOT GitHub):
   - Correct `metadata/com.bigbear2.voxtotext.yml` uses commit hash `46947aa...` (v1.0.0), no inline comments, `$$flutter$$/bin/flutter pub get` (not `flutter packages pub get`), build: `flutter build apk --release`.
   - MR opened: https://gitlab.com/fdroid/fdroiddata/-/merge_requests/45578 (needs a GitLab API token to update — user revoked the last one).

---

## 🛠️ Environment Rules for AI Agents
- Maintain friendly, precise, and practical developer-to-developer communication.
- Keep build scripts clean and aligned with modern Flutter SDK guidelines.
- Always check `.kts` syntax before offering Android Gradle solutions.
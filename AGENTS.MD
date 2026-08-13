# 🧠 AGENTS.MD - AI Context & Project Memory

This document serves as the persistent contextual memory for AI agents (Gemini, Copilot, ChatGPT) interacting with this codebase.

---

## 📌 Project Summary
- **App Name**: `audio_to_text_wa` (Package: `dev.bigbear2.audioscribe` / `com.example.audio_to_text_wa`)
- **Core Purpose**: Receive shared WhatsApp audio messages (`.opus`), decode/play them reliably on Android, and pass them to a transcription engine.

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

---

## 🛠️ Environment Rules for AI Agents
- Maintain friendly, precise, and practical developer-to-developer communication.
- Keep build scripts clean and aligned with modern Flutter SDK guidelines.
- Always check `.kts` syntax before offering Android Gradle solutions.
---

### 2. `TODOLIST.md`

```markdown
# 📋 TODOLIST - AudioScribe

## ✅ Completed / Completato

- [x] **Project Scaffolding**: Setup Flutter project with Kotlin DSL (`build.gradle.kts` & `settings.gradle.kts`).
- [x] **Rename app → VoxToText**: Rinomata app, pacchetto `com.bigbear2.voxtotext`, in `pubspec.yaml`, `main.dart`, manifest/`build.gradle.kts`, web, desktop (Linux/Windows/macOS), iOS, README, AGENTS.
- [x] **Multi-language UI (i18n)**: `flutter_localizations` + `intl` + ARB (`lib/l10n`). Supportate **12 lingue**: it, en, es, de, fr, pt, ru, tr, ar (RTL), hi, id, zh.
- [x] **Share Intent Receiver**: Deep integration with WhatsApp/Telegram share sheet to accept `.opus` voice messages (`PTT-*.opus`).
- [x] **Native Codec Integration**: Configured `ExoPlayer` / `MediaCodec` (`c2.android.opus.decoder`) for Opus decoding at 48kHz.
- [x] **Gradle Modernization**: Upgraded Android Gradle Plugin to 8.6.0 and Kotlin to 2.0.0 for Flutter SDK compliance.
- [x] **Test setup**: Smoke widget test con `sqflite_common_ffi` (verde).

---

## 🚧 Pending / Da Implementare

- [ ] **Remove hardcoded Groq API key** (necessario per F-DROID: il sorgente è pubblico). Spostare la chiave nelle Impostazioni (l'utente incolla la propria) oppure usare `--dart-define`.
- [ ] **Audio Session & Playback Fix**:
  - [ ] Implement `audio_session` configuration (`AndroidAudioUsage.media`, `AndroidAudioContentType.speech`) to prevent Xiaomi/MIUI auto-pause behavior on playback start.
  - [ ] Explicitly request `AndroidAudioFocusGainType.gain` before invoking `.play()`.
- [ ] **Transcription Pipeline**:
  - [ ] Connect audio parser output to Speech-to-Text API (e.g., OpenAI Whisper, Google Speech, or local Whisper tflite).
  - [ ] Add loading indicators and progress states during API transcription calls.
- [ ] **UI & History**:
  - [ ] Local storage (SQLite/Isar) to save past transcriptions and audio metadata.
  - [ ] One-click "Copy to Clipboard" button for transcribed text.

---

## 💡 Architectural Ideas & Future Extensions / Nuove Idee

- [💡] **Local Whisper Inference (On-Device)**: Integrate `whisper.cpp` via FFI/tflite for offline transcription without cloud dependencies or API keys.
- [💡] **Automated Audio Cleaning**: Pre-process `.opus` files using high-pass filters or noise suppression before transcription to improve speech accuracy.
- [💡] **WhatsApp Floating Overlay (Bubble)**: Display transcription inside a floating overlay window (System Alert Window) directly over WhatsApp without switching apps.
- [💡] **LLM Summary Module**: Pass the raw transcription into a fast local/remote LLM to generate concise key points or action items.
- [💡] **Batch Multi-Audio Queue**: Allow selecting multiple WhatsApp voice notes at once and processing them in a sequential background queue.
# VoxToText

> Transcribe WhatsApp & Telegram voice notes (`.opus`) into text, right on your Android phone.

## 🇬🇧 English

**VoxToText** is a free and open-source Flutter app that receives voice notes (`.opus` format) shared from WhatsApp or Telegram and turns them into text using the **Groq** API (Whisper `whisper-large-v3`).

It integrates directly with Android's system **share sheet**: you share a voice note from any messaging app and it lands straight in the transcription pipeline. You can also replay the audio while it is being transcribed, and every result is saved to a local history.

### ✨ Features

- 📥 Receive and transcribe `.opus` voice notes from WhatsApp / Telegram via the share menu.
- 🔊 Built-in audio player (reliable playback even on **Xiaomi / MIUI** devices via `audio_session`).
- 🧠 AI transcription powered by **Groq** (`whisper-large-v3`).
- 🗂️ Local history of past transcriptions (SQLite) with audio replay when the file is still available.
- 🌐 12 localized languages, follow-the-system option, RTL support (Arabic).
- 🎨 Light / Dark / System theme.
- ⚙️ Settings screen: your own Groq API key, app language, transcription language, playback and history toggles.

### 🚀 Quick start

```bash
flutter pub get
flutter run -d <device_id>
```

> You need your own **Groq API key** (free at <https://console.groq.com/keys>) — set it from the in-app *Settings* screen. The app ships with an **empty** default key on purpose.

### 🏗️ Tech stack

- **Framework**: Flutter (Dart)
- **Target**: Android (Kotlin DSL, AGP 8.6+, Java/Kotlin 17)
- **Package / Bundle**: `com.bigbear2.voxtotext`
- **Key dependencies**: `share_handler` / `share_plus` (share intent), `just_audio` + `audio_session` (playback & routing), Groq API (transcription), `sqflite` (history), `shared_preferences` (settings), `url_launcher` (open Groq console).

### 🌐 Languages

Italian, English, Español, Deutsch, Français, Português, Русский, Türkçe, العربية (RTL), हिन्दी, Bahasa Indonesia, 中文.

### 📦 Distribution

F-DROID publishing guide: [PUBBLICARE_FDROID.md](PUBBLICARE_FDROID.md)

### 📄 License

[MIT](LICENSE)

---

## 🇮🇹 Italiano

**VoxToText** è un'app Flutter gratuita e open source che riceve i messaggi vocali (formato `.opus`) condivisi da WhatsApp o Telegram e li trascrive in testo usando l'API **Groq** (Whisper `whisper-large-v3`).

Si integra direttamente nel **menu di condivisione** di Android: condividi un vocale da qualsiasi app di messaggistica e finisce subito nella pipeline di trascrizione. Puoi anche riascoltare l'audio mentre viene trascritto, e ogni risultato viene salvato in una cronologia locale.

### ✨ Funzionalità

- 📥 Ricevi e trascrivi i vocali `.opus` di WhatsApp / Telegram tramite il menu di condivisione.
- 🔊 Player audio integrato (riproduzione affidabile anche su dispositivi **Xiaomi / MIUI** grazie ad `audio_session`).
- 🧠 Trascrizione AI con **Groq** (`whisper-large-v3`).
- 🗂️ Cronologia locale delle trascrizioni (SQLite) con riproduzione dell'audio se il file è ancora disponibile.
- 🌐 12 lingue localizzate, opzione "segui il sistema", supporto RTL (arabo).
- 🎨 Tema Chiaro / Scuro / Sistema.
- ⚙️ Schermata Impostazioni: la tua chiave API Groq, lingua app, lingua di trascrizione e toggle di riproduzione e cronologia.

### 🚀 Avvio rapido

```bash
flutter pub get
flutter run -d <id_dispositivo>
```

> Ti serve una **chiave API Groq** personale (gratuita su <https://console.groq.com/keys>) — impostala dalla schermata *Impostazioni* dell'app. L'app parte volutamente con chiave default **vuota**.

### 🏗️ Stack tecnico

- **Framework**: Flutter (Dart)
- **Target**: Android (Kotlin DSL, AGP 8.6+, Java/Kotlin 17)
- **Package / Bundle**: `com.bigbear2.voxtotext`
- **Dipendenze principali**: `share_handler` / `share_plus` (intent di condivisione), `just_audio` + `audio_session` (riproduzione e routing), API Groq (trascrizione), `sqflite` (cronologia), `shared_preferences` (impostazioni), `url_launcher` (apre la console Groq).

### 🌐 Lingue

Italiano, English, Español, Deutsch, Français, Português, Русский, Türkçe, العربية (RTL), हिन्दी, Bahasa Indonesia, 中文.

### 📦 Distribuzione

Guida alla pubblicazione su F-DROID: [PUBBLICARE_FDROID.md](PUBBLICARE_FDROID.md)

### 📄 Licenza

[MIT](LICENSE)

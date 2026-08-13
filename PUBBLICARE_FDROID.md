# 📦 Pubblicare VoxToText su F-DROID / Publishing VoxToText on F-DROID

> [ITA] Guida passo-passo per pubblicare **VoxToText** sull'app store **F-DROID** (software libero).
> [ENG] Step-by-step guide to publish **VoxToText** on the free-software store **F-DROID**.
>
> Stato attuale / Current status: **PRE-REQUISITI MANCANTI** — leggi la sezione "Punti critici" prima di tutto.

---

## 🎯 Cosa serve / Requirements

F-DROID **non accetta APK già compilati**: compila l'app **dal sorgente** del tuo repo git pubblico.
So F-DROID **does NOT accept pre-built APKs**: it compiles the app **from the source** of your public git repo.

Servono / Required:

1. **Repo git pubblico** (GitHub, es. `https://github.com/bigbear2/voxtotext`).
2. **Licenza open-source** (es. GPLv3, MIT, Apache-2.0) → file `LICENSE` nella root.
3. Il progetto deve compilare con: `flutter build apk --release`.
4. (Consigliato) **Fastlane** o file di **metadata** per descrizione, screenshots, icone.

---

## 🚀 Procedura / Steps

### 1. Ripulisci e pubblica il repo
```bash
git remote add origin https://github.com/bigbear2/voxtotext.git
git push -u origin main
```
- Aggiungi una `LICENSE` nella root.
- Aggiungi `.gitignore` adeguato (già presente per Flutter/Android).
- Pubblica il repo come **Public**.

### 2. Verifica la build pulita
```bash
flutter clean
flutter pub get
flutter build apk --release
```
Prova a compilare su una macchina "pulita" (senza build cache) per garantire riproducibilità.

### 3. Crea i metadati (consigliato)
Crea la cartella Fastlane per descrizione e screenshots:
```
fastlane/metadata/android/en-US/  (full_description.txt, short_description.txt, title.txt)
fastlane/metadata/android/it-IT/
```
Oppure una semplice cartella `metadata/` da citare nella richiesta.

### 4. Invia la richiesta di inclusione
- Vai su ☰ Menu → **Submit / Richiedi inclusione**: `https://f-droid.org/wiki/page/Submitting_to_F-DROID`
- Forka il repo `https://github.com/f-droid/fdroiddata`
- Aggiungi un file `metadata/com.bigbear2.voxtotext.yml` dentro `metadata/` con:
  ```yaml
  Categories:
    - Office
  License: GPL-3.0-or-later
  WebSite: https://github.com/bigbear2/voxtotext
  SourceCode: https://github.com/bigbear2/voxtotext
  IssueTracker: https://github.com/bigbear2/voxtotext/issues
  AutoName: VoxToText
  Summary: Trascrizione vocali WhatsApp/Telegram
  Description: |
    Rende il testo dei messaggi vocali di WhatsApp e Telegram.
  Name: VoxToText
  MinimalVersion: '21'
  CurrentVersion: '1.0'
  CurrentVersionCode: '1'
  Builds: []
  ```
- Apri una **Merge Request** sul repo `fdroiddata`.

---

## ⚠️ Punti critici / Critical points

### 🔑 La Groq API Key è hardcoded (PROBLEMA PER F-DROID)
Il file `lib/main.dart` contiene una chiave API Groq in chiaro:
`const String GROQ_API_KEY = "gsk_..."`.

Per F-DROID (qui il codice **è pubblico**) ciò significa che la chiave verrebbe **esposta a tutti**.
Devi scegliere una delle opzioni **prima di pubblicare**:

- **A) L'utente inserisce la propria chiave** (consigliato):
  Aggiungi un campo nelle Impostazioni dove l'utente incolla la sua chiave Groq
  (gratuita su groq.com). Il codice legge la chiave da lì invece che dal sorgente.
- **B) Backend proxy** (più complesso): un piccolo server intermedio che tenga la chiave
  segreta e inoltri le richieste al client.
- **C) `--dart-define`**: tieni la chiave fuori dal sorgente e compila con
  `--dart-define=GROQ_API_KEY=...` — ma su F-DROID build automatiche **non potrai** passarla.

> ⚠️ **Consiglio**: implementa l'opzione **A** (chiave utente nelle Impostazioni) per rendere
> il progetto realmente "free", senza segreti nel sorgente. Questo è anche ciò che F-DROID
> preferisce.

### 🖼️ Icone e media
- Le icone default di Flutter vanno sostituite con icone/marchio propri.
- Servono **screenshots** in almeno 1-2 lingue (EN, IT).

### 🏷️ Versione
In `android/app/build.gradle.kts`: `versionCode` e `versionName` devono essere incrementati
**ad ogni release** (F-DROID si aggancia a questi numeri).

---

## 📌 Checklist finale / Final checklist
- [ ] Repo pubblico con licenza open-source
- [ ] Build pulita: `flutter build apk --release` ✓
- [ ] Nessuna chiave API hardcoded (implementata opzione A/B/C)
- [ ] Icone e screenshots propri
- [ ] `metadata/com.bigbear2.voxtotext.yml` nel fork di `fdroiddata`
- [ ] Merge Request inviata a fdroiddata
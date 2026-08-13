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

### 🔑 La Groq API Key non è più hardcoded ✅ (risolto)
La chiave è stata rimossa dal sorgente e ora:
- il default vive in `lib/secrets.dart`, committato **vuoto**;
- la chiave reale si mette **solo in locale** e si protegge con:
  `git update-index --skip-worktree lib/secrets.dart`;
- su F-DROID/clone fresco resta vuota e **l'utente inserisce la propria chiave**
  dalla schermata Impostazioni (campo "Groq API Key" + pulsante che apre
  `https://console.groq.com/keys`).

Questo rende il progetto "free" senza segreti nel sorgente, come richiede F-DROID.
Assicurati solo di **non committare mai** `lib/secrets.dart` con un valore reale.

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
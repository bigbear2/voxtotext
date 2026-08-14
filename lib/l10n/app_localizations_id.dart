// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'VoxToText';

  @override
  String get navTranscribe => 'Transkripsi';

  @override
  String get navHistory => 'Riwayat';

  @override
  String get langLabel => 'Bahasa:';

  @override
  String get languageAuto => 'Otomatis (deteksi)';

  @override
  String get homeStatusWaiting =>
      'Menunggu file audio yang dibagikan dari WhatsApp atau Telegram...';

  @override
  String get statusProcessing => 'Memproses pesan suara dengan Groq...';

  @override
  String get statusProcessingLocal =>
      'Mentranskripsi secara lokal di perangkat...';

  @override
  String get engineLabelLocal => 'Lokal';

  @override
  String get engineLabelGroq => 'Groq';

  @override
  String statusDownloadingModel(int percent) {
    return 'Mengunduh model... $percent%';
  }

  @override
  String get transcriptionCompleted => 'Transkripsi selesai!';

  @override
  String get noTextExtracted => 'Tidak ada teks yang diekstrak.';

  @override
  String get errorFileNotFound =>
      'Error: file audio tidak ditemukan di perangkat.';

  @override
  String loadedFromHistory(String date) {
    return 'Dimuat dari riwayat ($date)';
  }

  @override
  String errorApi(int code, String body) {
    return 'Error API Groq [$code]: $body';
  }

  @override
  String errorConversion(String error) {
    return 'Terjadi kesalahan saat konversi: $error';
  }

  @override
  String get copiedClipboard => 'Teks disalin ke clipboard!';

  @override
  String get shareSubject => 'Transkripsi suara';

  @override
  String get transcribedLabel => 'Teks transkripsi:';

  @override
  String get btnCopy => 'Salin';

  @override
  String get btnShare => 'Bagikan';

  @override
  String get historyTitle => 'Riwayat Transkripsi';

  @override
  String get historyEmpty => 'Tidak ada transkripsi dalam riwayat.';

  @override
  String historyItemSubtitle(String date, String langLabel, String language) {
    return '$date • $langLabel: $language';
  }

  @override
  String get historyLangLabel => 'Bahasa';

  @override
  String get clearHistoryTitle => 'Bersihkan Riwayat';

  @override
  String get clearHistoryBody => 'Yakin ingin mengosongkan seluruh riwayat?';

  @override
  String get cancel => 'Batal';

  @override
  String get clear => 'Bersihkan';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get settingsSectionApi => 'Transkripsi Groq';

  @override
  String get settingsSectionEngine => 'Mesin transkripsi';

  @override
  String get settingsEngineTitle => 'Mesin transkripsi';

  @override
  String get settingsEngineLocal => 'Lokal (offline)';

  @override
  String get settingsEngineGroq => 'Groq (cloud)';

  @override
  String settingsModelDownloadTitle(String size) {
    return 'Model lokal ($size)';
  }

  @override
  String get settingsModelDownloaded => 'Terpasang';

  @override
  String settingsModelNotDownloaded(String size) {
    return 'Belum terpasang ($size)';
  }

  @override
  String get settingsModelDownload => 'Unduh model';

  @override
  String settingsModelDownloading(int percent) {
    return 'Mengunduh… $percent%';
  }

  @override
  String get settingsModelDownloadedOk => 'Model terunduh';

  @override
  String get settingsSectionModel => 'Model Lokal';

  @override
  String get settingsModelSelectTitle => 'Model Whisper';

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
      'Paling kecil dan cepat (~39 juta parameter), ideal untuk perangkat dengan sumber daya sangat terbatas, tetapi akurasinya lebih rendah.';

  @override
  String get modelBaseDesc =>
      'Sekitar 74 juta parameter, bagus untuk tes cepat atau tugas sederhana.';

  @override
  String get modelSmallDesc =>
      'Ukuran kecil, kompromi yang baik untuk penggunaan umum.';

  @override
  String get modelMediumDesc =>
      'Performa tinggi, membutuhkan lebih banyak memori (RAM/VRAM).';

  @override
  String get modelLargeDesc =>
      'Model andalan dengan lebih dari 1,5 miliar parameter. Akurasi maksimal, menangani dialek, kebisingan latar, dan terjemahan kompleks.';

  @override
  String get settingsModelDownloadHint =>
      'Model yang dipilih diunduh saat pertama kali digunakan.';

  @override
  String get settingsApiKeyTitle => 'Kunci API Groq';

  @override
  String get settingsApiKeyHint => 'Tempel kunci API Groq Anda (gsk_...)';

  @override
  String get settingsApiKeyHelper =>
      'Digunakan untuk mentranskripsi pesan suara. Dapatkan kunci gratis di bawah.';

  @override
  String get settingsGetKey => 'Dapatkan kunci gratis';

  @override
  String get settingsSectionGeneral => 'Umum';

  @override
  String get settingsAppLangTitle => 'Bahasa aplikasi';

  @override
  String get settingsAppLangSystem => 'Sistem (default)';

  @override
  String get settingsThemeTitle => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistem';

  @override
  String get settingsThemeLight => 'Terang';

  @override
  String get settingsThemeDark => 'Gelap';

  @override
  String get settingsRepoTitle => 'Repositori proyek';

  @override
  String get settingsRepoSub => 'Lihat kode sumber di GitHub';

  @override
  String get settingsTranscriptionLangTitle => 'Bahasa transkripsi';

  @override
  String get settingsSectionBehavior => 'Perilaku';

  @override
  String get settingsPlayAudioTitle => 'Putar audio selama transkripsi';

  @override
  String get settingsPlayAudioSub => 'Dengarkan pesan suara saat ditranskripsi';

  @override
  String get settingsSaveHistoryTitle => 'Simpan transkripsi ke riwayat';

  @override
  String get settingsSaveHistorySub => 'Simpan salinan setiap transkripsi';

  @override
  String get settingsNotificationsTitle => 'Tampilkan notifikasi transkripsi';

  @override
  String get settingsNotificationsSub =>
      'Tampilkan teks transkripsi di notifikasi saat selesai';

  @override
  String get settingsSave => 'Simpan';

  @override
  String get settingsSaved => 'Pengaturan disimpan';

  @override
  String get settingsKeyEmpty =>
      'Kunci API kosong: transkripsi tidak akan berfungsi.';
}

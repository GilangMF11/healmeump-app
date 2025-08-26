class ApiUrl {

  static String login = 'api/v1/auth/login';

  static String attendance = '/api/v1/attendance';
  static String attendancaRecap = 'api/v1/attendance/history?month=';

  // Permit
  static String permit = 'api/v1/permit/history?month=';
  static String permitAdd = 'api/v1/permit';
  static String permitUpdate = 'api/v1/permit/update/';
  static String permitDelete = 'api/v1/permit/delete/';

  // Overtime
  static String overtime = 'api/v1/lembur/history?month=';
  static String overtimeAdd = 'api/v1/lembur';
  static String overtimeUpdate = 'api/v1/lembur/update/';
  static String overtimeDelete = 'api/v1/lembur/delete/';

  // Logbook
  static String logbook = 'api/v1/log/history?month=';
  static String logbookAdd = 'api/v1/logbook';
  static String logbookUpdate = 'api/v1/logbook/update/';
  static String logbookDelete = 'api/v1/logbook/delete/';

  static String version = 'api/v1/version';

  static String location = 'api/v1/locations';

  // Pengajian
  static String pengajian = 'pengajian';
  static String pengajianSend = 'data-pengajian';
  static String pengajianRecap = 'daftar-bulan';
  static String pengajianRecapDetail = 'rekap-pengajian';

  // Alquran
  static String surah = 'surat';
  static String surahDetail = 'surat/';
  static String tafsir = 'tafsir/';
  
  // Ramadhan 1446
  static String kegiatanInfo1446 = 'ramadhan1446/infokegiatanterdaftar.php';
  static String evaluasi1446 = 'ramadhan1446/evaluasi.php';
  static String pretest1446 = 'ramadhan1446/pretest_api.php';
  static String posttest1446 = 'ramadhan1446/posttest_api.php';
  static String presensi1446 = 'ramadhan1446/presensi_api.php';
  static String doaHarian1446 = 'ramadhan1446/doaharian.php';
  static String evaluasiKuesioner1446 = 'ramadhan1446/evaluasi_kuesioner_api.php';
  static String presensiSesiDetail1446 = 'ramadhan1446/presensi_sesi_detail.php';
  static String sertifikat1446 = 'ramadhan1446/sertifikat.php';
  static String logbookRamadhan1446 = 'ramadhan1446/logbook.php';
  static String jenisKegiatan1446 = 'ramadhan1446/jenis_kegiatan.php';

  // Simpeg
  static String dataPegawai = 'simpeg/edit_biodata.php';


}
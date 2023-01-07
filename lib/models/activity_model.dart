class ActivityModel {
  String? absen_pagi;
  String? absen_siang;
  String? absen_malem;
  final String hari_aktivitas;
  final String tanggal_aktivitas;

  ActivityModel({
    required this.absen_pagi,
    required this.absen_siang,
    required this.absen_malem,
    required this.hari_aktivitas,
    required this.tanggal_aktivitas,
  });
}

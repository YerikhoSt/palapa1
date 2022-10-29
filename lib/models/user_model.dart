class UserModel {
  String username;
  String email;
  String name;
  String tanggal_lahir;
  String alamat;
  String no_telpon;
  String nama_pendamping;
  String no_telpon_pendamping;
  String kota;
  String provinsi;

  UserModel({
    required this.username,
    required this.email,
    required this.name,
    required this.tanggal_lahir,
    required this.alamat,
    required this.no_telpon,
    required this.nama_pendamping,
    required this.no_telpon_pendamping,
    required this.kota,
    required this.provinsi,
  });
}

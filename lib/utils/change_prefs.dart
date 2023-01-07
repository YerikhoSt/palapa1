import 'package:shared_preferences/shared_preferences.dart';

Future<void> changePrefsLogin(Map<String, dynamic> userMap) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(
      'user_email', userMap['email'] != null ? userMap['email'] as String : '');
  await prefs.setString('user_password',
      userMap['password'] != null ? userMap['password'] as String : '');
  await prefs.setString('token', userMap['token'] as String);
  await prefs.setInt(
      'user_id', userMap['user_id'] != null ? userMap['user_id'] : 0);
}

Future<Map<String, dynamic>> getPrefsProfile() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return <String, dynamic>{
    'user_email': prefs.getString('user_email') ?? '',
    'user_password': prefs.getString('user_password') ?? '',
    'token': prefs.getString('token') ?? '',
    'user_id': prefs.getInt('user_id') ?? 0,
  };
}

Future<void> changePrefsProfile(Map<String, dynamic> userMap) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_username',
      userMap['username'] != null ? userMap['username'] as String : '');
  await prefs.setString(
      'user_email', userMap['email'] != null ? userMap['email'] as String : '');
  await prefs.setString(
      'user_name', userMap['name'] != null ? userMap['name'] as String : '');
  await prefs.setString(
      'user_tanggal_lahir',
      userMap['tanggal_lahir'] != null
          ? userMap['tanggal_lahir'] as String
          : '');
  await prefs.setString('user_alamat',
      userMap['alamat'] != null ? userMap['alamat'] as String : '');
  await prefs.setString('user_no_telpon',
      userMap['no_telpon'] != null ? userMap['no_telpon'] as String : '');
  await prefs.setString(
      'user_nama_pendamping',
      userMap['nama_pendamping'] != null
          ? userMap['nama_pendamping'] as String
          : '');
  await prefs.setString(
      'user_no_telpon_pendamping',
      userMap['no_telpon_pendamping'] != null
          ? userMap['no_telpon_pendamping'] as String
          : '');
  await prefs.setString(
      'user_kota', userMap['kota'] != null ? userMap['kota'] as String : '');
  await prefs.setString('user_provinsi',
      userMap['provinsi'] != null ? userMap['provinsi'] as String : '');
}

Future<Map<String, dynamic>> getPrefsProfileForm() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return <String, dynamic>{
    'user_username': prefs.getString('user_username') ?? '',
    'user_email': prefs.getString('user_email') ?? '',
    'user_name': prefs.getString('user_name') ?? '',
    'user_tanggal_lahir': prefs.getString('user_tanggal_lahir') ?? '',
    'user_alamat': prefs.getString('user_alamat') ?? '',
    'user_no_telpon': prefs.getString('user_no_telpon') ?? '',
    'user_nama_pendamping': prefs.getString('user_nama_pendamping') ?? '',
    'user_no_telpon_pendamping':
        prefs.getString('user_no_telpon_pendamping') ?? '',
    'user_kota': prefs.getString('user_kota') ?? '',
    'user_provinsi': prefs.getString('user_provinsi') ?? '',
  };
}

Future<void> changePrefsSettings(Map<String, dynamic> userMap) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('user_notif',
      userMap['notif'] != null ? userMap['notif'] as bool : false);
  await prefs.setBool('user_vibra',
      userMap['vibra'] != null ? userMap['vibra'] as bool : false);
}

Future<Map<String, dynamic>> getPrefsSettings() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return <String, dynamic>{
    'user_notif': prefs.getBool('user_notif') ?? false,
    'user_vibra': prefs.getBool('user_vibra') ?? false,
  };
}

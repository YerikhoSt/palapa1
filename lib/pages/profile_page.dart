import 'package:flutter/material.dart';
import 'package:palapa1/models/user_model.dart';
import 'package:palapa1/pages/attributes/profile/profile_page_card.dart';
import 'package:palapa1/services/drift/drift_local.dart' as df;
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/change_prefs.dart';
import 'package:palapa1/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _token;
  int? _user_id;

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print(_user_id);
    print(_token);
  }

  UserModel? _user;

  Future<void> _getUsertInfo() async {
    getPrefsProfileForm().then(
      (Map<String, dynamic> value) {
        print(value);

        setState(() {
          _user = UserModel(
            username: value['user_username'],
            email: value['user_email'],
            name: value['user_name'],
            tanggal_lahir: value['user_tanggal_lahir'],
            alamat: value['user_alamat'],
            no_telpon: value['user_no_telpon'],
            nama_pendamping: value['user_nama_pendamping'],
            no_telpon_pendamping: value['user_no_telpon_pendamping'],
            kota: value['user_kota'],
            provinsi: value['user_provinsi'],
          );
        });
      },
    );
    fetchData(
      'api/user/view/${_user_id}',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then(
      (dynamic value) async {
        print(value);
        await changePrefsProfile(
          <String, String>{
            'username': value['data']['username'],
            'email': value['data']['email'],
            'name': value['data']['name'],
            'tanggal_lahir': value['data']['tanggal_lahir'].toString(),
            'alamat': value['data']['alamat'],
            'no_telpon': value['data']['no_telpon'].toString(),
            'nama_pendamping': value['data']['nama_pendamping'],
            'no_telpon_pendamping':
                value['data']['no_telpon_pendamping'].toString(),
            'kota': value['data']['kota'],
            'provinsi': value['data']['provinsi'],
          },
        );
        print('response profile');
        print(value);
      },
    );
  }

  Future<void> _getUserData() async {
    await _sharePrefs();
    await _getUsertInfo();
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user != null
          ? ProfilePageCard(
              user: _user!,
            )
          : Center(
              child: CircularProgressIndicator(
                color: Config.primaryColor,
              ),
            ),
    );
  }
}

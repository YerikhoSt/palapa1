import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/pages/attributes/jadwal_kegiatan_follow_up/add_jadwal_kegiatan.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JadwalKegiatanFollowUp extends StatefulWidget {
  const JadwalKegiatanFollowUp({super.key});

  @override
  State<JadwalKegiatanFollowUp> createState() => _JadwalKegiatanFollowUpState();
}

class _JadwalKegiatanFollowUpState extends State<JadwalKegiatanFollowUp> {
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

  Future<void> _getDataFollowUp() async {
    await _sharePrefs();
    fetchData(
      'api/follow-up/view/${_user_id}',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then((dynamic value) {
      print(value);
    });
  }

  @override
  void initState() {
    _getDataFollowUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'Jadwal',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16.sp,
                fontWeight: Config.bold,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.of(context).push(
              AniRoute(
                child: const AddJadwalKegiatan(),
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Config.primaryColor,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  'Masukan Kegiatan Follow Up',
                  style: Config.primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: Config.semiBold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

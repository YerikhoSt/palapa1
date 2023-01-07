import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/jadwal_kegiatan_model.dart';
import 'package:palapa1/pages/attributes/jadwal_kegiatan_follow_up/add_jadwal_kegiatan.dart';
import 'package:palapa1/pages/attributes/jadwal_kegiatan_follow_up/jadwal_kegiatan_follow_up_card.dart';
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
  bool _isLoading = false;
  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print(_user_id);
    print(_token);
  }

  List<JadwalKegiatanModel> _listJadwal = <JadwalKegiatanModel>[];

  Future<void> _getDataFollowUp() async {
    await _sharePrefs();
    setState(() {
      _isLoading = true;
    });
    fetchData(
      'api/follow-up/view/${_user_id}',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then((dynamic value) {
      for (final dynamic i in value['data']) {
        final JadwalKegiatanModel val = JadwalKegiatanModel(
          id: i['id'].toString(),
          user_id: i['user_id'].toString(),
          tanggal_follow_up: i['tanggal_follow_up'],
          perineometri: i['perineometri'].toString(),
          pad_test: i['pad_test'].toString(),
          udi_6: i['udi_6'].toString(),
          iiq_7: i['iiq_7'].toString(),
        );
        if (mounted) {
          setState(() {
            _listJadwal.add(val);
          });
        }
      }
      setState(() {
        _isLoading = false;
      });
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
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'Jadwal',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16.sp,
                fontWeight: Config.bold,
              ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Config.primaryColor,
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                ListView.builder(
                  itemCount: _listJadwal.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, int i) {
                    return JadwalKegiatanFollowUpCard(
                      jadwal: _listJadwal[i],
                    );
                  },
                ),
                SizedBox(height: 20.h),
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

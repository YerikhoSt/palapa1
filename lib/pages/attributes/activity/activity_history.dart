import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/activity_model.dart';
import 'package:palapa1/pages/attributes/activity/activity_history_card.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityHistory extends StatefulWidget {
  const ActivityHistory({super.key});

  @override
  State<ActivityHistory> createState() => _ActivityHistoryState();
}

class _ActivityHistoryState extends State<ActivityHistory> {
  String? _token;
  int? _user_id;

  List<ActivityModel> _activityHistory = <ActivityModel>[];

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print(_user_id);
    print(_token);
  }

  Future<void> _getHistory() async {
    await _sharePrefs();
    fetchData(
      'api/aktivitas-harian/view/${_user_id}',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then(
      (dynamic value) {
        print(value);
        for (final dynamic i in value['data']) {
          final ActivityModel val = ActivityModel(
            absen_pagi: i['absen_pagi'].toString(),
            absen_siang: i['absen_siang'].toString(),
            absen_malem: i['absen_malem'].toString(),
            hari_aktivitas: i['hari_aktivitas'],
            tanggal_aktivitas: i['tanggal_aktivitas'],
          );
          setState(() {
            _activityHistory.add(val);
          });
        }
        print('haloiii');
      },
    );
  }

  @override
  void initState() {
    _getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: true,
          elevation: 0.2,
          title: Text(
            'History',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: Config.bold,
                ),
          ),
        ),
        body: ListView.builder(
            itemCount: _activityHistory.length,
            padding: EdgeInsets.all(22.w),
            itemBuilder: (_, int i) {
              return ActivityHistoryCard(
                activity: _activityHistory[i],
              );
            }));
  }
}

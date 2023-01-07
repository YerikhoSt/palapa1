import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphic/graphic.dart';
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
  bool _isLoading = false;
  String _totalPagi = '';
  String _totalSiang = '';
  String _totalMalam = '';
  List<ActivityModel> _activityHistory = <ActivityModel>[];
  List<Color> _colorPie = [
    Colors.red,
    Colors.blue,
    Colors.green,
  ];
  List<Map<String, dynamic>> dataPie = <Map<String, dynamic>>[];
  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print(_user_id);
    print(_token);
  }

  Future<void> _getHistoryPieCart() async {
    await _sharePrefs();
    setState(() {
      _isLoading = true;
    });
    await fetchData(
      'api/chart-pie/aktivitas-harian/$_user_id',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then(
      (dynamic value) {
        print('hasil ===> $value');
        setState(() {
          _isLoading = false;
        });
        List isiData = value['data'];

        var resultPie = isiData.map((e) {
          print('ISI PERSENTASE ===> ${e['percentage']}');
          return {
            'time': e['total'] == 0 ? ' ' : '${e['name']}',
            'sales': num.parse(e['percentage'].toString()),
          };
        }).toList();
        setState(() {
          dataPie = resultPie;
          _totalPagi = isiData[0]['total'].toString();
          _totalSiang = isiData[1]['total'].toString();
          _totalMalam = isiData[2]['total'].toString();
        });
      },
    );
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
            absen_pagi: i['absen_pagi'],
            absen_siang: i['absen_siang'],
            absen_malem: i['absen_malem'],
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
    _getHistoryPieCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
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
          elevation: 0.2,
          title: Text(
            'History',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: Config.bold,
                ),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _isLoading
                ? CircularProgressIndicator(
                    color: Config.primaryColor,
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Chart(
                      data: dataPie,
                      variables: {
                        'time': Variable(
                          accessor: (Map map) => map['time'] as String,
                        ),
                        'sales': Variable(
                          accessor: (Map map) => map['sales'] as num,
                          scale: LinearScale(min: 0),
                        ),
                      },
                      transforms: [
                        Proportion(
                          variable: 'sales',
                          as: 'percent',
                        ),
                      ],
                      elements: [
                        IntervalElement(
                          position: Varset('percent') / Varset('time'),
                          modifiers: [StackModifier()],
                          color: ColorAttr(
                            variable: 'time',
                            values: _colorPie,
                          ),
                          label: LabelAttr(
                            encoder: (Tuple tuple) => Label(
                              tuple['time'].toString(),
                              LabelStyle(style: Defaults.runeStyle),
                            ),
                          ),
                        )
                      ],
                      coord: PolarCoord(
                        transposed: true,
                        dimCount: 1,
                      ),
                    ),
                  ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Pagi : ${_totalPagi}x',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15.sp,
                        fontWeight: Config.bold,
                      ),
                ),
                Text(
                  'Siang : ${_totalSiang}x',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15.sp,
                        fontWeight: Config.bold,
                      ),
                ),
                Text(
                  'Malam : ${_totalMalam}x',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15.sp,
                        fontWeight: Config.bold,
                      ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _activityHistory.length,
                padding: EdgeInsets.fromLTRB(22.w, 50.h, 22.w, 50.h),
                itemBuilder: (_, int i) {
                  return ActivityHistoryCard(
                    activity: _activityHistory[i],
                  );
                },
              ),
            ),
          ],
        ));
  }
}

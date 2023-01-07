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
  List<ActivityModel> _activityHistory = <ActivityModel>[];
  List<Map<String, dynamic>> dataPie = <Map<String, dynamic>>[
    // {'time': 'Sore', 'sales': 20.0},
    // {'time': 'Siang', 'sales': 40.0},
    // {'time': 'Malam', 'sales': 40.0},
  ];
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
        setState(() {
          _isLoading = false;
        });
        List isiData = value['data'];
        var resultPie = isiData.map((e) {
          return {
            'time': '${e['name']}',
            'sales': num.parse(e['percentage'].toString()),
          };
        }).toList();
        setState(() {
          dataPie = resultPie;
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
        body: Stack(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: _activityHistory.length,
              padding: EdgeInsets.fromLTRB(22.w, 200.h, 22.w, 50.h),
              itemBuilder: (_, int i) {
                return ActivityHistoryCard(
                  activity: _activityHistory[i],
                );
              },
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Config.primaryColor,
                    ),
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
                            values: Defaults.colors10,
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
          ],
        ));
  }
}

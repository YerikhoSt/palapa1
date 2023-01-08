import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/activity_model.dart';
import 'package:palapa1/pages/attributes/activity/activity_absen_button.dart';
import 'package:palapa1/pages/attributes/activity/activity_cart.dart';
import 'package:palapa1/pages/attributes/activity/activity_empty.dart';
import 'package:palapa1/pages/attributes/activity/activity_history.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  DateTime _dateTime = DateTime.now();
  String _showDays = '';
  List<int> _colorDynamic = <int>[];
  String _dateDetail = '';
  bool _isKL = false;
  bool _isKC = false;
  String _dateActivity = '';
  List<String> _listJawaban = <String>['Pagi', 'Siang', 'Malam'];
  List<String> _isCheck = <String>[];
  List<String> _isClose = <String>[];
  DateTime _selectedDate = DateTime.now();
  ActivityModel? _activityCheck;
  bool _isLoading = false;

  void _checkTimeForAbsen() {
    print('ISI HOUR =====> ${_dateTime.hour}');
    if (_dateTime.hour > 12) {
      print('JANCOK ${_dateTime.hour}');

      setState(() {
        _listJawaban.remove('Pagi');
      });
    }
    if (_dateTime.hour > 17) {
      setState(() {
        _listJawaban.remove('Siang');
      });
    }
    if (_dateTime.hour > 23) {
      setState(() {
        _listJawaban.remove('Malam');
      });
    }
  }

  void ShowQuestionDialog(
    void Function() send,
    String waktu,
  ) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              alignment: Alignment.center,
              title: Text(
                getTranslated(context, 'kontraksi') ?? '',
                style: Config.blackTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: Config.semiBold,
                ),
                textAlign: TextAlign.center,
              ),
              actionsOverflowAlignment: OverflowBarAlignment.center,
              content: Text(
                '${getTranslated(context, 'kontraksi_ask') ?? ''} ${getTranslated(context, waktu.toLowerCase())} ?',
                style: Config.blackTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: Config.medium,
                ),
                textAlign: TextAlign.center,
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 7.sp),
                  decoration: BoxDecoration(
                    color: _isKL ? Config.primaryColor : Colors.grey,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: CheckboxListTile(
                    value: _isKL,
                    title: Text(
                      getTranslated(context, 'kl') ?? 'Kontraksi Lambat',
                      style: Config.whiteTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: Config.bold,
                      ),
                    ),
                    checkColor: Config.primaryColor,
                    onChanged: (bool? value) {
                      setState(() {
                        _isKL = !_isKL;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 7.sp),
                  decoration: BoxDecoration(
                    color: _isKC ? Config.primaryColor : Colors.grey,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: CheckboxListTile(
                    value: _isKC,
                    title: Text(
                      getTranslated(context, 'kc') ?? 'Kontraksi Cepat',
                      style: Config.whiteTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: Config.bold,
                      ),
                    ),
                    checkColor: Config.primaryColor,
                    onChanged: (bool? value) {
                      setState(() {
                        _isKC = !_isKC;
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 7.sp),
                  decoration: BoxDecoration(
                    color: _isKC && _isKL ? Config.primaryColor : Colors.grey,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextButton(
                    child: Text(
                      'Submit',
                      style: Config.whiteTextStyle.copyWith(
                        fontSize: 18.sp,
                        fontWeight: Config.bold,
                      ),
                    ),
                    onPressed: _isKC && _isKL ? send : null,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

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

  Future<void> _getStatusActivity() async {
    await _sharePrefs();
    setState(() {
      _isLoading = true;
    });
    await fetchData(
      'api/aktivitas-harian/view-today/${_user_id}',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then(
      (dynamic value) {
        setState(() {
          _isLoading = false;
        });
        print('CHECK AKTIFITY ===> $value');
        setState(() {
          _activityCheck = ActivityModel(
            absen_pagi: value['data']['absen_pagi'],
            absen_siang: value['data']['absen_siang'],
            absen_malem: value['data']['absen_malem'],
            hari_aktivitas: value['data']['hari_aktivitas'].toString(),
            tanggal_aktivitas: value['data']['tanggal_aktivitas'].toString(),
          );
        });

        if (_activityCheck!.absen_pagi != null) {
          setState(() {
            _listJawaban.remove('Pagi');
          });
        }
        if (_activityCheck!.absen_siang != null) {
          setState(() {
            _listJawaban.remove('Siang');
          });
        }
        if (_activityCheck!.absen_malem != null) {
          setState(() {
            _listJawaban.remove('Malam');
          });
        }
        print(_listJawaban);

        print('haloiii');
      },
    );
  }

  @override
  void initState() {
    _checkTimeForAbsen();
    super.initState();
    DateFormat('y-MM-d h : mm : 0').format(_selectedDate);
    _sharePrefs();
    _getStatusActivity();
    print('ISI DARI DATE TIME =====> $_dateTime');
    _showDays = DateFormat.EEEE('id_ID').format(_dateTime);
    _dateDetail = DateFormat.yMMMMd('id_ID').format(_dateTime);
    _dateActivity = DateFormat('y-MM-dd').format(_dateTime);
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
        elevation: 0,
        title: Text(
          getTranslated(context, 'aktivitas') ?? 'Aktivitas',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16.sp,
                fontWeight: Config.bold,
              ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).push(
              AniRoute(
                child: const ActivityHistory(),
              ),
            ),
            child: Text(
              getTranslated(context, 'daftar_aktivitas') ?? 'Daftar Aktivitas',
              style: Config.primaryTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: Config.semiBold,
              ),
            ),
          ),
        ],
      ),
      body: _listJawaban.isEmpty
          ? const ActivityEmpty()
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
              children: <Widget>[
                Image.asset(
                  'assets/images/aktifitas.png',
                  width: 180.w,
                  height: 150.h,
                ),
                SizedBox(height: 20.w),
                Column(
                  children: <Widget>[
                    Text(
                      _showDays,
                      style: Config.primaryTextStyle.copyWith(
                        fontSize: 26.sp,
                        fontWeight: Config.bold,
                      ),
                    ),
                    Text(
                      _dateDetail,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18,
                            fontWeight: Config.bold,
                          ),
                    ),
                  ],
                ),
                Divider(
                  color: Config.primaryColor,
                  height: 50.h,
                  thickness: 1.5,
                ),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Config.primaryColor,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _listJawaban.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, int i) {
                          return ButtonAbsen(
                            text: _listJawaban[i],
                            colorDynamic: _isCheck.contains(_listJawaban[i])
                                ? 1
                                : _isClose.contains(_listJawaban[i])
                                    ? 2
                                    : 0,
                            check: () {
                              ShowQuestionDialog(
                                () {
                                  print('send');
                                  setState(() {
                                    _isCheck.add(_listJawaban[i]);
                                  });
                                  fetchData(
                                    'api/aktivitas-harian/post',
                                    method: FetchDataMethod.post,
                                    tokenLabel: TokenLabel.xa,
                                    extraHeader: <String, String>{
                                      'Authorization': 'Bearer ${_token}'
                                    },
                                    params: <String, dynamic>{
                                      'user_id': _user_id,
                                      'absen_pagi': _isCheck.contains('Pagi')
                                          ? _selectedDate.toString()
                                          : null,
                                      'absen_siang': _isCheck.contains('Siang')
                                          ? _selectedDate.toString()
                                          : null,
                                      'absen_malem': _isCheck.contains('Malam')
                                          ? _selectedDate.toString()
                                          : null,
                                      'tanggal_aktivitas': _dateActivity,
                                    },
                                  ).then((dynamic value) {
                                    if (value['status'] == 200) {
                                      print('hasil dari absen $value');
                                      setState(() {
                                        _listJawaban.removeAt(i);
                                        _getStatusActivity();
                                      });
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          backgroundColor: Config.alertColor,
                                          content: const Text(
                                            'Silahkan Selesaikan Kedua Penilaian Kondisi Dahulu',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                },
                                _listJawaban[i],
                              );
                            },
                            close: () {
                              setState(() {
                                _isClose.add(_listJawaban[i]);
                              });
                              fetchData(
                                'api/aktivitas-harian/post',
                                method: FetchDataMethod.post,
                                tokenLabel: TokenLabel.xa,
                                extraHeader: <String, String>{
                                  'Authorization': 'Bearer ${_token}'
                                },
                                params: <String, dynamic>{
                                  'user_id': _user_id,
                                  'absen_pagi':
                                      _isClose.contains('Pagi') ? null : null,
                                  'absen_siang':
                                      _isClose.contains('Siang') ? null : null,
                                  'absen_malem':
                                      _isClose.contains('Malam') ? null : null,
                                  'tanggal_aktivitas': _dateActivity,
                                },
                              ).then((dynamic value) {
                                print(value);
                                setState(() {
                                  _listJawaban.removeAt(i);
                                  _getStatusActivity();
                                });
                              });
                            },
                          );
                        },
                      ),
              ],
            ),
      bottomNavigationBar: InkWell(
        onTap: () => Navigator.of(context).push(
          AniRoute(
            child: const ActivityHistory(),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.h,
          margin: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Config.primaryColor,
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: Center(
            child: Text(
              getTranslated(context, 'history_aktivitas') ??
                  'Lihat History Aktivitas',
              style: Config.whiteTextStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: Config.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

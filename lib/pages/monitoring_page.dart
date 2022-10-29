import 'package:flutter/material.dart';
import 'package:palapa1/pages/attributes/monitoring/monitoring_page_card.dart';
import 'package:palapa1/pages/attributes/monitoring/monitoring_result.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  String? _token;
  int? _user_id;

  List<dynamic> _udi6 = <dynamic>[];
  List<dynamic> _iiq7 = <dynamic>[];
  List<dynamic> _perineometri = <dynamic>[];
  List<dynamic> _padTest = <dynamic>[];

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print(_user_id);
    print(_token);
  }

  Future<void> _getData() async {
    await _sharePrefs();
    fetchData(
      'api/graph/${_user_id}',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then((dynamic value) {
      print('response');
      print(value);
      setState(() {
        _udi6 = value['data']['udi_6'];
        _iiq7 = value['data']['iiq_7'];
        _perineometri = value['data']['perineometri'];
        _padTest = value['data']['pad_test'];
      });
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Monitoring',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 18,
                fontWeight: Config.bold,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          MonitoringPageCard(
            text: 'Perbaikan Gejala Inkontinensia Urin (Skor UDI - 6)',
            onTap: () {
              Navigator.of(context).push(
                AniRoute(
                  child: MonitoringResult(
                    idType: 1,
                    result: _udi6,
                  ),
                ),
              );
            },
          ),
          MonitoringPageCard(
            text:
                'Perbaikan Kualitas Hidup yang berkaitan dengan kondisi IUT (Skor IIQ - 7)',
            onTap: () {
              Navigator.of(context).push(
                AniRoute(
                  child: MonitoringResult(
                    idType: 2,
                    result: _iiq7,
                  ),
                ),
              );
            },
          ),
          MonitoringPageCard(
            text: 'Kekuatan Kontraksi Otot Dasar Panggal (Perineometri)',
            onTap: () {
              Navigator.of(context).push(
                AniRoute(
                  child: MonitoringResult(
                    idType: 3,
                    result: _perineometri,
                  ),
                ),
              );
            },
          ),
          MonitoringPageCard(
            text: 'Keparahan IUT Berdasarkan Pengukuran Pad Test 1 Jam',
            onTap: () {
              Navigator.of(context).push(
                AniRoute(
                  child: MonitoringResult(
                    idType: 4,
                    result: _padTest,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphic/graphic.dart';
import 'package:palapa1/models/monitoring_result_model.dart';
import 'package:palapa1/pages/attributes/monitoring/monitoring_result_card.dart';
import 'package:palapa1/utils/config.dart';

class MonitoringResult extends StatefulWidget {
  final int idType;
  final List<dynamic> result;
  const MonitoringResult(
      {super.key, required this.idType, required this.result});

  @override
  State<MonitoringResult> createState() => _PerbaikanGejalaState();
}

class _PerbaikanGejalaState extends State<MonitoringResult> {
  List<MonitoringResultModel> _result = [];
  List<Map<String, dynamic>> dataChart = [];
  String textDinamis() {
    switch (widget.idType) {
      case 1:
        return 'Perbaikan Gejala Inkontinensia Urin';
      case 2:
        return 'Perbaikan Kualitas Hidup';
      case 3:
        return 'Kekuatan Kontraksi Otot Dasar Panggal';
      case 4:
        return 'Keparahan IUT Berdasarkan Pad Test';
      default:
        return '';
    }
  }

  Future<void> _resultData() async {
    var resultMonitoring = widget.result.map((e) {
      return {
        'week': 'week ${e['week']}',
        'skor': num.parse(e['skor'].toString()),
      };
    }).toList();
    setState(() {
      dataChart = resultMonitoring;
    });
    for (var i in widget.result) {
      i['week'] = '${i['week']}';
      i['skor'] = num.parse(i['skor'].toString());
      setState(() {
        print('ISI RESULT ${widget.result}');

        print('DATA CHART =====> $dataChart');
        final MonitoringResultModel rt = MonitoringResultModel(
          week: i['week'].toString(),
          skor: double.parse(i['skor'].toString()),
        );
        _result.add(rt);
      });
    }
  }

  @override
  void initState() {
    print('ISI RESULT =======>>> ${widget.result}');
    _resultData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
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
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: <Widget>[
          Text(
            textDinamis(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: Config.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Chart(
                data: dataChart,
                variables: {
                  'week': Variable(
                    accessor: (Map map) => map['week'] as String,
                  ),
                  'skor': Variable(
                    accessor: (Map map) => map['skor'] as num,
                  ),
                },
                elements: [IntervalElement()],
                axes: [
                  Defaults.horizontalAxis,
                  Defaults.verticalAxis,
                ],
              )),
          const SizedBox(height: 50),
          ListView.builder(
            itemCount: _result.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, int i) {
              return MonitoringResultCard(
                result: _result[i],
                param: _result[i].skor > 50 ? 1 : 2,
              );
            },
          ),
        ],
      ),
    );
  }
}

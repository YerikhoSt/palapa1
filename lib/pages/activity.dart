import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/pages/attributes/activity/activity_absen_button.dart';
import 'package:palapa1/pages/attributes/activity/activity_cart.dart';
import 'package:palapa1/pages/attributes/activity/activity_history.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  DateTime _dateTime = DateTime.now();
  String _showDays = '';
  int _colorDynamic = 0;
  String _dateDetail = '';
  List<String> _listJawaban = <String>['Pagi', 'Siang', 'Malam'];
  List<bool> _isCheck = <bool>[];

  @override
  void initState() {
    super.initState();
    _showDays = DateFormat.EEEE('id_ID').format(_dateTime);
    _dateDetail = DateFormat.yMMMMd('id_ID').format(_dateTime);
  }

  List<FlSpot> _points = [
    const FlSpot(0, 110.0),
    const FlSpot(1, 110.0),
    const FlSpot(2, 130.0),
    const FlSpot(3, 100.0),
    const FlSpot(4, 130.0),
    const FlSpot(5, 160.0),
    const FlSpot(6, 190.0),
    const FlSpot(7, 150.0),
    const FlSpot(8, 170.0),
    const FlSpot(9, 180.0),
    const FlSpot(10, 140.0),
    const FlSpot(11, 150.0),
  ];

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = 'Jan';
              break;
            case 3:
              text = 'Mar';
              break;
            case 5:
              text = 'May';
              break;
            case 7:
              text = 'Jul';
              break;
            case 9:
              text = 'Sep';
              break;
            case 11:
              text = 'Nov';
              break;
          }

          return Text(text);
        },
      );

  SideTitles get _leftTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = 'Pagi';
              break;
            case 3:
              text = 'Siang';
              break;
            case 5:
              text = 'Sore';
              break;
          }

          return Text(text);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Aktivitas',
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
              'History',
              style: Config.primaryTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: Config.semiBold,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        children: <Widget>[
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
          ListView.builder(
            itemCount: _listJawaban.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, int i) {
              return ButtonAbsen(
                text: _listJawaban[i],
                colorDynamic: _colorDynamic,
                check: () {
                  setState(() {
                    _colorDynamic = 1;
                  });
                },
                close: () {
                  setState(() {
                    _colorDynamic = 2;
                  });
                },
              );
            },
          ),
          const ActivityCart(),
        ],
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 40.h,
        margin: EdgeInsets.all(20.w),
        padding: EdgeInsets.symmetric(vertical: 12.w),
        decoration: BoxDecoration(
          color: Config.primaryColor,
          borderRadius: BorderRadius.circular(16.w),
        ),
        child: Center(
          child: Text(
            'Confirm Absen',
            style: Config.whiteTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: Config.bold,
            ),
          ),
        ),
      ),
    );
  }
}

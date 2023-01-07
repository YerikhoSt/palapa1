import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/utils/config.dart';

class MonitoringEmptyPage extends StatelessWidget {
  const MonitoringEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        titleSpacing: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/monitoring_empty.jpg',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 15.h),
          Text(
            'Hasil Monitoring Kamu Masih Kosong!',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20.w,
                  fontWeight: Config.semiBold,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

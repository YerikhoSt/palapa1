import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/utils/config.dart';

class ActivityEmpty extends StatefulWidget {
  const ActivityEmpty({super.key});

  @override
  State<ActivityEmpty> createState() => _ActivityEmptyState();
}

class _ActivityEmptyState extends State<ActivityEmpty> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/absen.jpg',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 15.h),
          Text(
            'Yey kamu sudah menyelesaikan semua aktivitas hari ini!',
            style: Config.blackTextStyle.copyWith(
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

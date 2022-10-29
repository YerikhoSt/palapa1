import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/pages/attributes/activity/activity_history_card.dart';
import 'package:palapa1/utils/config.dart';

class ActivityHistory extends StatefulWidget {
  const ActivityHistory({super.key});

  @override
  State<ActivityHistory> createState() => _ActivityHistoryState();
}

class _ActivityHistoryState extends State<ActivityHistory> {
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
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: <Widget>[
          const ActivityHistoryCard(day: 'Senin, 10 Oktober 2022'),
          const ActivityHistoryCard(day: 'Selasa, 11 Oktober 2022'),
          const ActivityHistoryCard(day: 'Rabu, 12 Oktober 2022'),
        ],
      ),
    );
  }
}

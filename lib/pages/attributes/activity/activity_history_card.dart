import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/activity_model.dart';
import 'package:palapa1/utils/config.dart';

class ActivityHistoryCard extends StatefulWidget {
  final ActivityModel activity;
  const ActivityHistoryCard({super.key, required this.activity});

  @override
  State<ActivityHistoryCard> createState() => _ActivityHistoryCardState();
}

class _ActivityHistoryCardState extends State<ActivityHistoryCard> {
  bool _isShow = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isShow = !_isShow;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 15.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.w),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ],
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${widget.activity.hari_aktivitas}, ${widget.activity.tanggal_aktivitas}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16.sp,
                        fontWeight: Config.bold,
                      ),
                ),
                Icon(
                  _isShow ? Icons.expand_less_sharp : Icons.expand_more_sharp,
                  size: 25,
                  color: Config.primaryColor,
                ),
              ],
            ),
            Visibility(
              visible: _isShow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(
                    color: Config.primaryColor,
                    height: 30.h,
                    thickness: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Pagi',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15.sp,
                              fontWeight: Config.bold,
                            ),
                      ),
                      Text(
                        widget.activity.absen_pagi ?? 'tidak aktivitas',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: Config.regular,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Siang',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15.sp,
                              fontWeight: Config.bold,
                            ),
                      ),
                      Text(
                        widget.activity.absen_siang ?? 'tidak aktivitas',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: Config.regular,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Malam',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15.sp,
                              fontWeight: Config.bold,
                            ),
                      ),
                      Text(
                        widget.activity.absen_malem ?? 'tidak aktivitas',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: Config.regular,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

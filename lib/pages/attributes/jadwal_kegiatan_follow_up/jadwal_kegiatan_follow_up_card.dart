import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/jadwal_kegiatan_model.dart';
import 'package:palapa1/utils/config.dart';

class JadwalKegiatanFollowUpCard extends StatelessWidget {
  final JadwalKegiatanModel jadwal;
  const JadwalKegiatanFollowUpCard({super.key, required this.jadwal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Config.blackColor.withOpacity(0.2),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            jadwal.tanggal_follow_up,
            style: Config.primaryTextStyle.copyWith(
              fontSize: 18.sp,
              fontWeight: Config.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Perineometri',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: Config.semiBold,
                    ),
              ),
              Text(
                jadwal.perineometri,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 15.sp,
                      fontWeight: Config.bold,
                    ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Pad_test',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: Config.semiBold,
                    ),
              ),
              Text(
                jadwal.pad_test,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 15.sp,
                      fontWeight: Config.bold,
                    ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'UDI 6',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: Config.semiBold,
                    ),
              ),
              Text(
                jadwal.udi_6,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 15.sp,
                      fontWeight: Config.bold,
                    ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'IIQ 7',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: Config.semiBold,
                    ),
              ),
              Text(
                jadwal.iiq_7,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 15.sp,
                      fontWeight: Config.bold,
                    ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}

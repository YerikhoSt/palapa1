import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/pages/login.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';

class NotLoginUser extends StatelessWidget {
  const NotLoginUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Kamu Belum Login',
            style: Config.blackTextStyle.copyWith(
              fontSize: 15.sp,
              fontWeight: Config.semiBold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'Ayo login untuk membuka semua fitur!',
            style: Config.blackTextStyle.copyWith(
              fontSize: 15.sp,
              fontWeight: Config.semiBold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.h),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                AniRoute(
                  child: const Login(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.sp,
                vertical: 7.w,
              ),
              decoration: BoxDecoration(
                color: Config.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'Login',
                style: Config.whiteTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: Config.medium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

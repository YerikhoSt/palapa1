import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';

class InformationApplication extends StatelessWidget {
  const InformationApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          getTranslated(context, 'informasi') ?? '',
          style: Config.primaryTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: Config.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.sp),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.sp),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Config.primaryColor,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  getTranslated(context, 'tentang') ?? 'Tentang Aplikasi',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  getTranslated(context, 'tentang_1') ?? '',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.semiBold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  getTranslated(context, 'tentang_2') ?? '',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.semiBold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  getTranslated(context, 'tentang_3') ?? '',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.semiBold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  getTranslated(context, 'tentang_4') ?? '',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.semiBold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.sp),
            margin: EdgeInsets.only(top: 30.sp),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.sp),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Config.primaryColor,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  getTranslated(context, 'referensi') ?? 'Referensi Aplikasi',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  getTranslated(context, 'referensi_1') ?? '',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.semiBold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  getTranslated(context, 'referensi_2') ?? '',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.semiBold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  getTranslated(context, 'referensi_3') ?? '',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.semiBold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  getTranslated(context, 'referensi_4') ?? '',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.semiBold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  getTranslated(context, 'referensi_5') ?? '',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.semiBold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

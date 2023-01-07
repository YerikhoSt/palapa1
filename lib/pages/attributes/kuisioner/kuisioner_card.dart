import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/utils/config.dart';

class KuisionerCard extends StatelessWidget {
  final void Function()? ontap;
  final String judul;
  final String subJudul;
  const KuisionerCard({
    super.key,
    this.ontap,
    required this.judul,
    required this.subJudul,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Text(
              judul,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: Config.bold,
                  ),
            ),
            Text(
              subJudul,
              style: Config.primaryTextStyle.copyWith(
                fontSize: 12.sp,
                fontWeight: Config.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

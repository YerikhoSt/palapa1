import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/utils/config.dart';

class ListVideoCard extends StatelessWidget {
  final String subTitle;
  final String title;
  const ListVideoCard({super.key, required this.subTitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
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
          Image.asset(
            'assets/images/login_image.png',
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 13.sp,
                        fontWeight: Config.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  color: Config.primaryColor,
                  height: 20,
                  thickness: 1.5,
                ),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 12.sp,
                        fontWeight: Config.medium,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

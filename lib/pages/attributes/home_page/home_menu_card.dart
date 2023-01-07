import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/utils/config.dart';

class HomeMenuCard extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;
  final String text;
  final bool isDisable;
  const HomeMenuCard({
    super.key,
    this.onTap,
    required this.icon,
    required this.text,
    this.isDisable = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDisable ? Colors.grey : Config.primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50,
              color: Config.whiteColor,
            ),
            const SizedBox(height: 15),
            Text(
              text,
              style: Config.whiteTextStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: Config.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

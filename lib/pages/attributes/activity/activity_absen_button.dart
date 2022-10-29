import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/utils/config.dart';

class ButtonAbsen extends StatefulWidget {
  final String text;
  final void Function() check;
  final void Function() close;
  final int colorDynamic;
  const ButtonAbsen({
    super.key,
    required this.text,
    required this.check,
    required this.close,
    required this.colorDynamic,
  });

  @override
  State<ButtonAbsen> createState() => _ButtonAbsenState();
}

class _ButtonAbsenState extends State<ButtonAbsen> {
  Color _colorDynamic() {
    switch (widget.colorDynamic) {
      case 1:
        return Colors.greenAccent;
      case 2:
        return Config.alertColor;
      default:
        return Theme.of(context).cardColor;
    }
  }

  Widget _absen() {
    return Row(
      key: const Key('first'),
      children: <Widget>[
        InkWell(
          onTap: widget.close,
          child: Icon(
            Icons.close,
            size: 25.w,
            color: Config.alertColor,
          ),
        ),
        SizedBox(width: 15.w),
        InkWell(
          onTap: widget.check,
          child: Icon(
            Icons.check,
            size: 25.w,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _absenResult() {
    return Container(
      key: const Key('second'),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: widget.colorDynamic == 1
          ? Icon(
              Icons.check,
              size: 25.w,
              color: Colors.green,
            )
          : Icon(
              Icons.close,
              size: 25.w,
              color: Config.alertColor,
            ),
    );
  }

  Widget _animatedSwitcher() {
    return widget.colorDynamic == 1 ? _absenResult() : _absen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(
        vertical: 12.w,
        horizontal: 15.w,
      ),
      decoration: BoxDecoration(
        color: _colorDynamic(),
        borderRadius: BorderRadius.circular(16.w),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: Config.semiBold,
                ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _animatedSwitcher(),
          ),
        ],
      ),
    );
  }
}
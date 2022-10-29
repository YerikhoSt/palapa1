import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void changeStatusBarColor(
    {required Brightness statusBarIconBrightness,
    Color? statusBarColor,
    Color? systemNavigationBarColor}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor ?? Colors.transparent,
      statusBarIconBrightness: statusBarIconBrightness,
    ),
  );
}

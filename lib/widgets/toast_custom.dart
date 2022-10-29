import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, {int timeInSec = 60}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    textColor: Colors.white,
    backgroundColor: Colors.black87,
    timeInSecForIosWeb: timeInSec,
    fontSize: 16.0,
  );
}

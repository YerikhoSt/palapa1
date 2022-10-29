import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:palapa1/pages/home.dart';
import 'package:palapa1/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString('token') == null) {
    runApp(const Login());
  } else {
    runApp(Home());
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:palapa1/pages/home.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/change_prefs.dart';
import 'package:palapa1/utils/checker_chat.dart';
import 'package:palapa1/widgets/toast_custom.dart';

Future<void> doLoginToServer(BuildContext context, String username,
    String password, Function(bool) progress) async {
  if (chatChecker(username) == false || chatChecker(password) == false) {
    showToast('Login alert');
    progress(false);
  } else {
    progress(true);
    login(
      username: username,
      pass: password,
    ).then(
      (dynamic value) async {
        progress(false);
        if (value != null) {
          if (value['status'] != 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 500),
                backgroundColor: Colors.red.shade400,
                content: const Text(
                  'Password Anda Salah',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            await changePrefsLogin(<String, dynamic>{
              'email': username,
              'password': password,
              'token': value['data']['remember_token'] as String,
              'user_id': value['data']['id'],
            });
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(
                builder: (_) => Home(),
              ),
              (Route<void> route) => false,
            );
          }
        } else {
          showToast('error server');
        }
      },
    );
  }
}

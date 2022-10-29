import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuthenticationService _authApple =
      FirebaseAuthenticationService();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<dynamic> googleLogin() async {
    final GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
    if (_googleUser == null) return;
    _user = _googleUser;

    final GoogleSignInAuthentication _googleAuth =
        await _googleUser.authentication;

    final OAuthCredential _credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(_credential);

    notifyListeners();
  }

  Future<dynamic> appleLogin() async {
    final FirebaseAuthenticationResult result =
        await _authApple.signInWithApple(
      appleRedirectUri:
          'https://moofoods-ef031.firebaseapp.com/__/auth/handler',
      appleClientId: '',
    );
  }

  Future<dynamic> gooleLogOut() async {
    await _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

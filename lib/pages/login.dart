import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/auth/login_auth.dart';
import 'package:palapa1/pages/forgot_password.dart';
import 'package:palapa1/pages/sign_up_form.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/utils/localization/custom_localization.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';
import 'package:palapa1/utils/theme/theme_data_custom.dart';
import 'package:permission_handler/permission_handler.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Locale? _locale;

  ///function for set local attribute class from parent class (MyApp)
  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  void _initLocale() {
    getLocale().then((Locale? locale) {
      setState(() {
        _locale = locale;
      });
    });
  }

  ///like initStete function, this function run for provide code when class was loaded
  @override
  void didChangeDependencies() {
    _initLocale();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _initLocale();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Palapa1',
          theme: ThemeDataCustom.light,
          debugShowCheckedModeBanner: false,

          ///Add default locale class to MaterialApp locale attribute
          locale: _locale,
          supportedLocales: const <Locale>[
            Locale('en', 'US'),
            Locale('id', 'ID')
          ],

          ///Add buildup delegate and custom delegate that we made
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            CustomLocalizations.delegate, //Custom delegate
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          ///Create callback logic for locale
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            for (final Locale supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;

            ///if default locale not support, use first local in supportedLocales list (english)
          },
          home: child,
        );
      },
      child: LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _progressStatus = false;
  bool _usernameIsWrong = false;
  bool _passwordIsWrong = false;
  bool _obscureText = true;

  void _progress(bool status) {
    if (mounted) {
      setState(() => _progressStatus = status);
    }
  }

  void _goToLogin() {
    doLoginToServer(
        context, _controllerUsername.text, _controllerPassword.text, _progress);
  }

  Future<void> _getStoragePermission() async {
    Permission.storage.status.then((PermissionStatus status) async {
      if (status == PermissionStatus.granted) {
        _goToLogin();
      } else {
        final PermissionStatus _permissionStatus =
            await Permission.storage.request();
        if (_permissionStatus.isGranted) {
          _goToLogin();
        } else {
          _getStoragePermission();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Config.whiteColor,
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Welcome To Cherry',
                    style: Config.primaryTextStyle.copyWith(
                      fontSize: 22,
                      fontWeight: Config.bold,
                    ),
                  ),
                  Text(
                    'Sign in your account to continue',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                          fontWeight: Config.light,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Image.asset(
              'assets/images/login_image.png',
              width: 120,
              height: 200,
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: _controllerUsername,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Config.blackColor,
                        width: 2,
                      ),
                    ),
                    hintText: 'Enter your username',
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Config.primaryColor,
                        width: 2,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      size: 23,
                      color: _usernameIsWrong == true
                          ? Config.primaryColor
                          : Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                Visibility(
                  visible: _usernameIsWrong,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    child: Text(
                      getTranslated(context, 'email_wajib_di_isi') ?? '',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Config.alertColor,
                            fontWeight: Config.light,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: _controllerPassword,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Config.blackColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Config.primaryColor,
                        width: 2,
                      ),
                    ),
                    hintText: 'Enter your password',
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    prefixIcon: Icon(
                      Icons.key,
                      size: 23,
                      color: _usernameIsWrong == true
                          ? Config.primaryColor
                          : Theme.of(context).iconTheme.color,
                    ),
                    suffixIcon: _obscureText == true
                        ? Icon(
                            Icons.visibility_outlined,
                            size: 20,
                            color: _passwordIsWrong == true
                                ? Config.alertColor
                                : Theme.of(context).iconTheme.color,
                          )
                        : Icon(
                            Icons.visibility_off_outlined,
                            size: 20,
                            color: _passwordIsWrong == true
                                ? Config.alertColor
                                : Theme.of(context).iconTheme.color,
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Visibility(
                      visible: _usernameIsWrong,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin:
                            const EdgeInsets.only(top: 5, left: 20, right: 20),
                        child: Text(
                          getTranslated(context, 'email_wajib_di_isi') ?? '',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Config.alertColor,
                                    fontWeight: Config.light,
                                  ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        AniRoute(
                          child: const ForgotPassword(),
                        ),
                      ),
                      child: Text(
                        'Lupa Password?',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15,
                              fontWeight: Config.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(
                top: 30,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Config.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (_controllerUsername.text.isNotEmpty &&
                      _controllerPassword.text.isNotEmpty) {
                    _getStoragePermission();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 500),
                        backgroundColor: Colors.red.shade400,
                        content: const Text(
                          'username atau password anda belum di isi',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
                child: Center(
                  child: _progressStatus
                      ? CircularProgressIndicator(
                          color: Config.whiteColor,
                        )
                      : Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 20,
                                    fontWeight: Config.semiBold,
                                    color: Colors.white,
                                  ),
                        ),
                ),
              ),
            ),
            Divider(
              color: Config.primaryColor,
              height: 50,
              thickness: 1,
            ),
            Column(
              children: <Widget>[
                Text(
                  'belum memiliki akun?',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15,
                        fontWeight: Config.regular,
                      ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    AniRoute(
                      child: const SignUpForm(),
                    ),
                  ),
                  child: Text(
                    'Daftar disini',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          fontWeight: Config.bold,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

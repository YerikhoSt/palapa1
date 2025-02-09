import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/pages/edukasi.dart';
import 'package:palapa1/pages/main_container.dart';
import 'package:palapa1/providers/google_sign_in_provider.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/change_statusbar_color.dart';
import 'package:palapa1/utils/localization/custom_localization.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:palapa1/utils/theme/theme_data_custom.dart';
import 'package:palapa1/utils/theme/theme_mode.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Home extends StatefulWidget {
  //Function for set Local attribute in _MyAppState class from other class
  static void setLocale(BuildContext context, Locale locale) {
    final HomeBodyState? state =
        context.findAncestorStateOfType<HomeBodyState>();
    state!.setLocale(locale);
  }

  @override
  State createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'id high important channel',
    'title',
    importance: Importance.high,
    playSound: true,
  );
  Future<void> _localNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  @override
  void initState() {
    _localNotification();
//FIREBASE MESSAGING CONTROLLER
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        Navigator.of(context).push(
          AniRoute(
            child: const Edukasi(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<ThemeModeCustom>(
          create: (_) => ThemeModeCustom(),
        ),
        ChangeNotifierProvider<GoogleSignInProvider>(
          create: (_) => GoogleSignInProvider(),
        ),
      ],
      child: const HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  State createState() {
    return HomeBodyState();
  }
}

class HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  ///Define default Locale variable
  late Locale? _locale;

  ///function for set local attribute class from parent class (MyApp)
  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  ///like initStete function, this function run for provide code when class was loaded
  @override
  void didChangeDependencies() {
    getLocale().then((Locale? locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  HomeBodyState();
  // Future<void> _silentLogin() async {
  //   await getPrefsProfile().then((Map<String, dynamic> v) {
  //     login(
  //       username: v['user_email'] ?? '',
  //       pass: v['user_password'] ?? '',
  //     ).then((dynamic value) async {
  //       print('disini');
  //       print(value);

  //       await changePrefsLogin(<String, dynamic>{
  //         'email': v['user_email'] ?? '',
  //         'password': v['user_password'] ?? '',
  //         'token': value['data']['remember_token'] as String,
  //         'user_id': value['data']['id'],
  //       });
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeMode>(
      future: context.watch<ThemeModeCustom>().themeMode,
      builder: (_, AsyncSnapshot<ThemeMode> snapshot) {
        if (snapshot.data == ThemeMode.dark) {
          changeStatusBarColor(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent);
        } else {
          changeStatusBarColor(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent);
        }
        return ScreenUtilInit(
          designSize: const Size(360, 640),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return snapshot.hasData
                ? MaterialApp(
                    title: 'Palapa1',
                    theme: ThemeDataCustom.light,
                    darkTheme: ThemeDataCustom.dark,
                    themeMode: snapshot.data,
                    debugShowCheckedModeBanner: false,
                    initialRoute: '/home',
                    routes: <String, Widget Function(BuildContext)>{
                      '/home': (BuildContext context) => const MainContainer(),
                    },
                    //Add default locale class to MaterialApp locale attribute
                    locale: _locale,
                    supportedLocales: const <Locale>[
                      Locale('en', 'US'),
                      Locale('id', 'ID')
                    ],
                    //Add buildup delegate and custom delegate that we made
                    localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                      CustomLocalizations.delegate, //Custom delegate
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    //Create callback logic for locale
                    localeResolutionCallback:
                        (Locale? locale, Iterable<Locale> supportedLocales) {
                      for (final Locale supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode ==
                                locale!.languageCode &&
                            supportedLocale.countryCode == locale.countryCode) {
                          return supportedLocale;
                        }
                      }
                      return supportedLocales
                          .first; //if default locale not support, use first local in supportedLocales list (english)
                    },
                    home: child,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
          child: const MainContainer(),
        );
      },
    );
  }
}

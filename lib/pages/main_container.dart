import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/instance_manager.dart';
import 'package:palapa1/controller/notification_controller.dart';
import 'package:palapa1/models/activity_model.dart';
import 'package:palapa1/pages/home_page.dart';
import 'package:palapa1/pages/not_login_user.dart';
import 'package:palapa1/pages/pengaturan_page.dart';
import 'package:palapa1/pages/pilih_admin.dart';
import 'package:palapa1/pages/profile_page.dart';
import 'package:palapa1/pages/tanya_kami_page.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/change_prefs.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainContainer extends StatefulWidget {
  final int index;
  const MainContainer({super.key, this.index = 0});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer>
    with TickerProviderStateMixin<MainContainer> {
  late TabController _tabController;
  var notifController = Get.put(NotificationController());
  ActivityModel? _activityCheck;
  String? _token;
  bool _vibra = false;
  bool _notif = false;
  int? _user_id;
  String _textNotification = '';
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'id high important channel',
    'title',
    importance: Importance.high,
    playSound: true,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _localNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
      _vibra = prefs.getBool('user_vibra') ?? false;
      _notif = prefs.getBool('user_notif') ?? false;
    });
    print('hasil vibrasi $_vibra');
  }

  Future<void> _showNotification() async {
    await _sharePrefs();
    await _localNotification();

    await fetchData(
      'api/aktivitas-harian/view-today/${_user_id}',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then(
      (dynamic value) {
        print(value);
        setState(() {
          _activityCheck = ActivityModel(
            absen_pagi: value['data']['absen_pagi'],
            absen_siang: value['data']['absen_siang'],
            absen_malem: value['data']['absen_malem'],
            hari_aktivitas: value['data']['hari_aktivitas'].toString(),
            tanggal_aktivitas: value['data']['tanggal_aktivitas'].toString(),
          );
        });

        if (_activityCheck!.absen_pagi == null) {
          setState(() {
            _textNotification = 'Kamu belum absen pagi loh!';
          });
        } else if (_activityCheck!.absen_siang == null) {
          setState(() {
            _textNotification = 'Kamu belum absen siang loh!';
          });
        } else if (_activityCheck!.absen_malem == null) {
          setState(() {
            _textNotification = 'Kamu belum absen malam loh!';
          });
        }

        print('haloiii');
        if (_notif == true) {
          flutterLocalNotificationsPlugin.show(
            0,
            'Absen',
            _textNotification,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                enableVibration: _vibra,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    _sharePrefs();
    _localNotification();

    print('log notif ${_notif}');
    _showNotification();

    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
    _tabController.index = widget.index;

    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            const HomePage(),
            _token != null ? const PilihAdmin() : const NotLoginUser(),
            _token != null ? const PengaturanPage() : const NotLoginUser(),
            _token != null ? const ProfilePage() : const NotLoginUser(),
          ],
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            padding: const EdgeInsets.all(0),
            labelColor: Config.primaryColor,
            indicatorWeight: 0.5,
            labelPadding: const EdgeInsets.all(0),
            unselectedLabelColor: Config.blackColor,
            tabs: <Widget>[
              Tab(
                iconMargin: const EdgeInsets.all(0),
                icon: InkWell(
                  child: Icon(
                    Icons.home,
                    size: 30,
                    color: _tabController.index == 0
                        ? Config.primaryColor
                        : Config.blackColor,
                  ),
                ),
                text: getTranslated(context, 'beranda'),
              ),
              GestureDetector(
                onTap: () async {
                  if (_token != null) {
                    await Navigator.of(context).push(
                      AniRoute(
                        child: const PilihAdmin(),
                      ),
                    );
                  }
                },
                child: Tab(
                  iconMargin: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.headset_outlined,
                    size: 30,
                    color: _tabController.index == 1
                        ? Config.primaryColor
                        : Config.blackColor,
                  ),
                  text: getTranslated(context, 'tanya_kami'),
                ),
              ),
              Tab(
                iconMargin: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.settings,
                  size: 30,
                  color: _tabController.index == 2
                      ? Config.primaryColor
                      : Config.blackColor,
                ),
                text: getTranslated(context, 'pengaturan'),
              ),
              Tab(
                iconMargin: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.person_sharp,
                  size: 30,
                  color: _tabController.index == 3
                      ? Config.primaryColor
                      : Config.blackColor,
                ),
                text: getTranslated(context, 'profil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

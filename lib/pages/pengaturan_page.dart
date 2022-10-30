import 'package:flutter/material.dart';
import 'package:palapa1/pages/home.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';
import 'package:palapa1/utils/theme/theme_mode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  bool _changeLang = false;

  void _changeLanguage(Locale locale) {
    setLocale(locale.toString());
    Home.setLocale(context, locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pengaturan',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 18,
                fontWeight: Config.bold,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.dark_mode_outlined,
                color: Theme.of(context).iconTheme.color),
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              getTranslated(context, 'mode_gelap') ?? '',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                    fontWeight: Config.bold,
                  ),
            ),
            trailing: Switch(
              thumbColor: Theme.of(context).brightness == Brightness.dark
                  ? MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor)
                  : null,
              trackColor: Theme.of(context).brightness == Brightness.dark
                  ? MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor.withOpacity(0.5))
                  : null,
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (bool value) async {
                await context
                    .read<ThemeModeCustom>()
                    .changeTheme(darkMode: value);
              },
              activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.3),
              activeColor: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                _changeLang = !_changeLang;
              });
            },
            leading: Icon(
              Icons.language_outlined,
              color: Theme.of(context).iconTheme.color,
              size: 25,
            ),
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              getTranslated(context, 'bahasa') ?? '',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                  ),
            ),
            trailing: Icon(
              _changeLang
                  ? Icons.keyboard_arrow_up_outlined
                  : Icons.keyboard_arrow_down_outlined,
              color: Config.blackColor,
              size: 30,
            ),
          ),
          Visibility(
            visible: _changeLang,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _changeLanguage(const Locale('id', 'ID'));
                        _changeLang = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 2,
                            spreadRadius: 0.1,
                            offset: const Offset(1, 0),
                          ),
                        ],
                        color: Theme.of(context).cardColor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/indo.png',
                            width: 27,
                            height: 27,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Indonesia',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 16, fontWeight: Config.semiBold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _changeLanguage(const Locale('en', 'US'));
                        _changeLang = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 2,
                            spreadRadius: 0.1,
                            offset: const Offset(1, 0),
                          ),
                        ],
                        color: Theme.of(context).cardColor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/eng.png',
                            width: 27,
                            height: 27,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'English',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 16, fontWeight: Config.semiBold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.vibration,
              color: Theme.of(context).iconTheme.color,
              size: 25,
            ),
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              'Getaran',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                  ),
            ),
            trailing: Switch(
              thumbColor: Theme.of(context).brightness == Brightness.dark
                  ? MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor)
                  : null,
              trackColor: Theme.of(context).brightness == Brightness.dark
                  ? MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor.withOpacity(0.5))
                  : null,
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (bool value) async {},
              activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.3),
              activeColor: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.notifications,
              color: Theme.of(context).iconTheme.color,
              size: 25,
            ),
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              'Notification',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                  ),
            ),
            trailing: Switch(
              thumbColor: Theme.of(context).brightness == Brightness.dark
                  ? MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor)
                  : null,
              trackColor: Theme.of(context).brightness == Brightness.dark
                  ? MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor.withOpacity(0.5))
                  : null,
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (bool value) async {},
              activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.3),
              activeColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

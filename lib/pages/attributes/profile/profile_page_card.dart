import 'package:flutter/material.dart';
import 'package:palapa1/models/user_model.dart';
import 'package:palapa1/pages/attributes/profile/edit_profile_page.dart';
import 'package:palapa1/pages/login.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageCard extends StatelessWidget {
  final UserModel user;

  const ProfilePageCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(25, 70, 25, 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Theme.of(context).cardColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Config.primaryColor.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Config.blackColor,
                ),
                Text(
                  user.name,
                  style: Config.primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: Config.bold,
                  ),
                ),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: Config.bold,
                      ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  color: Config.primaryColor,
                  height: 60,
                  thickness: 1.5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'No. Telepon',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            fontWeight: Config.bold,
                          ),
                    ),
                    Text(
                      user.no_telpon,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            fontWeight: Config.medium,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Nama Pendamping',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            fontWeight: Config.bold,
                          ),
                    ),
                    Text(
                      user.nama_pendamping,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            fontWeight: Config.medium,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'No. Telepon Pendamping',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            fontWeight: Config.bold,
                          ),
                    ),
                    Text(
                      user.no_telpon_pendamping,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            fontWeight: Config.medium,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Alamat',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            fontWeight: Config.bold,
                          ),
                    ),
                    Text(
                      user.alamat,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            fontWeight: Config.medium,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () => Navigator.of(context).push(
                  AniRoute(
                    child: EditProfilePage(
                      NoTelpon: user.no_telpon,
                      alamat: user.alamat,
                      email: user.email,
                      kota: user.kota,
                      namaPendamping: user.nama_pendamping,
                      name: user.name,
                      noTelponPendamping: user.no_telpon_pendamping,
                      provinsi: user.provinsi,
                      tanggalLahir: user.tanggal_lahir,
                      username: user.username,
                    ),
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  margin: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).cardColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 2,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    'Edit',
                    style: Config.primaryTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: Config.semiBold,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                    AniRoute(child: const Login()),
                    (route) => false,
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  margin: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).cardColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 2,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    'logout',
                    style: Config.blackTextStyle.copyWith(
                      fontSize: 15,
                      color: Config.alertColor,
                      fontWeight: Config.semiBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/utils/config.dart';

class JadwalKegiatanFollowUp extends StatefulWidget {
  const JadwalKegiatanFollowUp({super.key});

  @override
  State<JadwalKegiatanFollowUp> createState() => _JadwalKegiatanFollowUpState();
}

class _JadwalKegiatanFollowUpState extends State<JadwalKegiatanFollowUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'Jadwal',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16.sp,
                fontWeight: Config.bold,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Column(
            children: <Widget>[
              Image.asset(
                'assets/images/jadwal_empty.jpg',
                width: 250,
                height: 250,
              ),
              Text(
                'Jadwal kegiatan follow up anda masih kosong',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18,
                      fontWeight: Config.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

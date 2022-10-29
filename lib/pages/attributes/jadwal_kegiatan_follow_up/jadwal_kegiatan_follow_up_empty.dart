import 'package:flutter/material.dart';
import 'package:palapa1/utils/config.dart';

class JadwalKegiatanFollowUp extends StatelessWidget {
  const JadwalKegiatanFollowUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

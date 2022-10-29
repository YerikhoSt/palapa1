import 'package:flutter/material.dart';
import 'package:palapa1/pages/main_container.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';

class KuisionerDone extends StatelessWidget {
  const KuisionerDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/kuisioner_done.jpg',
            width: 300,
            height: 300,
          ),
          Text(
            'Hore ! ! !',
            style: Config.primaryTextStyle.copyWith(
              fontSize: 24,
              fontWeight: Config.bold,
            ),
          ),
          Text(
            'Kamu sudah menyelesaikan kuisioner kondisi gejala awal',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 18,
                  fontWeight: Config.bold,
                ),
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
              AniRoute(
                child: const MainContainer(),
              ),
              (Route<void> route) => false,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 3,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Text(
                'Kembali',
                style: Config.primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: Config.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

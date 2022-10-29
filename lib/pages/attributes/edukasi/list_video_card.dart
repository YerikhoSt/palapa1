import 'package:flutter/material.dart';
import 'package:palapa1/utils/config.dart';

class ListVideoCard extends StatelessWidget {
  final void Function()? onTap;
  final String subTitle;
  final int nomer;
  const ListVideoCard(
      {super.key, this.onTap, required this.subTitle, required this.nomer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
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
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/login_image.png',
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Senam Kegel - ${nomer}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 17,
                          fontWeight: Config.bold,
                        ),
                  ),
                  Divider(
                    color: Config.primaryColor,
                    height: 20,
                    thickness: 1.5,
                  ),
                  Text(
                    subTitle,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12,
                          fontWeight: Config.medium,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

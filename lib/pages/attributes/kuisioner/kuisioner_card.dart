import 'package:flutter/material.dart';
import 'package:palapa1/utils/config.dart';

class KuisionerCard extends StatelessWidget {
  final void Function()? ontap;
  final String judul;
  final String subJudul;
  const KuisionerCard({
    super.key,
    this.ontap,
    required this.judul,
    required this.subJudul,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.only(bottom: 20),
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
            Text(
              judul,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: Config.bold,
                  ),
            ),
            Text(
              subJudul,
              style: Config.primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: Config.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
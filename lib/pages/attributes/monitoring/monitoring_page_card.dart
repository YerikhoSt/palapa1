import 'package:flutter/material.dart';
import 'package:palapa1/utils/config.dart';

class MonitoringPageCard extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MonitoringPageCard({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
          text,
          style: Config.primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: Config.semiBold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

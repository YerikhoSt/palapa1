import 'package:flutter/material.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/widgets/button_question.dart';

class KuisionerAnswerCard extends StatelessWidget {
  final String text;
  final dynamic radioValue;
  final dynamic groupValue;
  final void Function(dynamic) onChange;
  final void Function()? onTap;
  const KuisionerAnswerCard(
      {super.key,
      required this.text,
      this.onTap,
      this.radioValue,
      this.groupValue,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: groupValue == radioValue
              ? Config.primaryColor.withOpacity(0.8)
              : Theme.of(context).cardColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Config.primaryColor.withOpacity(0.3),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Radio(
              value: radioValue,
              groupValue: groupValue,
              onChanged: onChange,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: Config.medium,
                    color: groupValue == radioValue
                        ? Config.whiteColor
                        : Config.blackColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

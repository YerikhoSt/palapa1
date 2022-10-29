import 'package:flutter/material.dart';
import 'package:palapa1/utils/config.dart';

class ButtonQuestion extends StatelessWidget {
  final bool isSelect;
  const ButtonQuestion({super.key, this.isSelect = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      margin: const EdgeInsets.only(right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 1.5,
          color: isSelect ? Config.whiteColor : Config.blackColor,
        ),
      ),
      child: Center(
        child: Visibility(
          visible: isSelect,
          child: Icon(
            Icons.circle,
            color: Config.whiteColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}

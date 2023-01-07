import 'package:flutter/material.dart';
import 'package:palapa1/utils/config.dart';

class CustomProgressBar extends StatefulWidget {
  final int progress;
  const CustomProgressBar({super.key, required this.progress});

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  double progressDinamis() {
    switch (widget.progress) {
      case 0:
        return MediaQuery.of(context).size.width;
      case 25:
        return 4;
      case 50:
        return 2;
      case 75:
        return 1.5;
      case 100:
        return 0.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 25),
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / progressDinamis(),
            height: double.infinity,
            decoration: BoxDecoration(
              color: Config.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${widget.progress}%',
              style: Config.whiteTextStyle.copyWith(
                fontSize: 18,
                fontWeight: Config.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

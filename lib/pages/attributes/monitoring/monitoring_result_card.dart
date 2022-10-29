import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/monitoring_result_model.dart';
import 'package:palapa1/utils/config.dart';

class MonitoringResultCard extends StatefulWidget {
  final MonitoringResultModel result;
  final int param;
  const MonitoringResultCard({
    super.key,
    required this.result,
    required this.param,
  });

  @override
  State<MonitoringResultCard> createState() => _MonitoringResultCardState();
}

class _MonitoringResultCardState extends State<MonitoringResultCard> {
  Color _colorDinamis() {
    switch (widget.param) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.green;

      default:
        return Theme.of(context).cardColor;
    }
  }

  String _textDinamis() {
    switch (widget.param) {
      case 1:
        return 'Hasil Buruk';
      case 2:
        return 'Hasil Bagus';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.w),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _colorDinamis(),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Minggu ke - ${widget.result.week}',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 18.sp,
                  fontWeight: Config.semiBold,
                ),
          ),
          Divider(
            color: _colorDinamis(),
            height: 30.h,
            thickness: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Score',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: Config.semiBold,
                    ),
              ),
              Text(
                widget.result.skor.toString(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: Config.bold,
                      color: _colorDinamis(),
                    ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            _textDinamis(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 15.sp,
                  fontWeight: Config.regular,
                  color: _colorDinamis(),
                ),
          ),
        ],
      ),
    );
  }
}

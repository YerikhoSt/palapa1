import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/province_model.dart';
import 'package:palapa1/pages/constant.dart';
import 'package:palapa1/pages/sign_up_form.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';

class SelectionCity extends StatefulWidget {
  final int provinsiId;
  final String provinsiName;
  const SelectionCity(
      {super.key, required this.provinsiId, required this.provinsiName});

  @override
  State<SelectionCity> createState() => _SelectionCityState();
}

class _SelectionCityState extends State<SelectionCity> {
  List<ProvinceModel> _listCity = <ProvinceModel>[];

  Future<void> _getDataProvince() async {
    await fetchData(
      'https://dev.farizdotid.com/api/daerahindonesia/kota?id_provinsi=${widget.provinsiId}',
      useBaseUrl: false,
    ).then(
      (value) async {
        print('ISI VALUE $value');
        for (final i in value['kota_kabupaten']) {
          ProvinceModel city = ProvinceModel(
            id: i['id'],
            name: i['nama'],
          );
          setState(() {
            _listCity.add(city);
          });
        }
      },
    );
  }

  @override
  void initState() {
    _getDataProvince();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          getTranslated(context, 'kota') ?? 'Kota',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16.sp,
                fontWeight: Config.bold,
              ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _listCity.length,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemBuilder: (context, index) {
          print('LENGHT =====> ${_listCity.length}');
          return ListTile(
            onTap: () {
              setState(() {
                Constant.kota = _listCity[index].name;
                Constant.provinsi = widget.provinsiName;
                Constant.controllerKota.text = _listCity[index].name;
                Constant.controllerProvinsi.text = widget.provinsiName;
              });
              Navigator.pop(context);
              Navigator.pop(context);

              // Navigator.of(context).push(
              //   AniRoute(
              //     child: SignUpForm(
              //       provinsi: widget.provinsiName,
              //       kota: _listCity[index].name,
              //     ),
              //   ),
              // );
            },
            title: Text(
              _listCity[index].name,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18.sp,
                    fontWeight: Config.bold,
                  ),
            ),
          );
        },
      ),
    );
  }
}

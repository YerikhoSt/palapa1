import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/province_model.dart';
import 'package:palapa1/pages/selection_city.dart';
import 'package:palapa1/pages/sign_up_form.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';

class SelectionProvince extends StatefulWidget {
  const SelectionProvince({super.key});

  @override
  State<SelectionProvince> createState() => _SelectionProvinceState();
}

class _SelectionProvinceState extends State<SelectionProvince> {
  List<ProvinceModel> _listProvince = <ProvinceModel>[];

  Future<void> _getDataProvince() async {
    await fetchData(
      'https://dev.farizdotid.com/api/daerahindonesia/provinsi',
      useBaseUrl: false,
    ).then(
      (value) async {
        print('ISI VALUE $value');
        for (final i in value['provinsi']) {
          ProvinceModel province = ProvinceModel(
            id: i['id'],
            name: i['nama'],
          );
          setState(() {
            _listProvince.add(province);
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
          getTranslated(context, 'provinsi') ?? 'Provinsi',
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
        itemCount: _listProvince.length,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemBuilder: (context, index) {
          print('LENGHT =====> ${_listProvince.length}');
          return ListTile(
            onTap: () {
            
              Navigator.of(context).push(
                AniRoute(
                  child: SelectionCity(
                    provinsiName: _listProvince[index].name,
                    provinsiId: _listProvince[index].id,
                  ),
                ),
              );
            },
            title: Text(
              _listProvince[index].name,
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

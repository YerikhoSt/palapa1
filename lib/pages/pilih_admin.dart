import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/list_admin_model.dart';
import 'package:palapa1/pages/tanya_kami_page.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PilihAdmin extends StatefulWidget {
  const PilihAdmin({super.key});

  @override
  State<PilihAdmin> createState() => _PilihAdminState();
}

class _PilihAdminState extends State<PilihAdmin> {
  String? _token;
  int? _user_id;

  bool _isLoading = false;

  List<ListAdminModel> _listAdmin = <ListAdminModel>[];

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print(_user_id);
    print(_token);
  }

  Future<void> _getListAdmin() async {
    await _sharePrefs();
    setState(() {
      _isLoading = true;
    });
    fetchData(
      'api/live-chat/list-adminuser-online?token=$_token',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then(
      (dynamic value) {
        print(value);
        print('haloiii');
        if (value['status'] == 200) {
          for (final dynamic val in value['data']['admin']) {
            final ListAdminModel _valueAdmin = ListAdminModel(
              user_id: val['user_id'].toString(),
              nama: val['nama'],
              status: val['status'],
            );
            setState(() {
              _listAdmin.add(_valueAdmin);
            });
          }
          setState(() {
            _isLoading = false;
          });
        } else {
          _getListAdmin();
        }
      },
    );
  }

  @override
  void initState() {
    _getListAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Config.primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Config.whiteColor,
          ),
        ),
        title: Text(
          'Tanya Kami',
          style: Config.whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: Config.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 25.w,
        ),
        children: <Widget>[
          Image.asset(
            'assets/images/chat.png',
            width: 150.w,
            height: 150.h,
          ),
          SizedBox(height: 25.h),
          Text(
            'Pilih admin untuk kamu chat',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 18.sp,
                  fontWeight: Config.semiBold,
                ),
          ),
          SizedBox(height: 20.w),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Config.primaryColor,
                  ),
                )
              : ListView.builder(
                  itemCount: _listAdmin.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        AniRoute(
                          child: TanyaKamiPage(
                            adminModel: _listAdmin[index],
                          ),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                          horizontal: 17.w,
                          vertical: 12.w,
                        ),
                        margin: EdgeInsets.only(bottom: 15.w),
                        decoration: BoxDecoration(
                          color: Config.whiteColor,
                          borderRadius: BorderRadius.circular(6.w),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Config.blackColor.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 30.w,
                              height: 30.w,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey.shade300,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.headset_mic_outlined,
                                  color: Config.blackColor,
                                  size: 25,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _listAdmin[index].nama,
                                  style: Config.blackTextStyle.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: Config.semiBold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  _listAdmin[index].status,
                                  style: Config.blackTextStyle.copyWith(
                                    fontSize: 14.w,
                                    color: _listAdmin[index].status == 'offline'
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

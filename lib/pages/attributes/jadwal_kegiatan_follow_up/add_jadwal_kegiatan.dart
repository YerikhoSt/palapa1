import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/pages/jadwal_kegiatan_follow_up.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddJadwalKegiatan extends StatefulWidget {
  const AddJadwalKegiatan({super.key});

  @override
  State<AddJadwalKegiatan> createState() => _AddJadwalKegiatanState();
}

class _AddJadwalKegiatanState extends State<AddJadwalKegiatan> {
  TextEditingController _controllerTanggal = TextEditingController();
  TextEditingController _controllerPerineometri = TextEditingController();
  TextEditingController _controllerPadTest = TextEditingController();

  bool _usernameIsWrong = false;
  DateTime _selectedDate = DateTime.now();

  String? _token;
  int? _user_id;

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print(_user_id);
    print(_token);
  }

  @override
  void initState() {
    _sharePrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        automaticallyImplyLeading: false,
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
        title: Text(
          getTranslated(context, 'add_jadwal') ?? '',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16.sp,
                fontWeight: Config.bold,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                readOnly: true,
                controller: _controllerTanggal,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2101),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          dialogTheme: const DialogTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ),
                          colorScheme: ColorScheme.light(
                            primary: Theme.of(context).primaryColor,
                            onPrimary: Config.whiteColor,
                            onSurface: Config.blackColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Config.blackColor,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then((DateTime? value) {
                    if (value != null) {
                      setState(() {
                        _controllerTanggal.text =
                            DateFormat('y-MM-dd').format(value);
                      });
                    }
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Tanggal Follow Up Kamu',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.date_range,
                    size: 23,
                    color: _usernameIsWrong == true
                        ? Config.primaryColor
                        : Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
              Visibility(
                visible: _usernameIsWrong,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Text(
                    getTranslated(context, 'email_wajib_di_isi') ?? '',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Config.alertColor,
                          fontWeight: Config.light,
                        ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _controllerPerineometri,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Enter nilai perineometri kamu',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.school_rounded,
                    size: 23,
                    color: _usernameIsWrong == true
                        ? Config.primaryColor
                        : Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
              Visibility(
                visible: _usernameIsWrong,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Text(
                    getTranslated(context, 'email_wajib_di_isi') ?? '',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Config.alertColor,
                          fontWeight: Config.light,
                        ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _controllerPadTest,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Enter nilai pad test kamu',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.school_rounded,
                    size: 23,
                    color: _usernameIsWrong == true
                        ? Config.primaryColor
                        : Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
              Visibility(
                visible: _usernameIsWrong,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Text(
                    getTranslated(context, 'email_wajib_di_isi') ?? '',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Config.alertColor,
                          fontWeight: Config.light,
                        ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          InkWell(
            onTap: () async {
              if (_controllerTanggal.text.isNotEmpty &&
                  _controllerPerineometri.text.isNotEmpty &&
                  _controllerPadTest.text.isNotEmpty) {
                await fetchData(
                  'api/follow-up/post',
                  method: FetchDataMethod.post,
                  tokenLabel: TokenLabel.xa,
                  extraHeader: <String, String>{
                    'Authorization': 'Bearer ${_token}'
                  },
                  params: <String, dynamic>{
                    'user_id': _user_id,
                    'tanggal_follow_up': _controllerTanggal.text,
                    'perineometri': _controllerPerineometri.text,
                    'pad_test': _controllerPadTest.text,
                  },
                ).then((dynamic value) async {
                  print(value);
                  if (value['status'] == 200) {
                    await Navigator.pushAndRemoveUntil(
                      context,
                      AniRoute(child: const JadwalKegiatanFollowUp()),
                      ModalRoute.withName('/home'),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 500),
                        backgroundColor: Colors.red.shade400,
                        content: const Text(
                          'Belum saatnya memasukan hasil follow up',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(milliseconds: 500),
                    backgroundColor: Colors.red.shade400,
                    content: const Text(
                      'Semua Data Wajib Di Isi',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Config.primaryColor,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  'Confirm',
                  style: Config.primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: Config.semiBold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

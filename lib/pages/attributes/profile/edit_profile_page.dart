import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/pages/aktivasi_akun.dart';
import 'package:palapa1/pages/main_container.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/change_prefs.dart';
import 'package:palapa1/utils/config.dart';
import 'package:intl/intl.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String alamat;
  final String NoTelpon;
  final String namaPendamping;
  final String noTelponPendamping;
  final String kota;
  final String provinsi;
  final String tanggalLahir;
  final String username;

  const EditProfilePage({
    Key? key,
    required this.name,
    required this.email,
    required this.alamat,
    required this.NoTelpon,
    required this.namaPendamping,
    required this.noTelponPendamping,
    required this.kota,
    required this.provinsi,
    required this.username,
    required this.tanggalLahir,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAlamat = TextEditingController();
  TextEditingController _controllerKota = TextEditingController();
  TextEditingController _controllerProvinsi = TextEditingController();
  TextEditingController _controllerNoTelepon = TextEditingController();
  TextEditingController _controllerNamaPendamping = TextEditingController();
  TextEditingController _controllerNoTeleponPendamping =
      TextEditingController();
  TextEditingController _controllerTanggalLahir = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _usernameIsWrong = false;
  bool _isLoading = false;
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

  Future<void> _getDataUser() async {
    await _sharePrefs();
    await fetchData(
      'api/user/view/${_user_id}',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then(
      (dynamic value) async {
        print(value);
        await changePrefsProfile(
          <String, String>{
            'username': value['data']['username'],
            'email': value['data']['email'],
            'name': value['data']['name'],
            'tanggal_lahir': value['data']['tanggal_lahir'].toString(),
            'alamat': value['data']['alamat'],
            'no_telpon': value['data']['no_telpon'].toString(),
            'nama_pendamping': value['data']['nama_pendamping'],
            'no_telpon_pendamping':
                value['data']['no_telpon_pendamping'].toString(),
            'kota': value['data']['kota'],
            'provinsi': value['data']['provinsi'],
          },
        );
        print('response profile');
        print(value);
      },
    );
  }

  @override
  void initState() {
    _sharePrefs();
    setState(() {
      _controllerName.text = widget.name;
      _controllerAlamat.text = widget.alamat;
      _controllerEmail.text = widget.email;
      _controllerKota.text = widget.kota;
      _controllerNamaPendamping.text = widget.namaPendamping;
      _controllerNoTelepon.text = widget.NoTelpon;
      _controllerNoTeleponPendamping.text = widget.noTelponPendamping;
      _controllerUsername.text = widget.username;
      _controllerTanggalLahir.text = widget.tanggalLahir;
      _controllerProvinsi.text = widget.provinsi;
    });

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
          'Edit Account',
          style: Config.primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: Config.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 20.w,
          horizontal: 15.w,
        ),
        children: <Widget>[
          Image.asset(
            'assets/images/registrasi.png',
            width: 180.w,
            height: 180.w,
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _controllerName,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Enter your name',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline,
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
                readOnly: true,
                controller: _controllerTanggalLahir,
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
                        _controllerTanggalLahir.text =
                            DateFormat('y-MM-d').format(value);
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
                  hintText: 'Tanggal Lahir kamu',
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
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     TextField(
          //       controller: _controllerUsername,
          //       decoration: InputDecoration(
          //         enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide(
          //             color: Config.blackColor,
          //             width: 2,
          //           ),
          //         ),
          //         hintText: 'Enter your username',
          //         hintStyle: Theme.of(context).textTheme.bodyText1,
          //         focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide(
          //             color: Config.primaryColor,
          //             width: 2,
          //           ),
          //         ),
          //         prefixIcon: Icon(
          //           Icons.person_outline,
          //           size: 23,
          //           color: _usernameIsWrong == true
          //               ? Config.primaryColor
          //               : Theme.of(context).iconTheme.color,
          //         ),
          //       ),
          //     ),
          //     Visibility(
          //       visible: _usernameIsWrong,
          //       child: Container(
          //         width: MediaQuery.of(context).size.width,
          //         margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
          //         child: Text(
          //           getTranslated(context, 'email_wajib_di_isi') ?? '',
          //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
          //                 color: Config.alertColor,
          //                 fontWeight: Config.light,
          //               ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Enter your email',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.mail_outline,
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
                controller: _controllerAlamat,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Enter your address',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.maps_home_work_outlined,
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
                controller: _controllerKota,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Masukkan kotamu',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.location_city,
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
                controller: _controllerProvinsi,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Masukkan provinsi mu',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    CommunityMaterialIcons.city_variant,
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
                controller: _controllerNoTelepon,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Enter your phone number',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.phone,
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
          // const SizedBox(
          //   height: 20,
          // ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     TextField(
          //       controller: _controllerNamaPendamping,
          //       decoration: InputDecoration(
          //         enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide(
          //             color: Config.blackColor,
          //             width: 2,
          //           ),
          //         ),
          //         hintText: 'Nama pendamping',
          //         hintStyle: Theme.of(context).textTheme.bodyText1,
          //         focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide(
          //             color: Config.primaryColor,
          //             width: 2,
          //           ),
          //         ),
          //         prefixIcon: Icon(
          //           Icons.people,
          //           size: 23,
          //           color: _usernameIsWrong == true
          //               ? Config.primaryColor
          //               : Theme.of(context).iconTheme.color,
          //         ),
          //       ),
          //     ),
          //     Visibility(
          //       visible: _usernameIsWrong,
          //       child: Container(
          //         width: MediaQuery.of(context).size.width,
          //         margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
          //         child: Text(
          //           getTranslated(context, 'email_wajib_di_isi') ?? '',
          //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
          //                 color: Config.alertColor,
          //                 fontWeight: Config.light,
          //               ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     TextField(
          //       controller: _controllerNoTeleponPendamping,
          //       decoration: InputDecoration(
          //         enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide(
          //             color: Config.blackColor,
          //             width: 2,
          //           ),
          //         ),
          //         hintText: 'Nomer telepon pendamping',
          //         hintStyle: Theme.of(context).textTheme.bodyText1,
          //         focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide(
          //             color: Config.primaryColor,
          //             width: 2,
          //           ),
          //         ),
          //         prefixIcon: Icon(
          //           Icons.phone,
          //           size: 23,
          //           color: _usernameIsWrong == true
          //               ? Config.primaryColor
          //               : Theme.of(context).iconTheme.color,
          //         ),
          //       ),
          //     ),
          //     Visibility(
          //       visible: _usernameIsWrong,
          //       child: Container(
          //         width: MediaQuery.of(context).size.width,
          //         margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
          //         child: Text(
          //           getTranslated(context, 'email_wajib_di_isi') ?? '',
          //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
          //                 color: Config.alertColor,
          //                 fontWeight: Config.light,
          //               ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Config.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                if (_controllerAlamat.text.isNotEmpty &&
                    _controllerEmail.text.isNotEmpty &&
                    _controllerKota.text.isNotEmpty &&
                    _controllerName.text.isNotEmpty &&
                    _controllerNoTelepon.text.isNotEmpty &&
                    _controllerProvinsi.text.isNotEmpty &&
                    _controllerTanggalLahir.text.isNotEmpty) {
                  setState(() {
                    _isLoading = true;
                  });
                  await fetchData(
                    'api/user/edit/${_user_id}',
                    method: FetchDataMethod.post,
                    tokenLabel: TokenLabel.xa,
                    extraHeader: <String, String>{
                      'Authorization': 'Bearer ${_token}'
                    },
                    params: <String, dynamic>{
                      'avatar': 'https://via.placeholder.com/150',
                      'email': _controllerEmail.text,
                      'name': _controllerName.text,
                      'tanggal_lahir': _controllerTanggalLahir.text,
                      'alamat': _controllerAlamat.text,
                      'kota': _controllerKota.text,
                      'provinsi': _controllerProvinsi.text,
                      'long': '3412412',
                      'lat': '1231231',
                      'no_telpon': _controllerNoTelepon.text,
                    },
                  ).then(
                    (dynamic value) async {
                      print('response regist');
                      print(value);
                      await _getDataUser();
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                        AniRoute(
                          child: const MainContainer(
                            index: 3,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(milliseconds: 500),
                      backgroundColor: Colors.red.shade400,
                      content: const Text(
                        'Silahkan isi semua data terlebih dahulu',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              child: Center(
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: Config.whiteColor,
                      )
                    : Text(
                        'Edit',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 20,
                              fontWeight: Config.semiBold,
                              color: Colors.white,
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

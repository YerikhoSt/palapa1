import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/pages/aktivasi_akun.dart';
import 'package:palapa1/pages/constant.dart';
import 'package:palapa1/pages/login.dart';
import 'package:palapa1/pages/selection_province.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:intl/intl.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';

class SignUpForm extends StatefulWidget {
  final String? provinsi;
  final String? kota;
  const SignUpForm({Key? key, this.provinsi, this.kota}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerAlamat = TextEditingController();
  TextEditingController _controllerKota = TextEditingController();
  TextEditingController _controllerProvinsi = TextEditingController();
  TextEditingController _controllerNoTelepon = TextEditingController();
  TextEditingController _controllerNamaPendamping = TextEditingController();
  TextEditingController _controllerNoTeleponPendamping =
      TextEditingController();
  bool _obscureText = true;

  TextEditingController _controllerTanggalLahir = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _usernameIsWrong = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      Constant.controllerProvinsi.text = Constant.provinsi;
      Constant.controllerKota.text = Constant.kota;
    });
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
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
          'Sign Up',
          style: Config.primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: Config.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        children: <Widget>[
          Text(
            'Create Your Kegel Account',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 18,
                  fontWeight: Config.light,
                ),
          ),
          const SizedBox(
            height: 50,
          ),
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
                controller: _controllerPassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Enter your Password',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.primaryColor,
                      width: 2,
                    ),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText == true
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.key,
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
                controller: Constant.controllerProvinsi,
                readOnly: true,
                onTap: () {
                  Navigator.of(context).push(
                    AniRoute(
                      child: const SelectionProvince(),
                    ),
                  );
                },
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
                controller: Constant.controllerKota,
                readOnly: true,
                onTap: () {
                  Navigator.of(context).push(
                    AniRoute(
                      child: const SelectionProvince(),
                    ),
                  );
                },
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
                controller: _controllerNoTelepon,
                keyboardType: TextInputType.number,
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
                    Constant.controllerKota.text.isNotEmpty &&
                    _controllerName.text.isNotEmpty &&
                    _controllerNoTelepon.text.isNotEmpty &&
                    _controllerPassword.text.isNotEmpty &&
                    Constant.controllerProvinsi.text.isNotEmpty &&
                    _controllerTanggalLahir.text.isNotEmpty) {
                  setState(() {
                    _isLoading = true;
                  });
                  await fetchData(
                    'api/register',
                    method: FetchDataMethod.post,
                    tokenLabel: TokenLabel.none,
                    params: <String, dynamic>{
                      'email': _controllerEmail.text,
                      'username': _controllerName.text,
                      'password': _controllerPassword.text,
                      'name': _controllerName.text,
                      'tanggal_lahir': _controllerTanggalLahir.text,
                      'alamat': _controllerAlamat.text,
                      'kota': Constant.controllerKota.text,
                      'provinsi': Constant.controllerProvinsi.text,
                      'long': '3412412',
                      'lat': '1231231',
                      'no_telpon': _controllerNoTelepon.text,
                      'nama_pendamping': 'test',
                      'no_telpon_pendamping': '0812345678',
                    },
                  ).then(
                    (dynamic value) {
                      setState(() {
                        _isLoading = false;
                      });
                      print('response regist $value');

                      if (value['status'] == 200) {
                        Navigator.of(context).push(
                          AniRoute(
                            child: AktivasiAkun(
                              email: _controllerEmail.text,
                            ),
                          ),
                        );
                      } else if (value['status'] == 400) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 500),
                            backgroundColor: Colors.red.shade400,
                            content: Text(
                              getTranslated(context, 'sm_regis') ?? 'Error',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(milliseconds: 500),
                      backgroundColor: Colors.red.shade400,
                      content: Text(
                        getTranslated(context, 'sm_regis2') ?? 'Error',
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
                        'Sign Up',
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

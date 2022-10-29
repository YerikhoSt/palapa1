import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:palapa1/pages/aktivasi_akun.dart';
import 'package:palapa1/pages/login.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:intl/intl.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign Up',
                style: Config.primaryTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: Config.bold,
                ),
              ),
              Text(
                'Create Your Kegel Account',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18,
                      fontWeight: Config.light,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/images/sign_up.jpg',
            width: 180,
            height: 180,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _controllerUsername,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Enter your username',
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
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _controllerNamaPendamping,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Nama pendamping',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.primaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.people,
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
                controller: _controllerNoTeleponPendamping,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Config.blackColor,
                      width: 2,
                    ),
                  ),
                  hintText: 'Nomer telepon pendamping',
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
                setState(() {
                  _isLoading = true;
                });
                await fetchData(
                  'api/register',
                  method: FetchDataMethod.post,
                  tokenLabel: TokenLabel.none,
                  params: <String, dynamic>{
                    'email': _controllerEmail.text,
                    'username': _controllerUsername.text,
                    'password': _controllerPassword.text,
                    'name': _controllerName.text,
                    'tanggal_lahir': _controllerTanggalLahir.text,
                    'alamat': _controllerAlamat.text,
                    'kota': _controllerKota.text,
                    'provinsi': _controllerProvinsi.text,
                    'long': '3412412',
                    'lat': '1231231',
                    'no_telpon': _controllerNoTelepon.text,
                    'nama_pendamping': _controllerNamaPendamping.text,
                    'no_telpon_pendamping': _controllerNoTeleponPendamping.text,
                  },
                ).then(
                  (value) {
                    setState(() {
                      _isLoading = false;
                    });
                    print('response regist');
                    print(value);
                    Navigator.of(context).push(
                      AniRoute(
                        child: AktivasiAkun(
                          email: _controllerEmail.text,
                        ),
                      ),
                    );
                  },
                );
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

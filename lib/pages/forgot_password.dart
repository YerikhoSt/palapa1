import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/pages/attributes/forgot_password/input_new_password.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _controllerEmail = TextEditingController();
  bool _usernameIsWrong = false;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
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
        foregroundColor: Theme.of(context).iconTheme.color,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 50),
              children: <Widget>[
                Image.asset(
                  'assets/images/lupa_password.png',
                  width: 120.w,
                  height: 200.w,
                ),
                SizedBox(height: 50.w),
                Text(
                  'Forgot Password',
                  style: Config.primaryTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: Config.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Masukkan Email Kamu',
                  style: Config.blackTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: Config.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'kamu akan menerima 5 digit kode di email untuk verifikasi',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 12,
                      ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).iconTheme.color!,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.mail_outline,
                          size: 23,
                          color: _usernameIsWrong == true
                              ? Config.alertColor
                              : Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _controllerEmail,
                            style: Theme.of(context).textTheme.bodyText1!,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintText: 'your email address',
                              hintStyle: Theme.of(context).textTheme.bodyText1!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Config.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_controllerEmail.text.isNotEmpty) {
                        setState(() {
                          _isLoading = true;
                        });
                        fetchData('api/forgot-password',
                            tokenLabel: TokenLabel.none,
                            method: FetchDataMethod.post,
                            params: {
                              'email': _controllerEmail.text,
                            }).then((dynamic value) {
                          setState(() {
                            _isLoading = false;
                          });

                          print('message forgot');
                          print(value);
                          if (value != null) {
                            Navigator.of(context).push(
                              AniRoute(
                                child: InputNewPassword(
                                  email: _controllerEmail.text,
                                ),
                              ),
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 500),
                            backgroundColor: Config.alertColor,
                            content: const Text(
                              'Masukkan Email Anda',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Config.whiteColor,
                            ),
                          )
                        : Text(
                            'SEND',
                            style: Config.whiteTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: Config.semiBold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

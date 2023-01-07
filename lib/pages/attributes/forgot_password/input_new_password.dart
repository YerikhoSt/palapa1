import 'package:flutter/material.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/pages/login.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class InputNewPassword extends StatefulWidget {
  final String email;
  const InputNewPassword({super.key, required this.email});

  @override
  State<InputNewPassword> createState() => _InputNewPasswordState();
}

class _InputNewPasswordState extends State<InputNewPassword> {
  bool _isFirst = false;
  final TextEditingController _controllerPassword = TextEditingController();
  bool _newPassword = false;

  bool _isLoading = false;
  final TextEditingController _controllerCode = TextEditingController();
  bool _codeIsWrong = false;
  bool hasError = false;

  bool _passwordIsWrong = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        foregroundColor: Theme.of(context).iconTheme.color,
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
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Text(
                      'Email Verification',
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
                      'Kode terkirim ke',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 12,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.email,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15, fontWeight: Config.bold),
                      textAlign: TextAlign.center,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: PinCodeTextField(
                        autofocus: true,
                        controller: _controllerCode,
                        highlight: true,
                        highlightColor: Config.primaryColor,
                        defaultBorderColor: _codeIsWrong == true
                            ? Config.primaryColor
                            : Colors.black,
                        hasTextBorderColor: _codeIsWrong == true
                            ? Config.primaryColor
                            : Config.blackColor,
                        maxLength: 5,
                        hasError: hasError,
                        maskCharacter: '•',
                        onTextChanged: (_) {
                          setState(() {
                            _codeIsWrong = false;
                          });
                        },
                        onDone: (String text) {
                          print('DONE $text');
                          print('DONE CONTROLLER ${_controllerCode.text}');
                        },
                        pinBoxWidth: 50,
                        pinBoxHeight: 50,
                        wrapAlignment: WrapAlignment.spaceAround,
                        keyboardType: TextInputType.text,
                        pinBoxDecoration:
                            ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                        pinTextStyle: TextStyle(
                          fontFamily: Config.defaultFont,
                          color: _codeIsWrong == true
                              ? Config.primaryColor
                              : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                          fontStyle: FontStyle.normal,
                        ),
                        pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration:
                            const Duration(milliseconds: 300),
                        highlightAnimationBeginColor: Colors.black,
                        highlightAnimationEndColor: Colors.white12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Config.primaryColor,
            height: 100,
            thickness: 1.5,
            endIndent: 20,
            indent: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Text(
                      'Create New Password',
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
                      'Masukkan password baru kamu',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 12,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
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
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Config.primaryColor,
                            width: 2,
                          ),
                        ),
                        hintText: 'Enter your password',
                        hintStyle: Theme.of(context).textTheme.bodyText1,
                        prefixIcon: Icon(
                          Icons.key,
                          size: 23,
                          color: _passwordIsWrong == true
                              ? Config.primaryColor
                              : Theme.of(context).iconTheme.color,
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
                            color: _passwordIsWrong == true
                                ? Config.alertColor
                                : Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 2),
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
                          if (_controllerPassword.text.isNotEmpty) {
                            setState(() {
                              _isLoading = true;
                            });
                            fetchData('api/change-password-otp',
                                method: FetchDataMethod.post,
                                params: <String, String>{
                                  'password': _controllerPassword.text,
                                  'otp': _controllerCode.text,
                                  'email': widget.email,
                                }).then((dynamic value) {
                              setState(() {
                                _isLoading = false;
                              });
                              print('response forgot password');
                              print(value);

                              Navigator.of(context).pushAndRemoveUntil(
                                AniRoute(
                                  child: const Login(),
                                ),
                                (route) => false,
                              );
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 500),
                                backgroundColor: Config.alertColor,
                                content: const Text(
                                  'Masukkan Password Baru Anda',
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
                                'Submit',
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
        ],
      ),
    );
  }
}

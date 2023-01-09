import 'package:flutter/material.dart';
import 'package:palapa1/pages/login.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class AktivasiAkun extends StatefulWidget {
  final String email;
  const AktivasiAkun({Key? key, required this.email}) : super(key: key);

  @override
  State<AktivasiAkun> createState() => AktivasiAkunState();
}

class AktivasiAkunState extends State<AktivasiAkun> {
  final TextEditingController _controllerCode = TextEditingController();
  bool _codeIsWrong = false;
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).iconTheme.color,
      ),
      body: Container(
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
                  getTranslated(context, 'ipn') ?? '',
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
                      if (_controllerCode.text.isNotEmpty) {
                        fetchData(
                          'api/check-otp-activation',
                          method: FetchDataMethod.post,
                          params: <String, String>{
                            'email': widget.email,
                            'otp': _controllerCode.text,
                          },
                        ).then(
                          (dynamic value) {
                            print('response aktivasi');
                            print(value);

                            Navigator.of(context).push(
                              AniRoute(
                                child: const Login(),
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      'SUBMIT',
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

import 'package:flutter/material.dart';
import 'package:palapa1/pages/attributes/kuisioner/kuisioner_question/kuisioner_answer_card.dart';
import 'package:palapa1/pages/attributes/kuisioner/kuisioner_question/kuisioner_done.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:intl/intl.dart';
import 'package:palapa1/utils/config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KuisionerQuestion extends StatefulWidget {
  final int type;
  const KuisionerQuestion({super.key, this.type = 1});

  @override
  State<KuisionerQuestion> createState() => _KuisionerQuestionState();
}

class _KuisionerQuestionState extends State<KuisionerQuestion> {
  int _questionIndex = 0;
  DateTime _selectedDate = DateTime.now();
  bool _isAdded = false;
  String? _token;
  int? _user_id;
  bool isLoading = false;

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print(_user_id);
    print(_token);
  }

  int groupValue = 0;

  Future<void> _postResult() async {
    await DateFormat('y-MM-d HH : mm : ss').format(_selectedDate);

    print('testing');
    print(_selectedDate);
    await _sharePrefs();

    if (widget.type == 1) {
      setState(() {
        isLoading = true;
      });
      fetchData(
        'api/kuesioner-udi-6/post',
        method: FetchDataMethod.post,
        tokenLabel: TokenLabel.xa,
        extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
        params: <String, dynamic>{
          'user_id': _user_id,
          'jawaban_1': _isAnswer[0],
          'jawaban_2': _isAnswer[1],
          'jawaban_3': _isAnswer[2],
          'jawaban_4': _isAnswer[3],
          'jawaban_5': _isAnswer[4],
          'jawaban_6': _isAnswer[5],
          'tanggal_pengisian': _selectedDate.toString(),
        },
      ).then(
        (dynamic value) {
          setState(() {
            isLoading = false;
          });
          print('response post');
          print(value);
          if (value['status'] == 200) {
            Navigator.of(context).push(
              AniRoute(
                child: KuisionerDone(
                  skor: value['data']['total_skor_udi_6'].toString(),
                ),
              ),
            );
          } else if (value['status'] == 400) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 500),
                backgroundColor: Colors.red.shade400,
                content: const Text(
                  'belom waktunya untuk mengisi kuisioner lagi',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        },
      );
    } else {
      setState(() {
        isLoading = true;
      });
      fetchData(
        'api/kuesioner-iiq-7/post',
        method: FetchDataMethod.post,
        tokenLabel: TokenLabel.xa,
        extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
        params: <String, dynamic>{
          'user_id': _user_id,
          'jawaban_1': _isAnswer[0],
          'jawaban_2': _isAnswer[1],
          'jawaban_3': _isAnswer[2],
          'jawaban_4': _isAnswer[3],
          'jawaban_5': _isAnswer[4],
          'jawaban_6': _isAnswer[5],
          'jawaban_7': _isAnswer[6],
          'tanggal_pengisian': _selectedDate.toString(),
        },
      ).then(
        (dynamic value) {
          setState(() {
            isLoading = false;
          });
          print('response post');
          print(value);
          if (value['status'] == 200) {
            Navigator.of(context).push(
              AniRoute(
                child: KuisionerDone(
                  skor: value['data']['total_skor'].toString(),
                ),
              ),
            );
          } else if (value['status'] == 400) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 500),
                backgroundColor: Colors.red.shade400,
                content: const Text(
                  'belom waktunya untuk mengisi kuisioner lagi',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  List<dynamic> _isAnswer = <dynamic>[];
  @override
  Widget build(BuildContext context) {
    List<String> _answer = <String>[
      getTranslated(context, 'answer_1') ?? 'Tidak Pernah',
      getTranslated(context, 'answer_2') ?? 'Jarang',
      getTranslated(context, 'answer_3') ?? 'Kadang - kadang',
      getTranslated(context, 'answer_4') ?? 'Sering Kali',
    ];
    List<int> _binaryAnswer = <int>[0, 1, 2, 3];

    List<String> _questionIiq7 = <String>[
      getTranslated(context, 'iiq_q_1') ?? '',
      getTranslated(context, 'iiq_q_2') ?? '',
      getTranslated(context, 'iiq_q_3') ?? '',
      getTranslated(context, 'iiq_q_4') ?? '',
      getTranslated(context, 'iiq_q_5') ?? '',
      getTranslated(context, 'iiq_q_6') ?? '',
      getTranslated(context, 'iiq_q_7') ?? '',
    ];

    List<String> _questionUdi6 = <String>[
      getTranslated(context, 'udi_q_1') ?? '',
      getTranslated(context, 'udi_q_2') ?? '',
      getTranslated(context, 'udi_q_3') ?? '',
      getTranslated(context, 'udi_q_4') ?? '',
      getTranslated(context, 'udi_q_5') ?? '',
      getTranslated(context, 'udi_q_6') ?? '',
    ];
    Widget dinamisQuestion() {
      switch (widget.type) {
        case 1:
          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 25.w, 20.w, 130.w),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    getTranslated(context, 'udi') ?? 'Kondisi Gejala Awal',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20,
                          fontWeight: Config.bold,
                        ),
                  ),
                  Text(
                    'UDI - 6',
                    style: Config.primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: Config.semiBold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    getTranslated(context, 'udi_topper') ?? '',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16.sp,
                          fontWeight: Config.regular,
                        ),
                  ),
                  Text(
                    getTranslated(context, 'udi_bottom') ?? '',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16.sp,
                          fontWeight: Config.bold,
                        ),
                  ),
                  Divider(
                    color: Config.primaryColor,
                    height: 40,
                    thickness: 1.5,
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _questionUdi6[_questionIndex],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 20,
                            fontWeight: Config.bold,
                          ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _binaryAnswer.length,
                      padding: const EdgeInsets.only(top: 15),
                      itemBuilder: (_, int i) {
                        return KuisionerAnswerCard(
                          text: _answer[i],
                          onChange: (s) {
                            setState(() {
                              if (_isAnswer.contains(s)) {
                                _isAnswer.remove(_binaryAnswer[i]);
                              } else {
                                _isAnswer.add(_binaryAnswer[i]);
                              }

                              groupValue = s;
                            });
                          },
                          radioValue: _binaryAnswer[i],
                          groupValue: groupValue,
                          onTap: () {
                            setState(() {
                              groupValue = _binaryAnswer[i];
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        case 2:
          return ListView(
            padding: EdgeInsets.fromLTRB(
              20.w,
              25.w,
              20.w,
              135.w,
            ),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    getTranslated(context, 'iiq') ?? 'Kualitas Hidup',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 20.sp,
                          fontWeight: Config.bold,
                        ),
                  ),
                  Text(
                    'IIQ - 7',
                    style: Config.primaryTextStyle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: Config.semiBold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Distress Urinary',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16.sp,
                          fontWeight: Config.regular,
                        ),
                  ),
                  Text(
                    getTranslated(context, 'iiq_bottom') ?? '',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16.sp,
                          fontWeight: Config.bold,
                        ),
                  ),
                  Divider(
                    color: Config.primaryColor,
                    height: 40,
                    thickness: 1.5,
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _questionIiq7[_questionIndex],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 20,
                            fontWeight: Config.bold,
                          ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _binaryAnswer.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 15),
                      itemBuilder: (_, int i) {
                        return KuisionerAnswerCard(
                          text: _answer[i],
                          onChange: (s) {
                            setState(() {
                              if (_isAnswer.contains(s)) {
                                _isAnswer.remove(_binaryAnswer[i]);
                              } else {
                                _isAnswer.add(_binaryAnswer[i]);
                              }

                              groupValue = s;
                            });
                          },
                          radioValue: _binaryAnswer[i],
                          groupValue: groupValue,
                          onTap: () {
                            setState(() {
                              groupValue = _binaryAnswer[i];
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        default:
          return const SizedBox.shrink();
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        automaticallyImplyLeading: false,
        elevation: 0,
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
          'Pertanyaan',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 18,
                fontWeight: Config.bold,
              ),
        ),
      ),
      body: dinamisQuestion(),
      bottomSheet: Container(
        color: Config.whiteColor,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InkWell(
              onTap: () {
                if (_questionIndex != 0) {
                  if (widget.type == 1) {
                    if (_questionIndex <= 5) {
                      setState(() {
                        _questionIndex--;
                        _isAnswer.remove(groupValue);
                      });
                    }
                  } else {
                    if (_questionIndex <= 6) {
                      setState(() {
                        _questionIndex--;
                        _isAnswer.remove(groupValue);
                      });
                    }
                  }
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.2,
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: _questionIndex == 0 ? Colors.grey : Config.alertColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                    child: Text(
                  'Back',
                  style: Config.whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: Config.bold,
                  ),
                )),
              ),
            ),
            InkWell(
              onTap: isLoading == true
                  ? null
                  : () {
                      if (widget.type == 1) {
                        if (_questionIndex < 5) {
                          setState(() {
                            _questionIndex++;
                            _isAnswer.add(groupValue);
                          });
                        } else {
                          _isAnswer.add(groupValue);
                          print(_isAnswer);

                          _postResult();
                        }
                      } else {
                        if (_questionIndex < 6) {
                          setState(() {
                            _questionIndex++;
                            _isAnswer.add(groupValue);
                          });
                        } else {
                          _isAnswer.add(groupValue);
                          print(_isAnswer);

                          _postResult();
                        }
                      }
                    },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.2,
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Config.primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Config.whiteColor,
                        ),
                      )
                    : Center(
                        child: widget.type == 1
                            ? Text(
                                _questionIndex == 5
                                    ? 'Selesaikan Kuis'
                                    : 'Selanjutnya',
                                style: Config.whiteTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: Config.bold,
                                ),
                              )
                            : Text(
                                _questionIndex == 6
                                    ? 'Selesaikan Kuis'
                                    : 'Selanjutnya',
                                style: Config.whiteTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: Config.bold,
                                ),
                              ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

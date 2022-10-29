import 'package:flutter/material.dart';
import 'package:palapa1/pages/attributes/kuisioner/kuisioner_question/kuisioner_answer_card.dart';
import 'package:palapa1/pages/attributes/kuisioner/kuisioner_question/kuisioner_done.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:intl/intl.dart';
import 'package:palapa1/utils/config.dart';
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

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print(_user_id);
    print(_token);
  }

  Widget dinamisQuestion() {
    switch (widget.type) {
      case 1:
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Kondisi Gejala Awal',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                  'Pertanyaan berikut berhubungan dengan inkontinensia urin',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: Config.regular,
                      ),
                ),
                Text(
                  'Apakah kencing yang keluar mengganggu:',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
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
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Kualitas Hidup',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20,
                        fontWeight: Config.bold,
                      ),
                ),
                Text(
                  'IIQ - 7',
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
                  'Distress Urinary',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: Config.regular,
                      ),
                ),
                Text(
                  'Apakah anda mengalami, dan jika ya seberapa parah anda terganggu dengan :',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
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

  List<String> _questionIiq7 = <String>[
    'Aktivitas pekerjaan rumah tangga anda?',
    'Kegiatan rekreasi seperti berjalan - jalan, berenang, atau berolahraga?',
    'Aktivitas hiburan(nonton film, pertunjukan konser, dan lain - lain) ?',
    'Perjalanan dengan mobil atau bus lebih dari 30 menit?',
    'Kegiatan pada aktivitas sosial di luar rumah?',
    'Kesehatan mental(gelisah, depresi, malu, rendah hati, dan lain - lain)?',
    'Menimbulkan perasaan frustasi?',
  ];

  List<String> _questionUdi6 = <String>[
    'Sering Kencing?',
    'Keluarnya Kencing yang berhubungan dengan perasaan ingin kencing?',
    'Keluarnya kencing yang berhubungan dengan aktivitas fisik, batuk, atau bersin?',
    'Keluarnya kencing dalam jumlah sedikit (menetas)?',
    'Kesulitan mengosongkan kandung kencing (puas berkemih)',
    'Nyeri atau perasaan tidak enak pada perut bagian bawah atau daerah kemaluan?',
  ];
  List<String> _answer = <String>[
    'Tidak Pernah',
    'Jarang',
    'Kadang - Kadang',
    'Sering Kali',
  ];
  List<int> _binaryAnswer = <int>[0, 1, 2, 3];

  int groupValue = 0;

  Future<void> _postResult() async {
    await DateFormat('y-MM-d HH : mm : ss').format(_selectedDate);

    print('testing');
    print(_selectedDate);
    await _sharePrefs();
    if (widget.type == 1) {
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
          print('response post');
          print(value);
        },
      );
    } else {
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
          print('response post');
          print(value);
        },
      );
    }
  }

  @override
  void initState() {
    groupValue = _binaryAnswer.first;
    super.initState();
  }

  List<dynamic> _isAnswer = <dynamic>[];
  @override
  Widget build(BuildContext context) {
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
      bottomSheet: InkWell(
        onTap: () {
          if (widget.type == 1) {
            if (_questionIndex < 5) {
              setState(() {
                _questionIndex++;
                _isAnswer.add(groupValue);
              });
            } else {
              _isAnswer.add(groupValue);
              print(_isAnswer);

              _postResult().then(
                (value) => Navigator.of(context).push(
                  AniRoute(
                    child: const KuisionerDone(),
                  ),
                ),
              );
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

              _postResult().then(
                (value) => Navigator.of(context).push(
                  AniRoute(
                    child: const KuisionerDone(),
                  ),
                ),
              );
            }
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.all(20),
          height: 50,
          decoration: BoxDecoration(
            color: Config.primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: widget.type == 1
                ? Text(
                    _questionIndex == 5 ? 'Selesaikan Kuis' : 'Next Question',
                    style: Config.whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: Config.bold,
                    ),
                  )
                : Text(
                    _questionIndex == 6 ? 'Selesaikan Kuis' : 'Next Question',
                    style: Config.whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: Config.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

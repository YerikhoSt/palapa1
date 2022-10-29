import 'package:flutter/material.dart';
import 'package:palapa1/pages/attributes/kuisioner/kuisioner_card.dart';
import 'package:palapa1/pages/attributes/kuisioner/kuisioner_question/kuisioner_question.dart';
import 'package:palapa1/pages/jadwal_kegiatan_follow_up.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KuisionerPage extends StatefulWidget {
  const KuisionerPage({super.key});

  @override
  State<KuisionerPage> createState() => _KuisionerPageState();
}

class _KuisionerPageState extends State<KuisionerPage> {
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

  Future<void> _getKuis() async {
    await _sharePrefs();
    fetchData(
      'api/kuesioner-iiq-7/view/45',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then((value) {
      print(value);
    });
  }

  @override
  void initState() {
    _getKuis();
    super.initState();
  }

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
          'Kuisioner',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 18,
                fontWeight: Config.bold,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Image.asset(
            'assets/images/kuisioner.jpg',
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Pilih Kuisioner',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18,
                      fontWeight: Config.bold,
                    ),
              ),
              Divider(
                color: Config.primaryColor,
                thickness: 2,
                height: 10,
                endIndent: 200,
              ),
            ],
          ),
          const SizedBox(height: 25),
          KuisionerCard(
            judul: 'Kondisi Gejala Awal',
            subJudul: 'UDI-6',
            ontap: () => Navigator.of(context).push(
              AniRoute(
                child: const KuisionerQuestion(),
              ),
            ),
          ),
          KuisionerCard(
            judul: 'Kualitas Hidup',
            subJudul: 'IIQ-7',
            ontap: () => Navigator.of(context).push(
              AniRoute(
                child: const KuisionerQuestion(
                  type: 2,
                ),
              ),
            ),
          ),
          Divider(
            color: Config.blackColor.withOpacity(0.5),
            thickness: 1,
            height: 40,
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
              AniRoute(
                child: const JadwalKegiatanFollowUp(),
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Config.primaryColor,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'Jadwal Kegiatan',
                    style: Config.whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: Config.bold,
                    ),
                  ),
                  Text(
                    'Follow - Up',
                    style: Config.whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: Config.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
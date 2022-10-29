import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palapa1/pages/attributes/edukasi/list_video_card.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/widgets/custom_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Edukasi extends StatefulWidget {
  const Edukasi({super.key});

  @override
  State<Edukasi> createState() => _EdukasiState();
}

class _EdukasiState extends State<Edukasi> {
  VideoPlayerController? _controllerVideo;
  ChewieController? _chewieController;
  List<String> _listVideo = <String>[
    'assets/images/palapa.mp4',
    'assets/images/palapa.mp4',
    'assets/images/palapa.mp4',
    'assets/images/palapa.mp4',
  ];
  int _selectedVideoIndex = 0;
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

  int dinamisProgress() {
    switch (_selectedVideoIndex) {
      case 0:
        return 25;
      case 1:
        return 50;
      case 2:
        return 75;
      case 3:
        return 100;
      default:
        return 0;
    }
  }

  // Future<void> _getVideosList() async {
  //   await _sharePrefs();
  //   await fetchData(
  //     'api/video-kegel/list',
  //     method: FetchDataMethod.get,
  //     tokenLabel: TokenLabel.xa,
  //     extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
  //   ).then((dynamic value) async {
  //     print('response setting');
  //     print(value);
  //     setState(() {
  //       _listVideo = <String>[
  //         value['data']['link_video_1'],
  //         value['data']['link_video_2'],
  //         value['data']['link_video_3'],
  //         value['data']['link_video_4'],
  //       ];
  //     });
  //   });
  //   loadVideo();
  // }

  Future<void> loadVideo() async {
    _controllerVideo =
        VideoPlayerController.asset(_listVideo[_selectedVideoIndex]);
    await _controllerVideo!.initialize().then((void value) {
      setState(() {});
    });
    _controllerVideo!.addListener(() {
      setState(() {});
    });
    _chewieController = ChewieController(
      videoPlayerController: _controllerVideo!,
    );

    _chewieController!.addListener(() {
      if (!_chewieController!.isFullScreen) {
        SystemChrome.setPreferredOrientations(
          <DeviceOrientation>[DeviceOrientation.portraitUp],
        );
      }
    });
  }

  @override
  void initState() {
    loadVideo();
    // _getVideosList();
    super.initState();
  }

  @override
  void dispose() {
    _controllerVideo!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'Edukasi Senam Kegel',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 18,
                fontWeight: Config.bold,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  child: _chewieController != null
                      ? Chewie(controller: _chewieController!)
                      : const SizedBox.shrink(),
                ),
                Text(
                  'Senam Kegel - ${_selectedVideoIndex + 1}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20,
                        fontWeight: Config.bold,
                      ),
                ),
                Text(
                  'Video gerakan kegel yang membantu melakukan pemanasan',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: Config.medium,
                      ),
                ),
              ],
            ),
          ),
          CustomProgressBar(progress: dinamisProgress()),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _listVideo.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 240,
              mainAxisSpacing: 10,
              crossAxisSpacing: 16,
              crossAxisCount: 2,
            ),
            itemBuilder: (_, int i) {
              return ListVideoCard(
                nomer: i + 1,
                subTitle: 'Panduan awal pemanasan senam kegel',
                onTap: () {
                  setState(() {
                    _selectedVideoIndex = i;
                    print('halo');
                    print(_selectedVideoIndex);
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/pages/attributes/edukasi/list_video_card.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';
import 'package:palapa1/widgets/custom_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

class Edukasi extends StatefulWidget {
  const Edukasi({super.key});

  @override
  State<Edukasi> createState() => _EdukasiState();
}

class _EdukasiState extends State<Edukasi> {
  VideoPlayerController? _controllerVideo;
  ChewieController? _chewieController;
  DateTime _selectedDate = DateTime.now();
  bool _loadingVideo = false;

  List<String> _listVideo = <String>[
    // 'assets/images/palapa.mp4',
    // 'assets/images/palapa.mp4',
    // 'assets/images/palapa.mp4',
    // 'assets/images/palapa.mp4',
  ];
  int _selectedVideoIndex = 0;
  bool _isCompleted = false;
  int _progressVideoIndex = 0;
  List _progressVideo = [];
  String? _token;
  int? _user_id;
  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print('isi user id ========> $_user_id');
    print(_token);
  }

  void checkVideo() {
    // Implement your calls inside these conditions' bodies :
    if (_controllerVideo!.value.position ==
        const Duration(seconds: 0, minutes: 0, hours: 0)) {
      print('video Started');
    }

    if (_controllerVideo!.value.position == _controllerVideo!.value.duration) {
      print('video Ended');
    }
  }

  dinamisProgress() {
    switch (_progressVideoIndex) {
      case 0:
        return 0;
      case 1:
        return 25;
      case 2:
        return 50;
      case 3:
        return 75;
      case 4:
        return 100;
      default:
        return 0;
    }
  }

  Future<void> _getProgressVideo() async {
    await _sharePrefs();
    setState(() {
      _isCompleted = true;
    });
    await fetchData(
      'api/video-kegel/view/$_user_id',
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then(
      (dynamic value) {
        setState(() {
          _isCompleted = false;
        });
        print('get progress $value');

        setState(() {
          _progressVideo = <String>[
            value['data']['video_1'].toString(),
            value['data']['video_2'].toString(),
            value['data']['video_3'].toString(),
            value['data']['video_4'].toString(),
          ];
        });
      },
    );
  }

  Future<void> _getVideosList() async {
    await _sharePrefs();
    await _getProgressVideo();
    if (_progressVideo[0] != 'null') {
      setState(() {
        _progressVideoIndex = 1;
      });
      if (_progressVideo[1] != 'null') {
        setState(() {
          _progressVideoIndex = 2;
        });
        if (_progressVideo[2] != 'null') {
          setState(() {
            _progressVideoIndex = 3;
          });
          if (_progressVideo[3] != 'null') {
            setState(() {
              _progressVideoIndex = 4;
            });
          }
        }
      }
    }

    await fetchData(
      'api/video-kegel/list',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then((dynamic value) async {
      print('LINK VIDEO 1 ====> ${value['data']['link_video_1']}');
      print('LINK VIDEO 2 ====> ${value['data']['link_video_2']}');

      setState(() {
        _listVideo = <String>[
          value['data']['link_video_1'],
          value['data']['link_video_2'],
          value['data']['link_video_3'],
          value['data']['link_video_4'],
        ];
      });
    });
    loadVideo();
  }

  Future<void> loadVideo() async {
    setState(() {
      _loadingVideo = true;
    });
    _controllerVideo =
        await VideoPlayerController.network(_listVideo[_selectedVideoIndex]);
    await _controllerVideo!.initialize().then((void value) {});
    _controllerVideo!.addListener(() {
      if (mounted) {
        setState(() {});
      }
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
    setState(() {
      _loadingVideo = false;
    });
  }

  @override
  void initState() {
    DateFormat('y-MM-d h : mm : 0').format(_selectedDate);

    _sharePrefs();
    loadVideo();
    _getVideosList();
    print('index progress $_progressVideoIndex');
    if (_controllerVideo != null) {
      _controllerVideo!.addListener(checkVideo);
    }
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
    List<String> _listJudul = <String>[
      getTranslated(context, 'edukasi_1') ?? '',
      getTranslated(context, 'edukasi_2') ?? '',
      getTranslated(context, 'edukasi_3') ?? '',
      getTranslated(context, 'edukasi_4') ?? '',
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
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
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          getTranslated(context, 'edukasi') ?? 'Edukasi',
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
                _loadingVideo
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Config.primaryColor,
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        child: _chewieController != null
                            ? Chewie(controller: _chewieController!)
                            : const SizedBox.shrink(),
                      ),
                Text(
                  _listJudul[_selectedVideoIndex],
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20,
                        fontWeight: Config.bold,
                      ),
                ),
                Text(
                  getTranslated(context, 'edukasi_desc') ??
                      'Educational videos to help with the Kegel exercise process',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: Config.medium,
                      ),
                ),
                SizedBox(height: 15.w),
                if (_controllerVideo != null)
                  Visibility(
                    visible: _controllerVideo!.value.position ==
                                _controllerVideo!.value.duration &&
                            _loadingVideo == false
                        ? true
                        : false,
                    child: InkWell(
                      onTap: () async {
                        if (_progressVideo[3] == 'null') {
                          if (_selectedVideoIndex == 0) {
                            log('testing post video');
                            await fetchData(
                              'api/video-kegel/post',
                              method: FetchDataMethod.post,
                              tokenLabel: TokenLabel.xa,
                              extraHeader: <String, String>{
                                'Authorization': 'Bearer ${_token}'
                              },
                              params: <String, dynamic>{
                                'user_id': _user_id,
                                'video_1': _selectedDate.toString(),
                              },
                            ).then((dynamic value) async {
                              log('testing post video');
                              log(value.toString());

                              await _getVideosList();

                              setState(() {
                                _selectedVideoIndex++;
                                loadVideo();
                              });
                            });
                          } else if (_selectedVideoIndex == 1) {
                            await fetchData(
                              'api/video-kegel/post',
                              method: FetchDataMethod.post,
                              tokenLabel: TokenLabel.xa,
                              extraHeader: <String, String>{
                                'Authorization': 'Bearer ${_token}'
                              },
                              params: <String, dynamic>{
                                'user_id': _user_id,
                                'video_2': _selectedDate.toString(),
                              },
                            ).then((dynamic value) async {
                              log('testing post video');
                              log(value.toString());

                              await _getVideosList();

                              setState(() {
                                _selectedVideoIndex++;
                                loadVideo();
                              });
                            });
                          } else if (_selectedVideoIndex == 2) {
                            await fetchData(
                              'api/video-kegel/post',
                              method: FetchDataMethod.post,
                              tokenLabel: TokenLabel.xa,
                              extraHeader: <String, String>{
                                'Authorization': 'Bearer ${_token}'
                              },
                              params: <String, dynamic>{
                                'user_id': _user_id,
                                'video_3': _selectedDate.toString(),
                              },
                            ).then((dynamic value) async {
                              log('testing post video');
                              log(value.toString());
                              await _getVideosList();

                              setState(() {
                                _selectedVideoIndex++;
                                loadVideo();
                              });
                            });
                          } else if (_selectedVideoIndex == 3) {
                            await fetchData(
                              'api/video-kegel/post',
                              method: FetchDataMethod.post,
                              tokenLabel: TokenLabel.xa,
                              extraHeader: <String, String>{
                                'Authorization': 'Bearer ${_token}'
                              },
                              params: <String, dynamic>{
                                'user_id': _user_id,
                                'video_4': _selectedDate.toString(),
                              },
                            ).then((dynamic value) async {
                              log('testing post video');
                              log(value.toString());

                              await _getVideosList();

                              setState(() {
                                _selectedVideoIndex = 0;
                              });
                            });
                          }
                        } else {
                          print(
                              'select4ed video =====> ${_selectedVideoIndex}');
                          if (_selectedVideoIndex == 3) {
                            Navigator.pop(context);
                            setState(() {
                              _selectedVideoIndex = 0;
                            });
                          } else {
                            setState(() {
                              _selectedVideoIndex++;
                              loadVideo();
                            });
                          }
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 7.h),
                        decoration: BoxDecoration(
                          color: Config.primaryColor,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Center(
                          child: Text(
                            _selectedVideoIndex == 3
                                ? getTranslated(context, 'edukasi_selesai') ?? ''
                                : getTranslated(context, 'next_video') ?? '',
                            style: Config.whiteTextStyle.copyWith(
                              fontSize: 18.sp,
                              fontWeight: Config.semiBold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          _isCompleted
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.w),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Config.primaryColor,
                    ),
                  ),
                )
              : Visibility(
                  visible: _progressVideoIndex != 4,
                  child: CustomProgressBar(
                    progress: dinamisProgress(),
                  ),
                ),
          SizedBox(height: 20.w),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _listVideo.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 180.h,
              mainAxisSpacing: 10,
              crossAxisSpacing: 16,
              crossAxisCount: 2,
            ),
            itemBuilder: (_, int i) {
              return ListVideoCard(
                title: _listJudul[i],
                subTitle: 'Panduan awal senam kegel',
              );
            },
          ),
        ],
      ),
    );
  }
}

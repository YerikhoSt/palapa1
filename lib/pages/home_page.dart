import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/berita_model.dart';
import 'package:palapa1/models/slide_show_model.dart';
import 'package:palapa1/pages/activity.dart';
import 'package:palapa1/pages/all_berita_list_page.dart';
import 'package:palapa1/pages/attributes/home_page/home_menu_card.dart';
import 'package:palapa1/pages/edukasi.dart';
import 'package:palapa1/pages/information_application.dart';
import 'package:palapa1/pages/kuisioner_page.dart';
import 'package:palapa1/pages/login.dart';
import 'package:palapa1/pages/monitoring_page.dart';
import 'package:palapa1/pages/web_view_page.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/change_prefs.dart';
import 'package:palapa1/utils/localization/localization_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/widgets/slider_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController _controllerCarousel = CarouselController();
  int _currentIndex = 0;
  bool _isLoadingSlide = false;
  bool _isLoadingNews = false;

  List<BeritaModel> _beritaValue = <BeritaModel>[];
  List<SlideShowModel> _slideShowValue = <SlideShowModel>[];

  String? _token;
  int? _user_id;

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
    print('isi token $_token');
  }

  List _menuAccess = [
    '',
    '',
    '',
    '',
  ];
  Future<void> _getDataUser() async {
    await _sharePrefs();
    await fetchData(
      'api/user/view/${_user_id}',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then(
      (dynamic value) async {
        print(value);
        await changePrefsProfile(
          <String, String>{
            'username': value['data']['username'],
            'email': value['data']['email'],
            'name': value['data']['name'],
            'tanggal_lahir': value['data']['tanggal_lahir'].toString(),
            'alamat': value['data']['alamat'],
            'no_telpon': value['data']['no_telpon'].toString(),
            'nama_pendamping': value['data']['nama_pendamping'],
            'no_telpon_pendamping':
                value['data']['no_telpon_pendamping'].toString(),
            'kota': value['data']['kota'],
            'provinsi': value['data']['provinsi'],
          },
        );
        print('response profile');
        print(value);
      },
    );
  }

  Future<void> _checkStatus() async {
    await fetchData('api/menu-pemission',
        method: FetchDataMethod.post,
        extraHeader: <String, String>{
          'Authorization': 'Bearer ${_token}'
        },
        params: {
          'user_id': _user_id,
        }).then((dynamic value) {
      if (value['data'] != null) {
        print('object $value');

        if (value['status'] == 200) {
          setState(() {
            _menuAccess = [
              value['data']['edukasi'],
              value['data']['kuesioner'],
              value['data']['aktivitas'],
              value['data']['monitoring'],
            ];
          });
        } else {
          _checkStatus();
        }
      }
    });
  }

  Future<void> _getSlide() async {
    await fetchData(
      'api/get-slideshow',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
    ).then((dynamic value) {
      setState(() {
        _isLoadingSlide = false;
      });
      print(value);
      print('testing');
      if (value['status'] == 200) {
        _slideShowValue = <SlideShowModel>[
          SlideShowModel(
            image: value['data']['slideshow_1'],
            link: value['data']['link_slideshow_1'],
          ),
          SlideShowModel(
            image: value['data']['slideshow_2'],
            link: value['data']['link_slideshow_2'],
          ),
          SlideShowModel(
            image: value['data']['slideshow_3'],
            link: value['data']['link_slideshow_3'],
          ),
        ];
      } else {
        _getSlide();
      }
    });
  }

  Future<void> _getBerita() async {
    await fetchData(
      'api/get-thumbnails',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
    ).then(
      (dynamic value) {
        if (mounted) {
          setState(() {
            _isLoadingNews = false;
          });
        }
        if (value['status'] == 200) {
          print('sukses');
          for (final dynamic i in value['data']) {
            BeritaModel bm = BeritaModel(
              thumb: i['images'],
              link: i['link'],
            );
            if (mounted) {
              setState(() {
                _beritaValue.add(bm);
              });
            }
          }
        } else {
          print('gagal');

          _getBerita();
        }
      },
    );
  }

  Future<void> _getNews() async {
    await _sharePrefs();
    setState(() {
      _isLoadingSlide = true;
    });
    _checkStatus();
    _getSlide();
    setState(() {
      _isLoadingNews = true;
    });
    _getBerita();
  }

  @override
  void initState() {
    _sharePrefs();
    _getDataUser();
    _getNews();
    _checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _checkStatus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Palapa 1',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 18,
                  fontWeight: Config.bold,
                ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  AniRoute(
                    child: const InformationApplication(),
                  ),
                );
              },
              icon: Icon(
                Icons.info_outline,
                color: Config.blackColor,
                size: 30,
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => _checkStatus(),
          color: Config.primaryColor,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _isLoadingSlide
                        ? Center(
                            child: Text(
                              'Loading data...',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: Config.bold,
                                  ),
                            ),
                          )
                        : CarouselSlider(
                            carouselController: _controllerCarousel,
                            items: List<Widget>.generate(
                              _slideShowValue.length,
                              (int index) {
                                return CachedNetworkImage(
                                  imageUrl: _slideShowValue[index].image,
                                  imageBuilder:
                                      (_, ImageProvider imageProvider) {
                                    return InkWell(
                                      onTap: () {
                                        launchUrl(
                                          Uri.parse(
                                              _slideShowValue[index].link),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4.5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget: (_, __, ___) => Container(
                                    height: MediaQuery.of(context).size.height /
                                        4.5,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Image Error',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 18.sp,
                                              fontWeight: Config.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                  placeholder: (_, __) => Container(
                                    height: MediaQuery.of(context).size.height /
                                        4.5,
                                    color: Colors.black12,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height / 4.5,
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                              onPageChanged: (int val, _) {
                                setState(() {
                                  _currentIndex = val;
                                });
                              },
                            ),
                          ),
                  ),
                  Container(
                    height: 8,
                    child: Center(
                      child: ListView.builder(
                        itemCount: _slideShowValue.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, int i) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentIndex == i ? 30 : 8,
                            height: 8,
                            margin: const EdgeInsets.only(
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              color: _currentIndex == i
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 30),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       getTranslated(context, 'berita') ?? 'berita',
              //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //             fontSize: 16.sp,
              //             fontWeight: Config.semiBold,
              //           ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         Navigator.of(context).push(
              //           AniRoute(
              //             child: AllBeritaListPage(listBerita: _beritaValue),
              //           ),
              //         );
              //       },
              //       child: Text(
              //         getTranslated(context, 'lihat_semua') ?? 'Lihat Semua',
              //         style: Config.primaryTextStyle.copyWith(
              //           fontSize: 16.sp,
              //           fontWeight: Config.semiBold,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 10),
              // _isLoadingNews
              //     ? Center(
              //         child: Text(
              //           'Memuat berita...',
              //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //                 fontSize: 18.sp,
              //                 fontWeight: Config.bold,
              //               ),
              //         ),
              //       )
              //     : CarouselSlider(
              //         carouselController: _controllerCarousel,
              //         items: List<Widget>.generate(
              //           _beritaValue.length,
              //           (int index) {
              //             return SliderCard(
              //               beritaModel: _beritaValue[index],
              //               onTap: () async {
              //                 Navigator.of(context).push(
              //                   AniRoute(
              //                     child:  WebViewPage(
              //                         url: _beritaValue[index].link),
              //                   ),
              //                 );
              //               },
              //             );
              //           },
              //         ),
              //         options: CarouselOptions(
              //           height: MediaQuery.of(context).size.height / 9,
              //           enableInfiniteScroll: false,
              //           aspectRatio: 1,
              //           initialPage: 2,
              //           viewportFraction: 0.5,
              //           enlargeCenterPage: true,
              //         ),
              //       ),
              const SizedBox(height: 30),
              Text(
                getTranslated(context, 'latihan_kegel') ?? 'Latihan Kegel',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18,
                      fontWeight: Config.bold,
                    ),
              ),
              GridView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 22,
                ),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 110.h,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 16,
                  crossAxisCount: 2,
                ),
                children: <Widget>[
                  HomeMenuCard(
                    icon: CommunityMaterialIcons.book_education_outline,
                    text: getTranslated(context, 'edukasi') ?? 'Edukasi',
                    isDisable: _menuAccess[0] == 'enabled' ? false : true,
                    onTap: () async {
                      if (_token != null) {
                        await Navigator.of(context).push(
                          AniRoute(
                            child: const Edukasi(),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Kamu Belum Login',
                                    style: Config.blackTextStyle.copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: Config.semiBold,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    'Ayo login untuk membuka semua fitur!',
                                    style: Config.blackTextStyle.copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: Config.semiBold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 15.h),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        AniRoute(
                                          child: const Login(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.sp,
                                        vertical: 7.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Config.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Text(
                                        'Login',
                                        style: Config.whiteTextStyle.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: Config.medium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  HomeMenuCard(
                    icon: CommunityMaterialIcons.chat_question_outline,
                    text: getTranslated(context, 'kuisioner') ?? 'Kuisioner',
                    isDisable: _menuAccess[1] == 'enabled' ? false : true,
                    onTap: () {
                      if (_menuAccess[1] == 'enabled') {
                        Navigator.of(context).push(
                          AniRoute(
                            child: const KuisionerPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 500),
                            backgroundColor: Config.alertColor,
                            content: const Text(
                              'Silahkan Tonton Video Edukasi Dahulu',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  HomeMenuCard(
                    icon: CommunityMaterialIcons.run,
                    text: getTranslated(context, 'aktivitas') ?? 'Aktivitas',
                    isDisable: _menuAccess[2] == 'enabled' ? false : true,
                    onTap: () {
                      if (_menuAccess[2] == 'enabled') {
                        Navigator.of(context).push(
                          AniRoute(
                            child: const Activity(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 500),
                            backgroundColor: Config.alertColor,
                            content: const Text(
                              'Silahkan Selesaikan Kuisioner Dahulu',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  HomeMenuCard(
                    icon: CommunityMaterialIcons.monitor_dashboard,
                    text: getTranslated(context, 'monitoring') ?? 'Monitoring',
                    isDisable: _menuAccess[3] == 'enabled' ? false : true,
                    onTap: () {
                      if (_menuAccess[3] == 'enabled') {
                        Navigator.of(context).push(
                          AniRoute(
                            child: const MonitoringPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 500),
                            backgroundColor: Config.alertColor,
                            content: const Text(
                              'Silahkan Selesaikan Kuisioner Dahulu',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

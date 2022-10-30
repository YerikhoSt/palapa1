import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/berita_model.dart';
import 'package:palapa1/pages/activity.dart';
import 'package:palapa1/pages/attributes/home_page/home_menu_card.dart';
import 'package:palapa1/pages/edukasi.dart';
import 'package:palapa1/pages/kuisioner_page.dart';
import 'package:palapa1/pages/monitoring_page.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/change_prefs.dart';
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
  List<bool> _listMenu = <bool>[
    false,
    false,
    false,
  ];

  List<BeritaModel> _beritaValue = <BeritaModel>[];
  List<String> _slideShowValue = <String>[];

  String? _token;
  int? _user_id;

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _user_id = prefs.getInt('user_id');
    });
  }

  Future<void> _getNews() async {
    await _sharePrefs();
    setState(() {
      _isLoadingSlide = true;
    });
    fetchData(
      'api/get-slideshow',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then((dynamic value) {
      setState(() {
        _isLoadingSlide = false;
      });
      print(value);
      print('testing');

      _slideShowValue = <String>[
        value['data']['slideshow_1'],
        value['data']['slideshow_2'],
        value['data']['slideshow_3'],
      ];
    });
    setState(() {
      _isLoadingNews = true;
    });
    fetchData(
      'api/get-thumbnails',
      method: FetchDataMethod.get,
      tokenLabel: TokenLabel.xa,
      extraHeader: <String, String>{'Authorization': 'Bearer ${_token}'},
    ).then(
      (dynamic value) {
        if (mounted) {
          setState(() {
            _isLoadingNews = false;
          });
        }

        print(value);
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
      },
    );
  }

  @override
  void initState() {
    _getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Palapa 1',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 18,
                fontWeight: Config.bold,
              ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.info_outline,
              color: Config.blackColor,
              size: 30,
            ),
          ),
        ],
      ),
      body: ListView(
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
                              imageUrl: _slideShowValue[index],
                              imageBuilder: (_, ImageProvider imageProvider) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              errorWidget: (_, __, ___) => Container(
                                height: MediaQuery.of(context).size.height / 4,
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
                                height: 200,
                                color: Colors.black12,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          },
                        ),
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height / 3.5,
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
                margin: const EdgeInsets.only(top: 15),
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
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Berita',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      fontWeight: Config.semiBold,
                    ),
              ),
              Text(
                'Lihat semua',
                style: Config.primaryTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: Config.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _isLoadingNews
              ? Center(
                  child: Text(
                    'Loading berita...',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: Config.bold,
                        ),
                  ),
                )
              : CarouselSlider(
                  carouselController: _controllerCarousel,
                  items: List<Widget>.generate(
                    _beritaValue.length,
                    (int index) {
                      return SliderCard(
                        beritaModel: _beritaValue[index],
                        onTap: () async {
                          await launchUrlString(_beritaValue[index].link);
                        },
                      );
                    },
                  ),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 9,
                    enableInfiniteScroll: false,
                    aspectRatio: 1,
                    initialPage: 2,
                    viewportFraction: 0.5,
                    enlargeCenterPage: true,
                  ),
                ),
          const SizedBox(height: 50),
          Text(
            'Latihan Kegel',
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 130,
              mainAxisSpacing: 10,
              crossAxisSpacing: 16,
              crossAxisCount: 2,
            ),
            children: <Widget>[
              HomeMenuCard(
                icon: CommunityMaterialIcons.book_education_outline,
                text: 'Edukasi',
                onTap: () async {
                  await Navigator.of(context).push(
                    AniRoute(
                      child: const Edukasi(),
                    ),
                  );
                  setState(() {
                    _listMenu[0] = true;
                  });
                },
              ),
              HomeMenuCard(
                icon: CommunityMaterialIcons.chat_question_outline,
                text: 'Kuisioner',
                isDisable: _listMenu[0] == false ? true : false,
                onTap: () {
                  if (_listMenu[0] == true) {
                    Navigator.of(context).push(
                      AniRoute(
                        child: const KuisionerPage(),
                      ),
                    );
                    setState(() {
                      _listMenu[1] = true;
                    });
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
                text: 'Aktivitas',
                isDisable: _listMenu[1] == false ? true : false,
                onTap: () {
                  if (_listMenu[1] == true) {
                    Navigator.of(context).push(
                      AniRoute(
                        child: const Activity(),
                      ),
                    );
                    setState(() {
                      _listMenu[2] = true;
                    });
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
                text: 'Monitoring',
                isDisable: _listMenu[2] == false ? true : false,
                onTap: () {
                  if (_listMenu[2] == true) {
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
    );
  }
}

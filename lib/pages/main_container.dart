import 'package:flutter/material.dart';
import 'package:palapa1/pages/home_page.dart';
import 'package:palapa1/pages/pengaturan_page.dart';
import 'package:palapa1/pages/profile_page.dart';
import 'package:palapa1/pages/tanya_kami_page.dart';
import 'package:palapa1/services/server/server.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainContainer extends StatefulWidget {
  final int index;
  const MainContainer({super.key, this.index = 0});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer>
    with TickerProviderStateMixin<MainContainer> {
  late TabController _tabController;

  String? _token;
  String? _email;

  Future<void> _sharePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _email = prefs.getString('user_email');
    });
    print(_email);
    print(_token);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
    _tabController.index = widget.index;
    _sharePrefs();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            const HomePage(),
            const TanyaKamiPage(),
            const PengaturanPage(),
            const ProfilePage(),
          ],
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            padding: const EdgeInsets.all(0),
            labelColor: Config.primaryColor,
            indicatorWeight: 0.5,
            labelPadding: const EdgeInsets.all(0),
            unselectedLabelColor: Config.blackColor,
            tabs: <Widget>[
              Tab(
                iconMargin: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.home,
                  size: 30,
                  color: _tabController.index == 0
                      ? Config.primaryColor
                      : Config.blackColor,
                ),
                text: 'Home',
              ),
              GestureDetector(
                onTap: () async {
                  await fetchData(
                    'api/live-chat/create-anonym',
                    method: FetchDataMethod.post,
                    tokenLabel: TokenLabel.xa,
                    extraHeader: <String, String>{
                      'Authorization': 'Bearer ${_token}'
                    },
                    params: <String, dynamic>{
                      'email': _email,
                    },
                  ).then(
                    (dynamic value) async {
                      print(value);
                      await Navigator.of(context).push(
                        AniRoute(
                          child: const TanyaKamiPage(),
                        ),
                      );
                    },
                  );
                },
                child: Tab(
                  iconMargin: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.headset_outlined,
                    size: 30,
                    color: _tabController.index == 1
                        ? Config.primaryColor
                        : Config.blackColor,
                  ),
                  text: 'Tanya Kami',
                ),
              ),
              Tab(
                iconMargin: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.settings,
                  size: 30,
                  color: _tabController.index == 2
                      ? Config.primaryColor
                      : Config.blackColor,
                ),
                text: 'Pengaturan',
              ),
              Tab(
                iconMargin: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.person_sharp,
                  size: 30,
                  color: _tabController.index == 3
                      ? Config.primaryColor
                      : Config.blackColor,
                ),
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

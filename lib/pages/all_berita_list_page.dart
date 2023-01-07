import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/berita_model.dart';
import 'package:palapa1/pages/web_view_page.dart';
import 'package:palapa1/utils/animation.dart';
import 'package:palapa1/utils/config.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AllBeritaListPage extends StatefulWidget {
  final List<BeritaModel> listBerita;
  const AllBeritaListPage({super.key, required this.listBerita});

  @override
  State<AllBeritaListPage> createState() => _AllBeritaListPageState();
}

class _AllBeritaListPageState extends State<AllBeritaListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Config.whiteColor,
          ),
        ),
        title: Text(
          'Berita',
          style: Config.whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: Config.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.listBerita.length,
        padding: EdgeInsets.symmetric(vertical: 25.w, horizontal: 20.w),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                AniRoute(
                  child: WebViewPage(url: widget.listBerita[index].link),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150.w,
              margin: EdgeInsets.only(bottom: 20.w),
              decoration: BoxDecoration(
                color: Config.whiteColor,
                borderRadius: BorderRadius.circular(10.w),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Config.blackColor.withOpacity(0.2),
                    blurRadius: 7,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl: widget.listBerita[index].thumb,
                imageBuilder: (_, ImageProvider imageProvider) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
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
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
              ),
            ),
          );
        },
      ),
    );
  }
}

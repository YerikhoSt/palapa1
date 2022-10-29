import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palapa1/models/berita_model.dart';
import 'package:palapa1/utils/config.dart';

class SliderCard extends StatelessWidget {
  final BeritaModel beritaModel;
  final void Function()? onTap;
  const SliderCard({Key? key, required this.beritaModel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: beritaModel.thumb,
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
    );
  }
}

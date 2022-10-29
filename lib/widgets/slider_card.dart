import 'package:flutter/material.dart';
import 'package:palapa1/models/berita_model.dart';

class SliderCard extends StatelessWidget {
  final BeritaModel beritaModel;
  final void Function()? onTap;
  const SliderCard({Key? key, required this.beritaModel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(beritaModel.thumb),
          ),
        ),
      ),
    );
  }
}

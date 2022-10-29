import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:palapa1/widgets/slider_card.dart';

class HomePageSlider extends StatefulWidget {
  const HomePageSlider({Key? key}) : super(key: key);

  @override
  State<HomePageSlider> createState() => _HomePageSliderState();
}

class _HomePageSliderState extends State<HomePageSlider> {
  CarouselController _controllerCarousel = CarouselController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FetchDataMethod { get, post, put, delete }

enum Environment { production, development }

enum TokenLabel { none, xa, tokenId }

class Config {
  Config();

  static FontWeight light = FontWeight.w100;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight verryBold = FontWeight.w900;

  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color alertColor = const Color(0xffED6363);
  static Color primaryColor = Colors.deepPurple.shade400;
  static Color backgroundColor = const Color(0xfff8f8f8);

  static String defaultFont = 'Poppins';

  static TextStyle primaryTextStyle = GoogleFonts.poppins(
    color: primaryColor,
    decoration: TextDecoration.none,
  );

  static TextStyle blackTextStyle = GoogleFonts.poppins(
    color: blackColor,
    decoration: TextDecoration.none,
  );

  static TextStyle whiteTextStyle = GoogleFonts.poppins(
    color: whiteColor,
    decoration: TextDecoration.none,
  );

  static MaterialColor colorPurplePrimary = const MaterialColor(
    0xffbe03fc,
    <int, Color>{
      50: Color(0xffbe03fc),
      100: Color(0xffbe03fc),
      200: Color(0xffbe03fc),
      300: Color(0xffbe03fc),
      400: Color(0xffbe03fc),
      500: Color(0xffbe03fc),
      600: Color(0xffbe03fc),
      700: Color(0xffbe03fc),
      800: Color(0xffbe03fc),
      900: Color(0xffbe03fc),
    },
  );

  static MaterialColor colorWhitePrimary = const MaterialColor(
    0xFFf7faff,
    <int, Color>{
      50: Color(0xFFf7faff),
      100: Color(0xFFf7faff),
      200: Color(0xFFf7faff),
      300: Color(0xFFf7faff),
      400: Color(0xFFf7faff),
      500: Color(0xFFf7faff),
      600: Color(0xFFf7faff),
      700: Color(0xFFf7faff),
      800: Color(0xFFf7faff),
      900: Color(0xFFf7faff),
    },
  );

  static MaterialColor colorBlackPrimary = const MaterialColor(
    0xFF535557,
    <int, Color>{
      50: Color(0xFF535557),
      100: Color(0xFF535557),
      200: Color(0xFF535557),
      300: Color(0xFF535557),
      400: Color(0xFF535557),
      500: Color(0xFF535557),
      600: Color(0xFF535557),
      700: Color(0xFF535557),
      800: Color(0xFF535557),
      900: Color(0xFF535557),
    },
  );

  static Environment env = Environment.production;

  static String domain =
      env == Environment.production ? 'https://palapa1.hugi.my.id/' : '';
}

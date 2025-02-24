import 'package:flutter/material.dart';

abstract class Styles {

  static const Color black = Color(0xFF101010);
  static const Color grey1 = Color(0xFFA4A4A4);
  static const Color grey2 = Color(0xFFF5F5F5);
  static const Color grey3 = Color(0xFFF8F8F8);
  static const Color grey4 = Color(0xFFD5D5D5);

  static ThemeData mainThemeData() {
    return ThemeData(
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: Colors.white,
      ),
      // backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Styles.blackMaterial,
      primaryColor: Colors.green,
      fontFamily: "Roboto",
      useMaterial3: false,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent
      ),
      textTheme: TextTheme(
        displayLarge:   TextStyle(color: Colors.black, ),
        displayMedium:  TextStyle(color: Colors.black, ),
        displaySmall:   TextStyle(color: Colors.black, ),
        headlineLarge:  TextStyle(color: Colors.black, fontWeight: FontWeight.w700, ),
        headlineMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, ),
        headlineSmall:  TextStyle(color: Colors.black, fontWeight: FontWeight.w700, ),
        titleLarge:     TextStyle(color: Colors.black, fontSize: 24, ),
        titleMedium:    TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18, ),
        titleSmall:     TextStyle(color: Colors.black, ),
        bodyLarge:      TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17,),
        bodyMedium:     TextStyle(color: Colors.black, ),
        bodySmall:      TextStyle(color: Colors.black, ),
        labelLarge:     TextStyle(color: Colors.black, ),
        labelMedium:    TextStyle(color: Colors.black, ),
        labelSmall:     TextStyle(color: Colors.black, ),
      ),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
    );
  }

  static const MaterialColor blackMaterial = MaterialColor(0xFF161616, {
    50: Color.fromRGBO(22, 22, 22, .1),
    100: Color.fromRGBO(22, 22, 22, .2),
    200: Color.fromRGBO(22, 22, 22, .3),
    300: Color.fromRGBO(22, 22, 22, .4),
    400: Color.fromRGBO(22, 22, 22, .5),
    500: Color.fromRGBO(22, 22, 22, .6),
    600: Color.fromRGBO(22, 22, 22, .7),
    700: Color.fromRGBO(22, 22, 22, .8),
    800: Color.fromRGBO(22, 22, 22, .9),
    900: Color.fromRGBO(22, 22, 22, 1),
  });

  static List<BoxShadow> defaultShadow = [
    BoxShadow(
      color: Colors.grey[300]!,
      blurRadius: 8.0,
      spreadRadius: 0.0,
      offset: Offset(
        0.0, 0.0,
      ),
    ),
  ];

}
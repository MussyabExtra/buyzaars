import 'package:flutter/material.dart';

class AppColor {
  static const Color primarycolor = Color(0xFF4F4A93);
  static const Color secondaryColor = Color(0xFFFEEFEF);
  static const Color red = Color(0xFF8572FC);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color brown = Color(0xFF665230);
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF140200),
      Color(0xFF4F4A93),
    ],
  );
  static LinearGradient WhitebackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 129, 117, 207),
      Color.fromARGB(255, 206, 183, 183),
    ],
    stops: [
      0.01,
      1.0,
    ],
  );
}

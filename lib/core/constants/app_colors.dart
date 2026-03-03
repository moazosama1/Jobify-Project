import 'package:flutter/material.dart';

abstract class AppColors {
  static MaterialColor white = const MaterialColor(0xFFF9F9F9, <int, Color>{
    10: Color(0xFFfefefe),
    20: Color(0xFFfdfdfd),
    30: Color(0xFFfcfcfc),
    40: Color(0xFFfbfbfb),
    50: Color(0xFFfafafa),
    60: Color(0xFFd0d0d0),
    70: Color(0xFFa6a6a6),
    80: Color(0xFF7d7d7d),
    90: Color(0xFF535353),
    100: Color(0xFF323232),
  });

  static MaterialColor mainColor = const MaterialColor(0xFF286AFF, <int, Color>{
    10: Color(0xFFE0E9FF),
    20: Color(0xFFB3C6FF),
    30: Color(0xFF809EFF),
    40: Color(0xFF4D75FF),
    50: Color(0xFF286AFF), // base color
    60: Color(0xFF1F55CC),
    70: Color(0xFF174099),
    80: Color(0xFF0F2B66),
    90: Color(0xFF081633),
    100: Color(0xFF040B1A),
  });

  static MaterialColor black = const MaterialColor(0xFF0C1015, <int, Color>{
    10: Color(0xFFcecfd0),
    20: Color(0xFFAEAFB1),
    30: Color(0xFF86888a),
    40: Color(0xFF5d6063),
    50: Color(0xFF34383c),
    60: Color(0xFF0a0d12),
    70: Color(0xFF080b0e),
    80: Color(0xFF06080b),
    90: Color(0xFF040507),
    100: Color(0xFF020304),
  });

  static const Color gray = Color(0xFF535353);
  static const Color red = Color(0xffCC1010);
  static const Color green = Color(0xFF0CB359);
  static const Color lightPink = Color(0xFFF9ECF0);
  static const Color yellow = Color(0xFFC8D444);
  static const Color splashBackground = Color(0xFF7D66FF);
  static const Color brandLight = Color(0xFFE8F5E9);
  static const Color brandDefault = Color(0xFF4CAF50);
}

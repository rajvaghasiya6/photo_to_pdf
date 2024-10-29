import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color kPrimaryColor = const Color(0xFFFF223F);
  static Color scaffoldColor = const Color.fromARGB(255, 246, 246, 246);

  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color blackColor = const Color(0xFF000000);
  static Color greyColor = const Color.fromARGB(255, 118, 118, 118);

  static List<Color> gradientColor = [
    const Color(0xFFFF223F),
    const Color(0xFFFF565F)
  ];

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color kPrimaryColor = const Color(0xFF007C6E);
  static Color kBackgroundColor = const Color(0xFF242B2A);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

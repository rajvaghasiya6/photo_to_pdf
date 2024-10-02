import 'package:flutter/material.dart';
import 'package:imagetopdf/utils/app_colors.dart';

class AppStyle {
  static boldStyle(
          {double? fz,
          Color? color,
          TextDecoration? textDecoration,
          FontWeight? fontWeight,
          double? letterSpacing,
          String? fontFamily,
          double? height}) =>
      TextStyle(
        color: color ?? AppColors.blackColor,
        fontSize: fz ?? 14,
        fontWeight: fontWeight,
        decoration: textDecoration,
        height: height,
        fontFamily: 'Poppins-Bold',
        letterSpacing: letterSpacing,
      );

  static mediumStyle(
          {double? fz,
          Color? color,
          TextDecoration? textDecoration,
          FontWeight? fontWeight,
          double? letterSpacing,
          String? fontFamily,
          double? height}) =>
      TextStyle(
        color: color ?? AppColors.blackColor,
        fontSize: fz ?? 14,
        fontWeight: fontWeight,
        decoration: textDecoration,
        height: height,
        fontFamily: 'Poppins-Medium',
        letterSpacing: letterSpacing,
      );

  static normalStyle(
          {double? fz,
          Color? color,
          TextDecoration? textDecoration,
          FontWeight? fontWeight,
          double? letterSpacing,
          String? fontFamily,
          double? height}) =>
      TextStyle(
        color: color ?? AppColors.blackColor,
        fontSize: fz ?? 14,
        decoration: textDecoration,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        fontFamily: 'Poppins-Regular',
        height: height,
      );
}

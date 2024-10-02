import 'package:flutter/material.dart';
import 'package:imagetopdf/utils/app_colors.dart';

class AppTheme {
  static String fontFamilyName = 'Poppins-Regular';

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    fontFamily: fontFamilyName,
    colorScheme: ColorScheme.light(
      primary: AppColors.kPrimaryColor,
    ),
    iconTheme: IconThemeData(
      color: AppColors.whiteColor,
    ),
    disabledColor: AppColors.kPrimaryColor.withOpacity(0.5),
  );
}

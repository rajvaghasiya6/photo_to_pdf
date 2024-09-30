import 'package:flutter/material.dart';
import 'package:imagetopdf/utils/app_colors.dart';

class AppTheme {
  static String fontFamilyName = 'Montserrat';

  static ThemeData darkMode({Color? kPrimaryColor, Color? kBackgroundColor, Color? errorColor, String? fontFamily}) {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      useMaterial3: true,
      primaryColor: kPrimaryColor,
      visualDensity: VisualDensity.comfortable,
      scaffoldBackgroundColor: AppColors.kBackgroundColor,
      shadowColor: const Color(0x8F000000),
      indicatorColor: kPrimaryColor,
      splashColor: kPrimaryColor?.withOpacity(0.2),
      hoverColor: kPrimaryColor?.withOpacity(0.1),
      splashFactory: InkRipple.splashFactory,
      canvasColor: const Color(0xFF1E1E1E),
      disabledColor: const Color(0xFFCCCCCC),
      textTheme: buildTextTheme(base: base.textTheme, myFontFamily: fontFamily),
      primaryTextTheme: buildTextTheme(base: base.primaryTextTheme, myFontFamily: fontFamily),
      androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      colorScheme: const ColorScheme.dark().copyWith(
        error: errorColor,
        primary: kPrimaryColor,
        background: kBackgroundColor,
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        centerTitle: true,
      ),
      popupMenuTheme: const PopupMenuThemeData(color: Color(0xFF303642)),
      tooltipTheme: TooltipThemeData(
        textStyle: TextStyle(color: const IconThemeData().color),
        decoration: BoxDecoration(
          color: const Color(0xFF181818),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kPrimaryColor ?? const Color(0xFF000000), width: 0.4),
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kPrimaryColor,
        foregroundColor: base.iconTheme.color,
      ),
    );
  }

  static TextTheme buildTextTheme({required TextTheme base, String? myFontFamily}) {
    return base.copyWith(
      bodyLarge: TextStyle(fontSize: 16.0, letterSpacing: 0.5, fontWeight: FontWeight.w400, color: base.bodyLarge!.color, fontFamily: myFontFamily),
      bodyMedium: TextStyle(fontSize: 14.0, letterSpacing: 0.25, fontWeight: FontWeight.w400, color: base.bodyMedium!.color, fontFamily: myFontFamily),
      displayLarge: TextStyle(fontSize: 96.0, letterSpacing: -1.5, fontWeight: FontWeight.w300, color: base.displayLarge!.color, fontFamily: myFontFamily),
      displayMedium: TextStyle(fontSize: 60.0, letterSpacing: -0.5, fontWeight: FontWeight.w300, color: base.displayMedium!.color, fontFamily: myFontFamily),
      displaySmall: TextStyle(fontSize: 48.0, letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.displaySmall!.color, fontFamily: myFontFamily),
      headlineMedium: TextStyle(fontSize: 34.0, letterSpacing: 0.25, fontWeight: FontWeight.w400, color: base.headlineMedium!.color, fontFamily: myFontFamily),
      headlineSmall: TextStyle(fontSize: 24.0, letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.headlineSmall!.color, fontFamily: myFontFamily),
      titleLarge: TextStyle(fontSize: 20.0, letterSpacing: 0.15, fontWeight: FontWeight.w500, color: base.titleLarge!.color, fontFamily: myFontFamily),
      titleMedium: TextStyle(fontSize: 16.0, letterSpacing: 0.15, fontWeight: FontWeight.w400, color: base.titleMedium!.color, fontFamily: myFontFamily),
      titleSmall: TextStyle(fontSize: 14.0, letterSpacing: 0.1, fontWeight: FontWeight.w500, color: base.titleSmall!.color, fontFamily: myFontFamily),
      bodySmall: TextStyle(fontSize: 12.0, letterSpacing: 0.4, fontWeight: FontWeight.w400, color: base.bodySmall!.color, fontFamily: myFontFamily),
      labelSmall: TextStyle(fontSize: 10.0, letterSpacing: 1.5, fontWeight: FontWeight.w400, color: base.labelSmall!.color, fontFamily: myFontFamily),
      labelLarge: TextStyle(fontSize: 14.0, letterSpacing: 1.25, fontWeight: FontWeight.w400, color: base.labelLarge!.color, fontFamily: myFontFamily),
    );
  }
}

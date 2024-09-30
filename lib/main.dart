import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/route/app_pages.dart';
import 'package:imagetopdf/route/app_routes.dart';
import 'package:imagetopdf/utils/app_colors.dart';
import 'package:imagetopdf/utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Photo To PDF",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkMode(
        kPrimaryColor: AppColors.kPrimaryColor,
        fontFamily: 'Montserrat',
      ),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.homeScreen,
    );
  }
}

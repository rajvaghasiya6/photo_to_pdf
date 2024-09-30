import 'package:get/get.dart';
import 'package:imagetopdf/views/home/home_screen.dart';
import 'package:imagetopdf/views/image_view/image_view_screen.dart';
import 'package:imagetopdf/views/layout/layout_screen.dart';
import 'package:imagetopdf/views/pdf_view/pdf_view_screen.dart';
import 'package:imagetopdf/views/save_view/save_view_screen.dart';

import '../views/home_pdf_view/home_pdf_view_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    // GetPage(
    //   name: AppRoutes.splashScreen,
    //   page: () => SplashScreen(),
    // ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.layoutScreen,
      page: () => LayoutScreen(),
    ),
    GetPage(
      name: AppRoutes.pdfViewScreen,
      page: () => PdfViewScreen(),
    ),
    GetPage(
      name: AppRoutes.imageViewScreen,
      page: () => ImageViewScreen(),
    ),
    GetPage(
      name: AppRoutes.homePdfViewScreen,
      page: () => HomePdfViewScreen(),
    ),
    GetPage(
      name: AppRoutes.saveViewScreen,
      page: () => SaveViewScreen(),
    ),
  ];
}

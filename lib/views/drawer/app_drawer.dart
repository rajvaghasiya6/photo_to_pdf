import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/utils/global.dart';
import 'package:imagetopdf/widget/webview.dart';

import '../../utils/app_colors.dart';
import '../home/home_controller.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});
  final HomeController con = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Get.height * .32,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/svg/ic_launcher-playstore.png',
                    height: Get.width / 3.5,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.kBackgroundColor,
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.share,
                      color: AppColors.kPrimaryColor,
                    ),
                    title: const Text(
                      'Share App',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      con.closeDrawer();
                      con.shareApp(
                        Platform.isAndroid ? "https://play.google.com/store/apps/details?id=com.micrasol.imagetopdfstudio" : "https://apps.apple.com/us/app/photo-to-pdf-studio/id6461312058",
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: AppColors.kPrimaryColor,
                    ),
                    title: const Text(
                      'About Us',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () async {
                      con.closeDrawer();
                      if (await getConnectivityResult()) {
                        Get.to(
                          () => const MyWebView(
                            title: "About Us",
                            webURL: "https://www.micrasolution.com/about-us/",
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

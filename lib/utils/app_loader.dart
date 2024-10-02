import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/utils/app_colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Scaffold(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(.2),
            body: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitSpinningLines(
                      size: 60,
                      color: AppColors.kPrimaryColor.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CircularLoader extends StatelessWidget {
  final Color? color;
  final double? size;

  const CircularLoader({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitSpinningLines(
        size: size ?? 30,
        color: AppColors.kPrimaryColor.withOpacity(0.8),
      ),
    );
  }
}

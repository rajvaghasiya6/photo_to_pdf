import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.2),
            body: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white.withOpacity(.5)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 18),
                    Text(
                      "Loading...",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    )
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
  final double? width;

  const CircularLoader({super.key, this.color, this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: Get.width * (width ?? 0.05),
          height: Get.width * (width ?? 0.05),
          child: getLoader(color, context),
        ),
      ),
    );
  }

  getLoader(Color? color, BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(color: color ?? Colors.black);
    } else {
      return CircularProgressIndicator(color: color ?? Colors.black, strokeWidth: 3);
    }
  }
}

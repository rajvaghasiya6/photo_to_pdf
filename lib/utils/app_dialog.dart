import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/route/app_routes.dart';
import 'package:imagetopdf/utils/app_assets.dart';

class AppDialogs {
  static discardDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                    margin: const EdgeInsets.symmetric(vertical: 8).copyWith(top: 0),
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      AppAssets.deleteDoc,
                      color: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      "Are you sure want to discard?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 46,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(.2),
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10)),
                            ),
                            child: const Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                            Get.offAllNamed(AppRoutes.homeScreen);
                          },
                          child: Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Center(
                              child: Text(
                                "Discard",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

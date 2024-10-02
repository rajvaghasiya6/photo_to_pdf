import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/route/app_routes.dart';
import 'package:imagetopdf/utils/app_assets.dart';
import 'package:imagetopdf/utils/app_button.dart';

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
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                    margin: const EdgeInsets.symmetric(vertical: 8)
                        .copyWith(top: 0),
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
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                          width: 100,
                          height: 38,
                          fontSize: 12,
                          borderRadius: BorderRadius.circular(5),
                          title: "Cancel",
                          buttonType: ButtonType.outline,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        AppButton(
                          width: 100,
                          height: 38,
                          fontSize: 12,
                          title: "Confirm",
                          borderRadius: BorderRadius.circular(5),
                          buttonType: ButtonType.gradient,
                          onPressed: () {
                            Navigator.pop(context);
                            Get.offAllNamed(AppRoutes.homeScreen);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

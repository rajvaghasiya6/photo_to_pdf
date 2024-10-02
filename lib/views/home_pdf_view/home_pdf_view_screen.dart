import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/utils/app_button.dart';
import 'package:imagetopdf/utils/app_style.dart';
import 'package:imagetopdf/utils/global.dart';
import 'package:imagetopdf/utils/sizedbox.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../utils/app_colors.dart';
import 'home_pdf_view_controller.dart';

class HomePdfViewScreen extends StatelessWidget {
  HomePdfViewScreen({super.key});
  final HomePdfViewController con = Get.put(HomePdfViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          title: Text(
            con.fileName.value,
            style: AppStyle.mediumStyle(fz: 18),
          ),
          foregroundColor: AppColors.kPrimaryColor,
          actions: [
            IconButton(
                onPressed: () async {
                  await Share.shareXFiles([XFile(con.path.value)]);
                },
                icon: const Icon(Icons.share))
          ],
        ),
        body: Obx(() => SfPdfViewer.file(
              File(con.path.value),
              onDocumentLoadFailed: (details) {
                if (details.description.contains('password')) {
                  if (details.description.contains('password') &&
                      con.hasPasswordDialog.value) {
                    toast('Invalid password');
                    Get.back();
                    con.formKey.currentState?.validate();
                    con.passwordController.value.clear();
                  } else {
                    passwordDialog(context);
                    con.passwordDialogFocusNode.requestFocus();
                    con.hasPasswordDialog.value = true;
                  }
                }
              },
              canShowPasswordDialog: false,
              password: con.password.value,
              controller: con.pdfController,
            )));
  }

  passwordDialog(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);
              Get.back();
              return true;
            },
            child: Dialog(
              surfaceTintColor: AppColors.whiteColor.withOpacity(.1),
              backgroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enter Password',
                      style: AppStyle.mediumStyle(fz: 16),
                    ),
                    hSizedBox30,
                    passwordTextFormField(),
                    hSizedBox30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                            Get.back();
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        AppButton(
                          width: 100,
                          height: 38,
                          fontSize: 12,
                          borderRadius: BorderRadius.circular(5),
                          title: "Confirm",
                          buttonType: ButtonType.gradient,
                          onPressed: () {
                            if (con.passwordController.value.text.isNotEmpty) {
                              con.password.value =
                                  con.passwordController.value.text;
                              Navigator.pop(context);
                            } else {
                              FocusScope.of(context).unfocus();

                              toast('Enter password');
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  passwordTextFormField() {
    return TextFormField(
      autofocus: true,
      controller: con.passwordController.value,
      style: AppStyle.normalStyle(fz: 16),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "*********",
          hintStyle: AppStyle.normalStyle(color: AppColors.greyColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.kPrimaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.kPrimaryColor)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.kPrimaryColor)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          fillColor: Colors.white,
          filled: true),
    );
  }
}

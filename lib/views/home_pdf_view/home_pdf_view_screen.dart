import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/utils/global.dart';
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
        backgroundColor: const Color.fromARGB(255, 235, 233, 233),
        appBar: AppBar(
          title: Text(con.fileName.value),
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
                  if (details.description.contains('password') && con.hasPasswordDialog.value) {
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
              Get.back();
              Get.back();
              return true;
            },
            child: Dialog(
              surfaceTintColor: AppColors.kBackgroundColor.withOpacity(.1),
              backgroundColor: AppColors.kBackgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Enter Password',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    passwordTextFormField(),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "Confirm",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          onTap: () {
                            if (con.passwordController.value.text.isNotEmpty) {
                              con.password.value = con.passwordController.value.text;
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
      decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          fillColor: Colors.black,
          filled: true),
    );
  }
}

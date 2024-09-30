import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/route/app_routes.dart';
import 'package:imagetopdf/utils/app_assets.dart';
import 'package:imagetopdf/utils/app_loader.dart';
import 'package:imagetopdf/utils/global.dart';
import 'package:imagetopdf/utils/pdfviews.dart';
import 'package:imagetopdf/views/image_view/image_view_controller.dart';
import 'package:imagetopdf/views/layout/layout_controller.dart';
import 'package:imagetopdf/utils/app_dialog.dart';
import 'package:printing/printing.dart';

import '../../utils/app_colors.dart';
import 'pdf_view_controller.dart';

class PdfViewScreen extends StatelessWidget {
  PdfViewScreen({super.key});
  final PdfViewController con = Get.put(PdfViewController());
  final ImageViewController imageCon = Get.find<ImageViewController>();
  final LayoutController layoutCon = Get.find<LayoutController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppDialogs.discardDialog(context);
        return false;
      },
      child: Stack(
        children: [
          SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: InkWell(
                  onTap: () async {
                    await fileNameDialog(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: const Color.fromARGB(255, 48, 55, 55)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            con.pdfName.isEmpty ? 'File name' : con.pdfName.value,
                            style: TextStyle(
                                fontSize: 16,
                                color: con.pdfName.isEmpty ? const Color.fromARGB(255, 162, 162, 162) : Colors.white),
                          ),
                        ),
                        const Icon(
                          Icons.edit,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: InkWell(
                      onTap: () async {
                        con.pdfName.value.isNotEmpty ? await con.saveAsFile(context) : await fileNameDialog(context);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              body: Obx(() => Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: PdfPreview(
                          previewPageMargin: const EdgeInsets.only(bottom: 15),
                          allowPrinting: false,
                          canChangeOrientation: false,
                          canChangePageFormat: false,
                          canDebug: false,
                          allowSharing: false,
                          shouldRepaint: true,
                          pdfPreviewPageDecoration: const BoxDecoration(color: Colors.white),
                          loadingWidget: const CircularLoader(),
                          build: (format) async {
                            var pdf = await PdfService().createPDF(type: con.type.value, images: con.selectedImage);
                            con.pdfData = await pdf.save();
                            return con.pdfData!;
                          },
                        ),
                      ),
                      if (con.isPassword.value == true)
                        const Positioned(
                          right: 10,
                          top: 5,
                          child: Icon(Icons.lock),
                        )
                    ],
                  )),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          layoutCon.fromPdfView = true;
                          Get.toNamed(
                            AppRoutes.layoutScreen,
                            arguments: {
                              "fromPdfView": true,
                              "selectedImage": con.selectedImage,
                              'type': con.type.value,
                            },
                          );
                        },
                        child: Container(
                          height: 35,
                          width: 40,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            color: Colors.white,
                            AppAssets.frame,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          imageCon.isNav.value = false;
                          Get.toNamed(
                            AppRoutes.imageViewScreen,
                          );
                        },
                        child: Container(
                          height: 35,
                          width: 40,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            AppAssets.appSort,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await passwordDialog(context);
                        },
                        child: Container(
                          height: 35,
                          width: 40,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            AppAssets.docLock,
                            color: Colors.white,
                            height: 25,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          con.pdfName.value.isNotEmpty ? await con.shareAsFile(context) : await fileNameDialog(context);
                        },
                        child: Container(
                          height: 35,
                          width: 40,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            color: Colors.white,
                            AppAssets.share,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(() => con.isLoading.value ? const AppLoader() : const SizedBox())
        ],
      ),
    );
  }

  nameTextFormField() {
    return TextFormField(
      autofocus: true,
      controller: con.nameController.value,
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

  fileNameDialog(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            surfaceTintColor: AppColors.kBackgroundColor.withOpacity(.1),
            backgroundColor: AppColors.kBackgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'File Name',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  nameTextFormField(),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
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
                            "Rename",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          con.pdfName.value = con.nameController.value.text;
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  passwordTextFormField() {
    return Obx(() => TextFormField(
          autofocus: true,
          obscureText: true,
          controller: con.passwordController.value,
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              fillColor: Colors.black,
              filled: true),
        ));
  }

  passwordDialog(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          con.passwordController.value.text = con.pdfPassword.value;
          return Dialog(
            surfaceTintColor: AppColors.kBackgroundColor.withOpacity(.1),
            backgroundColor: AppColors.kBackgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Set Password',
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
                          onTap: () => Navigator.pop(context),
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
                          if (con.passwordController.value.text.trim().length >= 5 ||
                              con.passwordController.value.text.trim().isEmpty) {
                            con.pdfPassword.value = con.passwordController.value.text;
                            if (con.pdfPassword.value != '') {
                              con.isPassword.value = true;
                            } else {
                              con.isPassword.value = false;
                            }
                            Navigator.pop(context);
                          } else {
                            FocusScope.of(context).unfocus();
                            toast("Enter Valid Password");
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

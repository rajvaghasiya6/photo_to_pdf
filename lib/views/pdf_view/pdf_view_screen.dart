import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/route/app_routes.dart';
import 'package:imagetopdf/utils/app_assets.dart';
import 'package:imagetopdf/utils/app_button.dart';
import 'package:imagetopdf/utils/app_dialog.dart';
import 'package:imagetopdf/utils/app_loader.dart';
import 'package:imagetopdf/utils/app_style.dart';
import 'package:imagetopdf/utils/global.dart';
import 'package:imagetopdf/utils/pdfviews.dart';
import 'package:imagetopdf/utils/sizedbox.dart';
import 'package:imagetopdf/views/image_view/image_view_controller.dart';
import 'package:imagetopdf/views/layout/layout_controller.dart';
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
          Scaffold(
            appBar: AppBar(
              foregroundColor: AppColors.kPrimaryColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(5),
                  child: Container(
                    height: 0.5,
                    color: AppColors.kPrimaryColor,
                  )),
              title: InkWell(
                onTap: () async {
                  await fileNameDialog(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(
                        color: AppColors.kPrimaryColor.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          con.pdfName.isEmpty ? 'File Name' : con.pdfName.value,
                          style: AppStyle.normalStyle(
                              fz: 14,
                              color: con.pdfName.isEmpty
                                  ? AppColors.greyColor
                                  : AppColors.blackColor),
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        color: AppColors.kPrimaryColor,
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
                      con.pdfName.value.isNotEmpty
                          ? await con.saveAsFile(context)
                          : await fileNameDialog(context);
                    },
                    child: Text(
                      'Save',
                      style: AppStyle.mediumStyle(
                          fz: 16, color: AppColors.kPrimaryColor),
                    ),
                  ),
                )
              ],
            ),
            body: Obx(() => Stack(
                  children: [
                    PdfPreview(
                      previewPageMargin:
                          const EdgeInsets.only(top: 10, bottom: 10),
                      allowPrinting: false,
                      canChangeOrientation: false,
                      canChangePageFormat: false,
                      canDebug: false,
                      allowSharing: false,
                      shouldRepaint: true,
                      scrollViewDecoration: BoxDecoration(
                          color: AppColors.greyColor.withOpacity(0.1)),
                      pdfPreviewPageDecoration:
                          const BoxDecoration(color: Colors.white),
                      loadingWidget: const CircularLoader(size: 50),
                      build: (format) async {
                        var pdf = await PdfService().createPDF(
                            type: con.type.value, images: con.selectedImage);
                        con.pdfData = await pdf.save();
                        return con.pdfData!;
                      },
                    ),
                    if (con.isPassword.value == true)
                      const Positioned(
                        right: 10,
                        top: 5,
                        child: Icon(Icons.lock),
                      )
                  ],
                )),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border:
                      Border(top: BorderSide(color: AppColors.kPrimaryColor))),
              padding: const EdgeInsets.symmetric(vertical: 20)
                  .copyWith(bottom: MediaQuery.of(context).padding.bottom + 10),
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
                      width: 35,
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        color: AppColors.kPrimaryColor,
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
                      width: 35,
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        AppAssets.appSort,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await passwordDialog(context);
                    },
                    child: Container(
                      width: 35,
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        AppAssets.docLock,
                        color: AppColors.kPrimaryColor,
                        height: 25,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      con.pdfName.value.isNotEmpty
                          ? await con.shareAsFile(context)
                          : await fileNameDialog(context);
                    },
                    child: Container(
                      width: 35,
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        color: AppColors.kPrimaryColor,
                        AppAssets.share,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => con.isLoading.value ? const AppLoader() : const SizedBox())
        ],
      ),
    );
  }

  nameTextFormField() {
    return Obx(() => TextFormField(
          autofocus: true,
          controller: con.nameController.value,
          style: AppStyle.normalStyle(fz: 16),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Name",
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
        ));
  }

  fileNameDialog(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            surfaceTintColor: AppColors.whiteColor.withOpacity(.1),
            backgroundColor: AppColors.whiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'File Name',
                    style: AppStyle.mediumStyle(fz: 16),
                  ),
                  hSizedBox30,
                  nameTextFormField(),
                  hSizedBox30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppButton(
                        width: 100,
                        borderRadius: BorderRadius.circular(5),
                        height: 38,
                        fontSize: 12,
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
                        borderRadius: BorderRadius.circular(5),
                        title: "Rename",
                        buttonType: ButtonType.gradient,
                        onPressed: () {
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
        ));
  }

  passwordDialog(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            surfaceTintColor: AppColors.whiteColor.withOpacity(.1),
            backgroundColor: AppColors.whiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Set Password',
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
                          if (con.passwordController.value.text.trim().length >=
                                  5 ||
                              con.passwordController.value.text
                                  .trim()
                                  .isEmpty) {
                            con.pdfPassword.value =
                                con.passwordController.value.text;
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

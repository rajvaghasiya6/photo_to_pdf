import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/route/app_routes.dart';
import 'package:imagetopdf/utils/app_assets.dart';
import 'package:imagetopdf/utils/app_button.dart';
import 'package:imagetopdf/utils/app_loader.dart';
import 'package:imagetopdf/utils/app_style.dart';
import 'package:imagetopdf/utils/sizedbox.dart';
import 'package:imagetopdf/views/image_view/image_view_controller.dart';
import 'package:imagetopdf/views/layout/layout_controller.dart';
import 'package:imagetopdf/views/pdf_view/pdf_view_controller.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../utils/app_colors.dart';

class ImageViewScreen extends StatelessWidget {
  ImageViewScreen({super.key});

  final ImageViewController controller = Get.put(ImageViewController());
  final PdfViewController viewCon = Get.put(PdfViewController());
  final LayoutController layoutCon = Get.put(LayoutController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (!controller.isNav.value) {
            viewCon.selectedImage.value = controller.tempImageFileList;

            viewCon.type.value = layoutCon.selectedType.value;

            Get.offNamedUntil(
              AppRoutes.pdfViewScreen,
              (route) => true,
            );
          }
          return true;
        },
        child: Stack(children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                "Select Photos",
                style:
                    AppStyle.boldStyle(fz: 20, color: AppColors.kPrimaryColor),
              ),
              elevation: 0,
              scrolledUnderElevation: 0,
              foregroundColor: AppColors.kPrimaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Obx(
                () => controller.tempImageFileList.isEmpty &&
                        !controller.isLoading.value
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssets.emptyPhoto,
                              height: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('No photos found')
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(children: [
                          ReorderableGridView.builder(
                            dragStartDelay: Duration.zero,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.tempImageFileList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) => Stack(
                                key: ValueKey(index),
                                clipBehavior: Clip.none,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                          height: 140,
                                          width: 120,
                                          padding: const EdgeInsets.all(8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: AppColors.greyColor,
                                                )),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                File(controller
                                                    .tempImageFileList[index]
                                                    .path
                                                    .toString()),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )),
                                      Container(
                                          width: 16,
                                          height: 16,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppColors.kPrimaryColor
                                                  .withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                          child: Text(
                                            (index + 1).toString(),
                                            style: AppStyle.mediumStyle(
                                                fz: 10,
                                                color: AppColors.whiteColor),
                                          ))
                                    ],
                                  ),
                                  Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                          onTap: () => controller
                                              .tempImageFileList
                                              .removeAt(index),
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                border: Border.all(
                                                  color: AppColors.kPrimaryColor
                                                      .withOpacity(0.8),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Icon(
                                              Icons.clear,
                                              size: 13,
                                              color: AppColors.kPrimaryColor
                                                  .withOpacity(0.8),
                                            ),
                                          ))),
                                ]),
                            dragWidgetBuilder: (index, child) => Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.kPrimaryColor
                                          .withOpacity(0.5),
                                      width: 2),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(controller
                                        .tempImageFileList[index].path
                                        .toString()),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            onReorder: (oldIndex, newIndex) {
                              final element = controller.tempImageFileList
                                  .removeAt(oldIndex);
                              controller.tempImageFileList
                                  .insert(newIndex, element);
                            },
                          )
                        ])),
              ),
            ),
            floatingActionButton: Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: AppColors.gradientColor,
                ),
              ),
              child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  heroTag: "btn2",
                  elevation: 0,
                  onPressed: () {
                    selectionTypeDialog(context);
                  },
                  child: const Icon(Icons.add)),
            ),
            bottomNavigationBar:
                Obx(() => controller.tempImageFileList.isNotEmpty
                    ? SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: AppButton(
                            buttonType: ButtonType.gradient,
                            title:
                                controller.isNav.value ? "Continue" : "Go Back",
                            onPressed: () {
                              controller.imageFileList.value =
                                  controller.tempImageFileList;

                              if (controller.isNav.value) {
                                Get.toNamed(AppRoutes.layoutScreen, arguments: {
                                  "fromPdfView": false,
                                  'type': controller.selectedType,
                                  "selectedImage": controller.tempImageFileList,
                                });
                              } else {
                                viewCon.selectedImage.value =
                                    controller.tempImageFileList;
                                viewCon.type.value =
                                    layoutCon.selectedType.value;
                                Get.offNamedUntil(
                                  AppRoutes.pdfViewScreen,
                                  (route) => true,
                                );
                              }
                            },
                          ),
                        ),
                      )
                    : const SizedBox()),
          ),
          Obx(() =>
              controller.isLoading.value ? const AppLoader() : const SizedBox())
        ]));
  }

  selectionTypeDialog(context) {
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
                    'Select Photo Source',
                    style: AppStyle.mediumStyle(fz: 16),
                  ),
                  hSizedBox30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          controller.selectFromCamera();
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.kPrimaryColor)),
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.camera,
                                color: AppColors.kPrimaryColor,
                                size: 40,
                              ),
                            ),
                            hSizedBox6,
                            Text(
                              "Camera",
                              style: AppStyle.mediumStyle(
                                  fz: 13, color: AppColors.kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                      wSizedBox40,
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          controller.selectMultiImage();
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.kPrimaryColor)),
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.photo,
                                color: AppColors.kPrimaryColor,
                                size: 40,
                              ),
                            ),
                            hSizedBox6,
                            Text(
                              "Gallery",
                              style: AppStyle.mediumStyle(
                                  fz: 13, color: AppColors.kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

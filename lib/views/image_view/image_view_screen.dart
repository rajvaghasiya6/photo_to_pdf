import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/route/app_routes.dart';
import 'package:imagetopdf/utils/app_assets.dart';
import 'package:imagetopdf/utils/app_button.dart';
import 'package:imagetopdf/utils/app_loader.dart';
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
              title: const Text(
                "IMAGES",
                style: TextStyle(letterSpacing: 1),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Obx(
                () => controller.tempImageFileList.isEmpty && !controller.isLoading.value
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
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.tempImageFileList.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) =>
                                Stack(key: ValueKey(index), clipBehavior: Clip.none, children: [
                              Container(
                                  height: 140,
                                  width: 120,
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey, width: 2)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        File(controller.tempImageFileList[index].path.toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: GestureDetector(
                                    onTap: () => controller.tempImageFileList.removeAt(index),
                                    child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: AppColors.kPrimaryColor,
                                        child: const Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Icon(
                                            Icons.clear,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                        ))),
                              )
                            ]),
                            dragWidgetBuilder: (index, child) => Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey, width: 2)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(controller.tempImageFileList[index].path.toString()),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            onReorder: (oldIndex, newIndex) {
                              final element = controller.tempImageFileList.removeAt(oldIndex);
                              controller.tempImageFileList.insert(newIndex, element);
                            },
                          )
                        ])),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {
                  controller.selectMultiImage();
                },
                child: const Icon(Icons.add)),
            bottomNavigationBar: Obx(() => controller.tempImageFileList.isNotEmpty
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: AppButton(
                        title: controller.isNav.value ? "Continue" : "Go Back",
                        onPressed: () {
                          controller.imageFileList.value = controller.tempImageFileList;

                          if (controller.isNav.value) {
                            Get.toNamed(AppRoutes.layoutScreen, arguments: {
                              "fromPdfView": false,
                              'type': controller.selectedType,
                              "selectedImage": controller.tempImageFileList,
                            });
                          } else {
                            viewCon.selectedImage.value = controller.tempImageFileList;
                            viewCon.type.value = layoutCon.selectedType.value;
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
          Obx(() => controller.isLoading.value ? const AppLoader() : const SizedBox())
        ]));
  }
}

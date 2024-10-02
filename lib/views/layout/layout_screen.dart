import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/route/app_routes.dart';
import 'package:imagetopdf/utils/app_colors.dart';
import 'package:imagetopdf/utils/app_style.dart';
import 'package:imagetopdf/views/image_view/image_view_controller.dart';
import 'package:imagetopdf/views/pdf_view/pdf_view_controller.dart';

import 'layout_controller.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});

  final LayoutController con = Get.find<LayoutController>();
  final PdfViewController viewCon = Get.find<PdfViewController>();
  final ImageViewController imageCon = Get.find<ImageViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frames',
            style: AppStyle.boldStyle(fz: 20, color: AppColors.kPrimaryColor)),
        foregroundColor: AppColors.kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: con.layoutName1.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 180,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) => Column(
                        children: [
                          layout1(
                              layoutName: con.layoutName1[index],
                              index: con.index1[index],
                              context: context)
                        ],
                      )),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: con.layoutName2.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 180,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) => Column(
                        children: [
                          layout2(
                              layoutName: con.layoutName2[index],
                              index: con.index2[index],
                              context: context),
                        ],
                      )),
            ],
          ),
        ),
      ),
    );
  }

  layout1({String? layoutName, int? index, required BuildContext context}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            con.selectedType.value = layoutName ?? '';
            if (con.fromPdfView) {
              viewCon.type.value = con.selectedType.value;
              imageCon.selectedType.value = con.selectedType.value;
              viewCon.selectedImage.value = imageCon.tempImageFileList;
              Get.offNamedUntil(
                AppRoutes.pdfViewScreen,
                (route) => true,
              );
            } else {
              viewCon.type.value = con.selectedType.value;
              imageCon.selectedType.value = con.selectedType.value;
              viewCon.selectedImage.value = imageCon.tempImageFileList;

              Get.toNamed(
                AppRoutes.pdfViewScreen,
              );
            }
          },
          child: index == 0
              ? Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 150,
                      width: Get.width,
                    ),
                  ],
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 150,
                  width: Get.width,
                  child: FractionallySizedBox(
                    heightFactor: index == 2 ? 0.8 : .9,
                    widthFactor: index == 2 ? 0.78 : .85,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: (index! >= 3 && index != 4) ? 3 : 0,
                            color: Colors.black,
                          ),
                          Container(
                            width: index >= 4 ? 3 : 0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(layoutName ?? "")
      ],
    );
  }

  layout2({String? layoutName, int? index, required BuildContext context}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            con.selectedType.value = layoutName ?? '';
            if (con.fromPdfView) {
              viewCon.type.value = con.selectedType.value;
              imageCon.selectedType.value = con.selectedType.value;
              viewCon.selectedImage.value = imageCon.tempImageFileList;
              Get.offNamedUntil(
                AppRoutes.pdfViewScreen,
                (route) => true,
              );
            } else {
              viewCon.type.value = con.selectedType.value;
              imageCon.selectedType.value = con.selectedType.value;
              viewCon.selectedImage.value = imageCon.tempImageFileList;
              Get.toNamed(
                AppRoutes.pdfViewScreen,
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 150,
            width: Get.width,
            child: FractionallySizedBox(
              heightFactor: .9,
              widthFactor: .85,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    (index! >= 6 && index != 7)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 3,
                                color: Colors.black,
                              ),
                              Container(
                                width: 3,
                                color: Colors.black,
                              ),
                            ],
                          )
                        : Container(
                            width: 3,
                            color: Colors.black,
                          ),
                    index >= 7
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 3,
                                color: Colors.black,
                              ),
                              Container(
                                height: 3,
                                color: Colors.black,
                              ),
                            ],
                          )
                        : Container(
                            height: 3,
                            color: Colors.black,
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(layoutName ?? "")
      ],
    );
  }

  none({String? layoutName, required BuildContext context}) {
    GestureDetector(
        onTap: () {
          con.selectedType.value = layoutName ?? '';
          if (con.fromPdfView) {
            viewCon.type.value = con.selectedType.value;
            imageCon.selectedType.value = con.selectedType.value;
            viewCon.selectedImage.value = imageCon.tempImageFileList;
            Get.offNamedUntil(
              AppRoutes.pdfViewScreen,
              (route) => true,
            );
          } else {
            viewCon.type.value = con.selectedType.value;
            imageCon.selectedType.value = con.selectedType.value;
            viewCon.selectedImage.value = imageCon.tempImageFileList;
            Get.toNamed(
              AppRoutes.pdfViewScreen,
            );
          }
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 150,
              width: Get.width,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(layoutName ?? "")
          ],
        ));
  }
}

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
      backgroundColor: const Color(0xFFE5E5E5),
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
                  itemCount: con.layoutName.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 200,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) => Column(
                        children: [
                          layout(
                              layoutName: con.layoutName[index],
                              index: index,
                              context: context)
                        ],
                      )),
            ],
          ),
        ),
      ),
    );
  }

  layout(
      {String? layoutName, required int index, required BuildContext context}) {
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
          child: Image.asset(
            "assets/images/layout${index + 1}.png",
            width: 100,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(layoutName ?? "")
      ],
    );
  }
}

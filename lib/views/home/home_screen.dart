import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/route/app_routes.dart';
import 'package:imagetopdf/utils/app_assets.dart';
import 'package:imagetopdf/utils/app_button.dart';
import 'package:imagetopdf/widget/pdf_thumbnail.dart';
import 'package:imagetopdf/views/drawer/app_drawer.dart';
import 'package:imagetopdf/views/home/home_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: con.scaffoldKey,
        appBar: AppBar(
          title: const Text(
            "PDF Studio",
            style: TextStyle(letterSpacing: 1.5),
          ),
        ),
        drawer: AppDrawer(),
        body: Scaffold(
          body: Obx(
            () => con.pdfModelList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.emptyPdf,
                          height: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('No pdf found')
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: con.pdfModelList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: .7),
                    itemBuilder: (context, index) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.homePdfViewScreen, arguments: [con.pdfModelList[index].path, con.pdfModelList[index].name]);
                              },
                              child: PdfThumbnail.fromFile(con.pdfModelList[index].path.toString(),
                                  currentPage: 1,
                                  backgroundColor: Colors.transparent,
                                  loadingIndicator: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.grey.shade200,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        decoration: BoxDecoration(color: AppColors.kBackgroundColor, borderRadius: BorderRadius.circular(5)),
                                      ),
                                    ),
                                  ),
                                  currentPageDecoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey, width: 1), color: Colors.white)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              con.pdfModelList[index].name.toString().split('.').first,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        )),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: AppButton(
              onPressed: () => Get.toNamed(AppRoutes.imageViewScreen, arguments: {
                'isNav': true,
              }),
              title: "Create new PDF",
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/route/app_routes.dart';
import 'package:imagetopdf/utils/app_assets.dart';
import 'package:imagetopdf/utils/app_button.dart';
import 'package:imagetopdf/utils/app_colors.dart';
import 'package:imagetopdf/utils/app_loader.dart';
import 'package:imagetopdf/utils/app_style.dart';
import 'package:imagetopdf/utils/sizedbox.dart';
import 'package:imagetopdf/utils/utils.dart';
import 'package:imagetopdf/views/home/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: con.scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Photo to PDF",
            style: AppStyle.boldStyle(fz: 20, color: AppColors.kPrimaryColor),
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
          foregroundColor: AppColors.kPrimaryColor,
        ),
        // drawer: AppDrawer(),
        body: Scaffold(
          body: Obx(
            () => con.isLoading.value
                ? const CircularLoader(
                    size: 50,
                  )
                : con.pdfModelList.isEmpty
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
                            const Text('No PDF Document Found')
                          ],
                        ),
                      )
                    : Obx(() => ListView.separated(
                          padding: const EdgeInsets.all(16).copyWith(top: 0),
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: con.pdfModelList.length,
                          separatorBuilder: (context, index) {
                            DateTime todayDate =
                                DateUtils.dateOnly(DateTime.now());
                            DateTime yesterdayDate = DateUtils.dateOnly(
                                DateTime.now()
                                    .subtract(const Duration(days: 1)));

                            DateTime? currentDate = DateUtils.dateOnly(
                                DateTime.parse(
                                    con.pdfModelList[index].date.toString()));

                            DateTime? nextDate = (index == 0)
                                ? null
                                : DateUtils.dateOnly(DateTime.parse(con
                                    .pdfModelList[index + 1].date
                                    .toString()));

                            if (nextDate != null) {
                              if (nextDate.compareTo(currentDate) < 0) {
                                return Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.greyColor.withOpacity(0.1),
                                    ),
                                    child: Text(
                                      todayDate.compareTo(nextDate) == 0
                                          ? "Today"
                                          : nextDate.compareTo(yesterdayDate) ==
                                                  0
                                              ? "Yesterday"
                                              : DateFormat('dd MMMM yyyy')
                                                  .format(DateTime.parse(
                                                      nextDate.toString())),
                                      style: AppStyle.normalStyle(
                                          fz: 10, letterSpacing: 1),
                                    ),
                                  ),
                                );
                              } else {
                                return hSizedBox10;
                              }
                            } else {
                              return hSizedBox10;
                            }
                          },
                          itemBuilder: (context, index) {
                            DateTime todayDate =
                                DateUtils.dateOnly(DateTime.now());
                            DateTime yesterdayDate = DateUtils.dateOnly(
                                DateTime.now()
                                    .subtract(const Duration(days: 1)));

                            // Reverse index logic for descending order
                            DateTime? nextDate = DateUtils.dateOnly(
                                DateTime.parse(
                                    con.pdfModelList[index].date.toString()));

                            return Column(
                              children: [
                                if (index ==
                                    0) // Check if it's the first element (in reversed list)
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: BoxDecoration(
                                        color: AppColors.greyColor
                                            .withOpacity(0.1),
                                      ),
                                      child: Text(
                                        todayDate.compareTo(nextDate) == 0
                                            ? "Today"
                                            : nextDate.compareTo(
                                                        yesterdayDate) ==
                                                    0
                                                ? "Yesterday"
                                                : DateFormat('dd MMMM yyyy')
                                                    .format(DateTime.parse(
                                                        nextDate.toString())),
                                        style: AppStyle.normalStyle(
                                            fz: 10, letterSpacing: 1),
                                      ),
                                    ),
                                  ),
                                pdfListTile(index),
                              ],
                            );
                          },
                        )),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: AppButton(
              buttonType: ButtonType.gradient,
              onPressed: () =>
                  Get.toNamed(AppRoutes.imageViewScreen, arguments: {
                'isNav': true,
              }),
              title: "Create new PDF",
            ),
          ),
        ));
  }

  GestureDetector pdfListTile(int index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.homePdfViewScreen, arguments: [
          con.pdfModelList[index].path,
          con.pdfModelList[index].name
        ]);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Image.asset(
              AppAssets.pdfIcon,
              height: 60,
              width: 40,
            ),
            wSizedBox10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    con.pdfModelList[index].name
                            .toString()
                            .split('.')
                            .first
                            .capitalizeFirst ??
                        '',
                    style: AppStyle.normalStyle(fz: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy hh:mm a')
                            .format(con.pdfModelList[index].date),
                        style: AppStyle.normalStyle(
                            fz: 10, color: AppColors.greyColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      wSizedBox10,
                      Text(
                        formatBytes(con.pdfModelList[index].size, 2),
                        style: AppStyle.normalStyle(
                            fz: 10, color: AppColors.greyColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            ),
            wSizedBox10,
            if (con.pdfModelList[index].isProtected) ...[
              wSizedBox10,
              Image.asset(
                AppAssets.lock2,
                height: 18,
              ),
            ],
            CustomPopup(
              contentRadius: 5,
              content: SizedBox(
                width: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                        Get.toNamed(AppRoutes.homePdfViewScreen, arguments: [
                          con.pdfModelList[index].path,
                          con.pdfModelList[index].name
                        ]);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Icon(
                              Icons.output_rounded,
                              color: AppColors.kPrimaryColor,
                              size: 20,
                            ),
                            wSizedBox8,
                            Text(
                              'Open',
                              style: AppStyle.normalStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    hSizedBox4,
                    Divider(
                      color: AppColors.greyColor.withOpacity(0.2),
                    ),
                    hSizedBox4,
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                        await Share.shareXFiles(
                            [XFile(con.pdfModelList[index].path)]);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Icon(
                              Icons.share,
                              color: AppColors.kPrimaryColor,
                              size: 20,
                            ),
                            wSizedBox8,
                            Text(
                              'Share',
                              style: AppStyle.normalStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8).copyWith(right: 0),
                  child: Icon(
                    Icons.more_vert,
                    color: AppColors.greyColor,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

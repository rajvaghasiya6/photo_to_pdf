import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/route/app_routes.dart';
import 'package:imagetopdf/utils/app_button.dart';
import 'package:imagetopdf/utils/app_colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../widget/pdf_thumbnail.dart';
import 'save_view_controller.dart';

class SaveViewScreen extends StatelessWidget {
  SaveViewScreen({super.key});
  final SaveViewController con = Get.put(SaveViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Get.offAllNamed(AppRoutes.homeScreen),
              icon: const Icon(
                Icons.home,
                size: 28,
              ))
        ],
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(
            height: 50,
          ),
          const SizedBox(
            height: 80,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 2.8),
                child: PdfThumbnail.fromFile(con.path.toString(),
                    currentPage: 0,
                    backgroundColor: Colors.transparent,
                    loadingIndicator: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          decoration:
                              BoxDecoration(color: AppColors.kBackgroundColor, borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ),
                    currentPageDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Colors.white)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                con.fileName.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.kPrimaryColor,
                      child: const Icon(
                        Icons.done,
                        size: 15,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Saved successfully!',
                    style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(
            onPressed: () async {
              await Share.shareXFiles([XFile(con.path.value)]);
            },
            title: 'Share',
          ),
        ),
      ),
    );
  }
}

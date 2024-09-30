import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<PdfModel> pdfModelList = <PdfModel>[].obs;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  Future<void> launchUrlFunction(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  shareApp(String url) async {
    if (url != '') {
      await Share.shareWithResult(
        "Empower Your Document Transformation with Photo to PDF Studio: Your Ultimate Image-to-PDF Solution.\nCheck out here:- $url",
      );
    }
  }

  void getFiles() async {
    isLoading.value = true;
    if (Platform.isIOS) {
      var dir = await getApplicationDocumentsDirectory();
      if (await Directory(dir.path).exists()) {
        await Directory(dir.path).list().every((element) {
          if (element.path.split('/').last.split('.').last == 'pdf') {
            pdfModelList.add(PdfModel(path: element.path, name: element.path.split('/').last));
          }
          return true;
        });
      }
    } else {
      var dir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      if (await Directory('$dir/PhotoToPdfStudio/').exists()) {
        await Directory('$dir/PhotoToPdfStudio/').list().every((element) {
          if (element.path.split('/').last.split('.').last == 'pdf') {
            pdfModelList.add(PdfModel(path: element.path, name: element.path.split('/').last));
          }

          return true;
        });
      }
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getFiles();
  }
}

class PdfModel {
  String? path;
  String? name;
  PdfModel({this.name, this.path});
}

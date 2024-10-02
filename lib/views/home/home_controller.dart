import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_protected_pdf_checker/password_protected_pdf_checker.dart';
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
      await Share.share(
        "Empower Your Document Transformation with Photo to PDF Studio: Your Ultimate Image-to-PDF Solution.\nCheck out here:- $url",
      );
    }
  }

  void getFiles() async {
    isLoading.value = true;
    if (Platform.isIOS) {
      var dir = await getApplicationDocumentsDirectory();
      if (await Directory(dir.path).exists()) {
        await Directory(dir.path).list().forEach((element) async {
          if (element.path.split('/').last.split('.').last == 'pdf') {
            final file = File(element.path);

            // Get file metadata (date and size)
            final fileStat = await file.stat();
            final fileSize = await file.length(); // File size in bytes
            final lastModified = fileStat.modified; // Last modified date

            // Check if PDF is password protected
            bool isProtected = await PasswordProtectedPdfChecker()
                .isPDFPasswordProtected(file.readAsBytesSync());

            // Add to the list with path, name, date, and size
            pdfModelList.add(PdfModel(
                path: element.path,
                name: element.path.split('/').last,
                date: lastModified,
                size: fileSize,
                isProtected: isProtected));
          }
        });
      }
    } else {
      var dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      if (await Directory('$dir/PhotoToPdf/').exists()) {
        await Directory('$dir/PhotoToPdf/').list().forEach((element) async {
          if (element.path.split('/').last.split('.').last == 'pdf') {
            final file = File(element.path);

            // Get file metadata (date and size)
            final fileStat = await file.stat();
            final fileSize = await file.length(); // File size in bytes
            final lastModified = fileStat.modified; // Last modified date

            // Check if PDF is password protected
            bool isProtected = await PasswordProtectedPdfChecker()
                .isPDFPasswordProtected(file.readAsBytesSync());

            // Add to the list with path, name, date, and size
            pdfModelList.add(PdfModel(
                path: element.path,
                name: element.path.split('/').last,
                date: lastModified,
                size: fileSize,
                isProtected: isProtected));
          }
        });
      }
    }
    // Sort the pdfModelList by date in ascending order
    await Future.delayed(const Duration(milliseconds: 500));
    pdfModelList.sort((a, b) => b.date.compareTo(a.date));
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getFiles();
  }
}

class PdfModel {
  final String path;
  final String name;
  final DateTime date;
  final int size;
  bool isProtected;

  PdfModel({
    required this.path,
    required this.name,
    required this.date,
    required this.size,
    required this.isProtected,
  });
}

import 'dart:async';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/utils/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart' as pdfx;
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../route/app_routes.dart';

class PdfViewController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  pdfx.PdfController? pdfController;
  RxString type = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isPassword = false.obs;

  RxString pdfName = ''.obs;
  RxString pdfPassword = ''.obs;

  RxList<XFile> selectedImage = <XFile>[].obs;
  var pdfData;
  Future<void> saveAsFile(BuildContext context) async {
    String appDocPath = '';
    try {
      isLoading.value = true;
      if (isPassword.isTrue) {
        try {
          PdfDocument document = PdfDocument(inputBytes: pdfData);
          PdfSecurity security = document.security;
          security.algorithm = PdfEncryptionAlgorithm.rc4x128Bit;
          security.userPassword = pdfPassword.value;
          await document.save().then((value) async {
            if (Platform.isIOS) {
              var directory = await getApplicationDocumentsDirectory();
              appDocPath = directory.path;
            } else {
              var dir = await ExternalPath.getExternalStoragePublicDirectory(
                  ExternalPath.DIRECTORY_DOWNLOADS);
              var appDoc = await Directory('$dir/PhotoToPdf').create();
              appDocPath = appDoc.path;
            }

            final file = File('$appDocPath/${nameController.value.text}.pdf');
            isLoading.value = false;
            file.writeAsBytes(value).then((v) {
              toast("PDF downloaded successfully");
              Get.toNamed(AppRoutes.saveViewScreen, arguments: [
                '$appDocPath/${nameController.value.text}.pdf',
                nameController.value.text
              ]);
            });
          });
          document.dispose();
        } catch (e) {
          toast("Invalid Password");
        }
      } else {
        if (Platform.isIOS) {
          var directory = await getApplicationDocumentsDirectory();
          appDocPath = directory.path;
        } else {
          var dir = await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DOWNLOADS);
          var appDoc = await Directory('$dir/PhotoToPdf').create();
          appDocPath = appDoc.path;
        }

        final file = File('$appDocPath/${nameController.value.text}.pdf');
        isLoading.value = false;
        file.writeAsBytes(pdfData).then((value) {
          toast("PDF downloaded successfully");
          Get.toNamed(AppRoutes.saveViewScreen, arguments: [
            '$appDocPath/${nameController.value.text}.pdf',
            nameController.value.text
          ]);
        });
      }
    } catch (e) {
      toast(e.toString());
      isLoading.value = false;
    }
  }

  Future<void> shareAsFile(BuildContext context) async {
    String appDocPath = '';
    try {
      isLoading.value = true;
      if (isPassword.isTrue) {
        try {
          PdfDocument document = PdfDocument(inputBytes: pdfData);
          PdfSecurity security = document.security;
          security.algorithm = PdfEncryptionAlgorithm.rc4x128Bit;

          security.userPassword = pdfPassword.value;
          await document.save().then((value) async {
            var directory = await getTemporaryDirectory();
            appDocPath = directory.path;

            final file = File('$appDocPath/${nameController.value.text}.pdf');

            file.writeAsBytes(value).then((v) async {
              await Share.shareXFiles([XFile(file.path)]);
              isLoading.value = false;
            });
          });
          document.dispose();
        } catch (e) {
          toast("Invalid Password");
        }
      } else {
        var directory = await getTemporaryDirectory();
        appDocPath = directory.path;

        final file = File('$appDocPath/${nameController.value.text}.pdf');

        file.writeAsBytes(pdfData!).then((value) async {
          await Share.shareXFiles([XFile(file.path)]);
          isLoading.value = false;
        });
      }
    } catch (e) {
      toast("Something Went Wrong");
      isLoading.value = false;
    }
  }
}

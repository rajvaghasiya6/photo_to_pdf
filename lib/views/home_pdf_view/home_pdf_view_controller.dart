import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HomePdfViewController extends GetxController {
  final GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();
  final FocusNode passwordDialogFocusNode = FocusNode();
RxBool hasPasswordDialog=false.obs;
  PdfViewerController? pdfController;
  RxString password = ''.obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  RxString path = ''.obs;
  RxString fileName = ''.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      path.value = Get.arguments[0];
      fileName.value = Get.arguments[1];
      pdfController = PdfViewerController();
    }
  }
}

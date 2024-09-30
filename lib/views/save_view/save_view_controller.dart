import 'package:get/get.dart';

class SaveViewController extends GetxController {
  RxString path = ''.obs;
  RxString fileName = ''.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      path.value = Get.arguments[0];
      fileName.value = Get.arguments[1];
    }
  }
}

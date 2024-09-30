import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageViewController extends GetxController {
  List movedList = [];
  List contentList = [];
  RxString filePath = ''.obs;
  RxString selectedType = 'None'.obs;
  RxBool isNav = false.obs;
  final ImagePicker imagePicker = ImagePicker();
  RxList<XFile> tempImageFileList = <XFile>[].obs;
  RxList<XFile> imageFileList = <XFile>[].obs;
  RxList imageFil = [].obs;
  RxBool isLoading = false.obs;
  selectMultiImage() async {
    Future.delayed(const Duration(milliseconds: 100)).then((value) => isLoading.value = true);
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      tempImageFileList.addAll((selectedImages));
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isNav.value = Get.arguments['isNav'];
    }
  }
}

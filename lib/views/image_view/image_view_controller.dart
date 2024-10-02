import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagetopdf/utils/app_colors.dart';

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
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => isLoading.value = true);
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      tempImageFileList.addAll((selectedImages));
    }
    isLoading.value = false;
  }

  selectFromCamera() async {
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => isLoading.value = true);
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: selectedImage.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.kPrimaryColor,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: AppColors.kPrimaryColor,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
            ],
          ),
        ],
      );
      if (croppedFile != null) {
        tempImageFileList.add(XFile(croppedFile.path));
      }
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

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LayoutController extends GetxController {
  RxList layoutName1 = [
    'None',
    'Normal',
    'Narrow',
    '2x1',
    '1x2',
    '2x2',
  ].obs;

  // RxBool isLoading = false.obs;
  RxList layoutName2 = ['2x3', '3x2', '3x3'].obs;
  RxList index1 = [0, 1, 2, 3, 4, 5].obs;
  RxList index2 = [
    6,
    7,
    8,
  ].obs;
  RxString selectedType = 'None'.obs;
  final imageFileList = <XFile>[].obs;
  bool fromPdfView = false;
}

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LayoutController extends GetxController {
  RxList layoutName = [
    'None',
    'Normal',
    'Narrow',
    '2x1',
    '1x2',
    '2x2',
    '2x3',
    '3x2',
    '3x3'
  ].obs;

  RxString selectedType = 'None'.obs;
  final imageFileList = <XFile>[].obs;
  bool fromPdfView = false;
}

import 'dart:math';

bool isValEmpty(dynamic val) {
  String? value = val.toString();
  return (val == null ||
      value.isEmpty ||
      value == "null" ||
      value == "" ||
      value == "NULL" ||
      value == "{}");
}

String formatBytes(int bytes, int decimals) {
  if (bytes == 0) return "0 B";

  const List<String> sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
  int i = (log(bytes) / log(1024)).floor();
  double convertedSize = bytes / pow(1024, i);

  return '${convertedSize.toStringAsFixed(decimals)} ${sizes[i]}';
}

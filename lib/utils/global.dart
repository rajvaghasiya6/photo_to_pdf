import 'package:fluttertoast/fluttertoast.dart';

Future toast(message) async {
  FToast fToast = FToast();
  fToast.removeQueuedCustomToasts();
  fToast.removeCustomToast();
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontSize: 16.0,
  );
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
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

ConnectivityResult? connectivityResult;
final Connectivity connectivity = Connectivity();
Future<bool> getConnectivityResult() async {
  try {
    connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      toast("No Internet Available");
      return false;
    }
  } on PlatformException {
    toast("No Internet Available");
    return false;
  }
}

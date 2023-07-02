import 'package:connectivity_plus/connectivity_plus.dart';

class Utility{

  static String getEmptyIfNull(String str) {
  if (str == null || str.trim().toLowerCase() == "null" || str.trim().isEmpty) {
    return "";
  }
  return str;
}


static Future<bool> isNetworkConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;

}

}
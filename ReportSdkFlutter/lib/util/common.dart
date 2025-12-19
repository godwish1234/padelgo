import 'package:connectivity/connectivity.dart';

import '../flutter_datac.dart';
import 'const.dart';

class Common{
  static void reportError(String name, String key) {
    if (DataC.getInstance().isDebug) {
      throw Exception("your report " + name + " class is wrong with KEY " + key + " (correct key is among with ${Const.DATA_KEY}1-32)");
    } else {
      print(Const.LOG_TAG +
          "\t" +
          "your report " +
          name +
          " class is wrong with KEY " +
          key +
          " (correct key is among with ${Const.DATA_KEY}1-32)");
    }
  }

  static Future<String> getNet() async {
    String _net;
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      _net = "4g";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      _net = "wifi";
    } else {
      _net = "";
    }
    return _net;
  }

  static Future<bool> hasNet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static bool isDebug(){
    return !const bool.fromEnvironment('dart.vm.product');
  }
}
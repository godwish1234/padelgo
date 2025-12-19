import 'package:shared_preferences/shared_preferences.dart';

import 'const.dart';

class DataCPreferenceHelper {

  static const String _KEY_LAST_UPLOAD_TIME = "datac_key_last_upload_time";
  static const String _KEY_MAX_FILE_SIZE = "datac_key_max_file_size";
  static const String _KEY_MAX_DURING_TIME = "datac_key_max_during_time";
  static const String _KEY_TOKEN = "datac_key_token";
  static const String _KEY_LAST_AUTO_UPLOAD_TIME = "datac_key_last_auto_upload_time";
  static const String _KEY_PROXY = "datac_key_proxy";

  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_KEY_TOKEN, token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_KEY_TOKEN) ?? "";
  }

  static setLastUploadTime(int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_KEY_LAST_UPLOAD_TIME, time);
  }

  static Future<int> getLastUploadTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_KEY_LAST_UPLOAD_TIME) ?? 0;
  }

  static setMaxFileSize(int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_KEY_MAX_FILE_SIZE, time);
  }

  static Future<int> getMaxFileSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_KEY_MAX_FILE_SIZE) ?? Const.DEFAULT_MAX_FILE_SIZE;
  }

  static setMaxDuringTime(int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_KEY_MAX_DURING_TIME, time);
  }

  static Future<int> getMaxDuringTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_KEY_MAX_DURING_TIME) ?? Const.DEFAULT_MAX_DURING_TIME;
  }

  static setLastAutoUploadTime(int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_KEY_LAST_AUTO_UPLOAD_TIME, time);
  }

  static Future<int> getLastAutoUploadTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_KEY_LAST_AUTO_UPLOAD_TIME) ?? 0;
  }

  static setProxy(String proxy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_KEY_PROXY, proxy);
  }

  static Future<String> getProxy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_KEY_PROXY) ?? "";
  }

}

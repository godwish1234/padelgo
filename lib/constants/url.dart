import 'package:padelgo/config/environment.dart';

class UrlLink {
  static String get officialUrl => EnvironmentConfig.baseUrl;
  static String get officialUrlNoHttp {
    final url = EnvironmentConfig.baseUrl;
    return url.replaceAll('http://', '').replaceAll('https://', '');
  }

  static const host = 'http://';
}

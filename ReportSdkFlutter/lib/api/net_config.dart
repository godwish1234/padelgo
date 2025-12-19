import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_datac/flutter_datac.dart';
import 'package:flutter_datac/util/const.dart';
import 'package:flutter_datac/util/preference_helper.dart';

class DatacNetConfig {
  static const int RELEASE_HOST = 0;
  static const int DEBUG_HOST = 1;

  static String RELEASE_HOST_U = "https://reportlm.padelgo.id";

  static String DEBUG_HOST_U = "http://149.129.249.89:17956";

  static final DatacNetConfig _instance = DatacNetConfig._internal();

  factory DatacNetConfig() => _instance;

  Dio dio = Dio();

  Dio get getDio => dio;

  LogInterceptor logInterceptor = LogInterceptor(requestBody: false);

  DatacNetConfig._internal();

  Future init() async {
    initDio(getHost(RELEASE_HOST));
    freshProxy();
    dio.options.headers.addAll(await _getPublicStr());
//    dio.interceptors.add(LogInterceptor(requestBody: true,responseBody: true));
  }

  Future initWithHost(String releaseHost, String debugHost) async {
    RELEASE_HOST_U = releaseHost;
    DEBUG_HOST_U = debugHost;
    initDio(getHost(RELEASE_HOST));
    freshProxy();
    dio.options.headers.addAll(await _getPublicStr());
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future setDebug() async {
    dio = Dio();
    initDio(getHost(DEBUG_HOST));
    freshProxy();
    dio.options.headers.addAll(await _getPublicStr());
  }

  String getHost(int env) {
    switch (env) {
      case RELEASE_HOST:
        return RELEASE_HOST_U;
      case DEBUG_HOST:
        return DEBUG_HOST_U;
      default:
        break;
    }
    return RELEASE_HOST_U;
  }

  Future<Map<String, String>> _getPublicStr() async {
    return {
      Const.PARAM_DEVICE_ID:
          await DataC.getInstance().getInfoGetter!.getDeviceId(),
      Const.PARAM_DEVICE_MODEL:
          await DataC.getInstance().getInfoGetter!.getDeviceModel(),
      Const.PARAM_OS_VER: await DataC.getInstance().getInfoGetter!.getOsVer(),
      Const.PARAM_PLATFORM:
          await DataC.getInstance().getInfoGetter!.getPlatform(),
      Const.PARAM_DISPLAY:
          await DataC.getInstance().getInfoGetter!.getDisplay(),
      Const.PARAM_MAC: await DataC.getInstance().getInfoGetter!.getMac(),
      Const.PARAM_PKG: await DataC.getInstance().getInfoGetter!.getPkg(),
      Const.PARAM_APPVER: await DataC.getInstance().getInfoGetter!.getAppVer(),
      Const.PARAM_DEVICE_ID_MID:
          await DataC.getInstance().getInfoGetter!.getDeviceId(),
      Const.PARAM_DEVICE_MODEL_MID:
          await DataC.getInstance().getInfoGetter!.getDeviceModel(),
      Const.PARAM_OS_VER_MID:
          await DataC.getInstance().getInfoGetter!.getOsVer(),
      Const.PARAM_APPVER_MID:
          await DataC.getInstance().getInfoGetter!.getAppVer()
    };
  }

  void initDio(String host) {
    dio.options.baseUrl = host;
    dio.options.connectTimeout = 10000; //10s
    dio.options.contentType = "application/x-www-form-urlencoded";
    dio.options.receiveTimeout = 10000; //10s
    dio.interceptors.add(_getDioInterceptors());
//    dio.interceptors.add(logInterceptor);
  }

  Function onHttpCreate = (proxy) {
    return (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return Platform.isAndroid || Platform.isIOS;
      };
      client.findProxy = (url) {
        return 'PROXY $proxy';
      };
    };
  };

  _getDioInterceptors() {
    return InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        String token = await DataCPreferenceHelper.getToken();
        if (token.isNotEmpty) {
          options.headers.addAll({Const.PARAM_TOKEN: token});
        }
        handler.next(options);
      },
    );
  }

  Future freshProxy() async {
    DataCPreferenceHelper.getProxy().then((proxy) {
      if (proxy.isNotEmpty) {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            onHttpCreate(proxy);
      }
    });
  }
}

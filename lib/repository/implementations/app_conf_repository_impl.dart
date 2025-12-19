import 'package:flutter/foundation.dart';
import 'package:padelgo/constants/end_point.dart';
import 'package:padelgo/models/config.dart';
import 'package:padelgo/repository/base/helpers.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/app_conf_repository.dart';

class AppConfRepositoryImpl extends RestApiRepositoryBase
    implements AppConfRepository {
  @override
  Future<Config?> getConfig(String key) async {
    try {
      return await GetHelper<Config>().getCommon(() async {
        return await get('${EndPoint.appConfig}$key');
      }, (responseData) {
        return Config.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch products: $e');
      }
      rethrow;
    }
  }
}

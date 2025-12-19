import 'package:flutter/foundation.dart';
import 'package:padelgo/constants/end_point.dart';
import 'package:padelgo/models/user_apps_request.dart';
import 'package:padelgo/models/user_apps_response.dart';
import 'package:padelgo/repository/base/helpers.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/user_apps_repository.dart';
import 'package:padelgo/utils/toast_util.dart';

class UserAppsRepositoryImpl extends RestApiRepositoryBase
    implements UserAppsRepository {
  UserAppsRepositoryImpl({super.base});

  @override
  Future<UserAppsResponse?> saveUserApps(UserAppsRequest request) async {
    try {
      final result = await GetHelper<UserAppsResponse>().getCommon(() async {
        return await post(EndPoint.saveUserApps, request.toJson());
      }, (responseData) {
        return UserAppsResponse.fromJson(responseData);
      });

      if (result == null) {
        ToastUtil.showError('Failed to save user apps. Please try again.');
        return null;
      }

      if (!result.isSuccess) {
        return null;
      }

      if (kDebugMode) {
        print('User apps saved successfully - Count: ${result.savedCount}');
      }

      return result;
    } on Exception {
      ToastUtil.showError('An unexpected error occurred. Please try again.');
      return null;
    }
  }
}

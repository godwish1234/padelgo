import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:padelgo/models/user_apps_request.dart';
import 'package:padelgo/models/user_apps_response.dart';
import 'package:padelgo/repository/interfaces/user_apps_repository.dart';
import 'package:padelgo/services/interfaces/user_apps_service.dart';
import 'package:padelgo/utils/app_info_util.dart';

class UserAppsServiceImpl implements UserAppsService {
  final UserAppsRepository _userAppsRepository =
      GetIt.instance<UserAppsRepository>();

  @override
  Future<UserAppsResponse?> collectAndSaveUserApps() async {
    try {
      if (kDebugMode) {
        print('Starting user apps collection and save process');
      }

      final userAppsRequest = await AppInfoUtil.createFilteredUserAppsRequest();

      if (kDebugMode) {
        print('Collected ${userAppsRequest.list.length} user apps from device');
      }

      final response = await _userAppsRepository.saveUserApps(userAppsRequest);

      if (response?.isSuccess == true) {
        if (kDebugMode) {
          print(
              'User apps saved successfully - Count: ${response?.savedCount}');
          print(
              'Apps collected: ${userAppsRequest.list.map((app) => '${app.name} (${app.packageName})').join(', ')}');
        }
      } else {
        if (kDebugMode) {
          print('Failed to save user apps: ${response?.msg}');
        }
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error in collectAndSaveUserApps service: $e');
      }
      return null;
    }
  }

  @override
  Future<UserAppsRequest> getInstalledApps() async {
    try {
      return await AppInfoUtil.createFilteredUserAppsRequest();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting installed apps: $e');
      }
      return UserAppsRequest(list: []);
    }
  }
}

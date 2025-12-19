import 'package:padelgo/models/user_apps_request.dart';
import 'package:padelgo/models/user_apps_response.dart';

abstract class UserAppsService {
  Future<UserAppsResponse?> collectAndSaveUserApps();
  Future<UserAppsRequest> getInstalledApps();
}

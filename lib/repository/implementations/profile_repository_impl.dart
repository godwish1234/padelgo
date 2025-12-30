import 'package:flutter/foundation.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/profile_repository.dart';

class ProfileRepositoryImpl extends RestApiRepositoryBase
    implements ProfileRepository {
  @override
  Future<dynamic> getUserProfile() async {
    try {
      // TODO: Implement getUserProfile endpoint call
      // Example:
      // return await GetHelper<UserProfile>().getCommon(() async {
      //   return await get(EndPoint.getUserProfile, {});
      // }, (responseData) {
      //   return UserProfile.fromJson(responseData);
      // });

      return null;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to get user profile: $e');
      }
      rethrow;
    }
  }
}

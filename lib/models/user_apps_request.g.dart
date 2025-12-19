// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_apps_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAppsRequest _$UserAppsRequestFromJson(Map<String, dynamic> json) =>
    UserAppsRequest(
      list: (json['list'] as List<dynamic>)
          .map((e) => UserApp.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserAppsRequestToJson(UserAppsRequest instance) =>
    <String, dynamic>{
      'list': instance.list.map((e) => e.toJson()).toList(),
    };

UserApp _$UserAppFromJson(Map<String, dynamic> json) => UserApp(
      name: json['name'] as String,
      packageName: json['packageName'] as String,
      version: json['version'] as String,
      installTime: (json['installTime'] as num).toInt(),
    );

Map<String, dynamic> _$UserAppToJson(UserApp instance) => <String, dynamic>{
      'name': instance.name,
      'packageName': instance.packageName,
      'version': instance.version,
      'installTime': instance.installTime,
    };

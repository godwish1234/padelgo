// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_apps_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAppsResponse _$UserAppsResponseFromJson(Map<String, dynamic> json) =>
    UserAppsResponse(
      savedCount: (json['savedCount'] as num?)?.toInt(),
      message: json['message'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$UserAppsResponseToJson(UserAppsResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'savedCount': instance.savedCount,
      'message': instance.message,
    };

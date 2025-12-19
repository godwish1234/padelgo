// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveness_license_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LivenessLicenseEntity _$LivenessLicenseEntityFromJson(
        Map<String, dynamic> json) =>
    LivenessLicenseEntity(
      expiredTime: json['expiredTime'] as String?,
      license: json['license'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$LivenessLicenseEntityToJson(
        LivenessLicenseEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'expiredTime': instance.expiredTime,
      'license': instance.license,
    };

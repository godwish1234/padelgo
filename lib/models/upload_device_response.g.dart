// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadDeviceResponse _$UploadDeviceResponseFromJson(
        Map<String, dynamic> json) =>
    UploadDeviceResponse(
      uploadedCount: (json['uploadedCount'] as num?)?.toInt(),
      deviceFingerprint: json['deviceFingerprint'] as String?,
      riskScore: (json['riskScore'] as num?)?.toInt(),
      uploadTime: json['uploadTime'] as String?,
      deviceId: json['deviceId'] as String?,
      deviceStatus: json['deviceStatus'] as String?,
      securityLevel: (json['securityLevel'] as num?)?.toInt(),
      isNewDevice: json['isNewDevice'] as bool?,
      message: json['message'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$UploadDeviceResponseToJson(
        UploadDeviceResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'uploadedCount': instance.uploadedCount,
      'deviceFingerprint': instance.deviceFingerprint,
      'riskScore': instance.riskScore,
      'uploadTime': instance.uploadTime,
      'deviceId': instance.deviceId,
      'deviceStatus': instance.deviceStatus,
      'securityLevel': instance.securityLevel,
      'isNewDevice': instance.isNewDevice,
      'message': instance.message,
    };

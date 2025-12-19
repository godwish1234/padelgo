// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_info_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadInfoStatus _$UploadInfoStatusFromJson(Map<String, dynamic> json) =>
    UploadInfoStatus(
      uploadUserInfoStatus: (json['uploadUserInfoStatus'] as num?)?.toInt(),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$UploadInfoStatusToJson(UploadInfoStatus instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'uploadUserInfoStatus': instance.uploadUserInfoStatus,
    };

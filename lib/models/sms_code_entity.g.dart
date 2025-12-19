// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_code_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmsCodeEntity _$SmsCodeEntityFromJson(Map<String, dynamic> json) =>
    SmsCodeEntity(
      mobile: json['mobile'] as String?,
      expireTime: (json['expireTime'] as num?)?.toInt(),
      canRetryAfter: (json['canRetryAfter'] as num?)?.toInt(),
      msgid: json['msgid'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$SmsCodeEntityToJson(SmsCodeEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'mobile': instance.mobile,
      'expireTime': instance.expireTime,
      'canRetryAfter': instance.canRetryAfter,
      'msgid': instance.msgid,
    };

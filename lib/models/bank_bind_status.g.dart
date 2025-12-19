// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_bind_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankBindStatus _$BankBindStatusFromJson(Map<String, dynamic> json) =>
    BankBindStatus(
      bankBindStatus: (json['bankBindStatus'] as num?)?.toInt(),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$BankBindStatusToJson(BankBindStatus instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'bankBindStatus': instance.bankBindStatus,
    };

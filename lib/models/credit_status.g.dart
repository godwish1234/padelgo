// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditStatus _$CreditStatusFromJson(Map<String, dynamic> json) => CreditStatus(
      status: (json['status'] as num?)?.toInt(),
      availableAmount: json['availableAmount'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$CreditStatusToJson(CreditStatus instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'status': instance.status,
      'availableAmount': instance.availableAmount,
    };

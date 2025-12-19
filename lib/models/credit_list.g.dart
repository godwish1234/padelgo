// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditList _$CreditListFromJson(Map<String, dynamic> json) => CreditList(
      appId: (json['appId'] as num?)?.toInt(),
      partnerName: json['partnerName'] as String?,
      querySuccess: json['querySuccess'] as bool?,
      creditStatus: (json['creditStatus'] as num?)?.toInt(),
      creditAmount: json['creditAmount'] as String?,
      creditTotalAmount: json['creditTotalAmount'] as String?,
      expireTime: (json['expireTime'] as num?)?.toInt(),
      interestRate: (json['interestRate'] as num?)?.toDouble(),
      loanDays: (json['loanDays'] as num?)?.toInt(),
      errorMessage: json['errorMessage'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$CreditListToJson(CreditList instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'appId': instance.appId,
      'partnerName': instance.partnerName,
      'querySuccess': instance.querySuccess,
      'creditStatus': instance.creditStatus,
      'creditAmount': instance.creditAmount,
      'creditTotalAmount': instance.creditTotalAmount,
      'expireTime': instance.expireTime,
      'interestRate': instance.interestRate,
      'loanDays': instance.loanDays,
      'errorMessage': instance.errorMessage,
    };

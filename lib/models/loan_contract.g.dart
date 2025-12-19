// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanContract _$LoanContractFromJson(Map<String, dynamic> json) => LoanContract(
      url: json['url'] as String?,
      appId: (json['appId'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      loanAmount: json['loanAmount'] as String?,
      loanPeriod: (json['loanPeriod'] as num?)?.toInt(),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$LoanContractToJson(LoanContract instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'url': instance.url,
      'appId': instance.appId,
      'productId': instance.productId,
      'loanAmount': instance.loanAmount,
      'loanPeriod': instance.loanPeriod,
    };

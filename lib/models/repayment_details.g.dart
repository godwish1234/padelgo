// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repayment_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepaymentDetails _$RepaymentDetailsFromJson(Map<String, dynamic> json) =>
    RepaymentDetails(
      appName: json['appName'] as String?,
      bankCode: json['bankCode'] as String?,
      bankIcon: json['bankIcon'] as String?,
      bankName: json['bankName'] as String?,
      payType: json['payType'] as String?,
      phone: json['phone'] as String?,
      repayTipUrl: json['repayTipUrl'] as String?,
      totalAmount: json['totalAmount'] as String?,
      va: json['va'] as String?,
      dueDate: json['dueDate'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$RepaymentDetailsToJson(RepaymentDetails instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'appName': instance.appName,
      'bankCode': instance.bankCode,
      'bankIcon': instance.bankIcon,
      'bankName': instance.bankName,
      'payType': instance.payType,
      'phone': instance.phone,
      'repayTipUrl': instance.repayTipUrl,
      'totalAmount': instance.totalAmount,
      'va': instance.va,
      'dueDate': instance.dueDate,
    };

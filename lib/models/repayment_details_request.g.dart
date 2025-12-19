// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repayment_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepaymentDetailsRequest _$RepaymentDetailsRequestFromJson(
        Map<String, dynamic> json) =>
    RepaymentDetailsRequest(
      appId: (json['appId'] as num).toInt(),
      orderNo: json['orderNo'] as String,
      period: (json['period'] as num).toInt(),
    );

Map<String, dynamic> _$RepaymentDetailsRequestToJson(
        RepaymentDetailsRequest instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'orderNo': instance.orderNo,
      'period': instance.period,
    };

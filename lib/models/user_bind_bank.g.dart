// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bind_bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBindBank _$UserBindBankFromJson(Map<String, dynamic> json) => UserBindBank(
      recordId: (json['recordId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      bankCard: json['bankCard'] as String?,
      bankName: json['bankName'] as String?,
      bankCode: json['bankCode'] as String?,
      bankUserName: json['bankUserName'] as String?,
      status: (json['status'] as num?)?.toInt(),
      isDefaultBank: (json['isDefaultBank'] as num?)?.toInt(),
      partnerResults: (json['partnerResults'] as List<dynamic>?)
          ?.map((e) => PartnerResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$UserBindBankToJson(UserBindBank instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'recordId': instance.recordId,
      'userId': instance.userId,
      'bankCard': instance.bankCard,
      'bankName': instance.bankName,
      'bankCode': instance.bankCode,
      'bankUserName': instance.bankUserName,
      'status': instance.status,
      'isDefaultBank': instance.isDefaultBank,
      'partnerResults':
          instance.partnerResults?.map((e) => e.toJson()).toList(),
    };

PartnerResult _$PartnerResultFromJson(Map<String, dynamic> json) =>
    PartnerResult(
      appId: (json['appId'] as num?)?.toInt(),
      partnerName: json['partnerName'] as String?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PartnerResultToJson(PartnerResult instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'partnerName': instance.partnerName,
      'status': instance.status,
      'message': instance.message,
    };

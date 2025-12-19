// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultBank _$DefaultBankFromJson(Map<String, dynamic> json) => DefaultBank(
      userId: (json['userId'] as num?)?.toInt(),
      appId: (json['appId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      bankName: json['bankName'] as String?,
      bankCard: json['bankCard'] as String?,
      bankCode: json['bankCode'] as String?,
      bankUserName: json['bankUserName'] as String?,
      status: (json['status'] as num?)?.toInt(),
      statusDesc: json['statusDesc'] as String?,
      isDefaultBank: (json['isDefaultBank'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$DefaultBankToJson(DefaultBank instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'userId': instance.userId,
      'appId': instance.appId,
      'id': instance.id,
      'bankName': instance.bankName,
      'bankCard': instance.bankCard,
      'bankCode': instance.bankCode,
      'bankUserName': instance.bankUserName,
      'status': instance.status,
      'statusDesc': instance.statusDesc,
      'isDefaultBank': instance.isDefaultBank,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

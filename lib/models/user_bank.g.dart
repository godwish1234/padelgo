// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBank _$UserBankFromJson(Map<String, dynamic> json) => UserBank(
      items: (json['userBankList'] as List<dynamic>?)
          ?.map((e) => UserBankItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: (json['userId'] as num?)?.toInt(),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$UserBankToJson(UserBank instance) => <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'userBankList': instance.items?.map((e) => e.toJson()).toList(),
      'userId': instance.userId,
    };

UserBankItem _$UserBankItemFromJson(Map<String, dynamic> json) => UserBankItem(
      id: (json['id'] as num?)?.toInt(),
      bankName: json['bankName'] as String?,
      bankCard: json['bankCard'] as String?,
      bankCode: json['bankCode'] as String?,
      bankUserName: json['bankUserName'] as String?,
      status: (json['status'] as num?)?.toInt(),
      statusDesc: json['statusDesc'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$UserBankItemToJson(UserBankItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankName': instance.bankName,
      'bankCard': instance.bankCard,
      'bankCode': instance.bankCode,
      'bankUserName': instance.bankUserName,
      'status': instance.status,
      'statusDesc': instance.statusDesc,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

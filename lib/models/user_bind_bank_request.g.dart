// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bind_bank_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBindBankRequest _$UserBindBankRequestFromJson(Map<String, dynamic> json) =>
    UserBindBankRequest(
      bankName: json['bankName'] as String,
      bankCard: json['bankCard'] as String,
      bankCode: json['bankCode'] as String,
      isDefaultBank: (json['isDefaultBank'] as num).toInt(),
      appId: (json['appId'] as num?)?.toInt(),
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$UserBindBankRequestToJson(
        UserBindBankRequest instance) =>
    <String, dynamic>{
      'bankName': instance.bankName,
      'bankCard': instance.bankCard,
      'bankCode': instance.bankCode,
      'isDefaultBank': instance.isDefaultBank,
      'appId': instance.appId,
      'userName': instance.userName,
    };

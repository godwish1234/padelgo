// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_bank_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteBankRequest _$DeleteBankRequestFromJson(Map<String, dynamic> json) =>
    DeleteBankRequest(
      bankCard: json['bankCard'] as String,
      bankCode: json['bankCode'] as String,
      appId: (json['appId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DeleteBankRequestToJson(DeleteBankRequest instance) =>
    <String, dynamic>{
      'bankCard': instance.bankCard,
      'bankCode': instance.bankCode,
      'appId': instance.appId,
    };

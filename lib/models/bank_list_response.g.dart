// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankListResponse _$BankListResponseFromJson(Map<String, dynamic> json) =>
    BankListResponse(
      code: json['code'] as String?,
      traceId: json['trace_id'] as String?,
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BankItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$BankListResponseToJson(BankListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'trace_id': instance.traceId,
      'msg': instance.msg,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'timestamp': instance.timestamp,
    };

BankItem _$BankItemFromJson(Map<String, dynamic> json) => BankItem(
      id: (json['id'] as num?)?.toInt(),
      partnerAppId: (json['partnerAppId'] as num?)?.toInt(),
      partnerName: json['partnerName'] as String?,
      bankCode: json['bankCode'] as String?,
      bankName: json['bankName'] as String?,
      bankLogo: json['bankLogo'] as String?,
      bankType: json['bankType'] as String?,
      isSupported: json['isSupported'] as bool?,
      sort: (json['sort'] as num?)?.toInt(),
      requestType: (json['requestType'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$BankItemToJson(BankItem instance) => <String, dynamic>{
      'id': instance.id,
      'partnerAppId': instance.partnerAppId,
      'partnerName': instance.partnerName,
      'bankCode': instance.bankCode,
      'bankName': instance.bankName,
      'bankLogo': instance.bankLogo,
      'bankType': instance.bankType,
      'isSupported': instance.isSupported,
      'sort': instance.sort,
      'requestType': instance.requestType,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

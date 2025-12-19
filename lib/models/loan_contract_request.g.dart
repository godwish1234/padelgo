// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_contract_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanContractRequest _$LoanContractRequestFromJson(Map<String, dynamic> json) =>
    LoanContractRequest(
      appId: (json['appId'] as num).toInt(),
      loanAmount: json['loanAmount'] as String,
      loanPeriod: (json['loanPeriod'] as num).toInt(),
      productId: (json['productId'] as num).toInt(),
      contractType: json['contractType'] as String,
    );

Map<String, dynamic> _$LoanContractRequestToJson(
        LoanContractRequest instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'loanAmount': instance.loanAmount,
      'loanPeriod': instance.loanPeriod,
      'productId': instance.productId,
      'contractType': instance.contractType,
    };

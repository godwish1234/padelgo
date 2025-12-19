// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_preview_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanPreviewRequest _$LoanPreviewRequestFromJson(Map<String, dynamic> json) =>
    LoanPreviewRequest(
      appId: (json['appId'] as num).toInt(),
      loanAmount: json['loanAmount'] as String,
      loanTerm: (json['loanTerm'] as num).toInt(),
      loanTermUnit: (json['loanTermUnit'] as num).toInt(),
      loanPeriod: (json['loanPeriod'] as num).toInt(),
      productId: (json['productId'] as num).toInt(),
      purposeId: (json['purposeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoanPreviewRequestToJson(LoanPreviewRequest instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'loanAmount': instance.loanAmount,
      'loanTerm': instance.loanTerm,
      'loanTermUnit': instance.loanTermUnit,
      'loanPeriod': instance.loanPeriod,
      'productId': instance.productId,
      'purposeId': instance.purposeId,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanPreview _$LoanPreviewFromJson(Map<String, dynamic> json) => LoanPreview(
      appName: json['appName'] as String?,
      isHead: (json['isHead'] as num?)?.toInt(),
      receiveAmount: json['receiveAmount'] as String?,
      totalRepaymentAmount: json['totalRepaymentAmount'] as String?,
      totalRate: json['totalRate'] as String?,
      interestAmount: json['interestAmount'] as String?,
      poundageAmount: json['poundageAmount'] as String?,
      poundageTax: json['poundageTax'] as String?,
      signAmount: json['signAmount'] as String?,
      interestRate: json['interestRate'] as String?,
      principal: json['principal'] as String?,
      loanTerm: (json['loanTerm'] as num?)?.toInt(),
      loanTermUnit: (json['loanTermUnit'] as num?)?.toInt(),
      loanPeriod: (json['loanPeriod'] as num?)?.toInt(),
      planTrial: (json['planTrial'] as List<dynamic>?)
          ?.map((e) => PlanTrial.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$LoanPreviewToJson(LoanPreview instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'appName': instance.appName,
      'isHead': instance.isHead,
      'receiveAmount': instance.receiveAmount,
      'totalRepaymentAmount': instance.totalRepaymentAmount,
      'totalRate': instance.totalRate,
      'interestAmount': instance.interestAmount,
      'poundageAmount': instance.poundageAmount,
      'poundageTax': instance.poundageTax,
      'signAmount': instance.signAmount,
      'interestRate': instance.interestRate,
      'principal': instance.principal,
      'loanTerm': instance.loanTerm,
      'loanTermUnit': instance.loanTermUnit,
      'loanPeriod': instance.loanPeriod,
      'planTrial': instance.planTrial?.map((e) => e.toJson()).toList(),
    };

PlanTrial _$PlanTrialFromJson(Map<String, dynamic> json) => PlanTrial(
      money: json['money'] as String?,
      poundageTax: json['poundageTax'] as String?,
      totalAmount: json['totalAmount'] as String?,
      curPeriod: (json['curPeriod'] as num?)?.toInt(),
      poundageAmount: json['poundageAmount'] as String?,
      realReceiveMoney: json['realReceiveMoney'] as String?,
      interestAmount: json['interestAmount'] as String?,
      repaymentTime: (json['repaymentTime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlanTrialToJson(PlanTrial instance) => <String, dynamic>{
      'money': instance.money,
      'poundageTax': instance.poundageTax,
      'totalAmount': instance.totalAmount,
      'curPeriod': instance.curPeriod,
      'poundageAmount': instance.poundageAmount,
      'realReceiveMoney': instance.realReceiveMoney,
      'interestAmount': instance.interestAmount,
      'repaymentTime': instance.repaymentTime,
    };

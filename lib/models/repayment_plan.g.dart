// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repayment_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepaymentPlan _$RepaymentPlanFromJson(Map<String, dynamic> json) =>
    RepaymentPlan(
      items: (json['orderList'] as List<dynamic>?)
          ?.map((e) => RepaymentPlanItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$RepaymentPlanToJson(RepaymentPlan instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'orderList': instance.items?.map((e) => e.toJson()).toList(),
    };

RepaymentPlanItem _$RepaymentPlanItemFromJson(Map<String, dynamic> json) =>
    RepaymentPlanItem(
      appId: (json['appId'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      loanTerm: (json['loanTerm'] as num?)?.toInt(),
      loanTermUnit: (json['loanTermUnit'] as num?)?.toInt(),
      orderStatus: (json['orderStatus'] as num?)?.toInt(),
      partnerLogo: json['partnerLogo'] as String?,
      partnerName: json['partnerName'] as String?,
      loanTotalAmount: json['loanTotalAmount'] as String?,
      repayAmount: json['repayAmount'] as String?,
      orderDate: json['orderDate'] as String?,
      dueDate: json['dueDate'] as String?,
      currentDueAmount: json['currentDueAmount'] as String?,
      interestRate: json['interestRate'] as String?,
      totalInterests: json['totalInterests'] as String?,
      poundage: json['poundage'] as String?,
      poundageTax: json['poundageTax'] as String?,
      receivingAmount: json['receivingAmount'] as String?,
      totalPayment: json['totalPayment'] as String?,
      orderNo: json['orderNo'] as String?,
      period: (json['period'] as num?)?.toInt(),
      paymentDetail: json['paymentDetail'] == null
          ? null
          : PaymentDetail.fromJson(
              json['paymentDetail'] as Map<String, dynamic>),
      overDueDetail: json['overDueDetail'] == null
          ? null
          : OverDueDetail.fromJson(
              json['overDueDetail'] as Map<String, dynamic>),
      repaymentScheduleList: (json['repaymentScheduleList'] as List<dynamic>?)
          ?.map((e) => RepaymentSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      agreementDetails: json['agreementDetails'] as String?,
    )..principal = json['principal'] as String?;

Map<String, dynamic> _$RepaymentPlanItemToJson(RepaymentPlanItem instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'productId': instance.productId,
      'loanTerm': instance.loanTerm,
      'loanTermUnit': instance.loanTermUnit,
      'orderStatus': instance.orderStatus,
      'partnerLogo': instance.partnerLogo,
      'partnerName': instance.partnerName,
      'loanTotalAmount': instance.loanTotalAmount,
      'repayAmount': instance.repayAmount,
      'orderDate': instance.orderDate,
      'dueDate': instance.dueDate,
      'currentDueAmount': instance.currentDueAmount,
      'interestRate': instance.interestRate,
      'totalInterests': instance.totalInterests,
      'poundage': instance.poundage,
      'poundageTax': instance.poundageTax,
      'receivingAmount': instance.receivingAmount,
      'totalPayment': instance.totalPayment,
      'orderNo': instance.orderNo,
      'period': instance.period,
      'principal': instance.principal,
      'paymentDetail': instance.paymentDetail?.toJson(),
      'overDueDetail': instance.overDueDetail?.toJson(),
      'repaymentScheduleList':
          instance.repaymentScheduleList?.map((e) => e.toJson()).toList(),
      'agreementDetails': instance.agreementDetails,
    };

PaymentDetail _$PaymentDetailFromJson(Map<String, dynamic> json) =>
    PaymentDetail(
      paidDate: json['paidDate'] as String?,
      totalPaid: json['totalPaid'] as String?,
    );

Map<String, dynamic> _$PaymentDetailToJson(PaymentDetail instance) =>
    <String, dynamic>{
      'paidDate': instance.paidDate,
      'totalPaid': instance.totalPaid,
    };

OverDueDetail _$OverDueDetailFromJson(Map<String, dynamic> json) =>
    OverDueDetail(
      dueDate: json['dueDate'] as String?,
      overDueDays: json['overDueDays'] as String?,
      overDuePenelties: json['overDuePenelties'] as String?,
    );

Map<String, dynamic> _$OverDueDetailToJson(OverDueDetail instance) =>
    <String, dynamic>{
      'dueDate': instance.dueDate,
      'overDueDays': instance.overDueDays,
      'overDuePenelties': instance.overDuePenelties,
    };

RepaymentSchedule _$RepaymentScheduleFromJson(Map<String, dynamic> json) =>
    RepaymentSchedule(
      status: (json['status'] as num?)?.toInt(),
      repaymentTime: (json['repaymentTime'] as num?)?.toInt(),
      totalAmount: json['totalAmount'] as String?,
      payStatus: json['payStatus'] as bool?,
      curPeriod: (json['curPeriod'] as num?)?.toInt(),
      paidTime: (json['paidTime'] as num?)?.toInt(),
      principal: json['principalRepayment'] as String?,
      totalInterests: json['totalInterests'] as String?,
      poundage: json['poundage'] as String?,
      poundageTax: json['tax'] as String?,
      overDueDetail: json['overDueDetail'] == null
          ? null
          : OverDueDetail.fromJson(
              json['overDueDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RepaymentScheduleToJson(RepaymentSchedule instance) =>
    <String, dynamic>{
      'status': instance.status,
      'repaymentTime': instance.repaymentTime,
      'totalAmount': instance.totalAmount,
      'payStatus': instance.payStatus,
      'curPeriod': instance.curPeriod,
      'paidTime': instance.paidTime,
      'principalRepayment': instance.principal,
      'totalInterests': instance.totalInterests,
      'poundage': instance.poundage,
      'tax': instance.poundageTax,
      'overDueDetail': instance.overDueDetail?.toJson(),
    };

import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'repayment_plan.g.dart';

@JsonSerializable(explicitToJson: true)
class RepaymentPlan with BaseProtocolMixin {
  @JsonKey(name: 'orderList')
  List<RepaymentPlanItem>? items;

  RepaymentPlan({this.items});

  factory RepaymentPlan.fromJson(Map<String, dynamic> json) {
    final ocr = _$RepaymentPlanFromJson(json);
    ocr.parseBaseProtocol(json);
    return ocr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$RepaymentPlanToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

@JsonSerializable(explicitToJson: true)
class RepaymentPlanItem {
  int? appId;
  int? productId;
  int? loanTerm;
  int? loanTermUnit;
  int? orderStatus;
  String? partnerLogo;
  String? partnerName;
  String? loanTotalAmount;
  String? repayAmount;
  String? orderDate;
  String? dueDate;
  String? currentDueAmount;
  String? interestRate;
  String? totalInterests;
  String? poundage;
  String? poundageTax;
  String? receivingAmount;
  String? totalPayment;
  String? orderNo;
  int? period;
  String? principal;
  PaymentDetail? paymentDetail;
  OverDueDetail? overDueDetail;
  List<RepaymentSchedule>? repaymentScheduleList;
  String? agreementDetails;

  RepaymentPlanItem(
      {this.appId,
      this.productId,
      this.loanTerm,
      this.loanTermUnit,
      this.orderStatus,
      this.partnerLogo,
      this.partnerName,
      this.loanTotalAmount,
      this.repayAmount,
      this.orderDate,
      this.dueDate,
      this.currentDueAmount,
      this.interestRate,
      this.totalInterests,
      this.poundage,
      this.poundageTax,
      this.receivingAmount,
      this.totalPayment,
      this.orderNo,
      this.period,
      this.paymentDetail,
      this.overDueDetail,
      this.repaymentScheduleList,
      this.agreementDetails});

  factory RepaymentPlanItem.fromJson(Map<String, dynamic> json) =>
      _$RepaymentPlanItemFromJson(json);

  Map<String, dynamic> toJson() => _$RepaymentPlanItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PaymentDetail {
  String? paidDate;
  String? totalPaid;

  PaymentDetail({this.paidDate, this.totalPaid});

  factory PaymentDetail.fromJson(Map<String, dynamic> json) =>
      _$PaymentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OverDueDetail {
  String? dueDate;
  String? overDueDays;
  String? overDuePenelties;

  OverDueDetail({this.dueDate, this.overDueDays, this.overDuePenelties});

  factory OverDueDetail.fromJson(Map<String, dynamic> json) =>
      _$OverDueDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OverDueDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepaymentSchedule {
  int? status;
  int? repaymentTime;
  String? totalAmount;
  bool? payStatus;
  int? curPeriod;
  int? paidTime;
  @JsonKey(name: 'principalRepayment')
  String? principal;
  String? totalInterests;
  String? poundage;
  @JsonKey(name: 'tax')
  String? poundageTax;
  OverDueDetail? overDueDetail;

  RepaymentSchedule(
      {this.status,
      this.repaymentTime,
      this.totalAmount,
      this.payStatus,
      this.curPeriod,
      this.paidTime,
      this.principal,
      this.totalInterests,
      this.poundage,
      this.poundageTax,
      this.overDueDetail});

  factory RepaymentSchedule.fromJson(Map<String, dynamic> json) =>
      _$RepaymentScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$RepaymentScheduleToJson(this);
}

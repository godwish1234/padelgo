import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'loan_preview.g.dart';

@JsonSerializable(explicitToJson: true)
class LoanPreview with BaseProtocolMixin {
  String? appName;
  int? isHead;
  String? receiveAmount;
  String? totalRepaymentAmount;
  String? totalRate;
  String? interestAmount;
  String? poundageAmount;
  String? poundageTax;
  String? signAmount;
  String? interestRate;
  String? principal;
  int? loanTerm;
  int? loanTermUnit;
  int? loanPeriod;
  List<PlanTrial>? planTrial;

  LoanPreview(
      {this.appName,
      this.isHead,
      this.receiveAmount,
      this.totalRepaymentAmount,
      this.totalRate,
      this.interestAmount,
      this.poundageAmount,
      this.poundageTax,
      this.signAmount,
      this.interestRate,
      this.principal,
      this.loanTerm,
      this.loanTermUnit,
      this.loanPeriod,
      this.planTrial});

  factory LoanPreview.fromJson(Map<String, dynamic> json) {
    final ocr = _$LoanPreviewFromJson(json);
    ocr.parseBaseProtocol(json);
    return ocr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$LoanPreviewToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

@JsonSerializable(explicitToJson: true)
class PlanTrial {
  String? money;
  String? poundageTax;
  String? totalAmount;
  int? curPeriod;
  String? poundageAmount;
  String? realReceiveMoney;
  String? interestAmount;
  int? repaymentTime;

  PlanTrial({
    this.money,
    this.poundageTax,
    this.totalAmount,
    this.curPeriod,
    this.poundageAmount,
    this.realReceiveMoney,
    this.interestAmount,
    this.repaymentTime,
  });

  factory PlanTrial.fromJson(Map<String, dynamic> json) =>
      _$PlanTrialFromJson(json);

  Map<String, dynamic> toJson() => _$PlanTrialToJson(this);
}

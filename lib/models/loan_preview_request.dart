import 'package:json_annotation/json_annotation.dart';

part 'loan_preview_request.g.dart';

@JsonSerializable(explicitToJson: true)
class LoanPreviewRequest {
  int appId;
  String loanAmount;
  int loanTerm;
  int loanTermUnit;
  int loanPeriod;
  int productId;
  int? purposeId;

  LoanPreviewRequest(
      {required this.appId,
      required this.loanAmount,
      required this.loanTerm,
      required this.loanTermUnit,
      required this.loanPeriod,
      required this.productId,
      this.purposeId});

  factory LoanPreviewRequest.fromJson(Map<String, dynamic> json) =>
      _$LoanPreviewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoanPreviewRequestToJson(this);
}

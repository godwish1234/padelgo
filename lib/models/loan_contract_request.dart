import 'package:json_annotation/json_annotation.dart';

part 'loan_contract_request.g.dart';

@JsonSerializable(explicitToJson: true)
class LoanContractRequest {
  int appId;
  String loanAmount;
  int loanPeriod;
  int productId;
  String contractType;

  LoanContractRequest(
      {required this.appId,
      required this.loanAmount,
      required this.loanPeriod,
      required this.productId,
      required this.contractType});

  factory LoanContractRequest.fromJson(Map<String, dynamic> json) =>
      _$LoanContractRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoanContractRequestToJson(this);
}

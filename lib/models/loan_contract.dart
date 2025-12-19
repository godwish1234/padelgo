import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'loan_contract.g.dart';

@JsonSerializable(explicitToJson: true)
class LoanContract with BaseProtocolMixin {
  String? url;
  int? appId;
  int? productId;
  String? loanAmount;
  int? loanPeriod;

  LoanContract(
      {this.url, this.appId, this.productId, this.loanAmount, this.loanPeriod});

  factory LoanContract.fromJson(Map<String, dynamic> json) {
    final ocr = _$LoanContractFromJson(json);
    ocr.parseBaseProtocol(json);
    return ocr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$LoanContractToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

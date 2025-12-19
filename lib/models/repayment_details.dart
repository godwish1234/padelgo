import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'repayment_details.g.dart';

@JsonSerializable(explicitToJson: true)
class RepaymentDetails with BaseProtocolMixin {
  String? appName;
  String? bankCode;
  String? bankIcon;
  String? bankName;
  String? payType;
  String? phone;
  String? repayTipUrl;
  String? totalAmount;
  String? va;
  String? dueDate;

  RepaymentDetails(
      {this.appName,
      this.bankCode,
      this.bankIcon,
      this.bankName,
      this.payType,
      this.phone,
      this.repayTipUrl,
      this.totalAmount,
      this.va,
      this.dueDate});

  factory RepaymentDetails.fromJson(Map<String, dynamic> json) {
    final ocr = _$RepaymentDetailsFromJson(json);
    ocr.parseBaseProtocol(json);
    return ocr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$RepaymentDetailsToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

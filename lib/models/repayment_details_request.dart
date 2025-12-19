import 'package:json_annotation/json_annotation.dart';

part 'repayment_details_request.g.dart';

@JsonSerializable(explicitToJson: true)
class RepaymentDetailsRequest {
  int appId;
  String orderNo;
  int period;

  RepaymentDetailsRequest(
      {required this.appId, required this.orderNo, required this.period});

  factory RepaymentDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$RepaymentDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RepaymentDetailsRequestToJson(this);
}

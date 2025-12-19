import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'credit_list.g.dart';

@JsonSerializable(explicitToJson: true)
class CreditList with BaseProtocolMixin {
  int? appId;
  String? partnerName;
  bool? querySuccess;
  int? creditStatus;
  String? creditAmount;
  String? creditTotalAmount;
  int? expireTime;
  double? interestRate;
  int? loanDays;
  String? errorMessage;

  CreditList({
    this.appId,
    this.partnerName,
    this.querySuccess,
    this.creditStatus,
    this.creditAmount,
    this.creditTotalAmount,
    this.expireTime,
    this.interestRate,
    this.loanDays,
    this.errorMessage,
  });

  factory CreditList.fromJson(Map<String, dynamic> json) {
    final instance = _$CreditListFromJson(json);
    instance.parseBaseProtocol(json);
    return instance;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (appId != null) 'appId': appId,
      if (partnerName != null) 'partnerName': partnerName,
      if (querySuccess != null) 'querySuccess': querySuccess,
      if (creditStatus != null) 'creditStatus': creditStatus,
      if (creditAmount != null) 'creditAmount': creditAmount,
      if (creditTotalAmount != null) 'creditTotalAmount': creditTotalAmount,
      if (expireTime != null) 'expireTime': expireTime,
      if (interestRate != null) 'interestRate': interestRate,
      if (loanDays != null) 'loanDays': loanDays,
      if (errorMessage != null) 'errorMessage': errorMessage,
    };

    json.addAll(getBaseProtocolJson());
    return json;
  }
}

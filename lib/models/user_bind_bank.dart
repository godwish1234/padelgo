import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'user_bind_bank.g.dart';

@JsonSerializable(explicitToJson: true)
class UserBindBank with BaseProtocolMixin {
  int? recordId;
  int? userId;
  String? bankCard;
  String? bankName;
  String? bankCode;
  String? bankUserName;
  int? status;
  int? isDefaultBank;
  List<PartnerResult>? partnerResults;

  UserBindBank(
      {this.recordId,
      this.userId,
      this.bankCard,
      this.bankName,
      this.bankCode,
      this.bankUserName,
      this.status,
      this.isDefaultBank,
      this.partnerResults});

  factory UserBindBank.fromJson(Map<String, dynamic> json) {
    final ocr = _$UserBindBankFromJson(json);
    ocr.parseBaseProtocol(json);
    return ocr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$UserBindBankToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

@JsonSerializable(explicitToJson: true)
class PartnerResult {
  int? appId;
  String? partnerName;
  int? status;
  String? message;

  PartnerResult({
    this.appId,
    this.partnerName,
    this.status,
    this.message,
  });

  factory PartnerResult.fromJson(Map<String, dynamic> json) =>
      _$PartnerResultFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerResultToJson(this);
}

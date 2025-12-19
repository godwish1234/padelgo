import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'delete_bank.g.dart';

@JsonSerializable(explicitToJson: true)
class DeleteBank with BaseProtocolMixin {
  int? userId;
  String? bankCard;
  String? bankCode;
  int? status;
  List<PartnerResult>? partnerResults;

  DeleteBank(
      {this.userId,
      this.bankCard,
      this.bankCode,
      this.status,
      this.partnerResults});

  factory DeleteBank.fromJson(Map<String, dynamic> json) {
    final ocr = _$DeleteBankFromJson(json);
    ocr.parseBaseProtocol(json);
    return ocr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$DeleteBankToJson(this);
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

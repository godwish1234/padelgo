import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'default_bank.g.dart';

@JsonSerializable(explicitToJson: true)
class DefaultBank with BaseProtocolMixin {
  int? userId;
  int? appId;
  int? id;
  String? bankName;
  String? bankCard;
  String? bankCode;
  String? bankUserName;
  int? status;
  String? statusDesc;
  int? isDefaultBank;
  String? createdAt;
  String? updatedAt;

  DefaultBank(
      {this.userId,
      this.appId,
      this.id,
      this.bankName,
      this.bankCard,
      this.bankCode,
      this.bankUserName,
      this.status,
      this.statusDesc,
      this.isDefaultBank,
      this.createdAt,
      this.updatedAt});

  factory DefaultBank.fromJson(Map<String, dynamic> json) {
    final ocr = _$DefaultBankFromJson(json);
    ocr.parseBaseProtocol(json);
    return ocr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$DefaultBankToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

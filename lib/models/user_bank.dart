import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'user_bank.g.dart';

@JsonSerializable(explicitToJson: true)
class UserBank with BaseProtocolMixin {
  @JsonKey(name: 'userBankList')
  List<UserBankItem>? items;
  int? userId;

  UserBank({this.items, this.userId});

  factory UserBank.fromJson(Map<String, dynamic> json) {
    final ocr = _$UserBankFromJson(json);
    ocr.parseBaseProtocol(json);
    return ocr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$UserBankToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

@JsonSerializable(explicitToJson: true)
class UserBankItem {
  int? id;
  String? bankName;
  String? bankCard;
  String? bankCode;
  String? bankUserName;
  int? status;
  String? statusDesc;
  String? createdAt;
  String? updatedAt;

  UserBankItem(
      {this.id,
      this.bankName,
      this.bankCard,
      this.bankCode,
      this.bankUserName,
      this.status,
      this.statusDesc,
      this.createdAt,
      this.updatedAt});

  factory UserBankItem.fromJson(Map<String, dynamic> json) =>
      _$UserBankItemFromJson(json);

  Map<String, dynamic> toJson() => _$UserBankItemToJson(this);
}

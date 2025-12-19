import 'package:json_annotation/json_annotation.dart';

part 'user_bind_bank_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UserBindBankRequest {
  String bankName;
  String bankCard;
  String bankCode;
  int isDefaultBank;
  int? appId;
  String? userName;

  UserBindBankRequest(
      {required this.bankName,
      required this.bankCard,
      required this.bankCode,
      required this.isDefaultBank,
      this.appId,
      this.userName});

  factory UserBindBankRequest.fromJson(Map<String, dynamic> json) =>
      _$UserBindBankRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserBindBankRequestToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'delete_bank_request.g.dart';

@JsonSerializable(explicitToJson: true)
class DeleteBankRequest {
  String bankCard;
  String bankCode;
  int? appId;

  DeleteBankRequest(
      {required this.bankCard, required this.bankCode, this.appId});

  factory DeleteBankRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteBankRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteBankRequestToJson(this);
}

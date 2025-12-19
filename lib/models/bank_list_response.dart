import 'package:json_annotation/json_annotation.dart';

part 'bank_list_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BankListResponse {
  String? code;
  @JsonKey(name: 'trace_id')
  String? traceId;
  String? msg;
  List<BankItem>? data;
  String? timestamp;

  BankListResponse({
    this.code,
    this.traceId,
    this.msg,
    this.data,
    this.timestamp,
  });

  factory BankListResponse.fromJson(Map<String, dynamic> json) =>
      _$BankListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BankListResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BankItem {
  int? id;
  int? partnerAppId;
  String? partnerName;
  String? bankCode;
  String? bankName;
  String? bankLogo;
  String? bankType;
  bool? isSupported;
  int? sort;
  int? requestType;
  String? createdAt;
  String? updatedAt;

  BankItem({
    this.id,
    this.partnerAppId,
    this.partnerName,
    this.bankCode,
    this.bankName,
    this.bankLogo,
    this.bankType,
    this.isSupported,
    this.sort,
    this.requestType,
    this.createdAt,
    this.updatedAt,
  });

  factory BankItem.fromJson(Map<String, dynamic> json) =>
      _$BankItemFromJson(json);

  Map<String, dynamic> toJson() => _$BankItemToJson(this);
}

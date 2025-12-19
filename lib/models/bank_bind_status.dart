import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'bank_bind_status.g.dart';

@JsonSerializable(explicitToJson: true)
class BankBindStatus with BaseProtocolMixin {
  int? bankBindStatus;

  BankBindStatus({this.bankBindStatus});

  factory BankBindStatus.fromJson(Map<String, dynamic> json) {
    final instance = _$BankBindStatusFromJson(json);
    instance.parseBaseProtocol(json);
    return instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$BankBindStatusToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'credit_status.g.dart';

@JsonSerializable(explicitToJson: true)
class CreditStatus with BaseProtocolMixin {
  int? status;
  String? availableAmount;

  CreditStatus({this.status, this.availableAmount});

  factory CreditStatus.fromJson(Map<String, dynamic> json) {
    final instance = _$CreditStatusFromJson(json);
    instance.parseBaseProtocol(json);
    return instance;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (status != null) 'status': status,
      if (availableAmount != null) 'availableAmount': availableAmount,
    };

    json.addAll(getBaseProtocolJson());
    return json;
  }
}

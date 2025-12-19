import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'sms_code_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class SmsCodeEntity with BaseProtocolMixin {
  String? mobile;
  int? expireTime;
  int? canRetryAfter;
  String? msgid;

  SmsCodeEntity({
    this.mobile,
    this.expireTime,
    this.canRetryAfter,
    this.msgid,
  });

  factory SmsCodeEntity.fromJson(Map<String, dynamic> json) {
    final instance = _$SmsCodeEntityFromJson(json);
    instance.parseBaseProtocol(json);
    return instance;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (mobile != null) 'mobile': mobile,
      if (expireTime != null) 'expireTime': expireTime,
      if (canRetryAfter != null) 'canRetryAfter': canRetryAfter,
      if (msgid != null) 'msgid': msgid,
    };

    json.addAll(getBaseProtocolJson());
    return json;
  }
}

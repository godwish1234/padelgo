import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'liveness_license_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class LivenessLicenseEntity with BaseProtocolMixin {
  @JsonKey(name: 'expiredTime')
  String? expiredTime;

  @JsonKey(name: 'license')
  String? license;

  LivenessLicenseEntity({
    this.expiredTime,
    this.license,
  });

  factory LivenessLicenseEntity.fromJson(Map<String, dynamic> json) {
    final entity = _$LivenessLicenseEntityFromJson(json);
    entity.parseBaseProtocol(json);
    return entity;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$LivenessLicenseEntityToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

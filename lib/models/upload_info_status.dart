import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'upload_info_status.g.dart';

@JsonSerializable(explicitToJson: true)
class UploadInfoStatus with BaseProtocolMixin {
  int? uploadUserInfoStatus;

  UploadInfoStatus({this.uploadUserInfoStatus});

  factory UploadInfoStatus.fromJson(Map<String, dynamic> json) {
    final instance = _$UploadInfoStatusFromJson(json);
    instance.parseBaseProtocol(json);
    return instance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$UploadInfoStatusToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'upload_device_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UploadDeviceResponse with BaseProtocolMixin {
  int? uploadedCount;
  String? deviceFingerprint;
  int? riskScore;
  String? uploadTime;
  String? deviceId;
  String? deviceStatus;
  int? securityLevel;
  bool? isNewDevice;
  String? message;

  UploadDeviceResponse({
    this.uploadedCount,
    this.deviceFingerprint,
    this.riskScore,
    this.uploadTime,
    this.deviceId,
    this.deviceStatus,
    this.securityLevel,
    this.isNewDevice,
    this.message,
  });

  factory UploadDeviceResponse.fromJson(Map<String, dynamic> json) {
    final instance = _$UploadDeviceResponseFromJson(json);
    instance.parseBaseProtocol(json);
    return instance;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (uploadedCount != null) 'uploadedCount': uploadedCount,
      if (deviceFingerprint != null) 'deviceFingerprint': deviceFingerprint,
      if (riskScore != null) 'riskScore': riskScore,
      if (uploadTime != null) 'uploadTime': uploadTime,
      if (deviceId != null) 'deviceId': deviceId,
      if (deviceStatus != null) 'deviceStatus': deviceStatus,
      if (securityLevel != null) 'securityLevel': securityLevel,
      if (isNewDevice != null) 'isNewDevice': isNewDevice,
      if (message != null) 'message': message,
    };

    json.addAll(getBaseProtocolJson());
    return json;
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'liveness_check.g.dart';

@JsonSerializable(explicitToJson: true)
class LivenessCheck with BaseProtocolMixin {
  double? livenessScore;
  String? detectionResult;
  String? msgP;
  String? codeP;

  LivenessCheck({
    this.livenessScore,
    this.detectionResult,
    this.msgP,
    this.codeP,
  });

  factory LivenessCheck.fromJson(Map<String, dynamic> json) {
    final instance = _$LivenessCheckFromJson(json);
    instance.parseBaseProtocol(json);
    return instance;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (livenessScore != null) 'livenessScore': livenessScore,
      if (detectionResult != null) 'detectionResult': detectionResult,
      if (msgP != null) 'msgP': msgP,
      if (codeP != null) 'codeP': codeP,
    };

    json.addAll(getBaseProtocolJson());
    return json;
  }
}

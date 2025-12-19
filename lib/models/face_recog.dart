import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'face_recog.g.dart';

@JsonSerializable(explicitToJson: true)
class FaceRecog with BaseProtocolMixin {
  double? similarity;
  String? ktpIdUrl;
  String? faceRecognitionUrl;

  FaceRecog({
    this.similarity,
    this.ktpIdUrl,
    this.faceRecognitionUrl,
  });

  factory FaceRecog.fromJson(Map<String, dynamic> json) {
    final instance = _$FaceRecogFromJson(json);
    instance.parseBaseProtocol(json);
    return instance;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (similarity != null) 'similarity': similarity,
      if (ktpIdUrl != null) 'ktpIdUrl': ktpIdUrl,
      if (faceRecognitionUrl != null) 'faceRecognitionUrl': faceRecognitionUrl,
    };

    json.addAll(getBaseProtocolJson());
    return json;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_recog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceRecog _$FaceRecogFromJson(Map<String, dynamic> json) => FaceRecog(
      similarity: (json['similarity'] as num?)?.toDouble(),
      ktpIdUrl: json['ktpIdUrl'] as String?,
      faceRecognitionUrl: json['faceRecognitionUrl'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$FaceRecogToJson(FaceRecog instance) => <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'similarity': instance.similarity,
      'ktpIdUrl': instance.ktpIdUrl,
      'faceRecognitionUrl': instance.faceRecognitionUrl,
    };

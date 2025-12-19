// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveness_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LivenessCheck _$LivenessCheckFromJson(Map<String, dynamic> json) =>
    LivenessCheck(
      livenessScore: (json['livenessScore'] as num?)?.toDouble(),
      detectionResult: json['detectionResult'] as String?,
      msgP: json['msgP'] as String?,
      codeP: json['codeP'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$LivenessCheckToJson(LivenessCheck instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'livenessScore': instance.livenessScore,
      'detectionResult': instance.detectionResult,
      'msgP': instance.msgP,
      'codeP': instance.codeP,
    };

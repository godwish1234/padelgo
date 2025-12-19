// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreasEntity _$AreasEntityFromJson(Map<String, dynamic> json) => AreasEntity(
      area: (json['data'] as List<dynamic>?)
          ?.map((e) => AreasArea.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$AreasEntityToJson(AreasEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'data': instance.area?.map((e) => e.toJson()).toList(),
    };

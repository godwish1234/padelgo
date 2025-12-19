// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'religion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Religion _$ReligionFromJson(Map<String, dynamic> json) => Religion(
      religionList: (json['religion_list'] as List<dynamic>?)
          ?.map((e) => ReligionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$ReligionToJson(Religion instance) => <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'religion_list': instance.religionList?.map((e) => e.toJson()).toList(),
    };

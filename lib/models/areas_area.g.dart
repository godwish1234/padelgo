// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areas_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreasArea _$AreasAreaFromJson(Map<String, dynamic> json) => AreasArea(
      pid: (json['Pid'] as num?)?.toInt(),
      id: (json['Id'] as num?)?.toInt(),
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$AreasAreaToJson(AreasArea instance) => <String, dynamic>{
      'Pid': instance.pid,
      'Id': instance.id,
      'Name': instance.name,
    };

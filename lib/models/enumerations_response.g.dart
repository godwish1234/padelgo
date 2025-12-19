// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enumerations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnumerationsResponse _$EnumerationsResponseFromJson(
        Map<String, dynamic> json) =>
    EnumerationsResponse(
      code: json['code'] as String?,
      traceId: json['trace_id'] as String?,
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : EnumerationsData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$EnumerationsResponseToJson(
        EnumerationsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'trace_id': instance.traceId,
      'msg': instance.msg,
      'data': instance.data?.toJson(),
      'timestamp': instance.timestamp,
      'success': instance.success,
    };

EnumerationsData _$EnumerationsDataFromJson(Map<String, dynamic> json) =>
    EnumerationsData(
      gender: (json['gender'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      maritalStatus: (json['maritalStatus'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      loanPurpose: (json['loanPurpose'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      religions: (json['religions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      educationLevels: (json['educationLevels'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      workExperiences: (json['workExperiences'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      workTypes: (json['workTypes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      contactType: (json['contactType'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$EnumerationsDataToJson(EnumerationsData instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'maritalStatus': instance.maritalStatus,
      'loanPurpose': instance.loanPurpose,
      'religions': instance.religions,
      'educationLevels': instance.educationLevels,
      'workExperiences': instance.workExperiences,
      'workTypes': instance.workTypes,
      'contactType': instance.contactType,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_validation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactValidationResponse _$ContactValidationResponseFromJson(
        Map<String, dynamic> json) =>
    ContactValidationResponse(
      isValid: json['isValid'] as bool,
      validationMessages: (json['validationMessages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$ContactValidationResponseToJson(
        ContactValidationResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'isValid': instance.isValid,
      'validationMessages': instance.validationMessages,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_validation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactValidationRequest _$ContactValidationRequestFromJson(
        Map<String, dynamic> json) =>
    ContactValidationRequest(
      contactList: (json['contactList'] as List<dynamic>)
          .map((e) => ContactValidationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactValidationRequestToJson(
        ContactValidationRequest instance) =>
    <String, dynamic>{
      'contactList': instance.contactList.map((e) => e.toJson()).toList(),
    };

ContactValidationItem _$ContactValidationItemFromJson(
        Map<String, dynamic> json) =>
    ContactValidationItem(
      name: json['name'] as String,
      phone: json['phone'] as String,
      contactType: (json['contactType'] as num).toInt(),
    );

Map<String, dynamic> _$ContactValidationItemToJson(
        ContactValidationItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'contactType': instance.contactType,
    };

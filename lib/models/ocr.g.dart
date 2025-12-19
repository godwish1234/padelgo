// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ocr _$OcrFromJson(Map<String, dynamic> json) => Ocr(
      bloodType: json['bloodType'] as String?,
      birthday: json['birthday'] as String?,
      gender: json['gender'] as String?,
      birthPlaceBirthday: json['birthPlaceBirthday'] as String?,
      province: json['province'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      village: json['village'] as String?,
      rtrw: json['rtrw'] as String?,
      occupation: json['occupation'] as String?,
      expiryDate: json['expiryDate'] as String?,
      nationality: json['nationality'] as String?,
      address: json['address'] as String?,
      placeOfBirth: json['placeOfBirth'] as String?,
      ktpIdUrl: json['ktpIdUrl'] as String?,
      idNumber: json['idNumber'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      name: json['name'] as String?,
      religion: json['religion'] as String?,
      msgP: json['msgP'] as String?,
      codeP: json['codeP'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$OcrToJson(Ocr instance) => <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'bloodType': instance.bloodType,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'birthPlaceBirthday': instance.birthPlaceBirthday,
      'province': instance.province,
      'city': instance.city,
      'district': instance.district,
      'village': instance.village,
      'rtrw': instance.rtrw,
      'occupation': instance.occupation,
      'expiryDate': instance.expiryDate,
      'nationality': instance.nationality,
      'address': instance.address,
      'placeOfBirth': instance.placeOfBirth,
      'ktpIdUrl': instance.ktpIdUrl,
      'idNumber': instance.idNumber,
      'maritalStatus': instance.maritalStatus,
      'name': instance.name,
      'religion': instance.religion,
      'msgP': instance.msgP,
      'codeP': instance.codeP,
    };

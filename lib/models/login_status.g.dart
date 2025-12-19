// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginStatusData _$LoginStatusDataFromJson(Map<String, dynamic> json) =>
    LoginStatusData(
      isLoggedIn: json['isLoggedIn'] as bool?,
      uid: (json['uid'] as num?)?.toInt(),
      mobile: json['mobile'] as String?,
      username: json['username'] as String?,
      loginTime: (json['loginTime'] as num?)?.toInt(),
      tokenExpiry: (json['tokenExpiry'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoginStatusDataToJson(LoginStatusData instance) =>
    <String, dynamic>{
      'isLoggedIn': instance.isLoggedIn,
      'uid': instance.uid,
      'mobile': instance.mobile,
      'username': instance.username,
      'loginTime': instance.loginTime,
      'tokenExpiry': instance.tokenExpiry,
    };

LoginStatus _$LoginStatusFromJson(Map<String, dynamic> json) => LoginStatus(
      data: json['data'] == null
          ? null
          : LoginStatusData.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$LoginStatusToJson(LoginStatus instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'data': instance.data?.toJson(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
      'user': instance.user.toJson(),
      'token': instance.token,
    };

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: AuthData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data.toJson(),
    };

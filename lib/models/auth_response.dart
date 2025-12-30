import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/models/user_model.dart';

part 'auth_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthData {
  final UserModel user;
  final String token;

  AuthData({
    required this.user,
    required this.token,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AuthResponse {
  final bool success;
  final String message;
  final AuthData data;

  AuthResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

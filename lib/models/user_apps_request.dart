import 'package:json_annotation/json_annotation.dart';

part 'user_apps_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UserAppsRequest {
  final List<UserApp> list;

  UserAppsRequest({
    required this.list,
  });

  factory UserAppsRequest.fromJson(Map<String, dynamic> json) =>
      _$UserAppsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserAppsRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserApp {
  final String name;
  final String packageName;
  final String version;
  final int installTime;

  UserApp({
    required this.name,
    required this.packageName,
    required this.version,
    required this.installTime,
  });

  factory UserApp.fromJson(Map<String, dynamic> json) =>
      _$UserAppFromJson(json);

  Map<String, dynamic> toJson() => _$UserAppToJson(this);
}

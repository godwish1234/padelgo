import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'user_apps_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UserAppsResponse with BaseProtocolMixin {
  int? savedCount;
  String? message;

  UserAppsResponse({
    this.savedCount,
    this.message,
  });

  factory UserAppsResponse.fromJson(Map<String, dynamic> json) {
    final instance = _$UserAppsResponseFromJson(json);
    instance.parseBaseProtocol(json);
    return instance;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (savedCount != null) 'savedCount': savedCount,
      if (message != null) 'message': message,
    };

    json.addAll(getBaseProtocolJson());
    return json;
  }
}

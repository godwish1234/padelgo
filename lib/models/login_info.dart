import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'login_info.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginInfo with BaseProtocolMixin {
  String? authorization;
  bool? newUser;
  int? uid;

  LoginInfo({
    this.authorization,
    this.newUser,
    this.uid,
  });

  bool isLogined() {
    return authorization?.isNotEmpty ?? false;
  }

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    final instance = _$LoginInfoFromJson(json);
    instance.parseBaseProtocol(json);
    return instance;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (authorization != null) 'authorization': authorization,
      if (newUser != null) 'newUser': newUser,
      if (uid != null) 'uid': uid,
    };

    json.addAll(getBaseProtocolJson());
    return json;
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'login_status.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginStatusData {
  bool? isLoggedIn;
  int? uid;
  String? mobile;
  String? username;
  int? loginTime;
  int? tokenExpiry;

  LoginStatusData({
    this.isLoggedIn,
    this.uid,
    this.mobile,
    this.username,
    this.loginTime,
    this.tokenExpiry,
  });

  factory LoginStatusData.fromJson(Map<String, dynamic> json) =>
      _$LoginStatusDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginStatusDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginStatus with BaseProtocolMixin {
  LoginStatusData? data;

  LoginStatus({
    this.data,
  });

  factory LoginStatus.fromJson(Map<String, dynamic> json) {
    final instance = _$LoginStatusFromJson(json);
    instance.parseBaseProtocol(json);

    if (instance.data == null && json.containsKey('isLoggedIn')) {
      instance.data = LoginStatusData(
        isLoggedIn: json['isLoggedIn'] as bool?,
        uid: (json['uid'] as num?)?.toInt(),
        mobile: json['mobile']?.toString(),
        username: json['username']?.toString(),
        loginTime: (json['loginTime'] as num?)?.toInt(),
        tokenExpiry: (json['tokenExpiry'] as num?)?.toInt(),
      );
    }
    return instance;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (data != null) 'data': data!.toJson(),
    };

    json.addAll(getBaseProtocolJson());
    return json;
  }

  bool get userIsLoggedIn => data?.isLoggedIn ?? false;
  bool get hasValidToken =>
      userIsLoggedIn &&
      (data?.tokenExpiry ?? 0) > DateTime.now().millisecondsSinceEpoch;
}

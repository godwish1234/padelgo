class DBaseProtocolEntity {
  String? msg;
  String? code;

  DBaseProtocolEntity({this.msg, this.code});

  DBaseProtocolEntity.fromJson(Map<String, dynamic>? json) {
    msg = json?['msg_p'];
    code = json?['code_p'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg_p'] = this.msg;
    data['code_p'] = this.code;
    return data;
  }

  bool _isSuccessCode() {
    return code == "200";
  }

  bool get isNotLoginError => code == "4047";

  bool get isSuccess => _isSuccessCode();

  String get getErrorCode => code ?? "";

}

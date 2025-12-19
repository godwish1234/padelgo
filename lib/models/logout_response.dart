class LogoutResponse {
  String? code;
  String? traceId;
  String? msg;
  String? timestamp;
  bool? success;

  LogoutResponse({
    this.code,
    this.traceId,
    this.msg,
    this.timestamp,
    this.success,
  });

  LogoutResponse.fromJson(Map<String, dynamic> json) {
    code = json['code']?.toString();
    traceId = json['trace_id'];
    msg = json['msg'];
    timestamp = json['timestamp'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['trace_id'] = traceId;
    data['msg'] = msg;
    data['timestamp'] = timestamp;
    data['success'] = success;
    return data;
  }

  bool get isSuccess => code == "200" && (success == true);
}

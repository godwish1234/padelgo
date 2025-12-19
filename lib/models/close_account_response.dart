class CloseAccountResponse {
  String? codeP;
  String? msgP;
  String? traceId;
  String? timestamp;
  bool? success;
  String? message;
  String? closeTime;

  CloseAccountResponse({
    this.codeP,
    this.msgP,
    this.traceId,
    this.timestamp,
    this.success,
    this.message,
    this.closeTime,
  });

  CloseAccountResponse.fromJson(Map<String, dynamic> json) {
    codeP = json['code_p']?.toString();
    msgP = json['msg_p'];
    traceId = json['traceId'];
    timestamp = json['timestamp'];
    success = json['success'];
    message = json['message'];
    closeTime = json['closeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code_p'] = codeP;
    data['msg_p'] = msgP;
    data['traceId'] = traceId;
    data['timestamp'] = timestamp;
    data['success'] = success;
    data['message'] = message;
    data['closeTime'] = closeTime;
    return data;
  }

  bool get isSuccess => codeP == "200" && (success == true);
}

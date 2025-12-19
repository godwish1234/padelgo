import 'package:flutter/foundation.dart';
import 'package:padelgo/utils/text_util.dart';

mixin BaseProtocolMixin {
  String? msg;
  String? code;
  String? traceId;
  String? timestamp;
  bool? success;

  void parseBaseProtocol(Map<String, dynamic> json) {
    msg = json['msg_p'];
    code = json['code_p'];

    if (TextUtil.isEmpty(code)) {
      msg = json['msg'];
      code = json['code'];
      traceId = json['trace_id'];
      timestamp = json['timestamp'];
      success = json['success'];
    }

    if (code != null && code is! String) {
      code = code.toString();
    }

    if (kDebugMode) {
      print(
          'BaseProtocolMixin - parsed code: "$code", msg: "$msg", traceId: "$traceId", success: $success');
    }
  }

  Map<String, dynamic> getBaseProtocolJson() {
    return {
      'msg_p': msg,
      'code_p': code,
      if (traceId != null) 'trace_id': traceId,
      if (timestamp != null) 'timestamp': timestamp,
      if (success != null) 'success': success,
    };
  }

  bool _isSuccessCode() {
    return code == "200";
  }

  bool get isNotLoginError => code == "4047";
  bool get isSuccess => _isSuccessCode();
  String? get getErrorCode => code;
}

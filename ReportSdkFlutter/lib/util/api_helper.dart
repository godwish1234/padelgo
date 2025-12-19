import '../api/data_helper.dart';
import '../util/const.dart';
import '../util/preference_helper.dart';

typedef OnSuccess = void Function();
typedef OnFailed = void Function(String code);
typedef OnGetToken = void Function(String token);

class ApiHelper{

  static void report(String data, ReportCallback reportCallback, {bool needCheckToken = true}) {
    if (needCheckToken) {
      _checkTokenThenReport(data, reportCallback);
    } else {
      _getTokenThenReport(data, reportCallback);
    }
  }

  static void _checkTokenThenReport(String data, ReportCallback reportCallback){
    DatacDataHelper.checkToken().then((value) {
      if(value?.isSuccess ?? false){
        _report(data, reportCallback);
      }else if((value?.code?.isNotEmpty ?? false) && (value?.code == Const.CODE_TOKEN_INVALID || value?.code == Const.CODE_PARAM_LOSE)){
        _getTokenThenReport(data, reportCallback);
      }else{
        reportCallback.onFailed.call(value?.code ?? "-1");
      }
    });
  }

  static void _getToken(TokenCallback tokenCallback) {
    DatacDataHelper.getToken().then((value) {
      if(value?.isSuccess ?? false){
        String token = _convertToken(value?.token ?? "");
        tokenCallback.onGetToken(token);
      }else{
        tokenCallback.onFailed.call(value?.code ?? "-1");
      }
    });
  }

  static void _getTokenThenReport(String data, ReportCallback reportCallback){
    _getToken(TokenCallback((token){
      if(token.isEmpty){
        reportCallback.onFailed("-1");
        return;
      }
      DataCPreferenceHelper.setToken(token);
      _report(data, reportCallback);
    }, (code){
      reportCallback.onFailed(code);
    }));
  }

  static void _report(String data, ReportCallback reportCallback){
    DatacDataHelper.report(data).then((value) {
      if(value?.isSuccess ?? false){
        reportCallback.onSuccess();
      }else{
        reportCallback.onFailed.call(value?.code ?? "-1");
      }
    });
  }

  static _convertToken(String _token) {
    try{
      String originToken = _token;
      int start = int.parse(originToken.substring(0,2));
      int last = int.parse(originToken.substring(originToken.length -2, originToken.length));
      return originToken.substring(start + 2, last + 2);
    }catch (_){
      print(_);
    }
    return _token;
  }

}

class ReportCallback{
  OnSuccess onSuccess;
  OnFailed onFailed;
  ReportCallback(
    this.onSuccess,
    this.onFailed);
}

class TokenCallback{
  OnFailed onFailed;
  OnGetToken onGetToken;
  TokenCallback(
    this.onGetToken,
    this.onFailed);
}
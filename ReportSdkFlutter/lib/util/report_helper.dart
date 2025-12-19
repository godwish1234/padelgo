import 'package:flutter_datac/data/report_entity.dart';
import 'package:flutter_datac/data/save_entity.dart';
import 'package:flutter_datac/flutter_datac.dart';
import 'package:flutter_datac/util/const.dart';
import 'package:flutter_datac/util/preference_helper.dart';

import 'api_helper.dart';
import 'common.dart';
import 'file_util.dart';

class ReportHelper{
  static report(ReportEntity reportEntity) async{
    SaveEntity saveEntity = SaveEntity();
    await saveEntity.getData(reportEntity);
    String jsonStr = saveEntity.toJson();
    if (jsonStr.isEmpty) {
      return;
    }
    if(Common.isDebug()){
      _log("action isForce = ${reportEntity.isForce} $jsonStr");
    }
    if(reportEntity.isForce){
      _singleReport(jsonStr);
    }else{
      int fileSize = await FileUtil.saveStringToJson(jsonStr);
      if ((fileSize > Const.MAX_FILE_SIZE || await _isOverTime()) && await _canUpload()) {
        _uploadMultiReport(false);
      }
    }
  }

  static triggerUpload(final bool isForce) async{
    int fileSize = await FileUtil.getUploadFileSize();
    if (fileSize > Const.MAX_FILE_SIZE || await _isOverTime() || isForce) {
      _uploadMultiReport(isForce);
    }
  }

  static Future<bool> _canUpload() async{
    int lastAutoUploadTime = await DataCPreferenceHelper.getLastAutoUploadTime();
    return DateTime.now().millisecondsSinceEpoch - lastAutoUploadTime > Const.AUTO_UPLOAD_SPLIT;
  }

  static Future<bool> _isOverTime() async{
    int lastUploadTime = await DataCPreferenceHelper.getLastUploadTime();
    if (lastUploadTime == -1) {
      return false;
    }
    return (DateTime.now().millisecondsSinceEpoch - lastUploadTime) > Const.MAX_DURING_TIME;
  }

  static Future<bool> isNowWifi() async{
    return (await Common.getNet()) == "wifi";
  }


  static void _uploadMultiReport(bool isForce) async{
    if (!(await Common.hasNet()) || (!(await isNowWifi()) && !isForce)) {
      _log("uploadMultiReport has no network paused or its not wifi stat");
      return;
    }
    String? datas = await FileUtil.getReportString();
    if (datas?.isNotEmpty ?? false) {
      if(DataC.getInstance().isDebug){
        _log("trigger upload multiple datac\t"+(datas?.length.toString() ?? ""));
      }
      int time = DateTime.now().millisecondsSinceEpoch;
      DataCPreferenceHelper.setLastUploadTime(time);
      DataCPreferenceHelper.setLastAutoUploadTime(time);
      bool needCheck = (await DataCPreferenceHelper.getToken()).isNotEmpty;
      ApiHelper.report(datas!, ReportCallback(() {
        if(DataC.getInstance().isDebug){
          _log("uploadMultiReport upload successed");
        }
      }, (code) async{
        if(DataC.getInstance().isDebug){
          _log("multi upload onFailed\t"+code.toString());
        }
        await DataCPreferenceHelper.setLastUploadTime(0);
        await FileUtil.revertContent(datas);
        int size = await FileUtil.getUploadFileSize();
        if(size > Const.MAX_FILE_SIZE * Const.DUMP_TIMES){
          await FileUtil.deleteReportFile();
        }
      }), needCheckToken: needCheck);
    }
  }


  static _log(String msg){
    print(Const.LOG_TAG + "\t"+msg);
  }

  static void _singleReport(String jsonStr) async{
    if (!(await Common.hasNet())) {
      FileUtil.saveStringToJson(jsonStr);
      _log("uploadSingleReport has no network paused");
      return;
    }
    bool needCheck = (await DataCPreferenceHelper.getToken()).isNotEmpty;
    ApiHelper.report(jsonStr, ReportCallback(() {
      if(DataC.getInstance().isDebug){
        _log("single upload successed");
      }
    }, (code) {
      FileUtil.saveStringToJson(jsonStr);
    }), needCheckToken: needCheck);
  }


}
import 'dart:convert';

import 'package:flutter_datac/data/report_entity.dart';
import 'package:flutter_datac/flutter_datac.dart';
import 'package:flutter_datac/util/common.dart';
import 'package:flutter_datac/util/const.dart';

class SaveEntity {
  String? time_zone;
  String? timestamp;
  String? nettype;
  String? network;
  String? lat;
  String? lng;
  String? power;
  String? token;
  String? page;
  String? event;
  String? appVer;

  Map<String, dynamic> param = Map();

  Future getData(ReportEntity reportEntity) async{
    page = reportEntity.page;
    event = reportEntity.event;
    DateTime now = DateTime.now();
    time_zone = now.timeZoneName.toString();
    timestamp = now.millisecondsSinceEpoch.toString();
    nettype = await DataC.getInstance().getInfoGetter?.getNetType() ?? "";
    network =  await DataC.getInstance().getInfoGetter?.getNetwork()  ?? "";
    lat =  await DataC.getInstance().getInfoGetter?.getLat() ?? "";
    lng =  await DataC.getInstance().getInfoGetter?.getLng()  ?? "";
    power =  await DataC.getInstance().getInfoGetter?.getPowerPercent() ?? "";
    readParam(reportEntity.map, reportEntity.runtimeType.toString());
    token =  await DataC.getInstance().getInfoGetter?.getToken() ?? "";
    appVer =  await DataC.getInstance().getInfoGetter?.getAppVer() ?? "";
    if(DataC.getInstance().isDebug){
      print(Const.LOG_TAG+"\t-----------------start------------------ "+reportEntity.runtimeType.toString());
      print(Const.LOG_TAG+"\tpage_name\t"+(reportEntity.page));
      reportEntity.map.forEach((key, value) {
        print(Const.LOG_TAG+"\t$key\t"+value.toString());
      });
      print(Const.LOG_TAG+"\t-----------------finish------------------ "+reportEntity.runtimeType.toString());
    }
  }

  void readParam(Map<String, dynamic> map, String name) {
    if (map.isNotEmpty) {
      map.keys.forEach((key) {
        if (key.contains(Const.DATA_KEY)) {
          String indexStr = key.replaceAll(Const.DATA_KEY, "");
          int index = int.tryParse(indexStr) ?? -1;
          if (index >= 1 && index <= 32) {
            param[key] = map[key]?.toString() ?? "";
          } else {
            Common.reportError(name, key);
          }
        } else {
          Common.reportError(name, key);
        }
      });
    }
  }

  String toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["event"] = event;
    data["page"] = page;
    data["timestamp"] = timestamp;
    data["time_zone"] = time_zone;
    data["nettype"] = nettype;
    data["network"] = network;
    data["lat"] = lat;
    data["lng"] = lng;
    data["power"] = power;
    data["params"] = param;
    data["token"] = token;
    data["app_ver"] = appVer;
    return json.encode(data);
  }
}

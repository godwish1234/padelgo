import 'dart:core';

import 'package:flutter_datac/util/common.dart';

class ReportEntity{
  String page;
  String event;
  bool isForce = false;

  Map<String, dynamic> map = Map();

  ReportEntity(this.event, this.page);

  insert(String key, dynamic value){
    if (!map.containsKey(key)) {
      map[key] = value;
    } else {
      Common.reportError(this.runtimeType.toString(), key);
    }
  }
}
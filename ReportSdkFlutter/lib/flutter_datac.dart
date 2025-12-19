library flutter_datac;

import 'dart:async';
import 'dart:isolate';

import 'package:connectivity/connectivity.dart';
import 'api/net_config.dart';
import 'data/page_activate.dart';
import 'data/report_entity.dart';
import 'info_getter.dart';
import 'util/const.dart';
import 'util/report_helper.dart';


class DataC {

  static DataC? _dataC;
  InfoGetter? _infoGetter;
  DataC._internal();

  bool _isDebug = false;

  factory DataC.getInstance() {
    if (_dataC == null) {
      _dataC = DataC._internal();
    }
    return _dataC!;
  }

  InfoGetter? get getInfoGetter => _infoGetter;
  bool get isDebug => _isDebug;

  setDebug(bool isDebug){
    _isDebug = isDebug;
  }

  report(ReportEntity reportEntity) async{
    ReportHelper.report(reportEntity);
  }

  Future init(InfoGetter infoGetter) async{
    _infoGetter = infoGetter;
    await DatacNetConfig().init();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.wifi){
        triggerUpload(false);
      }
    });
  }

  Future initWithHost(InfoGetter infoGetter,String releaseHost,String debugHost) async{
    _infoGetter = infoGetter;
    await DatacNetConfig().initWithHost(releaseHost, debugHost);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.wifi){
        triggerUpload(false);
      }
    });
  }


  setUseDebugHost() async{
    await DatacNetConfig().setDebug();
  }

  setMaxFileSize(int fileSize) {
    Const.MAX_FILE_SIZE = fileSize;
  }

  setMaxDuringTime(int time) {
    Const.MAX_DURING_TIME = time;
  }

  triggerUpload(bool isForce) {
    ReportHelper.triggerUpload(isForce);
  }

  reportActivate() {
    PageActivate pageActivate = new PageActivate();
    pageActivate.isForce = true;
    DataC.getInstance().report(pageActivate);
  }

  static Isolate? _isolate;
  static bool _running = false;
  static int _counter = 0;
  static String notification = "";
  static ReceivePort? _receivePort;

  static void _checkTimer(SendPort? sendPort) async {
    sendPort?.send(_adder(1000));
  }

  static Future<int> _adder(int cal) async{
    return cal + 10000;
  }

  static void _handleMessage(dynamic data) {
    print("yao\t_handleMessage\t"+data.toString());

  }

  static Future<void> _start() async {
    _running = true;
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_checkTimer, _receivePort?.sendPort, debugName: "TATATA");
    // print("yao\tspawn"+(Isolate.current.debugName ?? ""));
    _receivePort?.listen(_handleMessage, onDone:() {
      // print("yao\tdone"+(Isolate.current.debugName ?? ""));
    });
  }

  static startThread() async{
    await _start();
  }

  static void _stop() {
    if (_isolate != null) {
      _receivePort?.close();
      _isolate?.kill(priority: Isolate.immediate);
      _isolate = null;
    }

  }
}

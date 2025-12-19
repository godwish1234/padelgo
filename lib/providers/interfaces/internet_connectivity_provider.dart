import 'package:flutter/material.dart';

abstract class InternetConnectivityProvider extends ChangeNotifier{
  bool get connected;

  Future<bool> hasInternet();

  Future initialize();

  enableToastMessaging(GlobalKey<ScaffoldMessengerState>  applicationScaffoldMessengerState);
}
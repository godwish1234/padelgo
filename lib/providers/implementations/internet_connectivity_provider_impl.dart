import 'dart:async';

import 'package:padelgo/providers/providers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnectivityProviderImpl extends ChangeNotifier
    implements InternetConnectivityProvider {
  final Connectivity _connectivity = Connectivity();
  bool _connected = true;
  //bool _checkConnectionError = false;
  GlobalKey<ScaffoldMessengerState>? _applicationScaffoldMessengerState;
  Timer? _timerHandle;
  StreamSubscription<List<ConnectivityResult>>? _connectivityStreamSubscription;

  @override
  bool get connected => _connected;

  @override
  enableToastMessaging(
    GlobalKey<ScaffoldMessengerState> applicationScaffoldMessengerState,
  ) {
    _applicationScaffoldMessengerState = applicationScaffoldMessengerState;
  }

  @override
  Future initialize() async {
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      hasInternet();
    });
  }

  @override
  Future<bool> hasInternet() async {
    var previousConnectedStatus = _connected;

    // bool isOnWifiOrMobileData = false;
    var connectivityResult = await _connectivity.checkConnectivity();

    // isOnWifiOrMobileData = connectivityResult == ConnectivityResult.mobile ||
    //     connectivityResult == ConnectivityResult.wifi;

    // Do network request to check if we really have internet connectivity
    // if (isOnWifiOrMobileData) {
    //   try {
    //     var res = await http
    //         .get(Uri.parse("https://www.google.com"))
    //         .timeout(_checkTimeout);
    //     _connected = res.statusCode == 200;
    //   } catch (e) {
    //     _connected = false;
    //   }
    // } else {
    //   _connected = false;
    // }
    final newStatus = connectivityResult != ConnectivityResult.none;
    if (newStatus) {
      _connected = true;
      // try {
      //   var res = await http
      //       .get(Uri.parse("https://www.google.com"))
      //       .timeout(_checkTimeout);
      //   _connected = res.statusCode == 200;
      // } catch (e) {
      //   _connected = false;
      // }
    } else {
      _connected = false;
    }

    // Notify all listeners when internet status changes
    if (previousConnectedStatus != _connected) {
      notifyListeners();
      _showSnackBar();
    }

    return _connected;
  }

  void _showSnackBar() {
    if (_applicationScaffoldMessengerState != null &&
        _applicationScaffoldMessengerState!.currentState != null) {
      if (!_connected) {
        _applicationScaffoldMessengerState!.currentState!
            .removeCurrentSnackBar();
        _applicationScaffoldMessengerState!.currentState!.showSnackBar(SnackBar(
          content: const Text('You are Offline'),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              _applicationScaffoldMessengerState!.currentState!
                  .hideCurrentSnackBar();
            },
          ),
        ));
      } else {
        _applicationScaffoldMessengerState!.currentState!
            .removeCurrentSnackBar();
        _applicationScaffoldMessengerState!.currentState!.showSnackBar(SnackBar(
          content: const Text('You are Online'),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              _applicationScaffoldMessengerState!.currentState!
                  .hideCurrentSnackBar();
            },
          ),
        ));
      }
      // }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timerHandle?.cancel();
    _connectivityStreamSubscription?.cancel();
  }
}

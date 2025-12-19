import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:padelgo/providers/providers.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:stacked/stacked.dart';

class OfflineDetectableViewModel extends BaseViewModel {
  final InternetConnectivityProvider _internetConnectivityProvider =
      GetIt.instance.get<InternetConnectivityProvider>();

  final EventProvider _eventProvider = GetIt.instance<EventProvider>();

  bool get hasInternet => _internetConnectivityProvider.connected;

  bool _isInitializing = false;
  bool _hasInitializedOnce = false;
  bool _pendingNetworkRestore = false;

  void initialize() async {
    if (_isInitializing) return;
    _isInitializing = true;

    _internetConnectivityProvider.removeListener(internetConnectivityUpdated);
    _internetConnectivityProvider.addListener(internetConnectivityUpdated);
    _setupEventListener();

    _hasInitializedOnce = true;
    _isInitializing = false;
  }

  void _setupEventListener() {
    _eventProvider.addListener(() {
      final event = _eventProvider.lastEvent;
      if (event is NetworkRestoreEvent) {
        if (kDebugMode) {
          print('NetworkRestoreEvent received in $runtimeType');
        }
        handleNetworkRestoration();
      }
    });
  }

  @override
  void dispose() {
    _internetConnectivityProvider.removeListener(internetConnectivityUpdated);
    super.dispose();
  }

  void internetConnectivityUpdated() async {
    notifyListeners();

    if (hasInternet &&
        !_isInitializing &&
        _hasInitializedOnce &&
        !_pendingNetworkRestore) {
      _pendingNetworkRestore = true;
      if (hasInternet) {
        handleNetworkRestoration();
      }

      _pendingNetworkRestore = false;
    }
  }

  void handleNetworkRestoration() {
    initialize();
  }
}

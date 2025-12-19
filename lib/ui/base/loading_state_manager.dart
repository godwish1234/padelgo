import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:padelgo/ui/base/base.dart';

class LoadingStateManager {
  static final LoadingStateManager _instance = LoadingStateManager._internal();

  factory LoadingStateManager() => _instance;

  LoadingStateManager._internal();

  final _busyStateListeners = <Function(bool)>[];
  bool _isBusy = false;

  Timer? _debounceTimer;
  static const _debounceDuration = Duration(milliseconds: 300);

  void addListener(Function(bool) listener) {
    _busyStateListeners.add(listener);
    listener(_isBusy);
  }

  void removeListener(Function(bool) listener) {
    _busyStateListeners.remove(listener);
  }

  void notifyBusyState(bool isBusy) {
    if (_isBusy == isBusy) return;

    _debounceTimer?.cancel();

    if (isBusy) {
      _isBusy = true;
      _notifyListeners();
    } else {
      _debounceTimer = Timer(_debounceDuration, () {
        _isBusy = false;
        _notifyListeners();
      });
    }
  }

  void _notifyListeners() {
    for (var listener in _busyStateListeners) {
      listener(_isBusy);
    }
  }

  bool get isBusy => _isBusy;
}

abstract class LoadingAwareViewModel extends OfflineDetectableViewModel {
  final _loadingStateManager = LoadingStateManager();

  @override
  void setBusy(bool value) {
    super.setBusy(value);
    _loadingStateManager.notifyBusyState(value);
  }

  @override
  Future<T> runBusyFuture<T>(
    Future<T> busyFuture, {
    Object? busyObject,
    bool throwException = false,
  }) async {
    try {
      if (busyObject != null) {
        setBusyForObject(busyObject, true);
      } else {
        setBusy(true);
      }

      _loadingStateManager.notifyBusyState(true);

      return await busyFuture;
    } catch (e) {
      if (throwException) {
        rethrow;
      }
      if (kDebugMode) {
        print('Error in runBusyFuture: $e');
      }
      return Future.value(null as T);
    } finally {
      // Clear busy state
      if (busyObject != null) {
        setBusyForObject(busyObject, false);
      } else {
        setBusy(false);
      }

      _loadingStateManager.notifyBusyState(false);
    }
  }
}

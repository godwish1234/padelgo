import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:padelgo/models/config.dart';
import 'package:padelgo/repository/interfaces/app_conf_repository.dart';
import 'package:padelgo/services/interfaces/app_conf_service.dart';

class AppConfServiceImpl extends AppConfService {
  final _appConfRepository = GetIt.instance<AppConfRepository>();

  @override
  Future<Config?> getConfig(String key) async {
    if (kDebugMode) {
      print('AppConfService: Getting config for key: $key');
    }

    final result = await _appConfRepository.getConfig(key);

    if (kDebugMode) {
      print(
          'AppConfService: Config result for $key - isSuccess: ${result?.isSuccess}, configValue: ${result?.configValue}');
    }

    return result;
  }
}

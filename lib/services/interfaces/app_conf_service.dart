import 'package:padelgo/models/config.dart';

abstract class AppConfService {
  Future<Config?> getConfig(String key);
}

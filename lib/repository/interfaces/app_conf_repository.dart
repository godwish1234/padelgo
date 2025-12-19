import 'package:padelgo/models/config.dart';

abstract class AppConfRepository {
  Future<Config?> getConfig(String key);
}

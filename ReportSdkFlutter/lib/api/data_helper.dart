import 'package:flutter_datac/data/datac_base_protocol_entity.dart';
import 'package:flutter_datac/data/token_entity.dart';

import 'api.dart';

class DatacDataHelper {

  static Future<TokenEntity?> getToken() async {
    TokenEntity? loginEntity = await Api.getToken();
    return loginEntity;
  }

  static Future<DBaseProtocolEntity?> report(String data) async {
    DBaseProtocolEntity? dBaseProtocolEntity = await Api.report(data);
    return dBaseProtocolEntity;
  }

  static Future<DBaseProtocolEntity?> checkToken() async {
    DBaseProtocolEntity? dBaseProtocolEntity = await Api.checkToken();
    return dBaseProtocolEntity;
  }

}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_datac/data/datac_base_protocol_entity.dart';
import 'package:flutter_datac/data/token_entity.dart';
import 'net_config.dart';

class Api {

  static String _obtainPathByHost(){
     String HOST_MEXICO= "https://api.pesochido.mx";

     if(DatacNetConfig.RELEASE_HOST_U == HOST_MEXICO){
        return "/api/report_server";
     }else{
        return "/api/report";
     }
  }


  static Future<TokenEntity?> getToken() async {
    try {
      return await GetHelper<TokenEntity>().getCommon(() {
        return DatacNetConfig().getDio.get("${_obtainPathByHost()}/token");
      }, (_data) {
        return TokenEntity.fromJson(_data);
      });
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  static Future<DBaseProtocolEntity?> checkToken() async {
    try {
      return await GetHelper<DBaseProtocolEntity>().getCommon(() {
        return DatacNetConfig().getDio.get("${_obtainPathByHost()}/check_token");
      }, (_data) {
        return DBaseProtocolEntity.fromJson(_data);
      });
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  static Future<DBaseProtocolEntity?> report(String data) async {
    try {
      return await GetHelper<DBaseProtocolEntity>().getCommon(() {
        return DatacNetConfig()
            .getDio
            .post("${_obtainPathByHost()}/app", data: data, options: Options(contentType: "application/text; charset=utf-8"));
      }, (_data) {
        return DBaseProtocolEntity.fromJson(_data);
      });
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}

class GetHelper<DBaseProtocolEntity> {
  Future<DBaseProtocolEntity?> getCommon(
      ResponseBuilder<DBaseProtocolEntity> builder, ConvertJson<DBaseProtocolEntity, Map<String, dynamic>?> convertJson) async {
    try {
      Response response = await builder();
      if (response.data is Map<String, dynamic>) {
        return convertJson(adjustMap(response.data as Map<String, dynamic>));
      } else {
        return convertJson(adjustMap(json.decode(response.data)));
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  static Map<String, dynamic>? adjustMap(Map<String, dynamic>? data) {
    if (null != data) {
      try {
        if (data["data"] is Map<String, dynamic>) {
          Map<String, dynamic> internData = (data["data"] ?? Map<String, dynamic>()) as Map<String, dynamic>;
          internData["msg_p"] = data["msg"] ?? "";
          internData["code_p"] = data["code"];
          return internData;
        } else {
          Map<String, dynamic> internData = Map<String, dynamic>();
          internData["msg_p"] = data["msg"] ?? "";
          internData["code_p"] = data["code"];
          return internData;
        }
      } on Exception catch (e) {
        print(e);
      }
    }
    return null;
  }
}

typedef ResponseBuilder<T> = Future<Response> Function();

typedef ConvertJson<T, S> = T Function(S);

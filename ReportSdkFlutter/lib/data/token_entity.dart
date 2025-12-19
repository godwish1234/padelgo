import 'package:flutter_datac/data/datac_base_protocol_entity.dart';

class TokenEntity extends DBaseProtocolEntity{
  String? _token;

  String? get token => _token;

  TokenEntity({
      String? token}){
    _token = token;
}

  TokenEntity.fromJson(dynamic json) : super.fromJson(json){
    _token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["token"] = _token;
    map.addAll(super.toJson());
    return map;
  }

}
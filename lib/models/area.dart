import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';
import 'package:padelgo/models/areas_area.dart';

part 'area.g.dart';

@JsonSerializable(explicitToJson: true)
class AreasEntity with BaseProtocolMixin {
  @JsonKey(name: 'data')
  List<AreasArea>? area;

  AreasEntity({this.area});

  factory AreasEntity.fromJson(Map<String, dynamic> json) {
    final areas = _$AreasEntityFromJson(json);
    areas.parseBaseProtocol(json);
    return areas;
  }

  Map<String, dynamic> toJson() {
    final data = _$AreasEntityToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }

  List<AreasArea>? get data => area;
}

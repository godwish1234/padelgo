import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';
import 'package:padelgo/models/religion_item.dart';

part 'religion.g.dart';

@JsonSerializable(explicitToJson: true)
class Religion with BaseProtocolMixin {
  @JsonKey(name: 'religion_list')
  List<ReligionItem>? religionList;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isUserChange = false;

  Religion({
    this.religionList,
  });

  factory Religion.fromJson(Map<String, dynamic> json) {
    final religion = _$ReligionFromJson(json);
    religion.parseBaseProtocol(json);
    return religion;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$ReligionToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

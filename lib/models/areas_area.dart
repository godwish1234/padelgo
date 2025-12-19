import 'package:json_annotation/json_annotation.dart';

part 'areas_area.g.dart';

@JsonSerializable(explicitToJson: true)
class AreasArea {
  @JsonKey(name: 'Pid')
  int? pid;

  @JsonKey(name: 'Id')
  int? id;

  @JsonKey(name: 'Name')
  String? name;

  AreasArea({this.pid, this.id, this.name});

  factory AreasArea.fromJson(Map<String, dynamic> json) =>
      _$AreasAreaFromJson(json);

  Map<String, dynamic> toJson() => _$AreasAreaToJson(this);
}

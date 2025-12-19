import 'package:json_annotation/json_annotation.dart';

part 'religion_item.g.dart';

@JsonSerializable(explicitToJson: true)
class ReligionItem {
  String? name;
  String? id;

  ReligionItem({
    this.name,
    this.id,
  });

  factory ReligionItem.fromJson(Map<String, dynamic> json) =>
      _$ReligionItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReligionItemToJson(this);
}

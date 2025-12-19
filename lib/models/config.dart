import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';

part 'config.g.dart';

@JsonSerializable(explicitToJson: true)
class Config with BaseProtocolMixin {
  String? config;
  String? configValue;
  String? description;
  String? createdAt;
  String? updatedAt;

  Config(
      {this.config,
      this.configValue,
      this.description,
      this.createdAt,
      this.updatedAt});

  factory Config.fromJson(Map<String, dynamic> json) {
    final ocr = _$ConfigFromJson(json);
    ocr.parseBaseProtocol(json);
    return ocr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$ConfigToJson(this);
    data.addAll(getBaseProtocolJson());
    return data;
  }
}

@JsonSerializable(explicitToJson: true)
class AppConf {
  String? name;
  String? subName;
  String? desc;
  String? logo;

  AppConf({this.name, this.subName, this.desc, this.logo});

  factory AppConf.fromJson(Map<String, dynamic> json) =>
      _$AppConfFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TermServiceConf {
  String? privacyUrl;
  String? termsUrl;

  TermServiceConf({this.privacyUrl, this.termsUrl});

  factory TermServiceConf.fromJson(Map<String, dynamic> json) =>
      _$TermServiceConfFromJson(json);

  Map<String, dynamic> toJson() => _$TermServiceConfToJson(this);
}

@JsonSerializable(explicitToJson: true)
class News {
  @JsonKey(name: 'news')
  List<NewsItem>? items;

  News({this.items});

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NewsItem {
  String? image;
  String? title;
  String? subTitle;
  String? time;
  String? url;

  NewsItem({this.image, this.title, this.subTitle, this.time, this.url});

  factory NewsItem.fromJson(Map<String, dynamic> json) =>
      _$NewsItemFromJson(json);

  Map<String, dynamic> toJson() => _$NewsItemToJson(this);
}

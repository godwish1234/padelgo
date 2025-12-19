// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      config: json['config'] as String?,
      configValue: json['configValue'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    )
      ..msg = json['msg'] as String?
      ..code = json['code'] as String?
      ..traceId = json['traceId'] as String?
      ..timestamp = json['timestamp'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'traceId': instance.traceId,
      'timestamp': instance.timestamp,
      'success': instance.success,
      'config': instance.config,
      'configValue': instance.configValue,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

AppConf _$AppConfFromJson(Map<String, dynamic> json) => AppConf(
      name: json['name'] as String?,
      subName: json['subName'] as String?,
      desc: json['desc'] as String?,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$AppConfToJson(AppConf instance) => <String, dynamic>{
      'name': instance.name,
      'subName': instance.subName,
      'desc': instance.desc,
      'logo': instance.logo,
    };

TermServiceConf _$TermServiceConfFromJson(Map<String, dynamic> json) =>
    TermServiceConf(
      privacyUrl: json['privacyUrl'] as String?,
      termsUrl: json['termsUrl'] as String?,
    );

Map<String, dynamic> _$TermServiceConfToJson(TermServiceConf instance) =>
    <String, dynamic>{
      'privacyUrl': instance.privacyUrl,
      'termsUrl': instance.termsUrl,
    };

News _$NewsFromJson(Map<String, dynamic> json) => News(
      items: (json['news'] as List<dynamic>?)
          ?.map((e) => NewsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'news': instance.items?.map((e) => e.toJson()).toList(),
    };

NewsItem _$NewsItemFromJson(Map<String, dynamic> json) => NewsItem(
      image: json['image'] as String?,
      title: json['title'] as String?,
      subTitle: json['subTitle'] as String?,
      time: json['time'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$NewsItemToJson(NewsItem instance) => <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'time': instance.time,
      'url': instance.url,
    };

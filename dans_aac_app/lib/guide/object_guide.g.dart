// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_guide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guide _$GuideFromJson(Map<String, dynamic> json) => Guide(
      id: json['id'] as String,
      name: json['name'] as String,
      pages: (json['pages'] as List<dynamic>)
          .map((e) => GuidePage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GuideToJson(Guide instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pages': instance.pages.map((e) => e.toJson()).toList(),
    };

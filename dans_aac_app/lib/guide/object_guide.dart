import 'package:dans_aac_app/guide/object_page.dart';
import 'package:json_annotation/json_annotation.dart';

part 'object_guide.g.dart';

@JsonSerializable(explicitToJson: true)
class Guide {
  String id;
  String name;
  List<GuidePage> pages;

  Guide({required this.id, required this.name, required this.pages});

  factory Guide.fromJson(Map<String, dynamic> json) => _$GuideFromJson(json);

  Map<String, dynamic> toJson() => _$GuideToJson(this);
}

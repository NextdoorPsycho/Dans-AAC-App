import 'package:json_annotation/json_annotation.dart';

part 'object_page.g.dart';

@JsonSerializable()
class GuidePage {
  String text;
  int number;

  GuidePage({required this.text, required this.number});

  factory GuidePage.fromJson(Map<String, dynamic> json) =>
      _$GuidePageFromJson(json);

  Map<String, dynamic> toJson() => _$GuidePageToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'author_model.g.dart';

@JsonSerializable(nullable: false)
class Author {
  String name;
  String email;
  String date;

  Author({this.name, this.email, this.date});

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

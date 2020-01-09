import 'package:github_test/models/author_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commit_model.g.dart';

@JsonSerializable(nullable: false)
class Commit {
  String message;
  String url;
  int comment_count;
  Author committer;
  Author author;
  String htmlUrl;

  Commit({this.message, this.url, this.comment_count, this.committer, this.author});

  factory Commit.fromJson(Map<String, dynamic> json) => _$CommitFromJson(json);
  Map<String, dynamic> toJson() => _$CommitToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commit _$CommitFromJson(Map<String, dynamic> json) {
  return Commit(
    message: json['message'] as String,
    url: json['url'] as String,
    comment_count: json['comment_count'] as int,
    committer: Author.fromJson(json['committer'] as Map<String, dynamic>),
    author: Author.fromJson(json['author'] as Map<String, dynamic>),
  )..htmlUrl = json['htmlUrl'] as String;
}

Map<String, dynamic> _$CommitToJson(Commit instance) => <String, dynamic>{
      'message': instance.message,
      'url': instance.url,
      'comment_count': instance.comment_count,
      'committer': instance.committer,
      'author': instance.author,
      'htmlUrl': instance.htmlUrl,
    };

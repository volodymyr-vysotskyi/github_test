// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(
    name: json['name'] as String,
    email: json['email'] as String,
    date: json['date'] as String,
  );
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'date': instance.date,
    };

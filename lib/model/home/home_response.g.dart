// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeData _$HomeDataFromJson(Map<String, dynamic> json) => HomeData(
      json['title'] as String? ?? '',
      (json['books'] as List<dynamic>?)
              ?.map((e) => BookHome.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$HomeDataToJson(HomeData instance) => <String, dynamic>{
      'title': instance.title,
      'books': instance.bookListHome,
    };

BookHome _$BookHomeFromJson(Map<String, dynamic> json) => BookHome(
      json['id'] as int,
      json['title'] as String? ?? '',
      json['category'] as String? ?? '',
      json['thumbnail'] as String? ?? '',
      json['author'] as String? ?? '',
    );

Map<String, dynamic> _$BookHomeToJson(BookHome instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.categoryName,
      'thumbnail': instance.thumbnail,
      'author': instance.author,
    };

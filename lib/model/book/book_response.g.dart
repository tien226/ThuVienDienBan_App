// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookResponse _$BookResponseFromJson(Map<String, dynamic> json) => BookResponse(
      (json['items'] as List<dynamic>?)
              ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$BookResponseToJson(BookResponse instance) =>
    <String, dynamic>{
      'items': instance.book,
    };

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      json['id'] as int? ?? -1,
      json['title'] as String? ?? '',
      json['language'] as String? ?? '',
      json['publisher'] as String?,
      json['quantity'] as int? ?? -1,
      json['publication_date'] == null
          ? null
          : DateTime.parse(json['publication_date'] as String),
      json['price'] as int? ?? -1,
      json['thumbnail'] as String?,
      json['description'] as String?,
      json['file'] as String?,
      (json['categories'] as List<dynamic>?)
              ?.map((e) => CategoryBook.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      (json['authors'] as List<dynamic>?)
              ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['total_available_book_items'] as int? ?? -1,
      json['is_available'] as bool,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'language': instance.language,
      'publisher': instance.publisher,
      'quantity': instance.quantity,
      'publication_date': instance.publicationDate?.toIso8601String(),
      'price': instance.price,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'file': instance.file,
      'total_available_book_items': instance.totalAvailableBookItems,
      'is_available': instance.isAvailable,
      'categories': instance.category,
      'authors': instance.authors,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String?,
      DateTime.parse(json['created_at'] as String),
      DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

CategoryBook _$CategoryBookFromJson(Map<String, dynamic> json) => CategoryBook(
      json['id'] as int,
      DateTime.parse(json['created_at'] as String),
      DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CategoryBookToJson(CategoryBook instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

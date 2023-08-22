// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrow_book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BorrowBookResponse _$BorrowBookResponseFromJson(Map<String, dynamic> json) =>
    BorrowBookResponse(
      json['id'] as int? ?? -1,
      json['status'] as String? ?? '',
      json['request_at'] as String? ?? '',
      json['borrow_at'] as String? ?? '',
      json['return_at'] as String? ?? '',
      json['cancel_at'] as String? ?? '',
      json['due_date'] as String? ?? '',
      json['url'] as String? ?? '',
      json['book_name'] as String? ?? '',
      json['price'] as int? ?? -1,
      json['author'] as String? ?? '',
    );

Map<String, dynamic> _$BorrowBookResponseToJson(BorrowBookResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'request_at': instance.requestAt,
      'borrow_at': instance.borrowAt,
      'return_at': instance.returnAt,
      'cancel_at': instance.cancelAt,
      'due_date': instance.dueDate,
      'url': instance.url,
      'book_name': instance.bookName,
      'price': instance.price,
      'author': instance.author,
    };

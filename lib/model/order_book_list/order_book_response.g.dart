// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBookResponse _$OrderBookResponseFromJson(Map<String, dynamic> json) =>
    OrderBookResponse(
      (json['items'] as List<dynamic>?)
              ?.map((e) => OrderBook.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OrderBookResponseToJson(OrderBookResponse instance) =>
    <String, dynamic>{
      'items': instance.OrderBookList,
    };

OrderBook _$OrderBookFromJson(Map<String, dynamic> json) => OrderBook(
      json['id'] as int? ?? -1,
      json['status'] as String? ?? '',
      json['request_at'] as String? ?? '',
      json['approve_at'] as String? ?? '',
      json['borrow_at'] as String? ?? '',
      json['return_at'] as String? ?? '',
      json['cancel_at'] as String? ?? '',
      json['due_date'] as String? ?? '',
      json['url'] as String? ?? '',
      json['book_name'] as String? ?? '',
      json['price'] as int? ?? -1,
      json['author'] as String? ?? '',
    );

Map<String, dynamic> _$OrderBookToJson(OrderBook instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'request_at': instance.requestAt,
      'approve_at': instance.approveAt,
      'borrow_at': instance.borrowAt,
      'return_at': instance.returnAt,
      'cancel_at': instance.cancelAt,
      'due_date': instance.dueDate,
      'url': instance.url,
      'book_name': instance.bookName,
      'price': instance.price,
      'author': instance.author,
    };

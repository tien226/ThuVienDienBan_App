import 'package:json_annotation/json_annotation.dart';
part 'order_book_response.g.dart';

@JsonSerializable()
class OrderBookResponse {
  @JsonKey(name: "items", defaultValue: [])
  final List<OrderBook> OrderBookList;

  OrderBookResponse(this.OrderBookList);
  
  factory OrderBookResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderBookResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderBookResponseToJson(this);
}

@JsonSerializable()
class OrderBook {
  @JsonKey(name: "id", defaultValue: -1)
  final int id;

  @JsonKey(name: "status", defaultValue: "")
  final String status;

  @JsonKey(name: "request_at", defaultValue: "")
  final String requestAt;

  @JsonKey(name: "approve_at", defaultValue: "")
  final String approveAt;

  @JsonKey(name: "borrow_at", defaultValue: "")
  final String borrowAt;

  @JsonKey(name: "return_at", defaultValue: "")
  final String returnAt;

  @JsonKey(name: "cancel_at", defaultValue: "")
  final String cancelAt;

  @JsonKey(name: "due_date", defaultValue: "")
  final String dueDate;

  @JsonKey(name: "url", defaultValue: "")
  final String url;

  @JsonKey(name: "book_name", defaultValue: "")
  final String bookName;

  @JsonKey(name: "price", defaultValue: -1)
  final int price;

  @JsonKey(name: "author", defaultValue: "")
  final String author;

  OrderBook(this.id, this.status, this.requestAt, this.approveAt, this.borrowAt, this.returnAt, this.cancelAt, this.dueDate, this.url, this.bookName, this.price, this.author);

factory OrderBook.fromJson(Map<String, dynamic> json) =>
      _$OrderBookFromJson(json);

  Map<String, dynamic> toJson() => _$OrderBookToJson(this);
}

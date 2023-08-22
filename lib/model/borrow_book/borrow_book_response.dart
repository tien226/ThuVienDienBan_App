import 'package:json_annotation/json_annotation.dart';
part 'borrow_book_response.g.dart';

@JsonSerializable()
class BorrowBookResponse {
  @JsonKey(name: "id", defaultValue: -1)
  final int id;

  @JsonKey(name: "status", defaultValue: "")
  final String status;

  @JsonKey(name: "request_at", defaultValue: "")
  final String requestAt;

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

  BorrowBookResponse(
      this.id,
      this.status,
      this.requestAt,
      this.borrowAt,
      this.returnAt,
      this.cancelAt,
      this.dueDate,
      this.url,
      this.bookName,
      this.price,
      this.author);

  factory BorrowBookResponse.fromJson(Map<String, dynamic> json) =>
      _$BorrowBookResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BorrowBookResponseToJson(this);
}

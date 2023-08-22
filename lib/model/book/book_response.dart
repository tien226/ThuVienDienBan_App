import 'package:json_annotation/json_annotation.dart';

// import '../category/category_response.dart';
part 'book_response.g.dart';

@JsonSerializable()
class BookResponse {
  
  @JsonKey(name: "items", defaultValue: [])
  final List<Book> book;

  BookResponse(this.book);

  factory BookResponse.fromJson(Map<String, dynamic> json) =>
      _$BookResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookResponseToJson(this);
}

@JsonSerializable()
class Book {
  @JsonKey(name: "id", defaultValue: -1)
  final int id;

  @JsonKey(name: "title", defaultValue: "")
  final String title;

  @JsonKey(name: "language", defaultValue: "")
  final String language;

  @JsonKey(name: "publisher")
  final String? publisher;

  @JsonKey(name: "quantity", defaultValue: -1)
  final int quantity;

  @JsonKey(name: "publication_date")
  final DateTime? publicationDate;

  @JsonKey(name: "price", defaultValue: -1)
  final int price;

  @JsonKey(name: "thumbnail")
  final String? thumbnail;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "file")
  final String? file;

  @JsonKey(name: "total_available_book_items", defaultValue: -1)
  final int totalAvailableBookItems;

  @JsonKey(name: "is_available")
  final bool isAvailable;

  @JsonKey(name: "categories", defaultValue: [])
  final List<CategoryBook> category;

  @JsonKey(name: "authors", defaultValue: [])
  final List<Author> authors;

  Book(
      this.id,
      this.title,
      this.language,
      this.publisher,
      this.quantity,
      this.publicationDate,
      this.price,
      this.thumbnail,
      this.description,
      this.file,
      this.category,
      this.authors, this.totalAvailableBookItems, this.isAvailable);

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@JsonSerializable()
class Author {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @JsonKey(name: "updated_at")
  final DateTime updatedAt;

  Author(this.id, this.name, this.description, this.createdAt,
      this.updatedAt);

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class CategoryBook {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @JsonKey(name: "updated_at")
  final DateTime updatedAt;

  CategoryBook(this.id, this.createdAt, this.updatedAt);

  factory CategoryBook.fromJson(Map<String, dynamic> json) => _$CategoryBookFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryBookToJson(this);
}

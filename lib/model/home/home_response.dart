import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeData {
  @JsonKey(name: "title", defaultValue: "")
  final String title;

  @JsonKey(name: "books", defaultValue: [])
  final List<BookHome> bookListHome;

  HomeData(this.title, this.bookListHome);

  factory HomeData.fromJson(Map<String, dynamic> json) =>
      _$HomeDataFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataToJson(this);
}

@JsonSerializable()
class BookHome {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "title", defaultValue: "")
  final String title;

  @JsonKey(name: "category", defaultValue: "")
  final String categoryName;

  @JsonKey(name: "thumbnail", defaultValue: "")
  final String thumbnail;

  @JsonKey(name: "author", defaultValue: "")
  final String author;

  BookHome(this.id, this.title, this.categoryName, this.thumbnail, this.author);

  factory BookHome.fromJson(Map<String, dynamic> json) =>
      _$BookHomeFromJson(json);

  Map<String, dynamic> toJson() => _$BookHomeToJson(this);
}

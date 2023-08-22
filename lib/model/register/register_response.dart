
import 'package:json_annotation/json_annotation.dart';
part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: "username", defaultValue: "")
  final String username;

  @JsonKey(name: "name", defaultValue: "")
  final String name;

  @JsonKey(name: "phone_number", defaultValue: "")
  final String phoneNumber;

  @JsonKey(name: "email", defaultValue: "")
  final String email;

  RegisterResponse(this.username, this.name, this.phoneNumber, this.email);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
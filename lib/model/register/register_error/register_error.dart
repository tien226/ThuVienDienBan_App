import 'package:json_annotation/json_annotation.dart';
part 'register_error.g.dart';

@JsonSerializable()
class RegisterError {
  @JsonKey(name: "email", defaultValue: [])
  final List<String> email;

  @JsonKey(name: "username", defaultValue: [])
  final List<String> username;

  RegisterError(this.email, this.username);

  factory RegisterError.fromJson(Map<String, dynamic> json) =>
      _$RegisterErrorFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterErrorToJson(this);
}

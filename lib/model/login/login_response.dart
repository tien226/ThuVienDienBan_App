import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "token")
  final String token;

  @JsonKey(name: "refresh_token")
  final String refreshToken;

  LoginResponse(this.token, this.refreshToken);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class Permissions {
  @JsonKey(name: "group")
  final List<String> group;

  @JsonKey(name: "variable")
  final List<String> variable;

  Permissions(this.group, this.variable);

  factory Permissions.fromJson(Map<String, dynamic> json) => _$PermissionsFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionsToJson(this);
}


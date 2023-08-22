// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['token'] as String,
      json['refresh_token'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refresh_token': instance.refreshToken,
    };

Permissions _$PermissionsFromJson(Map<String, dynamic> json) => Permissions(
      (json['group'] as List<dynamic>).map((e) => e as String).toList(),
      (json['variable'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PermissionsToJson(Permissions instance) =>
    <String, dynamic>{
      'group': instance.group,
      'variable': instance.variable,
    };

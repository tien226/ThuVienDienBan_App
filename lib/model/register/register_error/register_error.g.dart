// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterError _$RegisterErrorFromJson(Map<String, dynamic> json) =>
    RegisterError(
      (json['email'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      (json['username'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
    );

Map<String, dynamic> _$RegisterErrorToJson(RegisterError instance) =>
    <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
    };

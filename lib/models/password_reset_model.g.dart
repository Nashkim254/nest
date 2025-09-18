// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PasswordResetRequestModelImpl _$$PasswordResetRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PasswordResetRequestModelImpl(
      email: json['email'] as String,
      appLaunch: json['app_launch'] as String? ?? 'com.nesthaps.nest://',
    );

Map<String, dynamic> _$$PasswordResetRequestModelImplToJson(
        _$PasswordResetRequestModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'app_launch': instance.appLaunch,
    };

_$PasswordResetModelImpl _$$PasswordResetModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PasswordResetModelImpl(
      token: json['token'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$PasswordResetModelImplToJson(
        _$PasswordResetModelImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'password': instance.password,
    };

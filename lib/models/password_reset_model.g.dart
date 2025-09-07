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
      email: json['email'] as String,
      token: json['token'] as String,
      newPassword: json['new_password'] as String,
      confirmPassword: json['confirm_password'] as String,
      appLaunch: json['app_launch'] as String? ?? 'com.nesthaps.nest://',
    );

Map<String, dynamic> _$$PasswordResetModelImplToJson(
        _$PasswordResetModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'token': instance.token,
      'new_password': instance.newPassword,
      'confirm_password': instance.confirmPassword,
      'app_launch': instance.appLaunch,
    };

import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_reset_model.freezed.dart';
part 'password_reset_model.g.dart';

@freezed
class PasswordResetRequestModel with _$PasswordResetRequestModel {
  const factory PasswordResetRequestModel({
    required String email,
    @JsonKey(name: 'app_launch') @Default('com.nesthaps.nest://') String appLaunch,
  }) = _PasswordResetRequestModel;

  factory PasswordResetRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetRequestModelFromJson(json);
}

@freezed
class PasswordResetModel with _$PasswordResetModel {
  const factory PasswordResetModel({
    required String email,
    required String token,
    @JsonKey(name: 'new_password') required String newPassword,
    @JsonKey(name: 'confirm_password') required String confirmPassword,
    @JsonKey(name: 'app_launch') @Default('com.nesthaps.nest://') String appLaunch,
  }) = _PasswordResetModel;

  factory PasswordResetModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetModelFromJson(json);
}
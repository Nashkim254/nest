import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_model.freezed.dart';
part 'registration_model.g.dart';

@freezed
class RegistrationModel with _$RegistrationModel {
  const factory RegistrationModel({
    required String email,
    required String password,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    @Default([]) List<String> interests,
  }) = _RegistrationModel;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationModelFromJson(json);
}
